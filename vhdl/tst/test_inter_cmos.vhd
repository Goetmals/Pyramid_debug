-- -------------------------------------------------------------------------- --
-- File Name :	test_cmos.vhd
-- Author    :	Fred de Melo
-- Purpose   :	testbench
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--              f.de Melo         .  .2001      FPGA     Version
--
--		    (c) Copyright AEROSPATIALE MATRA Missiles
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;

entity TEST_CMOS is
generic (
	 WIDTH		: integer := 1280;
	 HEIGHT		: integer := 1024
	);
end TEST_CMOS;

--  définition de l'architecture de TEST_CMOS
-- ------------------------------------------------------------------------- --
architecture ARCH_TEST_CMOS of TEST_CMOS is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des composants externes
	-- --------------------------------------------------------- --
component INTER_CMOS 
	   port	(	
		resetb			: in	std_logic;
		clk108MHz		: in	std_logic;

		data			: in 	std_logic_vector(99 downto 0);
		select_mode		: in 	std_logic;
		row_exposure		: in 	std_logic_vector( 9 downto 0);

		hsync_out		: out 	std_logic;
		vsync_out		: out	std_logic;
		pixel_out		: out	std_logic_vector(7 downto 0);

		clk10_8			: out 	std_logic;
		row_strt_n		: out 	std_logic;
		ld_shift_n		: out	std_logic;
		dat_read_en_n		: out	std_logic;
		row_addr		: out	std_logic_vector(9 downto 0);
		tx_n			: out 	std_logic;
		pg_n			: out 	std_logic;
		cal_strt_n		: out 	std_logic;
		lrst_n			: out	std_logic;
		dark_off_enn		: out   std_logic;
		standby_n		: out   std_logic;
		pwrdwn_b		: out   std_logic
		);
end component;

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


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux internes
	-- --------------------------------------------------------- --
	signal resetb			: std_logic;
	signal clk108MHz 		: std_logic
					:= '0';
	signal sysclk			: std_logic;
	signal select_mode		: std_logic;
	signal row_exposure		: std_logic_vector(9 downto 0);
	signal hsync_out,vsync_out	: std_logic;
	signal pixel_out		: std_logic_vector(7 downto 0);
	signal row_strt_n		: std_logic;
	signal ld_shift_n,dat_read_en_n : std_logic;
	signal tx_n,pg_n		: std_logic;
	signal row_addr			: std_logic_vector(9 downto 0);
	signal cal_strt_n		: std_logic;
	signal lrst_n			: std_logic;
	signal dark_off_enn		: std_logic;
	signal standby_n		: std_logic;
	signal pwrdwn_b			: std_logic;
	
	signal data			: std_logic_vector(99 downto 0);
	signal row_done_n		: std_logic;
	signal cal_done_n		: std_logic;
	signal pixel_clk_out		: std_logic;
	
-- ========================================================================= --
begin
	-- Interface CMOS.
	-- --------------------------------------------------------- --
INT0:	INTER_CMOS	 port map	(
					 resetb,clk108MHz
					,data,select_mode,row_exposure
					,hsync_out,vsync_out,pixel_out
					,sysclk,row_strt_n,ld_shift_n
					,dat_read_en_n,row_addr,tx_n,pg_n
					,cal_strt_n,lrst_n,dark_off_enn
					,standby_n,pwrdwn_b
					);
	-- Modèle CMOS.
	-- --------------------------------------------------------- --			
PBM0:	PB_MV13 	generic map (
			     width  => WIDTH
			    ,height => HEIGHT
			    )
			 port map	(
			 		 resetb,sysclk
					,row_addr,row_strt_n
					,ld_shift_n,dat_read_en_n
					,cal_strt_n,tx_n,pg_n,dark_off_enn
					,row_done_n,cal_done_n,data,pixel_clk_out
					);
					
resetb       <= '0','1' after 80 ns;
clk108MHz    <= not clk108MHz after 936 ns;
select_mode  <= '0';
row_exposure <= "1111111010";
--data	     <= "0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000",
--	"0001010000000100110000010010000001000100000100000000001111000000111000000011010000001100000000101100" after 657.46 ns,
--	"0000000100000000100000000011000000010000000001010000000110000000011100000010000000001001000000101000" after 842.66 ns,
--	"0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" after 5250 ns;
			 		 
			     			
end ARCH_TEST_CMOS;			    				
