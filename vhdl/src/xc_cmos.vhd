-- ========================================================================== --
--
-- Fichier   :	XC_CMOS.vhd
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
-- Acquisition / Traitement / Restitution d'images à partir d'un capteur CMOS.
--
--	SELECT_MODE(0) : fréquence de sortie du flot vidéo (cf. PIXS).
--	SELECT_MODE(1) : mode simultané ou séquentiel
--
--	EDGE :		 '0' ->	Latch DIE/DIO, CTL[3:1], HSYNC, VSYNC sur front 
--				descendant de IDCK
--			,'1' ->	i.e sur front montant
--
--	PIXS :		 pixel select.	 '0' ->   un pixel  (DIE)
--					,'1' -> deux pixels (DIE/DIO)
--
--	PD   :		 power down (actif état bas)
--
-- ========================================================================== --


-- définition des librairies
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

--  module XC_CMOS
-- ------------------------------------------------------------------------- --
entity XC_CMOS is
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
	ROW_DONEN_CMOS		: in	std_logic;
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
end XC_CMOS;


	--  définition de l'architecture de XC_CMOS
	-- ------------------------------------------------------------------------- --
architecture ARCH_XC_CMOS of XC_CMOS is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des composants
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
	I0		: in	std_ulogic := '0';
	I1		: in	std_ulogic := '0';
	S		: in	std_ulogic := '0';
	O		: out	std_ulogic := '0'
	);
end component;
        
	-- ---------------------------------------------------------- --
component LED_LIFE
   port	(
	resetb		: in	std_logic;
	clk		: in	std_logic;

	sortie_led	: out	std_logic
	);
end component;

	-- ---------------------------------------------------------- --
component BUTTON
   port	(
	resetb		: in	std_logic;
	clk		: in	std_logic;

	button_up	: in	std_logic;
	button_down	: in	std_logic;

	mode		: out	std_logic_vector( 3 downto 0)
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
component INCRUSTE
   port	(	
	resetb		: in	std_logic;
	clk		: in	std_logic;
		
	-- mode --
	mode		: in	std_logic_vector( 3 downto 0);
		
	-- imaging technology --
	hsync_inn	: in	std_logic;
	vsync_inn	: in	std_logic;
	pixel_inn	: in	std_logic_vector( 7 downto 0);
		
	-- vesa --
	hsync_out	: out	std_logic;
	vsync_out	: out	std_logic;
	pixel_out	: out	std_logic_vector( 7 downto 0)
	);
end component;

	-- ---------------------------------------------------------- --
component INTER_CMOS
   port	(	
	resetb		: in	std_logic;
	clk108MHz	: in	std_logic;

	-- signaux de contrôle du capteur CMOS --
	clk10_8		: out 	std_logic;
	row_strt_n	: out 	std_logic;
	ld_shift_n	: out	std_logic;
	dat_read_en_n	: out	std_logic;
	row_addr	: out	std_logic_vector( 9 downto 0);
	tx_n		: out 	std_logic;
	pg_n		: out 	std_logic;
	cal_strt_n	: out 	std_logic;
	lrst_n		: out	std_logic;
	dark_off_enn	: out   std_logic;
	standby_n	: out   std_logic;

	-- données du capteur CMOS --
	data		: in 	std_logic_vector(99 downto 0);
	select_mode	: in 	std_logic;
	row_exposure	: in 	std_logic_vector( 9 downto 0);

	-- imaging technology --
	hsync_out	: out 	std_logic;
	vsync_out	: out	std_logic;
	pixel_out	: out	std_logic_vector( 7 downto 0)
	);
end component;

	-- ---------------------------------------------------------- --
component OREC
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 csin0		: in	std_logic_vector( 6 downto 0);
	 csin1		: in	std_logic_vector( 6 downto 0);
	 csin2		: in	std_logic_vector( 6 downto 0);
	 csin3		: in	std_logic_vector( 6 downto 0);
	 csin4		: in	std_logic_vector( 6 downto 0);
	 csin5		: in	std_logic_vector( 6 downto 0);

	 camp		: in	std_logic_vector( 7 downto 0);

	 seuil_bas	: in	std_logic_vector( 7 downto 0);
	 seuil_haut	: in	std_logic_vector( 7 downto 0);

	 mode           : in	std_logic_vector( 2 downto 0);

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 7 downto 0);
	 
	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 7 downto 0)
	);
