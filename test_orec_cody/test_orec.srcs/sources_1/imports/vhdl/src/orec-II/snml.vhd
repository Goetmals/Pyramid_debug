-- -------------------------------------------------------------------------- --
-- File Name :	SNML.vhd
-- Author    :	Fr�d�ric de Melo, ENSEA
-- Purpose   :	seuillage des non maxima locaux des gradients
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		Fred de Melo    18/05/2001     Nlle Version snml
--
--			(c) Copyright UBO & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;


--  module SNML
-- ------------------------------------------------------------------------- --
entity SNML is
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 hsync_nrm	: in	std_logic;
	 vsync_nrm	: in	std_logic;
	 pixel_ngd	: in	std_logic_vector(17 downto 0);
	 pixel_nor	: in	std_logic_vector( 2 downto 0);

	 hsync_max	: out	std_logic;
	 vsync_max	: out	std_logic;
	 pixel_max	: out	std_logic_vector(17 downto 0);
	 pixel_mor	: out	std_logic_vector( 2 downto 0)
	);
end SNML;


--  d�finition de l'architecture de SNML
-- ------------------------------------------------------------------------- --
architecture ARCH_SNML of SNML is
	
	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�claration des composants internes
	-- --------------------------------------------------------- --
component LR_SNML
   port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;
	 decalb		: in	std_logic;
	 di		: in	std_logic_vector(21 downto 0);
	 do		: out	std_logic_vector(21 downto 0)
	);
end component;

     
	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�finition des signaux internes
	-- --------------------------------------------------------- --
	signal	diF,doF			: std_logic_vector(21 downto 0);
	signal	ML,MLS			: std_logic;
	signal  Ab,Ob,Eb,B,C,D		: std_logic_vector(21 downto 0);
	signal  Ah,Oh,Eh,H,G,F		: std_logic_vector(20 downto 0);
	signal  F_r,F_rr		: std_logic_vector(20 downto 0);
	signal  D_r,D_rr		: std_logic_vector(21 downto 0);	
        signal  SH			: std_logic_vector(18 downto 0);
	signal	SHA,SHB			: std_logic_vector(17 downto 0);
        signal  SB			: std_logic_vector(18 downto 0);
	signal	SBA,SBB			: std_logic_vector(17 downto 0);

        signal	bord			: std_logic;
	signal	hsynch_rtd		: std_logic_vector( 4 downto 0);
	signal	nblig			: std_logic_vector( 2 downto 0);


-- ========================================================================= --
begin
	
	-- ligne � retard (ATTENTION : MLr en retard, calcul pipelin�)
	-- --------------------------------------------------------- --
	diF <= ML & F_rr;

	-- --------------------------------------------------------- --
RTL0:	LR_SNML        port map	(
				 resetb,clk
				,hsync_nrm,diF,doF
				);

          
        -- d�finition du masque haut
	-- --------------------------------------------------------- --
        Eh <= F;      Oh <= G;      Ah <= H;      B <= doF;
       
	-- --------------------------------------------------------- --    
MH0:    process ( resetb,clk )
        begin
		if    ( resetb='0' ) then
			D   <= (others=>'0');	C    <= (others=>'0'); 
			D_r <= (others=>'0');	D_rr <= (others=>'0'); 
			
		elsif ( rising_edge(clk) ) then
			D <= C;		D_r  <= D;
			C <= B;		D_rr <= d_r;
		end if;
	end process;

	
	-- d�finition du masque bas
	-- --------------------------------------------------------- --    
	Eb <= D;      Ob <= C;      Ab <= B;      H <= pixel_nor & pixel_ngd;

	-- --------------------------------------------------------- --    
MB0:    process ( resetb,clk )
        begin
		if ( resetb='0' ) then
			F   <= (others=>'0');	G    <= (others=>'0'); 
			F_r <= (others=>'0');	F_rr <= (others=>'0');
			
		elsif ( rising_edge(clk) ) then
			F <= G;		F_r  <= F;
			G <= H;		F_rr <= F_r;
		end if;
	end process;	

	
	-- traitement sur le masque haut
	-- --------------------------------------------------------- --    
