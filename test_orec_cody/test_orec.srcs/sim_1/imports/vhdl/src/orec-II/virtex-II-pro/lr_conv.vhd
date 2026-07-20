-- -------------------------------------------------------------------------- --
-- File Name :	LR_CONV.vhd
-- Author    :	Frederic DE MELO
-- Purpose   :	ligne � retard de 1280x8 avec une Dual Port Ram.
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

---- pragma translate_off
--library XilinxCoreLib;
--use XilinxCoreLib.all;
---- pragma translate_on

use work.all;

--  module LR_CONV
-- ------------------------------------------------------------------------- --
entity LR_CONV is
   port	(
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 decalb		: in	std_logic;
	 di		: in	std_logic_vector(87 downto 0);
 	 do		: out	std_logic_vector(87 downto 0)
	);
end LR_CONV;


--  d�finition de l'architecture de LR_CONV
-- ------------------------------------------------------------------------- --
architecture ARCH_LR_CONV of LR_CONV is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�claration des composants externes
--component dp_conv
--   port	(
--	clka		: in	std_logic;
--	addra		: in	std_logic_vector(10 downto 0);
--	douta		: out	std_logic_vector(87 downto 0);

--	clkb		: in	std_logic;
--	web		: in	std_logic;
--	addrb		: in	std_logic_vector(10 downto 0);
--	dinb		: in	std_logic_vector(87 downto 0)
--	);
--end component;

component dp_conv
    port (
    clka        : IN STD_LOGIC;
    wea         : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra       : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    dina        : IN STD_LOGIC_VECTOR(87 DOWNTO 0);
    clkb        : IN STD_LOGIC;
    addrb       : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
    doutb       : OUT STD_LOGIC_VECTOR(87 DOWNTO 0)
  );
end component;

---- Synplicity black box declaration
--attribute syn_black_box : boolean;
--attribute syn_black_box of dp_conv: component is true;

---- pragma translate_off
--for DPC0: dp_conv use entity XilinxCoreLib.blkmemdp_v3_1(behavioral)
--	    generic map	(
--			 c_has_enb		=> 0
--			,c_has_ena		=> 0
--			,c_write_modeb		=> 0
--			,c_pipe_stages_b	=> 0
--			,c_write_modea		=> 0
--			,c_pipe_stages_a	=> 0
--			,c_addrb_width		=> 11
--			,c_has_dinb		=> 1
--			,c_has_dina		=> 0
--			,c_has_doutb		=> 0
--			,c_has_douta		=> 1
--			,c_reg_inputsb		=> 0
--			,c_has_rfdb		=> 0
--			,c_reg_inputsa		=> 0
--			,c_has_rfda		=> 0
--			,c_mem_init_file	=> "mif_file_16_1"
--			,c_sinita_value		=> "0000000000000000000000"
--			,c_has_sinitb		=> 0
--			,c_has_sinita		=> 0
--			,c_depth_b		=> 1280
--			,c_depth_a		=> 1280
--			,c_has_ndb		=> 0
--			,c_has_nda		=> 0
--			,c_has_web		=> 1
--			,c_sinitb_value		=> "0000000000000000000000"
--			,c_has_wea		=> 0
--			,c_default_data		=> "0000000000000000000000"
--			,c_has_default_data	=> 1
--			,c_width_b		=> 88
--			,c_width_a		=> 88
--			,c_limit_data_pitch	=> 18
--			,c_has_rdyb		=> 0
--			,c_has_rdya		=> 0
--			,c_has_limit_data_pitch	=> 0
--			,c_enable_rlocs		=> 0
--			,c_addra_width		=> 11
--			);
---- pragma translate_on


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�claration des signaux internes
	-- --------------------------------------------------------- --
	signal	adL,adE 		: std_logic_vector(10 downto 0);
	signal	we			: std_logic_vector( 1 downto 0);
	signal	we_std			: std_logic_vector( 0 downto 0);
	

-- ========================================================================= --
begin
	
	-- connexions du bloc m�moire
	-- --------------------------------------------------------- --
DPC0:	dp_conv	       port map	( 
				 clkb	=> clkb
				,addrb	=> adL
				,doutb	=> do

				,clka	=> clkb
				,wea	=> we_std
				,addra	=> adE
				,dina	=> di
				);
we_std <= conv_std_logic_vector(we(1),1);	
	
	-- g�n�ration du signal d'�criture
	-- --------------------------------------------------------- --
RW0:	process( resetb,clkb )
	begin
		if    ( resetb = '0' ) then
			we <= "00";

		elsif ( rising_edge(clkb) ) then
			we <= we(0) & not decalb;
		end if;
	end process;


	-- incr�mentation de l'adresse de lecture
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


	-- g�n�ration de l'adresse d'�criture
	-- --------------------------------------------------------- --
WR0:	process( resetb,clkb )
        begin
		if    ( resetb='0' ) then
			adE <= (others=>'0');

		elsif ( rising_edge(clkb) ) then
			if    ( we(1)='0' ) then
				adE <= (others=>'0');
			else
				adE <= adE + '1';
			end if;
		end if;
	end process;	
	

end ARCH_LR_CONV;
-- ========================================================================= --


