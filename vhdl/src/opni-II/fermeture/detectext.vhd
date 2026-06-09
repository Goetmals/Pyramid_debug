-- -------------------------------------------------------------------------- --
-- File Name :	DETECTEXT.vhd
-- Author    :	L. Kessal, ENSEA / Philippe Lamaty, ENSEA
-- Purpose   :	détection des extrémités des contours
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		L.Kessal	05.12.1997	First Version
--		p.Lamaty	09.10.1998	entity update
--		p.Lamaty	12.10.1998	header update
--		p.Lamaty	06.11.1998	synopsys update
--		p.Lamaty	05.03.1999	CLKB     Update
--
--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;




--  module DETECTEXT
-- ------------------------------------------------------------------------- --
entity DETECTEXT is 
   port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 connexes	: in	std_logic;	-- '0': 4 conn., '1' : 8 conn.

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 1 downto 0);

	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 1 downto 0)
	);
end DETECTEXT;


--  définition de l'architecture de DETECTEXT
-- ------------------------------------------------------------------------- --
architecture ARCH_DETECTEXT of DETECTEXT is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des composants externes
	-- --------------------------------------------------------- --
component LR_DEXT
   port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 decalb		: in	std_logic;
	 di		: in	std_logic_vector( 1 downto 0);
	 do		: out	std_logic_vector( 1 downto 0)
	);
end component;

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
	signal	Si			: std_logic_vector( 7 downto 0);
	signal	s4,s8,St		: std_logic_vector( 3 downto 0);
	signal	 Gh, Ch, Dh		-- Gauche Courant Droite (HAUT)
		,Gc, Cc, Dc		--			 (COURANT)
		,Gb, Cb, Db		: std_logic_vector( 1 downto 0);

	signal	decalh,decalv		: std_logic;
	signal	diL,doL,doF		: std_logic_vector( 1 downto 0);

	signal	nblig			: std_logic_vector( 1 downto 0);
	signal	debfin			: std_logic_vector( 1 downto 0);
	signal	hsynch			: std_logic_vector( 1 downto 0);
	
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
	diL <= Db;

	-- --------------------------------------------------------- --
RTL0:	LR_DEXT		port map	(
				 	 resetb,clkb
					,hsync_inn,diL,doL
					);

RTL1:	LR_DEXT		port map	(
				 	 resetb,clkb
					,hsync_inn,doL,doF
					);

	-- élément structurant de 3x3x2
	-- --------------------------------------------------------- --
	Dh <= doF		when decalh='0' else FOND;
	Dc <= doL		when decalh='0' else FOND;
	Db <= pixel_inn		when decalv='0' else FOND;

	-- --------------------------------------------------------- --
ELM0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0') then
			Gh <= (others=>'0');	Ch <= (others=>'0');
			Gc <= (others=>'0');	Cc <= (others=>'0');
			Gb <= (others=>'0');	Cb <= (others=>'0');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			Gh <= Ch;		Ch <= Dh;
			Gc <= Cc;		Cc <= Dc;
			Gb <= Cb;		Cb <= Db;
		end if;
	end process;


	-- regarde les voisins de type CONTOUR
	-- --------------------------------------------------------- --
	Si(0) <= '1' when Ch=CONTOUR else '0';		--    Ch
	Si(1) <= '1' when Gc=CONTOUR else '0';		-- Gc    Dc
	Si(2) <= '1' when Dc=CONTOUR else '0';		--    Cb
	Si(3) <= '1' when Cb=CONTOUR else '0';

	St(0) <= '1' when Gh=CONTOUR else '0';		-- Gh    Dh
	St(1) <= '1' when Dh=CONTOUR else '0';		--
	St(2) <= '1' when Gb=CONTOUR else '0';		-- Gb    Db
	St(3) <= '1' when Db=CONTOUR else '0';

	Si(7 downto 4) <= "0000" when connexes='0' else St;


	-- test si le pixel central est une extrémité
	-- --------------------------------------------------------- --
OUT0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			pixel_out <= FOND;

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			-- ----------------------------------------- --
			if ( Cc=CONTOUR )  then
				-- --------------------------------- --
				case Si is
					when "00000000"=>
						pixel_out <= EXTREMITE;

					when "00000001"
					    |"00000010"
					    |"00000100"
					    |"00001000"
					    |"00010000"
					    |"00100000"
					    |"01000000"
					    |"10000000"=>
						pixel_out <= EXTREMITE;

					when "00010001"
					    |"00100001"
					    |"01000010"
					    |"00010010"
					    |"10000100"
					    |"00100100"
					    |"01001000"
					    |"10001000"
					    |"00110001"
					    |"10100100"
					    |"11001000"
					    |"01010010"=>
						pixel_out <= EXTREMITE;

					when others    =>
						pixel_out <= Cc;
				end case;

			-- ----------------------------------------- --
			else
				  pixel_out <= Cc;
			end if;
		end if;
	end process;


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



end ARCH_DETECTEXT;
-- ========================================================================= --
