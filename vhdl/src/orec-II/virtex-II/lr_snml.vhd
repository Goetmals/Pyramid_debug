-- -------------------------------------------------------------------------- --
-- File Name :	LR_SNML.vhd
-- Author    :	Frederic de Melo, UBO
-- Purpose   :	réalisation d'une fifo 1024x14 bits
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		f.de Melo      16/05/2001       first version
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


--  module LR_SNML
-- ------------------------------------------------------------------------- --
entity LR_SNML is
   port ( 
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 decalb 	: in	std_logic;
	 di		: in	std_logic_vector(21 downto 0);
	 do		: out	std_logic_vector(21 downto 0)
	);
end LR_SNML;


--  définition de l'architecture de LR_SNML
-- ------------------------------------------------------------------------- --
architecture ARCH_LR_SNML of LR_SNML is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des composants externes
	-- --------------------------------------------------------- --
component dp_snml
   port	(
	clka		: in	std_logic;
	addra		: in	std_logic_vector(10 downto 0);
	douta		: out	std_logic_vector(21 downto 0);

	clkb		: in	std_logic;
	web		: in	std_logic;
	addrb		: in	std_logic_vector(10 downto 0);
	dinb		: in	std_logic_vector(21 downto 0)
	);
end component;

-- Synplicity black box declaration
attribute syn_black_box : boolean;
attribute syn_black_box of dp_snml: component is true;

-- pragma translate_off
for DPL0:dp_snml  use entity XilinxCoreLib.blkmemdp_v3_1(behavioral)
		generic map(
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
			,c_mem_init_file	=> "mif_file_16_1"
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
			,c_default_data		=> "000000"
			,c_has_default_data	=> 1
			,c_width_b		=> 22
			,c_width_a		=> 22
			,c_limit_data_pitch	=> 18
			,c_has_rdyb		=> 0
			,c_has_rdya		=> 0
			,c_has_limit_data_pitch	=> 0
			,c_enable_rlocs		=> 0
			,c_addra_width		=> 11
			);
-- pragma translate_on

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- --------------------------------------------------------- --
	signal	adL,adE		        : std_logic_vector(10 downto 0);
	signal	decalb_r		: std_logic_vector( 4 downto 0);
	signal	we			: std_logic;
       
	
	
-- ========================================================================= --
begin
        
        -- connexions du bloc mémoire
	-- --------------------------------------------------------- --
DPL0:	dp_snml	       port map	( 
				 clka	=> clk
				,addra	=> adL
				,douta	=> do

				,clkb	=> clk
				,web	=> we
				,addrb	=> adE
				,dinb	=> di
				);

				
        -- retarde le signal decalb
	-- --------------------------------------------------------- --
RTD0:	process( resetb, clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			decalb_r <= (others=>'1');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
			decalb_r <= decalb_r(3 downto 0) & decalb;
		end if;
	end process;


	-- génération du signal d'écriture
	-- --------------------------------------------------------- --
	we <= not decalb_r(4);

	
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

	
	-- incrémentation de l'adresse d'écriture
	-- --------------------------------------------------------- --
WR0:	process( resetb,clk )
        begin
		if    ( resetb='0' ) then
			adE <= (others=>'0');

		elsif ( rising_edge(clk) ) then
		    if    ( decalb_r(4) = '1' ) then
				adE <= (others=>'0');
			else
				adE <= adE + '1';
		    end if;	
		end if;
	end process;	
	

end ARCH_LR_SNML;
-- ========================================================================= --

