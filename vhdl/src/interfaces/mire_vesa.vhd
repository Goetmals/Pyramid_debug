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
-- documentation_on
-- Rôle :
--
-- Génération d'une mire pour test de la norme VESA
--
-- documentation_off
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
entity MIRE_VESA is
   port	(
	resetb		: in	std_logic;
	clk		: in	std_logic;

	-- vesa --
	idck_2		: out	std_logic;
	die		: out	std_logic_vector( 7 downto 0);
	dio		: out	std_logic_vector( 7 downto 0);
	de		: out	std_logic;
	hsyn		: out	std_logic;
	vsyn		: out	std_logic
	);
end MIRE_VESA;


--  définition de l'architecture de MIRE_VESA
-- ------------------------------------------------------------------------- --
architecture arch_MIRE_VESA of MIRE_VESA is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des constantes
	-- ---------------------------------------------------------- --
constant	width			: integer := 1688;	--1688;
constant	height			: integer := 1066;	--1066;

constant	dehstart		: integer := 0;		-- 248;
constant	dehend			: integer := 1279;	--1527;
constant	devstart		: integer := 38;
constant	devend			: integer := 1061;

constant	hstart			: integer := 1328;	--1576;
constant	hend			: integer := 1439;	--1687;;

constant	vstart			: integer := 1063;	--1063;
constant	vend			: integer := 1065;	--1065;

constant	pol_hsyn		: std_logic := '0';
constant	pol_vsyn		: std_logic := '0';



	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux
	-- ---------------------------------------------------------- --
	signal	cpt_col 		: integer;
	signal	cpt_lig 		: integer;
	signal	de_int			: std_logic;

	signal	pixel			: std_logic_vector(10 downto 0);


-- ========================================================================== --
begin

	-- ---------------------------------------------------------- --
	pixel	<= conv_std_logic_vector( cpt_col,11 );

	-- ---------------------------------------------------------- --
	idck_2	<= not pixel(0);

	-- génération de la synchro horizontale avec une mire -- 
	-- ---------------------------------------------------------- --
HSY0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
			cpt_col <= hstart;
			hsyn	<= pol_hsyn;	--'0';
			die	<= (others=>'0');
			dio	<= (others=>'0');
			de_int	<= '0';
			de	<= '0';

		elsif ( rising_edge(clk) ) then
			if ( cpt_col = width - 1 ) then
				cpt_col <= 0;		-- Remise à zéro
			else
				cpt_col <= cpt_col + 1;	-- Incrémentation
			end if;

			if ( cpt_col >= hstart and cpt_col <= hend ) then
				hsyn <= not (pol_hsyn);--	'0';
			else
				hsyn <= pol_hsyn;--	'1';
			end if;

			if (    cpt_col >= dehstart and cpt_col <= dehend
			    and cpt_lig >= devstart and cpt_lig <= devend ) then
				die	<=   pixel(10 downto 3);
				dio	<=   pixel(10 downto 3);
				de_int	<= '1';
				de	<= '1';
			else
				die <= (others=>'0');
				dio <= (others=>'0');
				de_int <= '0';
				de <= '0';
			end if;

		end if;
	end process;
		

	-- génération de la synchro verticale -- 
	-- ---------------------------------------------------------- --
VSY0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
			cpt_lig <= vstart;
			vsyn	<= pol_vsyn;--	'1';

		elsif ( rising_edge(clk) ) then
			if ( cpt_col = hstart - 1 ) then
				cpt_lig <= cpt_lig + 1;

				if ( cpt_lig = height - 1 ) then
					cpt_lig <= 0;
				end if;
			end if;

			if ( cpt_lig >= vstart and cpt_lig <= vend ) then
				vsyn <= not (pol_vsyn);	--'0';
			else
				vsyn <= pol_vsyn;--	'1';
			end if;
		end if;
	end process;
				
				
end arch_MIRE_VESA;
-- ========================================================================== --

			

