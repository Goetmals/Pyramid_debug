-- -------------------------------------------------------------------------- --
-- File Name :	filtre_inter.vhd
-- Author    :	Jerome MICHEL
-- Purpose   :	filtrage d'interrupteur.
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		J MICHEL	09.01.2002	First Version
--
--			(c) Copyright  MBD.A
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

--  module FILTRE_INTER
-- ------------------------------------------------------------------------- --
entity FILTRE_INTER is
   port	(
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;
	 signal_inter	: in	std_logic;

	 sortie_inter	: out	std_logic
	);
end FILTRE_INTER;


--  définition de l'architecture de FILTRE_INTER
-- ------------------------------------------------------------------------- --
architecture ARCH_FILTRE_INTER of FILTRE_INTER is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux internes
	-- --------------------------------------------------------- --
	signal	compteur 		: integer := 0;
	signal	sample			: std_logic_vector(2 downto 0);
	signal	nb_sample		: integer range 0 to 4 := 0;
	signal	signal_rtd,start_timer	: std_logic := '0';
	signal	end_of_filtering	: std_logic := '0';


-- ========================================================================= --
begin
	
	-- declenchement du timer
	-- --------------------------------------------------------- --
RW0:	process( resetb,clkb )
	begin
		if    ( resetb = '0' ) then
			start_timer <= '0';
			signal_rtd <= '0';

		elsif ( rising_edge(clkb) ) then
			signal_rtd <= signal_inter;
			if ((signal_inter xor signal_rtd) = '1') then start_timer <= '1';
			elsif (end_of_filtering = '1') then start_timer <= '0';
			end if;
		end if;
	end process;


	-- echantillonnage de l'interrupteur
	-- --------------------------------------------------------- --
CPT0:   process( resetb,clkb )
        begin
		if    ( resetb = '0' ) then
			compteur <= 0;
			end_of_filtering <= '0';
			sample <= (others => '0');
			nb_sample <= 0;
			sortie_inter <= '1';

		elsif ( rising_edge(clkb) ) then
			if (start_timer = '1' and nb_sample < 4) then
				end_of_filtering <= '0';
				if (compteur = 0) then 	sample (2 downto 0) <=  sample(1 downto 0) & signal_inter;
							nb_sample <= nb_sample + 1;
				end if;
				compteur <=  (compteur + 1) mod 4194304;
--				compteur <=  (compteur + 1) mod 4;
			elsif (start_timer = '1' and nb_sample = 4) then 
				if sample = "111" then sortie_inter <= '1';
				elsif sample = "000" then sortie_inter <= '0';
				end if;
				compteur <= 0;
				end_of_filtering <= '1';
				sample <= (others => '0');
				nb_sample <= 0;
			elsif (start_timer = '0') then 	end_of_filtering <= '0';
							compteur <= 0;
							sample <= (others => '0');
							nb_sample <= 0;
			end if;
		end if;
	end process;


end ARCH_FILTRE_INTER;
-- ========================================================================= --


