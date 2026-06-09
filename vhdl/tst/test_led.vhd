-- ========================================================================== --
--
-- Fichier   :	TEST_LED.vhd
--
-- Auteur    :	Cedric Munoz, Frederic de Melo, Philippe Lamaty
--
-- Copyright :	AEROSPATIALE MATRA Missiles 2001-2001
--
-- -------------------------------------------------------------------------- --
-- Modification :
--
--	Auteur		Date		Version		Commentaire
--
--	c.Munoz		xx.xx.2001	1.0		création
--	f.de Melo	23.07.2001	1.0		    "
--	p.Lamaty	03.10.2001	1.1		
--
-- -------------------------------------------------------------------------- --
-- Rôle :
--
-- Test du module contenant simplement la led
--
-- ========================================================================== --

-- définition des librairies
-- -------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.all;


--  module TEST_LED
-- -------------------------------------------------------------------------- --
entity TEST_LED is
generic	(
	Periode			: time   :=  50 ns;
	FinSimu			: time	 := 200 ms
	);
end TEST_LED;


--  definition de l'architecture de TEST_LED
-- -------------------------------------------------------------------------- --
architecture ARCH_TEST_LED of TEST_LED is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des composants
	-- ---------------------------------------------------------- --
component XC_LED 
   port	(
	RESET		: in  std_logic;
	CLK_QUARTZ      : in  std_logic;
	LED		: out std_logic
	);
end component;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- ---------------------------------------------------------- --
	signal	EOS			: std_logic := '0';
	signal	RESETB			: std_logic := '0';
	signal	CLK			: std_logic := '0';
	signal	SORTIE_LED		: std_logic;


-- ========================================================================== --
begin

	-- GESTION FIN DE SIMULATION
	-- ---------------------------------------------------------- --
	EOS <= '0', '1' after FinSimu;

	-- ---------------------------------------------------------- --
FIN0:	process( EOS )
	begin
		if ( EOS='1' ) then
			ASSERT FALSE REPORT "- I -  Fin de simulation"
			SEVERITY ERROR;
		end if;
	end process;

	-- ---------------------------------------------------------- --
LED0:	XC_LED port map  (
			 RESETB 
			,CLK	
		  	,SORTIE_LED
			);
							
			
	-- ---------------------------------------------------------- --
	RESETB <= '0','1' after 70 ns;
	CLK    <= not CLK after Periode / 2;


end ARCH_TEST_LED;
-- ========================================================================== --
	     
