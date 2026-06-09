-- ========================================================================== --
--
-- Fichier   :	TEST_CMOS.vhd
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

--use work.all;


--  module TEST_CMOS
-- -------------------------------------------------------------------------- --
entity TEST_CMOS is
generic	(
	Periode			: time   :=  25 ns;
	FinSimu			: time	 := 200 ms
	);
end TEST_CMOS;


--  definition de l'architecture de TEST_CMOS
-- -------------------------------------------------------------------------- --
architecture ARCH_TEST_CMOS of TEST_CMOS is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des composants
	-- ---------------------------------------------------------- --
component XC_CMOS
   port (
	RESET  			: in   	std_logic;
	CLK_QUARTZ      	: in    std_logic;
	DATA_CMOS       	: in    std_logic_vector(99 downto 0);
	SELECT_WINDOW   	: in    std_logic_vector( 9 downto 0);
	SELECT_OREC    		: in    std_logic_vector( 2 downto 0);
	SELECT_MODE		: in	std_logic_vector( 1 downto 0);
	INTER0			: in	std_logic;
	INTER1			: in	std_logic;
	CLK_DVI 		: out   std_logic;
	SYSCLK_CMOS     	: out   std_logic;
	ROW_ADDR_CMOS   	: out   std_logic_vector( 9 downto 0);       											
	DATA_READ_ENN_CMOS      : out   std_logic;
	LD_SHIFTN_CMOS  	: out   std_logic;
	CAL_STRST_CMOS  	: out   std_logic;
	ROW_STRTN_CMOS  	: out   std_logic;
	DARK_OFF_ENN_CMOS       : out   std_logic;
	STANDBYN_CMOS   	: out   std_logic;
	LRSTN_CMOS     		: out   std_logic;
	PGN_CMOS       		: out   std_logic;
	TXN_CMOS       		: out   std_logic;
	ROW_DONEN_CMOS	: in	std_logic;
	DIE     		: out   std_logic_vector(23 downto 0);
	DIO    			: out   std_logic_vector(23 downto 0);
	DE      		: out   std_logic;
	HSYNCH  		: out   std_logic;
	VSYNCH  		: out   std_logic;
	CTL1    		: out   std_logic;
	CTL2    		: out   std_logic;
	CTL3    		: out   std_logic;
	EDGE    		: out   std_logic;
	PIXS    		: out   std_logic;
	PD      		: out   std_logic;
	LED     		: out   std_logic
        );
end component;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- ---------------------------------------------------------- --
	signal	EOS			: std_logic := '0';
	signal	RESETB			: std_logic := '0';
	signal	CLK			: std_logic := '0';
	signal	bruit			: std_logic := '0';
	signal	commande		: std_logic := '0';


	-- signal de contrôle du mux vidéo de sortie --
	signal	SELECT_OREC    		: std_logic_vector( 2 downto 0);

	-- signaux de contrôle du CMOS PB-MV13 --
	signal	DATA_CMOS       	: std_logic_vector(99 downto 0);
	signal	SELECT_WINDOW   	: std_logic_vector( 9 downto 0);
	signal	SELECT_MODE		: std_logic_vector( 1 downto 0);

	signal	SYSCLK_CMOS     	: std_logic;
	signal	ROW_ADDR_CMOS   	: std_logic_vector( 9 downto 0);       											
	signal	DATA_READ_ENN_CMOS      : std_logic;
	signal	LD_SHIFTN_CMOS  	: std_logic;
	signal	CAL_STRST_CMOS  	: std_logic;
	signal	ROW_STRTN_CMOS  	: std_logic;
	signal	DARK_OFF_ENN_CMOS       : std_logic;
	signal	STANDBYN_CMOS   	: std_logic;
	signal	LRSTN_CMOS     		: std_logic;
	signal	PGN_CMOS       		: std_logic;
	signal	TXN_CMOS       		: std_logic;
	signal	ROW_DONEN_CMOS		: std_logic := '0';

	-- signaux de contrôle du Silicon Image --
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
	signal	inter0_test,inter1_test :std_logic;

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
MOS0:	XC_CMOS
	       port map	(
			 RESET			=> RESETB
			,CLK_QUARTZ		=> CLK
			,DATA_CMOS		=> DATA_CMOS
			,SELECT_WINDOW		=> SELECT_WINDOW
			,SELECT_OREC		=> SELECT_OREC
			,SELECT_MODE		=> SELECT_MODE
			,INTER0			=> inter0_test
			,INTER1			=> inter1_test
			,CLK_DVI		=> CLK_DVI
			,SYSCLK_CMOS		=> SYSCLK_CMOS
			,ROW_ADDR_CMOS		=> ROW_ADDR_CMOS
			,DATA_READ_ENN_CMOS	=> DATA_READ_ENN_CMOS
			,LD_SHIFTN_CMOS		=> LD_SHIFTN_CMOS
			,CAL_STRST_CMOS		=> CAL_STRST_CMOS
			,ROW_STRTN_CMOS		=> ROW_STRTN_CMOS
			,DARK_OFF_ENN_CMOS	=> DARK_OFF_ENN_CMOS
 			,STANDBYN_CMOS		=> STANDBYN_CMOS
			,LRSTN_CMOS		=> LRSTN_CMOS
			,PGN_CMOS		=> PGN_CMOS
			,TXN_CMOS		=> TXN_CMOS
			,ROW_DONEN_CMOS		=> ROW_DONEN_CMOS
			,DIE			=> DIE
			,DIO			=> DIO
			,DE			=> DE
			,HSYNCH			=> HSYNCH
			,VSYNCH			=> VSYNCH
			,CTL1			=> CTL1
			,CTL2			=> CTL2
			,CTL3			=> CTL3
			,EDGE			=> EDGE
			,PIXS			=> PIXS
			,PD			=> PD
			,LED			=> SORTIE_LED
			);
							
			
	-- ---------------------------------------------------------- --
	RESETB <= '0','1' after 70 ns;
	CLK    <= not CLK after Periode / 2;

commande <= 	'0', '1' after 10 us, '0' after 20 us, '1' after 30 us, '0' after 30.1 us, '1' after 38 us, '0' after 40 us,
		'1' after 40.1 us, '0' after 48 us;
--commande <= not (commande) after 500 ms;
inter0_test <= commande;
inter1_test <= commande;

	-- ---------------------------------------------------------- --
	SELECT_MODE   <= "01";
	SELECT_OREC   <= "111";
	DATA_CMOS     <= "0000000100000000100000000011000000010000000001010000000110000000011100000010000000001001000000101000";
	SELECT_WINDOW <= "0010000000";


end ARCH_TEST_CMOS;
-- ========================================================================== --
	     



