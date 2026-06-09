-- ========================================================================== --
--
-- Fichier   :	MIRE_VESA.vhd
--
-- Auteur    :	Cedric Munoz (LE2I), Philippe lamaty
--
-- Copyright :	AEROSPATIALE MATRA Missiles 2001-2001
--
-- -------------------------------------------------------------------------- --
-- Modification :
--
--	Auteur		Date		Version		Commentaire
--
--	c.Munoz		10.07.2001	1.0		création
--	p.Lamaty	02.10.2001	1.1
--
-- -------------------------------------------------------------------------- --
-- Rôle :
--
-- Génération d'une mire pour test de la norme VESA
--
--	EDGE	:	 '0' ->	Latch DIE/DIO, CTL[3:1], HSYNC, VSYNC sur front 
--				descendant de IDCK
--			,'1' ->	i.e sur front montant
--
--	PIXS	:	pixel select.	 '0' ->   un pixel  (DIE)
--					,'1' -> deux pixels (DIE/DIO)
--
--	PD	:	Power down (actif état bas)
--
-- ========================================================================== --


-- définition des librairies
-- -------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.all;


--  module MIRE_VESA
-- ------------------------------------------------------------------------- --
entity CONNECT_VESA is
   port	(
	resetb		: in	std_logic;
	clk		: in	std_logic;

	idck		: in	std_logic;
	die		: out	std_logic_vector(23 downto 0);
	dio		: out	std_logic_vector(23 downto 0);
	de		: in	std_logic;
	hsyn		: in	std_logic;
	vsyn		: in	std_logic;
	ctl1		: out	std_logic;
	ctl2		: out	std_logic;
	ctl3		: out	std_logic;
	edge		: out	std_logic;
	pixs		: out	std_logic;
	pd		: out	std_logic
	);
end CONNECT_VESA;



--  définition de l'architecture de MIRE_VESA
-- ------------------------------------------------------------------------- --
architecture arch_CONNECT_VESA of CONNECT_VESA is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- ---------------------------------------------------------- --
constant	width			: integer := 832;	--1688;
constant	height			: integer := 509;	--1066;

constant	destart			: integer :=  80;	--   0;
constant	deend			: integer := 719;	--1279;

constant	hstart			: integer := 776;	--1328;
constant	hend			: integer := 831;	--1439;

constant	vstart			: integer := 506;	--1025;
constant	vend			: integer := 508;	--1028;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- ---------------------------------------------------------- --
	signal	cpt_col 		: integer;
	signal	cpt_lig 		: integer;

	signal	data			: std_logic_vector( 7 downto 0);
	signal	pixel			: std_logic_vector(10 downto 0);


-- ========================================================================== --
begin

	-- ---------------------------------------------------------- --
--	die	<= data & data & data;
	die	<= (others => '0');
	dio	<= (others => '0');
	ctl1	<= '0';
	ctl2	<= '0';
	ctl3	<= '0';
	edge	<= '1';	--'0';
	pixs	<= '0';
	pd	<= '1';	

	-- ---------------------------------------------------------- --
	pixel	<= conv_std_logic_vector( cpt_col,11 );


	-- ---------------------------------------------------------- --
-- --	idck	<= not pixel(0);
--	idck	<= clk;


	-- génération de la synchro horizontale avec une mire -- 
	-- ---------------------------------------------------------- --
HSY0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
--			hsyn	<= '0';
--			de	<= '0';
			cpt_col <= hstart;
			data    <= (others=>'0');

		elsif ( rising_edge(clk) ) then
--			if ( cpt_col = width - 1 ) then
--				cpt_col <= 0;		-- Remise à zéro
--			else
--				cpt_col <= cpt_col + 1;	-- Incrémentation
--			end if;

--			if ( cpt_col >= hstart and cpt_col <= hend ) then
--				hsyn <= '0';
--			else
--				hsyn <= '1';
--			end if;
--
--			if ( cpt_col >= destart and cpt_col <= deend ) then
--				de <= '1';
--			else
--				de <= '0';
--			end if;
data <= pixel(8) & pixel(9) & pixel(10) & pixel(9) & hsyn & vsyn & de & idck;
--			data	<= pixel(8) & pixel(9) & pixel(10)
--				 & pixel(8) & pixel(9) & pixel(10)
--				 & pixel(8) & pixel(9);
		end if;
	end process;
		

	-- génération de la synchro verticale -- 
	-- ---------------------------------------------------------- --
VSY0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
			cpt_lig <= vstart;
--			vsyn	<= '1';

		elsif ( rising_edge(clk) ) then
			if ( cpt_col = hstart - 1 ) then
				cpt_lig <= cpt_lig + 1;

				if ( cpt_lig = height - 1 ) then
					cpt_lig <= 0;
				end if;
			end if;

--			if ( cpt_lig >= vstart and cpt_lig <= vend ) then
--				vsyn <= '0';
--			else
--				vsyn <= '1';
--			end if;
		end if;
	end process;
				
				
end arch_CONNECT_VESA;
-- ========================================================================== --

			

