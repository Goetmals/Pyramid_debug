-- -------------------------------------------------------------------------- --
-- File Name :	CONV_COL.vhd
-- Author    :	Yves Guerin, IFITEP / Lounis Kessak, Philippe Lamaty, ENSEA / Cedric Munoz, LE2I
--              Fr�d�ric de Melo, UBO
--
-- Purpose   :	convolution colonne de l'image.
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		l.Kessal	  .  .1996	First Version
--		y.Guerin	  .  .1997	Aero update
--		p.Lamaty	07.05.1998	header update + add pipe line
--		c.Munoz		12.03.2001	FPGA Version
--		f.De Melo       12.07.2001      FPGA Version
--
--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

--  module CONV_COL
-- ------------------------------------------------------------------------- --
entity CONV_COL is
   port	(	
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 csin0		: in	std_logic_vector( 6 downto 0);
	 csin1		: in	std_logic_vector( 6 downto 0);
	 csin2		: in	std_logic_vector( 6 downto 0);
	 csin3		: in	std_logic_vector( 6 downto 0);
	 csin4		: in	std_logic_vector( 6 downto 0);
	 csin5 		: in	std_logic_vector( 6 downto 0);

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 7 downto 0);

	 hsync_out 	: out	std_logic;
	 vsync_out 	: out	std_logic;
	 pixel_out 	: out	std_logic_vector(11 downto 0)
	);
end CONV_COL;


--  definition de l'architecture de CONV_COL
-- ------------------------------------------------------------------------- --
architecture ARCH_CONV_COL of CONV_COL is
	
	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�claration des composants internes
	-- --------------------------------------------------------- --
component LR_CONV
   port	(
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 decalb		: in	std_logic;
	 di		: in	std_logic_vector(87 downto 0);
	 do		: out	std_logic_vector(87 downto 0)
	);
end component;

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- definition des types internes
	-- --------------------------------------------------------- --
	type	SLV11_8 is array(0 to 11) of std_logic_vector(7 downto 0);


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- definition des signaux internes
	-- --------------------------------------------------------- --
	signal	add_0_11,add_1_10	: std_logic_vector( 8 downto 0);
	signal	add_2_9,add_3_8		: std_logic_vector( 8 downto 0);
	signal	add_4_7,add_5_6		: std_logic_vector( 8 downto 0);

	signal	mult_1,mult_2		: std_logic_vector(15 downto 0);
	signal	mult_3,mult_4		: std_logic_vector(15 downto 0);
	signal	mult_5,mult_6		: std_logic_vector(15 downto 0);

	signal	temp_21,temp_22,temp_23	: std_logic_vector(16 downto 0);
	signal	temp_a2,temp_a3,temp_a4	: std_logic_vector(16 downto 0);
        
	signal  doL,doL_r,diL           : std_logic_vector(87 downto 0);
	signal	p_in			: SLV11_8;
	signal	p_in_r			: SLV11_8;
	
	signal  pixel_inn_r		: std_logic_vector( 7 downto 0);
        
	signal	hsync_rtd		: std_logic_vector( 9 downto 0);
	signal	nblig,nblig_r		: std_logic_vector( 6 downto 0);

	signal	bord_haut		: std_logic;
	

-- ========================================================================= --
begin

	-- decalage de la synchronisation horizontal
	-- --------------------------------------------------------- --
SYN0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			hsync_rtd <= (others=>'1');

		elsif ( rising_edge(clk) ) then
			hsync_rtd <= hsync_rtd(8 downto 0)&hsync_inn;
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
			if ( hsync_rtd(0)='1' and hsync_inn='0' ) then
				nblig <= nblig( 5 downto 0)&vsync_inn;
			end if;
		end if;
	end process;

	
	-- entree de la ligne a retard
	-- --------------------------------------------------------- --
	diL <=  p_in( 0) & p_in( 1) & p_in( 2) & p_in( 3) & p_in( 4)
	      & p_in( 5) & p_in( 6) & p_in( 7) & p_in( 8) & p_in( 9)
	      & p_in(10);

	
	-- ligne � retard 
	-- --------------------------------------------------------- --
RTL0:	LR_CONV        port map	(
				 resetb,clk
				,hsync_inn,diL,doL
				);
	
	-- Retard sur doL, bord_haut et nblig (contraintes placement&routage) 
	-- --------------------------------------------------------- --
