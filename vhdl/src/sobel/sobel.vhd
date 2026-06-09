-- -------------------------------------------------------------------------- --
-- File Name :	SOBEL.vhd
-- Author    :	Philippe Lamaty
-- Purpose   :	réalisation d'une convolution 3x3
--		Note : les coefficients sont supposés normés entre [0,1[
-- 
-- Modification
-- History :	Author		Date		Description
--
--		p.Lamaty	26.04.2002	creation
--
--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

-- définition des librairies
-- ------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;


--  module SOBEL
-- ------------------------------------------------------------------------- --
entity SOBEL is
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 7 downto 0);
         
	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_gx	: out	std_logic_vector( 9 downto 0);
	 pixel_gy	: out	std_logic_vector( 9 downto 0)
	);
end SOBEL;


--  définition de l'architecture de SOBEL
-- ------------------------------------------------------------------------- --
architecture ARCH_SOBEL of SOBEL is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des composants
	-- --------------------------------------------------------- --
component LR_1280x16
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 decalb		: in	std_logic;
	 di		: in	std_logic_vector(15 downto 0);
	 do		: out	std_logic_vector(15 downto 0)
	);
end component;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des types
	-- --------------------------------------------------------- --
	type	SLV8 is array(0 to 2)  of std_logic_vector( 7 downto 0);


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux
	-- --------------------------------------------------------- --
	signal	p_in			: SLV8;
	signal  doL,diL			: std_logic_vector(15 downto 0);

	signal	D,C,B			: std_logic_vector( 7 downto 0);
	signal	E,O,A			: std_logic_vector( 7 downto 0);
	signal	F,G,H			: std_logic_vector( 7 downto 0);

	signal	GX_0			: std_logic_vector( 7 downto 0);
	signal	GX_1			: std_logic_vector( 7 downto 0);
	signal	GX_2			: std_logic_vector( 7 downto 0);
	signal	GX_10			: std_logic_vector( 8 downto 0);
	signal	GX_11			: std_logic_vector( 8 downto 0);

	signal	GY_0			: std_logic_vector( 7 downto 0);
	signal	GY_1			: std_logic_vector( 7 downto 0);
	signal	GY_2			: std_logic_vector( 7 downto 0);
	signal	GY_10			: std_logic_vector( 8 downto 0);
	signal	GY_11			: std_logic_vector( 8 downto 0);

	signal	hsync_rtd		: std_logic_vector( 9 downto 0);
	signal	nblig			: std_logic_vector( 2 downto 0);


-- ========================================================================= --
begin

	-- decalage de la synchronisation horizontal
	-- --------------------------------------------------------- --
SYN0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			hsync_rtd <= (others=>'1');

		elsif ( rising_edge(clk) ) then
			hsync_rtd <= hsync_rtd(8 downto 0) & hsync_inn;
		end if;
	end process;


	-- compteur de lignes
	-- --------------------------------------------------------- --
CPL0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			nblig <= (others=>'1');

		elsif ( rising_edge(clk) ) then
			if ( hsync_rtd(0)='1' and hsync_inn='0' ) then
				nblig <= nblig(1 downto 0) & vsync_inn;
			end if;
		end if;
	end process;


	-- entree de la ligne a retard
	-- --------------------------------------------------------- --
	diL <=  p_in(1) & p_in(0);

	
	-- ligne à retard 
	-- --------------------------------------------------------- --
RTL0:	LR_1280x16     port map	(
				 resetb,clk
				,hsync_inn,diL,doL
				);


	-- registre a decalage 3x1x8 (Ligne x Colonne x Dynamique)
	-- --------------------------------------------------------- --
	p_in(2) <= doL(15 downto  8) when nblig(2 downto 1)/="10" else p_in(1);
	p_in(1) <= doL( 7 downto  0);
	p_in(0) <= pixel_inn         when nblig(1 downto 0)/="01" else p_in(1);


	-- creation du voisinage 3x3x8
	-- --------------------------------------------------------- --
MSK0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			D <= (others=>'0');	C <= (others=>'0');	B <= (others=>'0');
			E <= (others=>'0');	O <= (others=>'0');	A <= (others=>'0');
			F <= (others=>'0');	G <= (others=>'0');	H <= (others=>'0');

		elsif ( rising_edge(clk) ) then
			case hsync_rtd(1 downto 0) is
				when "10"   =>	-- bord gauche
					D <= C;		C <= p_in(2);	B <= p_in(2);
					E <= O;		O <= p_in(1);	A <= p_in(1);
					F <= G;		G <= p_in(0);	H <= p_in(0);

				when "01"   =>	-- bord droit
					D <= C;		C <= B;		B <= B;
					E <= O;		O <= A;		A <= A;
					F <= G;		G <= H;		H <= H;

				when others =>
					D <= C;		C <= B;		B <= p_in(2);
					E <= O;		O <= A;		A <= p_in(1);
					F <= G;		G <= H;		H <= p_in(0);
			end case;
		end if;
	end process;


	-- calcul de	1 0 -1
	-- 		2 0 -2
	--		1 0 -1
	-- --------------------------------------------------------- --
GX0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			GX_0     <= "00000000";
			GX_1     <= "00000000";
			GX_2     <= "00000000";

			GX_10    <= "000000000";
			GX_11    <= "000000000";

			pixel_gx <= "0000000000";

		elsif ( rising_edge(clk) ) then
			GX_0     <= D - B;
			GX_1     <= E - A;
			GX_2     <= F - H;

			GX_10    <= ('0' & GX_0) + ('0' & GX_2);
			GX_11    <= (GX_1 & '0');

			pixel_gx <= ('0' & GX_10) + ('0' & GX_11);
		end if;
	end process;


	-- calcul de	 1  2  1
	-- 		 0  0  0
	--		-1 -2 -1
	-- --------------------------------------------------------- --
GY0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			GY_0     <= "00000000";
			GY_1     <= "00000000";
			GY_2     <= "00000000";

			GY_10    <= "000000000";
			GY_11    <= "000000000";

			pixel_gy <= "0000000000";

		elsif ( rising_edge(clk) ) then
			GY_0     <= D - F;
			GY_1     <= C - G;
			GY_2     <= B - H;

			GY_10    <= ('0' & GY_0) + ('0' & GY_2);
			GY_11    <= (GY_1 & '0');

			pixel_gy <= ('0' & GY_10) + ('0' & GY_11);
		end if;
	end process;


	-- affectation des signaux de sortie
	-- --------------------------------------------------------- --
	hsync_out <= hsync_rtd(4);
	vsync_out <= hsync_rtd(4) or nblig(1);


end ARCH_SOBEL;
-- ========================================================================= --
