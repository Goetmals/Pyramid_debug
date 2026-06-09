-- ========================================================================== --
--
-- Fichier   :	XC_LED.vhd
--
-- Auteur    :	Cedric Munoz, Frederic de Melo
--
-- Copyright :	AEROSPATIALE MATRA Missiles 2001-2001
--
-- -------------------------------------------------------------------------- --
-- Modification :
--
--	Auteur		Date		Version		Commentaire
--
--	c.Munoz		xx.xx.2001	1.0		Première version
--	f.de Melo	23.07.2001	1.0			"
--
-- -------------------------------------------------------------------------- --
-- Rôle :
--
-- mire
--
-- ========================================================================== --


-- Définition des librairies
-- -------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- pragma translate_off
library unisim;
use unisim.vcomponents.all;
-- pragma translate_on

use work.all;


--  module XC_LED
-- ------------------------------------------------------------------------- --
entity XC_LED is
   port (
	RESET  			: in   	std_logic;
	CLK_QUARTZ      	: in    std_logic;
--	DATA_CMOS       	: in    std_logic_vector(99 downto 0);
--	SELECT_WINDOW   	: in    std_logic_vector( 9 downto 0);
--	SELECT_OREC    		: in    std_logic_vector( 2 downto 0);
--	SELECT_MODE		: in	std_logic_vector( 1 downto 0);
--	CLK_DVI 		: out   std_logic;
--	SYSCLK_CMOS     	: out   std_logic;
--	ROW_ADDR_CMOS   	: out   std_logic_vector(9 downto 0);       											
--	DATA_READ_ENN_CMOS      : out   std_logic;
--	LD_SHIFTN_CMOS  	: out   std_logic;
--	CAL_STRST_CMOS  	: out   std_logic;
--	ROW_STRTN_CMOS  	: out   std_logic;
--	DARK_OFF_ENN_CMOS       : out   std_logic;
--	STANDBYN_CMOS   	: out   std_logic;
--	LRSTN_CMOS     		: out   std_logic;
--	PGN_CMOS       		: out   std_logic;
--	TXN_CMOS       		: out   std_logic;
--	DIE     		: out   std_logic_vector(23 downto 0);
--	DIO    			: out   std_logic_vector(23 downto 0);
--	DE      		: out   std_logic;
--	HSYNCH  		: out   std_logic;
--	VSYNCH  		: out   std_logic;
--	CTL1    		: out   std_logic;
--	CTL2    		: out   std_logic;
--	CTL3    		: out   std_logic;
--	EDGE    		: out   std_logic;
--	PIXS    		: out   std_logic;
--	PD      		: out   std_logic;
	LED     		: out   std_logic
        );
end XC_LED;


	--  définition de l'architecture de XC_LED
	-- ------------------------------------------------------------------------- --
architecture ARCH_XC_LED of XC_LED is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des composants
	-- ---------------------------------------------------------- --
component LED_LIFE
   port	(
    	resetb		: in	std_logic;
    	clk	        : in	std_logic;

 	sortie_led	: out	std_logic
   	);
end component;

	-- ---------------------------------------------------------- --
component BUFG
   port	(
	O		: out	std_ulogic;
	I		: in	std_ulogic
	);
end component;

	-- ---------------------------------------------------------- --
component BUFGMUX
   port (
	I0		 : in	std_ulogic;
	I1		 : in	std_ulogic;
	S 	         : in	std_ulogic;
	O	         : out	std_ulogic
	);
end component;
        
	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des boîtes noires
	-- ---------------------------------------------------------- --
attribute syn_black_box			: boolean;
attribute syn_black_box of BUFG		: component is true;	
attribute syn_black_box of BUFGMUX	: component is true;
 	
	
	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- ---------------------------------------------------------- --
	signal	clk108MHz 		: std_logic;

	signal  gresetb			: std_logic;
	signal  gclkb40Mhz		: std_logic;
	signal  gclkb108Mhz		: std_logic;


-- ========================================================================== --
begin

	-- buffering du reset
	-- ---------------------------------------------------------- --		
BUF0:   BUFG   	       port map (
		       		 O => gresetb
			   	,I => RESET
		       	   	);


-- buffering de l'horloge à 108 MHz
	-- ---------------------------------------------------------- --		
BUF1:   BUFG   	       port map (
		       		 O => gclkb40Mhz
			   	,I => CLK_QUARTZ
		       	   	);

				
	-- module de clignotement de la led
	-- ---------------------------------------------------------- --
LED0:	LED_LIFE       port map	(
				 resetb		=> gresetb
    				,clk	        => gclkb40Mhz

 				,sortie_led	=> LED
				);


end ARCH_XC_LED;
-- ========================================================================== --
