-- -------------------------------------------------------------------------- --
-- File Name :	AMELIORATION.vhd
-- Author    :	f. DE MELO ,UBO
-- Purpose   :	amelioration des contours
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		Fred DE MELO	05/09/2001	VHDL 1rst version
--
--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;




--  module AMELIORATION
-- ------------------------------------------------------------------------- --
entity AMELIORATION is 
   port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 
	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 1 downto 0);

	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 1 downto 0)
	);
end AMELIORATION;


--  définition de l'architecture de AMELIORATION
-- ------------------------------------------------------------------------- --
architecture ARCH_AMELIORATION of AMELIORATION is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des composants externes
	-- --------------------------------------------------------- --
component LR_AMEL
   port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 decalb		: in	std_logic;
	 di		: in	std_logic_vector( 3 downto 0);
	 do		: out	std_logic_vector( 3 downto 0)
	);
end component;

	-- --------------------------------------------------------- --
--component LR_AMEL_II
--   port ( 
--	 resetb		: in	std_logic;
--	 clkb		: in	std_logic;

--	 decalb		: in	std_logic;
--	 di		: in	std_logic_vector( 1 downto 0);
--	 do		: out	std_logic_vector( 1 downto 0)
--	);
--end component;

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des constantes
	-- --------------------------------------------------------- --
	constant	NB_AE		: integer := 6;
	constant	CONTOUR		: std_logic_vector(1 downto 0) := "11"; 
	constant	CRETE		: std_logic_vector(1 downto 0) := "10";
	constant	EXTREMITE	: std_logic_vector(1 downto 0) := "01"; 
	constant	CRETE_FOND	: std_logic_vector(1 downto 0) := "10";
	constant	CRETE_CONTOUR	: std_logic_vector(1 downto 0) := "01"; 
	constant	FOND		: std_logic_vector(1 downto 0) := "00";

	
	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux internes
	-- --------------------------------------------------------- --
	signal	 Gh, Ch, Dh		-- Gauche Courant Droite (HAUT)
		,Gc, Cc, Dc		--			 (COURANT)
		,Gb, Cb, Db		: std_logic_vector( 1 downto 0);
	signal	result			: std_logic_vector( 1 downto 0);
	
	signal	decalh,decalv		: std_logic;
	
--	signal	diL,doL,diF,doF		: std_logic_vector( 1 downto 0);
	signal	di,do			: std_logic_vector( 3 downto 0);
	
	signal	nblig			: std_logic_vector( 1 downto 0);
	signal	debfin			: std_logic_vector( 1 downto 0);
	signal	hsynch			: std_logic_vector( 1 downto 0);
	
	signal	lsb_Dh,lsb_Ch,lsb_Gh	: std_logic;
	signal	lsb_Gc,lsb_Gb,lsb_Cb	: std_logic;
	signal	lsb_Db,lsb_Dc		: std_logic;
	
	signal	addresse		: integer;
	signal 	bus_addresse		: std_logic_vector( 7 downto 0);
	
-- ========================================================================= --
begin
	-- retarde le signal de synchronisation horizontale 'hsync'
	-- --------------------------------------------------------- --
CTL0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			decalh <= '1';
			decalv <= '1';

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			decalh <= hsync_inn;
			decalv <= vsync_inn;
		end if;
	end process;


	-- lignes à retard 
	-- --------------------------------------------------------- --
--	diL <= Db;
--	diF <= result;

	di <= Gc & Gb;

	-- --------------------------------------------------------- --
RTL0:	LR_AMEL	       port map	(
				 resetb,clkb
				,hsync_inn,di,do
				);

--RTL0:	LR_AMEL_I	port map	(
--				 	 resetb,clkb
--					,hsync_inn,diL,doL
--					);

--RTL1:	LR_AMEL_I	port map	(
--				 	 resetb,clkb
--					,hsync_inn,diF,doF
--					);
					
	-- élément structurant de 3x3x2
	-- --------------------------------------------------------- --
	Db <= pixel_inn		when decalv='0' else FOND;
--	Dc <= doL		when decalh='0' else FOND;
--	Dh <= doF		when decalh='0' else FOND;
	Dc <= do(1 downto 0)	when decalh='0' else FOND;
	Dh <= do(3 downto 2)	when decalh='0' else FOND;

	Gc <= result;

	-- --------------------------------------------------------- --
