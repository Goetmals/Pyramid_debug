-- -------------------------------------------------------------------------- --
-- File Name :	test_carte.vhd
-- Author    :	Fred de Melo
-- Purpose   :	testbench
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--              f.de Melo         .  .2001      FPGA     Version

--		    (c) Copyright AEROSPATIALE MATRA Missiles
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;

entity TEST_CARTE is
generic (
	 WIDTH			: integer := 1280;
	 HEIGHT			: integer := 1024;
	 
	 nomDest		: string := "./tst/resultat_carte.imv";
	 
	 WIDTH_VSA		: integer := 1688;
	 HEIGHT_VSA		: integer := 1066;
	 HSTART_VSA		: integer :=  247;
	 HEND_VSA		: integer := 1527;
	 VSTART_VSA		: integer :=   37;
	 VEND_VSA		: integer := 1061
	);
end TEST_CARTE;

--  définition de l'architecture de TEST_CARTE
-- ------------------------------------------------------------------------- --
architecture ARCH_TEST_CARTE of TEST_CARTE is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des composants externes
	-- --------------------------------------------------------- --

component PB_MV13 
   	generic (
		width			: integer := 1280;  
	  	height			: integer := 1024    
		);
		
	port 	(	
		l_rst_n			: in	std_logic;
		sysclk			: in	std_logic;
		row_addr		: in	std_logic_vector(9 downto 0);
		row_strt_n		: in 	std_logic;
		ld_shift_n		: in	std_logic;
		dat_read_en_n		: in	std_logic;
		cal_strt_n		: in 	std_logic;
		tx_n			: in 	std_logic;
		pg_n			: in 	std_logic;
		dark_off_enn		: in   std_logic;
		
		row_done_n		: out 	std_logic;
		cal_done_n		: out 	std_logic;
		data			: out 	std_logic_vector(99 downto 0);
		pixel_clk_out		: out	std_logic
		
		);
end component;

	-- ---------------------------------------------------------- --
component APRIS
	port (
	RESET  			: in   	std_logic;
	CLK_QUARTZ      	: in    std_logic;
	DATA_CMOS       	: in    std_logic_vector(99 downto 0);
	SELECT_WINDOW   	: in    std_logic_vector( 9 downto 0);
	SELECT_OREC    		: in    std_logic_vector( 2 downto 0);
	SELECT_MODE		: in	std_logic_vector( 1 downto 0);
	CLK_DVI 		: out   std_logic;
	SYSCLK_CMOS     	: out   std_logic;
	ROW_ADDR_CMOS   	: out   std_logic_vector(9 downto 0);       											
	DATA_READ_ENN_CMOS      : out   std_logic;
	LD_SHIFTN_CMOS  	: out   std_logic;
	CAL_STRST_CMOS  	: out   std_logic;
	ROW_STRTN_CMOS  	: out   std_logic;
	DARK_OFF_ENN_CMOS       : out   std_logic;
	STANDBYN_CMOS   	: out   std_logic;
	LRSTN_CMOS     		: out   std_logic;
	PGN_CMOS       		: out   std_logic;
	TXN_CMOS       		: out   std_logic;
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

	-- ---------------------------------------------------------- --
component WRITE_VESA
	generic	(
	 nomfichier	: string := "Imaging/ima.dst.imv";
	 
	 width			: integer := 1688;
	 height			: integer := 1066;
	 hstart			: integer :=  247;
	 hend			: integer := 1527;
	 vstart			: integer :=   37;
	 vend			: integer := 1061
	);
	
   port ( 
	 resetb		: in    std_logic;
	 clk		: in    std_logic;

	 mode		: in	std_logic;
	 
	 hsync_vsa	: in	std_logic;
	 vsync_vsa	: in	std_logic;
	 pixel_die	: in	std_logic_vector(23 downto 0);
	 pixel_dio	: in	std_logic_vector(23 downto 0)
	);
end component;

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux internes
	-- --------------------------------------------------------- --
	
	signal reset  			: std_logic;
	signal clk	   	   	: std_logic := '0';
	signal data_cmos       		: std_logic_vector(99 downto 0);
	signal select_window   		: std_logic_vector( 9 downto 0);
	signal select_orec    		: std_logic_vector( 2 downto 0);
	signal select_mode		: std_logic_vector( 1 downto 0);
	signal clk_dvi 			: std_logic;
	signal sysclk_cmos     		: std_logic;
	signal row_addr_cmos   		: std_logic_vector(9 downto 0);       											
	signal data_read_enn_cmos    	: std_logic;
	signal ld_shiftn_cmos  		: std_logic;
	signal cal_strtn_cmos  		: std_logic;
	signal row_strtn_cmos  		: std_logic;
	signal dark_off_enn_cmos       	: std_logic;
	signal standby_cmos   		: std_logic;
	signal lrstn_cmos     		: std_logic;
	signal pgn_cmos       		: std_logic;
	signal txn_cmos       		: std_logic;
	signal die     			: std_logic_vector(23 downto 0);
	signal dio    			: std_logic_vector(23 downto 0);
	signal de      			: std_logic;
	signal hsynch  			: std_logic;
	signal vsynch  			: std_logic;
	signal ctl1    			: std_logic;
	signal ctl2    			: std_logic;
	signal ctl3    			: std_logic;
	signal edge    			: std_logic;
	signal pixs    			: std_logic;
	signal pd      			: std_logic;
	signal led     			: std_logic;
	 
	signal pixel_clk_out 		: std_logic;
	signal row_done_n		: std_logic;
	signal cal_done_n		: std_logic;
	
-- ========================================================================= --
begin
	
	-- Module APRIS.
	-- --------------------------------------------------------- --	
APR0:	APRIS		port map	(
					 reset,clk
					,data_cmos
					,select_window,select_orec,select_mode
					,clk_dvi,sysclk_cmos
					,row_addr_cmos,data_read_enn_cmos
					,ld_shiftn_cmos,cal_strtn_cmos,row_strtn_cmos
					,dark_off_enn_cmos,standby_cmos,lrstn_cmos
					,pgn_cmos,txn_cmos
					,die,dio,de
					,hsynch,vsynch
					,ctl1,ctl2,ctl3
					,edge,pixs,pd,led
					);
	
	-- Modèle CMOS.
	-- --------------------------------------------------------- --			
PBM0:	PB_MV13 	generic map 	(
			    		 width  	=> WIDTH
			    		,height 	=> HEIGHT
			    		)
			 
			 port map	(
			 		 lrstn_cmos,sysclk_cmos
					,row_addr_cmos,row_strtn_cmos
					,ld_shiftn_cmos,data_read_enn_cmos
					,cal_strtn_cmos,txn_cmos,pgn_cmos,dark_off_enn_cmos
					,row_done_n,cal_done_n,data_cmos,pixel_clk_out
					);
				
	-- Ecriture de l'image au standard VESA.
	-- --------------------------------------------------------- --
WRV0:	WRITE_VESA	generic map	 (
					 nomfichier	=> nomDest
					 
				 	,width		=> WIDTH_VSA
			    		,height 	=> HEIGHT_VSA
					,hstart		=> HSTART_VSA
					,hend		=> HEND_VSA
					,vstart		=> VSTART_VSA
					,vend		=> VEND_VSA
				    	)

			port map	(
					 reset,clk_dvi		
 					,select_mode(0)		
		 			,hsynch,vsynch	
	 				,die,dio	
					);


reset 		<= '0','1' after 80 ns;
clk   		<= not clk after 9.259 ns;
select_window 	<= "1111111010";
select_mode	<= "00";
select_orec	<= "000";

end ARCH_TEST_CARTE;
