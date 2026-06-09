-- ========================================================================== --
--
-- Fichier   :	SELECT_SCREEN.vhd
--
-- Auteur    :	Jerome MICHEL
--
-- Copyright :	AEROSPATIALE MATRA Missiles 1998-2001
--
-- -------------------------------------------------------------------------- --
-- Modification :
--
--	Auteur		Date		Version		Commentaire
--
--	J. MICHEL	10.01.2002	1.0		création
--
-- -------------------------------------------------------------------------- --
-- Rôle : Selection du mode de fonctionnement par incrémentation et décrementation
-- d'un compteur.
-- 
--
-- ========================================================================== --



-- Définition des librairies
-- -------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;

--  module SELECT_SCREEN
-- ------------------------------------------------------------------------- --
entity SELECT_SCREEN is
   port	(
	resetb		: in	std_logic;
	clk		: in	std_logic;

	button_up	: in	std_logic;
	button_down	: in	std_logic;

	mode		: out	std_logic_vector( 3 downto 0)
	);
end SELECT_SCREEN;

--  definition de l'architecture de SELECT_SCREEN
-- ------------------------------------------------------------------------- --
architecture ARCH_SELECT_SCREEN of SELECT_SCREEN is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des composants
	-- ---------------------------------------------------------- --

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- ---------------------------------------------------------- --
	signal button_0_rtd, incr_compt	: std_logic := '0';
	signal button_1_rtd, decr_compt	: std_logic := '0';
	signal compteur			: std_logic_vector (3 downto 0) := (others => '0');

-- ========================================================================= --
begin

U0: process (resetb, clk)
begin
if (resetb = '0') then 
	button_0_rtd <= '0';
	incr_compt <= '0';
elsif (rising_edge (clk)) then
	button_0_rtd <= button_up;
	if (button_0_rtd = '1' and  button_up = '0') then incr_compt <= '1';
	else incr_compt <= '0';
	end if;
end if;
end process;

U1: process (resetb, clk)
begin
if (resetb = '0') then 
	button_1_rtd <= '0';
	decr_compt <= '0';
elsif (rising_edge (clk)) then
	button_1_rtd <= button_down;
	if (button_1_rtd = '1' and  button_down = '0') then decr_compt <= '1';
	else decr_compt <= '0';
	end if;
end if;
end process;

U2: process (resetb, clk)
begin
if resetb = '0' then compteur <= (others => '0');
elsif (rising_edge (clk)) then
	if (incr_compt = '1' ) then compteur <= compteur + '1';
	elsif (decr_compt = '1') then compteur <= compteur - '1';
	end if;
end if;
end process;

mode <= compteur;

end ARCH_SELECT_SCREEN;
-- ========================================================================= --

