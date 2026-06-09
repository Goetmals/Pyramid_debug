-- -------------------------------------------------------------------------- --
-- File Name :	LR_1280x16.vhd
-- Author    :	Frederic DE MELO
-- Purpose   :	ligne à retard de 1280x8 avec une Dual Port Ram.
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		f.De Melo	17.04.2001	First Version
--
--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- pragma translate_off
library XilinxCoreLib;
use XilinxCoreLib.all;
-- pragma translate_on

use work.all;

--  module LR_1280x16
-- ------------------------------------------------------------------------- --
entity LR_1280x16 is
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 decalb		: in	std_logic;
	 di		: in	std_logic_vector(15 downto 0);
 	 do		: out	std_logic_vector(15 downto 0)
	);
end LR_1280x16;


--  définition de l'architecture de LR_1280x16
-- ------------------------------------------------------------------------- --
architecture ARCH_LR_1280x16 of LR_1280x16 is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des composants externes
	-- --------------------------------------------------------- --
component dp_grad
  port (
	clka		: in  std_logic;
	addra		: in  std_logic_vector(10 downto 0);
	douta		: out std_logic_vector(15 downto 0);

	clkb		: in  std_logic;
	web		: in  std_logic;
	addrb		: in  std_logic_vector(10 downto 0);
	dinb		: in  std_logic_vector(15 downto 0)
	);
end component;

-- Synplicity black box declaration
attribute syn_black_box : boolean;
attribute syn_black_box of dp_grad: component is true;

-- pragma translate_off
for DPG0:dp_grad use entity XilinxCoreLib.blkmemdp_v3_1(behavioral)
	    generic map	(
			 c_has_enb		=> 0
			,c_has_ena		=> 0
			,c_write_modeb		=> 0
			,c_pipe_stages_b	=> 0
			,c_write_modea		=> 0
			,c_pipe_stages_a	=> 0
			,c_addrb_width		=> 11
			,c_has_dinb		=> 1
			,c_has_dina		=> 0
			,c_has_doutb		=> 0
			,c_has_douta		=> 1
			,c_reg_inputsb		=> 0
			,c_has_rfdb		=> 0
			,c_reg_inputsa		=> 0
			,c_has_rfda		=> 0
			,c_mem_init_file		=> "mif_file_16_1"
			,c_sinita_value		=> "0000000000000000000000"
			,c_has_sinitb		=> 0
			,c_has_sinita		=> 0
			,c_depth_b		=> 1280
			,c_depth_a		=> 1280
			,c_has_ndb		=> 0
			,c_has_nda		=> 0
			,c_has_web		=> 1
			,c_sinitb_value		=> "0000000000000000000000"
			,c_has_wea		=> 0
			,c_default_data		=> "0000"
			,c_has_default_data	=> 1
			,c_width_b		=> 16
			,c_width_a		=> 16
			,c_limit_data_pitch	=> 18
			,c_has_rdyb		=> 0
			,c_has_rdya		=> 0
			,c_has_limit_data_pitch	=> 0
			,c_enable_rlocs		=> 0
			,c_addra_width		=> 11
			);
-- pragma translate_on


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux internes
	-- --------------------------------------------------------- --
	signal	adL,adE 		: std_logic_vector(10 downto 0);
	signal	we			: std_logic;


-- ========================================================================= --
begin
        	
	-- connexions du bloc mémoire
	-- --------------------------------------------------------- --
DPG0:	dp_grad	       port map	( 
				 clka	=> clk
				,addra	=> adL
				,douta	=> do

				,clkb	=> clk
				,web	=> we
				,addrb	=> adE
				,dinb	=> di
				);
	

	-- génération du signal d'écriture
	-- --------------------------------------------------------- --
RW0:	process( resetb,clk )
	begin
		if    ( resetb = '0' ) then
			we <= '0';

		elsif ( rising_edge(clk) ) then
			we <= not decalb;
		end if;
	end process;

	
	-- incrémentation de l'adresse de lecture
	-- --------------------------------------------------------- --
CPT0:   process( resetb,clk )
        begin
		if    ( resetb = '0' ) then
			adL <= (others=>'0');

		elsif ( rising_edge(clk) ) then
			if    ( decalb='1' ) then
				adL <= (others=>'0');
			else
				adL <= adL + '1';
			end if;
		end if;
	end process;

	
	-- génération de l'adresse d'écriture
	-- --------------------------------------------------------- --
WR0:	process( resetb,clk )
        begin
		if    ( resetb='0' ) then
			adE <= (others=>'0');

		elsif ( rising_edge(clk) ) then
			adE <= adL;
		end if;
	end process;	
	
	
end ARCH_LR_1280x16;
-- ========================================================================= --