RTD0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			doL_r 		<= (others=>'0');
			pixel_inn_r	<= (others=>'0');
			nblig_r 	<= (others=>'0');
			bord_haut 	<= '0';           -- detection du bord haut

		elsif ( rising_edge(clk) ) then	
			doL_r 		<= doL;
			pixel_inn_r	<= pixel_inn;
			nblig_r 	<= nblig;

			if ( nblig(6 downto 5)="10" ) then
				bord_haut <= '1';
			else
				bord_haut <= '0';
			end if;
		end if;
	end process;
		         
		  	
	-- affectation du mux d'entr�e
	-- --------------------------------------------------------- --
	p_in(0)  <=    p_in( 1)	when nblig_r(1 downto 0)="01"	-- ligne N-6
		 else  p_in( 3)	when nblig_r(2 downto 1)="01"	-- ligne N-5
		 else  p_in( 5)	when nblig_r(3 downto 2)="01"	-- ligne N-4
		 else  p_in( 7)	when nblig_r(4 downto 3)="01"	-- ligne N-3
		 else  p_in( 9)	when nblig_r(5 downto 4)="01"	-- ligne N-2
		 else  p_in(11)	when nblig_r(6 downto 5)="01"	-- ligne N-1
		 else  pixel_inn_r;				-- INI


	-- Registre a decalage 12x1x12
	-- --------------------------------------------------------- --
	p_in( 1) <= doL_r(87 downto 80);
	p_in( 2) <= doL_r(79 downto 72);
	p_in( 3) <= doL_r(71 downto 64);
	p_in( 4) <= doL_r(63 downto 56);
	p_in( 5) <= doL_r(55 downto 48);
	-- --------------------------------------------------------- --
	p_in( 6) <= doL_r(47 downto 40) when bord_haut='0' else p_in(5);
        p_in( 7) <= doL_r(39 downto 32) when bord_haut='0' else p_in(4);
	p_in( 8) <= doL_r(31 downto 24) when bord_haut='0' else p_in(3);
	p_in( 9) <= doL_r(23 downto 16) when bord_haut='0' else p_in(2);
	p_in(10) <= doL_r(15 downto  8) when bord_haut='0' else p_in(1);
	p_in(11) <= doL_r( 7 downto  0); -- when bord_haut='0' else p_in(0);


	-- Retard sur la sortie du mux (impos� par les contraintes de 
	-- placement & routage)
	-- --------------------------------------------------------- --
RTD1:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			p_in_r <=  (others=>(others=>'0'));

		elsif ( rising_edge(clk) ) then
			p_in_r <= p_in;	
		end if;			
	end process;


	-- addition 12 bits + 12 bits = pix_ress sur 13 bits
	-- --------------------------------------------------------- --
ADD0:	process( resetb,clk ) 
	begin
		if    ( resetb='0' ) then
			add_0_11 <=  (others=>'0');
			add_1_10 <=  (others=>'0');
			add_2_9  <=  (others=>'0');
			add_3_8  <=  (others=>'0');
			add_4_7  <=  (others=>'0');
			add_5_6  <=  (others=>'0');

		elsif ( rising_edge(clk) ) then
			add_0_11 <= ('0'&p_in_r(0)) + ('0'&p_in_r(11));
			add_1_10 <= ('0'&p_in_r(1)) + ('0'&p_in_r(10));
			add_2_9 <=  ('0'&p_in_r(2)) + ('0'&p_in_r( 9));
			add_3_8 <=  ('0'&p_in_r(3)) + ('0'&p_in_r( 8));
			add_4_7 <=  ('0'&p_in_r(4)) + ('0'&p_in_r( 7));
			add_5_6 <=  ('0'&p_in_r(5)) + ('0'&p_in_r( 6));
		end if;
	end process;


	-- Multiplications 13 bits * 7 bits = pix_ress sur 20 bits
	-- --------------------------------------------------------- --
MUL0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			mult_1 <= (others=>'0');
			mult_2 <= (others=>'0');
			mult_3 <= (others=>'0');
			mult_4 <= (others=>'0');
			mult_5 <= (others=>'0');
			mult_6 <= (others=>'0');

		elsif ( rising_edge(clk) ) then
			mult_1 <= csin0 * add_0_11;	
			mult_2 <= csin1 * add_1_10;	
			mult_3 <= csin2 * add_2_9;	
		 	mult_4 <= csin3 * add_3_8;	
			mult_5 <= csin4 * add_4_7;	
			mult_6 <= csin5 * add_5_6;	
		end if;
	end process;


	-- Additions de 20 bits + 20 bits = pix_ress sur 20 bits
	-- Resultat final est sur 16 bits (poids fort)
	-- --------------------------------------------------------- --
ADD1:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			temp_21 <= (others=>'0');
			temp_22 <= (others=>'0');
			temp_23 <= (others=>'0');
			temp_a2 <= (others=>'0');
			temp_a3 <= (others=>'0');
			temp_a4 <= (others=>'0');

		elsif  ( rising_edge(clk) ) then
			temp_21 <= ('0'&mult_1) + ('0'&mult_2);	
			temp_22 <= ('0'&mult_3) + ('0'&mult_4);	
			temp_23 <= ('0'&mult_5) + ('0'&mult_6);	
			temp_a2 <= temp_23;
			temp_a3 <= temp_21 + temp_22;		
			temp_a4 <= temp_a3 + temp_a2;		
		end if;
	end process;

	-- Affectation des signaux de sortie
	-- --------------------------------------------------------- --
	hsync_out <= hsync_rtd(6);
	vsync_out <= hsync_rtd(6) or nblig_r(6);
	pixel_out <=   temp_a4(15 downto 4) when hsync_rtd(7)='0'
		  else (others=>'0');


end ARCH_CONV_COL;
-- ========================================================================= --
