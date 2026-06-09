-- -------------------------------------------------------------------------- --
-- File Name :	LR_PEXT.vhd
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


--  module LR_PEXT
-- ------------------------------------------------------------------------- --
entity LR_PEXT is
   port	(
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 decalb		: in	std_logic;
	 di		: in	std_logic_vector( 9 downto 0);
 	 do		: out	std_logic_vector( 9 downto 0)
	);
end LR_PEXT;


--  définition de l'architecture de LR_PEXT
-- ------------------------------------------------------------------------- --
architecture ARCH_LR_PEXT of LR_PEXT is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des composants externes
component dp_pext
  port (
	addra		: in  std_logic_vector(10 downto 0);
	addrb		: in  std_logic_vector(10 downto 0);
	clka		: in  std_logic;
	clkb		: in  std_logic;
	dina		: in  std_logic_vector( 9 downto 0);
	doutb		: out std_logic_vector( 9 downto 0);
	wea		: in  std_logic
	);
end component;

-- Synplicity black box declaration
attribute syn_black_box : boolean;
attribute syn_black_box of dp_pext: component is true;

-- synopsys translate_off
for DPP0:dp_pext use entity XilinxCoreLib.blkmemv2dp_v2_0(behavioral)
		generic map(
			c_depth_b => 1536,
			c_depth_a => 1536,
			c_has_rdyb => 0,
			c_has_rdya => 0,
			c_has_web => 0,
			c_has_wea => 1,
			c_sinitb_value => "0000000000000000000000",
			c_has_doutb => 1,
			c_has_douta => 0,
			c_has_limit_data_pitch => 0,
			c_sinita_value => "0000000000000000000000",
			c_limit_data_pitch => 18,
			c_width_b => 10,
			c_width_a => 10,
			c_write_modeb => 2,
			c_write_modea => 2,
			c_addra_width => 11,
			c_has_ndb => 0,
			c_has_nda => 0,
			c_has_dinb => 0,
			c_has_dina => 1,
			c_pipe_stages_b => 0,
			c_pipe_stages_a => 0,
			c_has_rfdb => 0,
			c_has_rfda => 0,
			c_has_enb => 0,
			c_has_ena => 0,
			c_reg_inputsb => 0,
			c_reg_inputsa => 0,
			c_default_data => "000000000",
			c_has_default_data => 1,
			c_mem_init_file => "BlankString",
			c_has_sinitb => 0,
			c_has_sinita => 0,
			c_enable_rlocs => 0,
			c_addrb_width => 11);
-- synopsys translate_on


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux internes
	-- --------------------------------------------------------- --
	signal	adL,adE 		: std_logic_vector(10 downto 0);
	signal	we			: std_logic;
	signal  decalb_r		: std_logic_vector( 2 downto 0);


-- ========================================================================= --
begin
        	
	-- connexions du bloc mémoire
	-- --------------------------------------------------------- --
DPP0:	dp_pext	       port map	( 
				 clka	=> clkb
				,wea	=> we
				,addra	=> adE
				,dina	=> di

				,clkb	=> clkb
				,addrb	=> adL
				,doutb	=> do
				);
	
	-- Retard sur le signal decalb
	-- --------------------------------------------------------- --
RDB0:	process( resetb,clkb )
	begin
		if    ( resetb = '0' ) then
			decalb_r <= (others=>'1');
						
		elsif ( rising_edge(clkb) ) then
			decalb_r <=decalb_r(1 downto 0) & decalb;	
		end if;
	end process;


	-- génération du signal d'écriture
	-- --------------------------------------------------------- --
we <= not decalb_r(2);
	
	-- incrémentation de l'adresse de lecture
	-- --------------------------------------------------------- --
CPT0:   process( resetb,clkb )
        begin
		if    ( resetb = '0' ) then
			adL <= (others=>'0');

		elsif ( rising_edge(clkb) ) then
			if    ( decalb='1' ) then
				adL <= (others=>'0');
			else
				adL <= adL + '1';
			end if;
		end if;
	end process;

	
	-- génération de l'adresse d'écriture
	-- --------------------------------------------------------- --
	
WR0:	process( resetb,clkb )
        begin
		if    ( resetb='0' ) then
			adE <= (others=>'0');

		elsif ( rising_edge(clkb) ) then
			if    ( decalb_r(2) = '1' ) then
				adE <= (others=>'0');
			else
				adE <= adE + '1';
			end if;
		end if;
	end process;	
	
	
end ARCH_LR_PEXT;
-- ========================================================================= --