end component;

	-- ---------------------------------------------------------- --
component INTER_VESA
   port	(	
	resetb		: in	std_logic;
	clk		: in	std_logic;
		
	-- mode even/odd --
	pixel_mode	: in	std_logic;
		
	-- imaging technology --
	hsync_img	: in	std_logic;
	vsync_img	: in	std_logic;
	pixel_img	: in	std_logic_vector( 7 downto 0);
		
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


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des boîtes noires
	-- ---------------------------------------------------------- --
attribute syn_black_box : boolean;
attribute syn_black_box of BUFG: component is true;
attribute syn_black_box of BUFGMUX: component is true;

attribute syn_macro : boolean;
attribute syn_macro of OUT0 : label is true;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- ---------------------------------------------------------- --
	signal  gresetb			: std_logic;
	signal	clk108MHz 		: std_logic;
	signal  gclk40Mhz		: std_logic;
	signal  gclk108Mhz		: std_logic;

	signal	hsync_inn		: std_logic;
	signal	vsync_inn 		: std_logic;
	signal	pixel_inn  		: std_logic_vector( 7 downto 0);

	signal	csin0			: std_logic_vector( 6 downto 0);
	signal	csin1			: std_logic_vector( 6 downto 0);
	signal	csin2			: std_logic_vector( 6 downto 0);
	signal	csin3			: std_logic_vector( 6 downto 0);
	signal	csin4			: std_logic_vector( 6 downto 0);
	signal	csin5			: std_logic_vector( 6 downto 0);
	signal	camp			: std_logic_vector( 7 downto 0);
	signal	seuil_bas		: std_logic_vector( 7 downto 0);
	signal	seuil_haut		: std_logic_vector( 7 downto 0);

	signal	hsync_inc		: std_logic;
	signal	vsync_inc		: std_logic;
	signal	pixel_inc		: std_logic_vector( 7 downto 0);

	signal	hsync_out		: std_logic;
	signal	vsync_out		: std_logic;
	signal	pixel_out		: std_logic_vector( 7 downto 0);
	
	signal	img_idck,mir_idck	: std_logic;
	signal	img_die	,mir_die	: std_logic_vector( 7 downto 0);
	signal	img_dio	,mir_dio	: std_logic_vector( 7 downto 0);
	signal	img_de	,mir_de		: std_logic;
	signal	img_hsyn,mir_hsyn	: std_logic;
	signal	img_vsyn,mir_vsyn	: std_logic;

	signal	display_mode		: std_logic_vector (3 downto 0);


-- ========================================================================== --
begin

	-- coefficient du convolueur
	-- ---------------------------------------------------------- --
--	csin0 <= conv_std_logic_vector( 15,7 );
--	csin1 <= conv_std_logic_vector( 15,7 );
--	csin2 <= conv_std_logic_vector( 15,7 );
--	csin3 <= conv_std_logic_vector( 15,7 );
--	csin4 <= conv_std_logic_vector( 15,7 );
--	csin5 <= conv_std_logic_vector( 15,7 );

	csin0 <= conv_std_logic_vector( 3,7 );
	csin1 <= conv_std_logic_vector( 8,7 );
	csin2 <= conv_std_logic_vector( 15,7 );
	csin3 <= conv_std_logic_vector( 24,7 );
	csin4 <= conv_std_logic_vector( 33,7 );
	csin5 <= conv_std_logic_vector( 41,7 );


	-- coefficient d'amplification
	-- ---------------------------------------------------------- --
--	camp  <= conv_std_logic_vector( 10,6 );
	camp  <= conv_std_logic_vector( 112,8 );


	-- seuil bas et haut
	-- ---------------------------------------------------------- --
--	seuil_bas  <= conv_std_logic_vector( 4,8 );
--	seuil_haut <= conv_std_logic_vector( 4,8 );
	seuil_bas  <= conv_std_logic_vector( 5,8 );
	seuil_haut <= conv_std_logic_vector( 20,8 );


	-- buffering du reset
	-- ---------------------------------------------------------- --		
--BUF0:   BUFG   	       port map (
--		       		 O => gresetb
--			   	,I => RESET
--		       	   	);
	gresetb <= RESET;


	-- buffering de l'horloge à 108 MHz
	-- ---------------------------------------------------------- --		
BUF1:   BUFG   	       port map (
		       		 O => gclk40Mhz
			   	,I => CLK_QUARTZ
		       	   	);


	-- module de clignotement de la led
	-- ---------------------------------------------------------- --
LED0:	LED_LIFE       port map	(
				 resetb		=> gresetb
    				,clk	        => gclk40Mhz

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


	-- pilote du capteur CMOS
	-- ---------------------------------------------------------- --
SYN0:	INTER_CMOS     port map	(
				 resetb		=> gresetb	
				,clk108MHz	=> gclk108Mhz			

				,clk10_8	=> SYSCLK_CMOS	
				,row_strt_n	=> ROW_STRTN_CMOS
				,ld_shift_n	=> LD_SHIFTN_CMOS
				,dat_read_en_n	=> DATA_READ_ENN_CMOS
				,row_addr	=> ROW_ADDR_CMOS
				,tx_n		=> TXN_CMOS
				,pg_n		=> PGN_CMOS
				,cal_strt_n	=> CAL_STRST_CMOS
				,lrst_n		=> LRSTN_CMOS
				,dark_off_enn	=> DARK_OFF_ENN_CMOS
				,standby_n	=> STANDBYN_CMOS

				,data		=> DATA_CMOS
				,select_mode	=> SELECT_MODE(1)
				,row_exposure	=> SELECT_WINDOW

				,hsync_out	=> hsync_inn
				,vsync_out	=> vsync_inn
				,pixel_out	=> pixel_inn
				);


	-- traitement bas niveau du flux vidéo --
	-- ---------------------------------------------------------- --
OREC0:	OREC	       port map	(
				 resetb		=> gresetb
				,clk		=> gclk108Mhz

				,csin0		=> csin0
	 			,csin1		=> csin1
	 			,csin2		=> csin2
	 			,csin3		=> csin3
	 			,csin4		=> csin4
	 			,csin5		=> csin5
	 			,camp		=> camp
	 			,seuil_bas	=> seuil_bas
	 			,seuil_haut	=> seuil_haut
	 			,mode           => display_mode (2 downto 0)

	 			,hsync_inn	=> hsync_inn
	 			,vsync_inn	=> vsync_inn
	 			,pixel_inn	=> pixel_inn

	 			,hsync_out	=> hsync_out
	 			,vsync_out	=> vsync_out
	 			,pixel_out	=> pixel_out
				);

	-- Incrustation un cartouche --
	-- ---------------------------------------------------------- --
INCRUSTE0: INCRUSTE   port map	(	
				 resetb		=> gresetb
				,clk		=> gclk108Mhz
		
				-- mode --
				,mode		=> display_mode
		
				-- input image --
				,hsync_inn	=> hsync_out	--hsync_inn
				,vsync_inn	=> vsync_out	--vsync_inn
				,pixel_inn	=> pixel_out	--pixel_inn
		
				-- output image --
				,hsync_out	=> hsync_inc
				,vsync_out	=> vsync_inc
				,pixel_out	=> pixel_inc
				);
 

	-- mise au standard VESA du format imaging --
	-- ---------------------------------------------------------- --
VSA0:	INTER_VESA     port map	(	
				 resetb		=> gresetb
				,clk		=> gclk108Mhz
		
				,pixel_mode	=> SELECT_MODE(0)
		
				,hsync_img	=> hsync_inc
				,vsync_img	=> vsync_inc
				,pixel_img	=> pixel_inc
		
				,idck_2		=> img_idck
				,die		=> img_die
				,dio		=> img_dio
				,de		=> img_de
				,hsyn		=> img_hsyn
				,vsyn		=> img_vsyn
				);


	-- génération d'une mire --
	-- ---------------------------------------------------------- --
MIR0:	MIRE_VESA      port map	(
				 resetb		=> gresetb
				,clk		=> gclk108Mhz

				,idck_2		=> mir_idck
				,die		=> mir_die
				,dio		=> mir_dio
				,de		=> mir_de
				,hsyn		=> mir_hsyn
				,vsyn		=> mir_vsyn
				);

	-- ---------------------------------------------------------- --
BUT0:	BUTTON	       port map	(
				 resetb		=> gresetb
				,clk		=> gclk40Mhz

				,button_up	=> INTER0
				,button_down	=> INTER1

				,mode		=> display_mode
				);


	-- mux de sortie --
	-- ---------------------------------------------------------- --
--	CLK_DVI	<= gclk108Mhz  when SELECT_MODE(0)='0' else mir_idck;	--idck_delay;

	CLK_DVI	<=   gclk108Mhz	when SELECT_MODE(0) = '0'
		else mir_idck	when display_mode = "1000"
		else img_idck;

	CTL1	<= '0';
	CTL2	<= '0';
	CTL3	<= '0';
	EDGE	<= '1';
	PIXS	<= SELECT_MODE(0);
	PD	<= '1';

	-- ---------------------------------------------------------- --
OUT0:	process ( gresetb,gclk108Mhz )
	begin
		if    ( gresetb = '0' ) then
			DIE	<= "000000000000000000000000";
			DIO	<= "000000000000000000000000";
			DE	<= '0';
			HSYNCH	<= '0';
			VSYNCH	<= '0';

		elsif ( rising_edge(gclk108Mhz) ) then
			if display_mode ="1000" then
			DE	<= mir_de;
			HSYNCH	<= mir_hsyn;
			VSYNCH	<= mir_vsyn;
			else
			DE	<= img_de;
			HSYNCH	<= img_hsyn;
			VSYNCH	<= img_vsyn;
			end if;

			if ( SELECT_OREC(2)='1' ) then			-- ROUGE
				if display_mode ="1000" then
					DIE(23 downto 16) <= mir_die;
					DIO(23 downto 16) <= mir_dio;
				else 
					DIE(23 downto 16) <= img_die;
					DIO(23 downto 16) <= img_dio;
				end if;
			else
				DIE(23 downto 16) <= "00000000";
				DIO(23 downto 16) <= "00000000";
			end if;

			if ( SELECT_OREC(1)='1' ) then			-- VERT
				if display_mode ="1000" then
					DIE(15 downto  8) <= mir_die;
					DIO(15 downto  8) <= mir_dio;
				else 
					DIE(15 downto  8) <= img_die;
					DIO(15 downto  8) <= img_dio;
				end if;
			else
				DIE(15 downto  8) <= "00000000";
				DIO(15 downto  8) <= "00000000";
			end if;

			if ( SELECT_OREC(0)='1' ) then			-- BLEU
				if display_mode ="1000" then
					DIE( 7 downto  0) <= mir_die;
					DIO( 7 downto  0) <= mir_dio;
				else
					DIE( 7 downto  0) <= img_die;
					DIO( 7 downto  0) <= img_dio;
				end if;
			else
				DIE( 7 downto  0) <= "00000000";
				DIO( 7 downto  0) <= "00000000";
			end if;
		end if;
	end process;


end ARCH_XC_CMOS;
-- ========================================================================== --
