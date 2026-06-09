-- ========================================================================== --
--
-- Fichier   :	XC_MIRE.vhd
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


--  module XC_MIRE
-- ------------------------------------------------------------------------- --
entity XC_MIRE is
   port (
	RESET  			: in	std_logic;
	CLK_QUARTZ      	: in	std_logic;
--	DATA_CMOS       	: in	std_logic_vector(99 downto 0);
	SELECT_WINDOW   	: in	std_logic_vector( 9 downto 0);
	SELECT_OREC    		: in	std_logic_vector( 2 downto 0);
	SELECT_MODE		: in	std_logic_vector( 1 downto 0);
	CLK_DVI 		: out	std_logic;
--	SYSCLK_CMOS     	: out	std_logic;
--	ROW_ADDR_CMOS   	: out	std_logic_vector(9 downto 0);       											
--	DATA_READ_ENN_CMOS      : out	std_logic;
--	LD_SHIFTN_CMOS  	: out	std_logic;
--	CAL_STRST_CMOS  	: out	std_logic;
--	ROW_STRTN_CMOS  	: out	std_logic;
--	DARK_OFF_ENN_CMOS       : out	std_logic;
--	STANDBYN_CMOS   	: out	std_logic;
--	LRSTN_CMOS     		: out	std_logic;
--	PGN_CMOS       		: out	std_logic;
--	TXN_CMOS       		: out	std_logic;
	DIE     		: out	std_logic_vector(23 downto 0);
	DIO    			: out	std_logic_vector(23 downto 0);
	DE      		: out	std_logic;
	HSYNCH  		: out   std_logic;
	VSYNCH  		: out	std_logic;
	PROBE_HSYNCH  		: out   std_logic;
	PROBE_VSYNCH  		: out	std_logic;
	CTL1    		: out	std_logic;
	CTL2    		: out	std_logic;
	CTL3    		: out   std_logic;
	EDGE    		: out	std_logic;
	PIXS    		: out   std_logic;
	PD      		: out	std_logic;
	LED     		: out	std_logic;

	HPD			: in	std_logic;
	SCL_INN			: in	std_logic;
	SCL_OUT			: out	std_logic;
	SDA_INN			: in	std_logic;
	SDA_OUT			: out	std_logic
        );
end XC_MIRE;


	--  définition de l'architecture de XC_MIRE
	-- ------------------------------------------------------------------------- --
architecture ARCH_XC_MIRE of XC_MIRE is

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
component EDCM108
   port	(
	resetb		: in	std_logic;
	clk40MHz	: in	std_logic;

	clk108MHz	: out	std_logic
	);
end component;

	-- ---------------------------------------------------------- --
component MIRE_VESA
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

	-- ---------------------------------------------------------- --
component I2C
   port	(
	reset		: in	std_logic;
	led		: in	std_logic;
	clk		: in	std_logic;
	scl		: out	std_logic;
	sda		: out	std_logic;
	watch_ack	: out	std_logic
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
	signal  gresetb			: std_logic;
	signal  gclk40Mhz		: std_logic;

	signal	clk108MHz 		: std_logic;
	signal  gclk108Mhz		: std_logic;

	signal	clk54Mhz		: std_logic;

	signal	led_int			: std_logic;
	signal	sda_int			: std_logic;
	signal	scl_int			: std_logic;
	signal	watch_ack_int		: std_logic;
	signal  reset_I2C		: std_logic;
	signal	HSYNCH_INT		: std_logic;
	signal	VSYNCH_INT		: std_logic;
	signal	VSYNCH_PROBE		: std_logic;
	signal	compte			: integer range 0 to 1024 := 0;
	signal	IDCK_2			: std_logic;
	signal	DIE_INT			: std_logic_vector( 7 downto 0);
	signal	DIO_INT			: std_logic_vector( 7 downto 0);


-- ========================================================================== --
begin
SDA_OUT <= not (sda_int);
SCL_OUT <= not (scl_int);
--SCL_OUT <= led_int;
--SDA_OUT <= led_int;

	-- buffering du reset
	-- ---------------------------------------------------------- --		
BUF0:   BUFG   	       port map (
		       		 O => gresetb
			   	,I => RESET
		       	   	);


	-- buffering de l'horloge à 40 MHz
	-- ---------------------------------------------------------- --		
BUF1:   BUFG   	       port map (
		       		 O => gclk40Mhz
			   	,I => CLK_QUARTZ
		       	   	);

				
	-- module de clignotement de la led
	-- ---------------------------------------------------------- --
LED0:	LED_LIFE       port map	(
				 resetb		=> gresetb
    				,clk	        => CLK_QUARTZ

 				,sortie_led	=> LED
				);


	-- génération de l'horloge à 108 MHz
	-- ---------------------------------------------------------- --
DCM0:	EDCM108	       port map	(
	 			 resetb		=> gresetb
				,clk40MHz	=> gclk40Mhz

				,clk108MHz	=> clk108MHz
				);

				
	-- buffering de l'horloge à 108 MHz
	-- ---------------------------------------------------------- --		
BUF2:   BUFG   	       port map (
		       		 O => gclk108Mhz
			   	,I => clk108MHz
		       	   	);

						
	-- génération de la mire
	-- ---------------------------------------------------------- --
MIR0:	MIRE_VESA
	       port map	(
			 resetb		=> gresetb
			,clk		=> gclk108Mhz

			,idck_2		=> IDCK_2
			,die		=> DIE_INT
			,dio		=> DIO_INT
			,de		=> DE
			,hsyn		=> HSYNCH_INT
			,vsyn		=> VSYNCH_INT
			);

	-- ---------------------------------------------------------- --
	CLK_DVI	<= gclk108Mhz  when SELECT_MODE(0)='0' else IDCK_2;
	CTL1	<= '0';
	CTL2	<= '0';
	CTL3	<= '0';
	EDGE	<= '1';
	PIXS	<= SELECT_MODE(0);
	PD	<= '1';

	DIE	<= DIE_INT & DIE_INT & DIE_INT;
	DIO	<= DIO_INT & DIO_INT & DIO_INT;
	HSYNCH	<= HSYNCH_INT;
	VSYNCH	<= VSYNCH_INT;

	-- ---------------------------------------------------------- --
CPT0:	process ( gresetb,gclk108Mhz )
	begin
		if    ( gresetb = '0' ) then
			compte <= 0;
		elsif ( rising_edge(gclk108Mhz) ) then
			compte <= (compte + 1) mod 1024;
		end if;

		if ( compte > 3 and compte < 16 ) then
			VSYNCH_PROBE <= '1';
		else
			VSYNCH_PROBE <= '0';
		end if;
	end process;

	PROBE_HSYNCH	<= HSYNCH_INT;
	PROBE_VSYNCH	<= VSYNCH_PROBE;

	reset_I2C	<= gresetb;

	-- ---------------------------------------------------------- --
I2C0:	I2C
	       port map	(
			 reset		=> reset_I2C
			,led		=> led_int
			,clk		=> CLK_QUARTZ
			,scl		=> scl_int
			,sda		=> sda_int
			,watch_ack	=> watch_ack_int
			);


end ARCH_XC_MIRE;
-- ========================================================================== --
