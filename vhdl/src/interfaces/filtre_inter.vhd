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
	signal	compteur 		: integer range 0 to 2097152 := 0 ;
	signal	sample			: std_logic_vector(2 downto 0);


-- ========================================================================= --
begin
	
	-- echantillonnage de l'interrupteur
	-- --------------------------------------------------------- --
CPT0:   process( resetb,clkb )
        begin
		if    ( resetb = '0' ) then
			sample <= (others => '0');
			sortie_inter <= '1';
			compteur <= 0;
		elsif ( rising_edge(clkb) ) then
--			compteur <=  (compteur + 1) mod 4194304;
			compteur <=  (compteur + 1) mod 2097152;
			if (compteur = 0) then sample <= sample (1 downto 0) & signal_inter;
			end if;
			if sample = "111" then sortie_inter <= '1';
			elsif sample = "000" then sortie_inter <= '0';
			end if;
		end if;
	end process;


end ARCH_FILTRE_INTER;
-- ========================================================================= --