ELM0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0') then
			Gh <= (others=>'0');	Ch <= (others=>'0');
						Cc <= (others=>'0');
			Gb <= (others=>'0');	Cb <= (others=>'0');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			Gh <= Ch;		Ch <= Dh;
						Cc <= Dc;
			Gb <= Cb;		Cb <= Db;
		end if;
	end process;


	-- mise en oeuvre de la LUT
	-- --------------------------------------------------------- --
	
	-- la LUT a ete calculee en prenant CRETE = "01" ....
	-- --------------------------------------------------------- --
	lsb_Dh <= Dh(0) or Dh(1);
	lsb_Ch <= Ch(0) or Ch(1);
	lsb_Gh <= Gh(0) or Gh(1);
	lsb_Gc <= Gc(0) or Gc(1);
	lsb_Gb <= Gb(0) or Gb(1);
	lsb_Cb <= Cb(0) or Cb(1);
	lsb_Db <= Db(0) or Db(1);
	lsb_Dc <= Dc(0) or Dc(1);
	
	-- definition des adresses de la LUT  
	-- --------------------------------------------------------- --
	bus_addresse <= lsb_Dc & lsb_Db & lsb_Cb & lsb_Gb 
		       &lsb_Gc & lsb_Gh & lsb_Ch & lsb_Dh;
	addresse <= conv_integer(bus_addresse);

	
	-- test sur l' adresse de la LUT
	-- --------------------------------------------------------- --
OUT0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			result <= FOND;

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			-- ----------------------------------------- --
					
			case addresse is
					
				when	-- LUT = 1 : forcage a crete
					-- --------------------------------------------------------- --
					  10| 11| 26| 27| 34| 35| 38| 39
					| 40| 41| 42| 43| 44| 45| 46| 47
					| 50| 51| 58| 59| 74| 75| 90| 91
					| 98|102|104|105|106|107|108|109
					|110|111|114|122|123|130|134|136
					|137|138|139|140|142|146|150|152
					|153|154|155|156|158|160|161|162
					|163|164|165|166|167|168|169|170
					|171|172|173|174|175|176|177|178
					|179|180|181|182|183|184|185|186
					|187|188|189|190|191|194|198|200
					|201|202|203|204|206|210|214|218
					|219|222|226|230|232|233|234|235
					|236|237|238|239|242|246|250|251
					|254 
						=>
							result <= CRETE;

					when 	-- LUT = 2 : forcage a fond
						-- --------------------------------------------------------- --
					   0|  1|  4|  5|  7| 14| 15| 16
					| 17| 20| 21| 28| 30| 31| 56| 60
					| 62| 63| 64| 65| 68| 69| 80| 81
					| 84| 85|112|120|124|126|127|131
					|135|143|159|193|195|199|207|223
					|224|225|227|231|240|241|243|247
					|248|249|252|253
						=>
							result <= FOND;

					when 	-- LUT = 0 : pixel non modifie
						-- --------------------------------------------------------- --
					others 				
					  	=>
							result <= Cc;
				end case;
			

		end if;
	end process;

	pixel_out <= result;

	-- synchro Horizontale/Verticale de l'image de sortie
	-- --------------------------------------------------------- --

	-- détection début/fin de ligne
	-- --------------------------------------------------------- --
	debfin(0) <= hsync_inn;

NSV0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then		-- "00" : In       Line
			debfin(1) <= '1';		-- "01" : End   Of Line

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then	-- "10" : Begin Of Line
			debfin(1) <= debfin(0);		-- "11" : Out   Of Line
		end if;
	end process;


	-- compteur de lignes
	-- --------------------------------------------------------- --
CPL0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			nblig <= (others=>'1');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			-- ----------------------------------------- --
			if ( debfin="10" ) then
				nblig <= nblig(0)&vsync_inn;
			end if;
		end if;
	end process;


	-- nouvelle synchro Horizontale
	-- --------------------------------------------------------- --
NSH0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			hsynch <= (others=>'1');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			hsynch <= hsynch(0) & hsync_inn;
		end if;
	end process;


	-- affectation de la synchro horizontale
	-- --------------------------------------------------------- --
	hsync_out <= hsynch(1);
	vsync_out <= hsynch(1) or nblig(1);



end ARCH_AMELIORATION;
-- ========================================================================= --
