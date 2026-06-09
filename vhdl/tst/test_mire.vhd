-- ========================================================================== --
--
-- Fichier   :	TEST_MIRE.vhd
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


--  module TEST_MIRE
-- -------------------------------------------------------------------------- --
entity TEST_MIRE is
generic	(
	Periode			: time   :=  25 ns;
	FinSimu			: time	 := 200 ms
	);
end TEST_MIRE;


--  definition de l'architecture de TEST_MIRE
-- -------------------------------------------------------------------------- --
architecture ARCH_TEST_MIRE of TEST_MIRE is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des composants
	-- ---------------------------------------------------------- --
component XC_MIRE
   port (
	RESET  			: in	std_logic;
	CLK_QUARTZ      	: in	std_logic;
	CLK_DVI 		: out   std_logic;
	DIE     		: out	std_logic_vector(23 downto 0);
	DIO    			: out	std_logic_vector(23 downto 0);
	DE      		: out	std_logic;
	HSYNCH  		: out	std_logic;
	VSYNCH  		: out	std_logic;
	CTL1    		: out	std_logic;
	CTL2    		: out	std_logic;
	CTL3    		: out	std_logic;
	EDGE    		: out	std_logic;
	PIXS    		: out	std_logic;
	PD      		: out	std_logic;
	LED     		: out	std_logic
        );
end component;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- ---------------------------------------------------------- --
	signal	EOS			: std_logic := '0';
	signal	RESETB			: std_logic := '0';
	signal	CLK			: std_logic := '0';

	signal	CLK_DVI 		: std_logic;
	signal	DIE     		: std_logic_vector(23 downto 0);
	signal	DIO    			: std_logic_vector(23 downto 0);
	signal	DE      		: std_logic;
	signal	HSYNCH  		: std_logic;
	signal	VSYNCH  		: std_logic;
	signal	CTL1    		: std_logic;
	signal	CTL2    		: std_logic;
	signal	CTL3    		: std_logic;
	signal	EDGE    		: std_logic;
	signal	PIXS    		: std_logic;
	signal	PD      		: std_logic;

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
MIR0:	XC_MIRE
	       port map	(
			 RESET		=> RESETB
			,CLK_QUARTZ	=> CLK
			,CLK_DVI	=> CLK_DVI
			,DIE		=> DIE
			,DIO		=> DIO
			,DE		=> DE
			,HSYNCH		=> HSYNCH
			,VSYNCH		=> VSYNCH
			,CTL1		=> CTL1
			,CTL2		=> CTL2
			,CTL3		=> CTL3
			,EDGE		=> EDGE
			,PIXS		=> PIXS
			,PD		=> PD
			,LED		=> SORTIE_LED
			);
							
			
	-- ---------------------------------------------------------- --
	RESETB <= '0','1' after 70 ns;
	CLK    <= not CLK after Periode / 2;


end ARCH_TEST_MIRE;
-- ========================================================================== --
	     