SH0:	process ( resetb,clk)
	begin
		if ( resetb='0' ) then
			SHA <= (others=>'0');
			SHB <= (others=>'0');
		
		elsif ( rising_edge(clk) ) then
			
			case Oh(20 downto 19) is
				when "00"   => SHA <= Ah(17 downto 0);
				when "01"   => SHA <=  B(17 downto 0);
				when "10"   => SHA <=  C(17 downto 0);
				when others => SHA <=  D(17 downto 0);
			end case;
			
			case Oh(20 downto 18) is
				when "000" 	  => SHB <= Ah(17 downto 0);
				when "001"|"010"  => SHB <=  B(17 downto 0);
				when "011"|"100"  => SHB <=  C(17 downto 0);
				when "101"|"110"  => SHB <=  D(17 downto 0);
				when others 	  => SHB <= Eh(17 downto 0);
			end case;
			
		end if;
	end process;
	
	-- --------------------------------------------------------- --    
TH0:    process ( resetb,clk )
        begin
		if    ( resetb='0' ) then
			SH <= (others=>'0'); 

		elsif ( rising_edge(clk) ) then
			SH <= ('0' & SHA) + ('0' & SHB);
		end if;
	end process;


	-- g�n�ration du bit ML
	-- --------------------------------------------------------- --    
ML0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			ML <= '0';
		elsif ( rising_edge(clk) ) then
			if ( SH <= (F_r(17 downto 0) & '0') ) then
				ML <= '1';  
	   		else 	ML <= '0';
			end if;
		end if;
	end process;
	
	
	-- traitement sur le masque haut
	-- --------------------------------------------------------- --    
SB0:	process ( resetb,clk)
	begin
		if ( resetb='0' ) then
			SBA <= (others=>'0');
			SBB <= (others=>'0');
		
		elsif ( rising_edge(clk) ) then
			
			case Ob(20 downto 19) is
				when "00"   => SBA <= Eb(17 downto 0);
				when "01"   => SBA <=  F(17 downto 0);
				when "10"   => SBA <=  G(17 downto 0);
				when others => SBA <=  H(17 downto 0);
			end case;
			
			case Ob(20 downto 18) is
				when "000"  	  => SBB <= Eb(17 downto 0);
				when "001"|"010"  => SBB <=  F(17 downto 0);
				when "011"|"100"  => SBB <=  G(17 downto 0);
				when "101"|"110"  => SBB <=  H(17 downto 0);
				when others       => SBB <= Ab(17 downto 0);
			end case;

		end if;
	end process;
	
	
	-- --------------------------------------------------------- --    
TB0:    process ( resetb,clk )
        begin
		if    ( resetb='0' ) then
			SB <= (others=>'0'); 

		elsif ( rising_edge(clk) ) then
			SB <= ('0' & SBA) + ('0' & SBB);
		end if;
	end process;


	-- g�n�ration du bit MLS
	-- --------------------------------------------------------- --    
MLS0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			MLS <= '0';
		elsif ( rising_edge(clk) ) then
			if ( SB <= (D_r(17 downto 0) & '0') ) then
				MLS <= '1';  
	   		else 	MLS <= '0';
			end if;
		end if;
	end process;
		
	    
	-- affectation de la sortie pixel_max
	-- --------------------------------------------------------- --
OUT0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			pixel_max <= (others=>'0');
			pixel_mor <= (others=>'0');

		elsif ( rising_edge(clk) ) then
			if( MLS='1' and D_rr(21)='1' and bord='0' ) then	-- if( MLS='1' and Eb(21)='1' and bord='0' )
				pixel_max <= D_rr(17 downto 0);			-- pixel_max <= Eb(17 downto 0);

			else
				pixel_max <= (others=>'0');
			end if;

			pixel_mor <= D_rr(20 downto 18);				--pixel_mor <= Eb(20 downto 18);
		end if;
	end process;


	-- compteur de lignes
	-- --------------------------------------------------------- --
CPL0:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			nblig <= (others=>'1');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
			-- ----------------------------------------- --
			if ( hsynch_rtd(0)='1' and hsync_nrm='0' ) then
				nblig <= nblig(1 downto 0) & vsync_nrm;
			end if;
		end if;
	end process;


	-- nouvelle synchro Horizontale
	-- --------------------------------------------------------- --
NSH0:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			hsynch_rtd <= (others=>'1');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
			hsynch_rtd <= hsynch_rtd(3 downto 0) & hsync_nrm;
		end if;
	end process;


	-- affectation de la synchro horizontale
	-- --------------------------------------------------------- --
	hsync_max <= hsynch_rtd(4);
	vsync_max <= hsynch_rtd(4) or nblig(1);

	bord      <= hsynch_rtd(4) or hsynch_rtd(2) or nblig(2) or nblig(0);	


end ARCH_SNML;
-- ========================================================================= --
