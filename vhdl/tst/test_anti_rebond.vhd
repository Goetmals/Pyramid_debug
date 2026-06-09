-- -------------------------------------------------------------------------- --
-- File Name :	TEST_ANTI_REBOND.vhd
-- Author    :	Fred de Melo  UBO
-- Purpose   :	Permet la gestion d'un bouton poussoir
--		avec anti_rebond
-- 
-- Modification
-- History :	Author		Date		Description
--
--		f.de melo	  	18.09.2001	First Version
--
--			(c) Copyright LE2i & Aerospatiale Matra Missiles
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;

--  module TEST_ANTI_REBOND
-- ------------------------------------------------------------------------- --
entity TEST_ANTI_REBOND is
end TEST_ANTI_REBOND;

--  définition de l'architecture de TEST_ANTI_REBOND
-- ------------------------------------------------------------------------- --
architecture ARCH_TEST_ANTI_REBOND of TEST_ANTI_REBOND is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des composants externes
	-- --------------------------------------------------------- --
component ANTI_REBOND 
	port (
		clk		: in std_logic;
		reset_b		: in std_logic;
		rplus		: in std_logic;
		splus		: in std_logic;
		rmoins		: in std_logic;
		smoins		: in std_logic;
		cpt_high	: out std_logic_vector (3 downto 0));
end component; 

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux internes
	-- --------------------------------------------------------- --

	signal clk   ,resetb	: std_logic := '0';
	signal rplus ,splus	: std_logic;
	signal rmoins,smoins	: std_logic;
	signal cpt_high		: std_logic_vector (3 downto 0);
	
-- ========================================================================= --
begin		

ATR0:	ANTI_REBOND	port map	(
					 clk,resetb
					,rplus,splus,rmoins,smoins
					,cpt_high
					);
					
	-- creation des stimulis resetb,clkb
	-- --------------------------------------------------------- --
	resetb	<= '0','1' after 80 ns;
	clk	<= not clk after 25 ns;
	rplus	<= '0','1' after 400 ns,'0' after 500 ns,'1' after 1500 ns,'0' after 1550 ns;
	splus	<= '0','1' after 750 ns,'0' after 850 ns,'1' after 1800 ns,'0' after 1875 ns;
	rmoins	<= '0','1' after 600 ns,'0' after 675 ns,'1' after 1400 ns,'0' after 1450 ns;
	smoins	<= '0','1' after 900 ns,'0' after 950 ns,'1' after 2000 ns,'0' after 2075 ns;

end  ARCH_TEST_ANTI_REBOND;

	
	
