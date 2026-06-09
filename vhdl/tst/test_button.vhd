-- ========================================================================== --
--
-- Fichier   :	TEST_BUTTON.vhd
--
-- Auteur    :	Philippe Lamaty
--
-- Copyright :	AEROSPATIALE MATRA Missiles 2001-2002
--
-- -------------------------------------------------------------------------- --
-- Modification :
--
--	Auteur		Date		Version		Commentaire
--
--	p.lamaty	10.01.2002	1.0		création

-- -------------------------------------------------------------------------- --
-- Rôle :
--
-- Réalise le test du module BUTTON.
--
-- ========================================================================== --


-- définition des librairies
-- -------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.all;


--  module TEST_BUTTON
-- ------------------------------------------------------------------------- --
entity TEST_BUTTON is
end TEST_BUTTON;


--  définition de l'architecture de TEST_BUTTON
-- ------------------------------------------------------------------------- --
architecture ARCH_TEST_BUTTON of TEST_BUTTON is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des composants
	-- --------------------------------------------------------- --
component BUTTON
   port	(
	resetb		: in	std_logic;
	clk		: in	std_logic;

	button_up	: in	std_logic;
	button_down	: in	std_logic;

	mode		: out	std_logic_vector( 3 downto 0)
	);
end component; 

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux
	-- --------------------------------------------------------- --
	signal resetb			: std_logic := '0';
	signal clk			: std_logic := '0';

	signal btop			: std_logic;
	signal bdown			: std_logic;
	signal mode			: std_logic_vector( 3 downto 0);

	
-- ========================================================================= --
begin		

ATR0:	BUTTON port map	(
			 resetb,clk
			,btop,bdown
			,mode
			);


	-- creation des stimulis resetb,clkb
	-- --------------------------------------------------------- --
	resetb	<= '0','1' after 80 ns;
	clk	<= not clk after  5 ns;
	btop	<= '1'
		  ,'0' after  100 ns
		  ,'1' after  150 ns
		  ,'0' after  200 ns
		  ,'1' after  310 ns
		  ,'0' after 1000 ns
		  ,'1' after 1100 ns
		  ,'0' after 1500 ns
		  ,'1' after 1650 ns;
	bdown	<= '1'
		  ,'0' after  600 ns
		  ,'1' after  640 ns
		  ,'0' after  800 ns
		  ,'1' after  910 ns;


end  ARCH_TEST_BUTTON;
-- ========================================================================= --

	
	
