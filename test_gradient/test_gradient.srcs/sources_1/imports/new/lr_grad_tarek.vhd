-- -------------------------------------------------------------------------- --
-- File Name :	LR_GRAD.vhd
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

--  module LR_GRAD
-- ------------------------------------------------------------------------- --
entity LR_GRAD_TAREK is
   port	(
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 enable		: in	std_logic;
	 di		    : in	std_logic_vector(7 downto 0);
 	 do		    : out	std_logic_vector(7 downto 0)
	);
end LR_GRAD_TAREK;


--  d�finition de l'architecture de LR_GRAD
-- ------------------------------------------------------------------------- --
architecture ARCH_LR_GRAD_TAREK of LR_GRAD_TAREK is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�claration des composants externes

component blk_mem_gen_0
    port (
    clka        : IN STD_LOGIC;
    wea         : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra       : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    dina        : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    clkb        : IN STD_LOGIC;
    addrb       : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
    doutb       : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
end component;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�claration des signaux internes
	-- --------------------------------------------------------- --
	signal	adL,adE 		: std_logic_vector(8 downto 0);
	signal	we			    : std_logic_vector( 0 downto 0);
    
-- ========================================================================= --
begin
        	
	-- connexions du bloc m�moire
	-- --------------------------------------------------------- --
DPG0:	blk_mem_gen_0	       port map	( 
				 clkb	=> clkb
				,addrb	=> adL
				,doutb	=> do

				,clka	=> clkb
				,wea	=> we
				,addra	=> adE
				,dina	=> di
				);


	-- g�n�ration du signal d'�criture
	-- --------------------------------------------------------- --
RW0:	process( resetb,clkb )
	begin
		if    ( resetb = '0' ) then
			we <= (others=>'0');

		elsif ( rising_edge(clkb) ) then
			we <= conv_std_logic_vector(enable,1);
		end if;
	end process;

	
	-- incr�mentation de l'adresse de lecture
	-- --------------------------------------------------------- --
CPT0:   process( resetb,clkb )
        begin
		if    ( resetb = '0' ) then
			adL <= (others=>'0');

		elsif ( rising_edge(clkb) ) then
			if    ( enable='0' ) then
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
			adE <= adL;
		end if;
	end process;	
	
	
end ARCH_LR_GRAD_TAREK;
-- ========================================================================= --
