-- ========================================================================== --
--
-- Fichier   :	LED_LIFE.vhd
--
-- Auteur    :	Cedric Munoz
--
-- Copyright :	AEROSPATIALE MATRA Missiles 2001-2001
--
-- -------------------------------------------------------------------------- --
-- Modification :
--
--	Auteur		Date		Version		Commentaire
--
--	c.Munoz		xx.xx.2001	1.0		création
--
-- -------------------------------------------------------------------------- --
-- Rôle :
--
-- Génération d'un clignotement avec une période de 2 s de la "led de vie"
--
-- ========================================================================== --


-- définition des librairies
-- -------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


use work.all;

--  module LED_LIFE
-- ------------------------------------------------------------------------- --
entity LED_LIFE is 
   port	(
	resetb		: in	std_logic;
	clk             : in	std_logic;
	sortie_led	: out	std_logic
	);
end LED_LIFE;


--  définition de l'architecture de LED_LIFE
-- ------------------------------------------------------------------------- --
architecture ARCH_LED_LIFE of LED_LIFE is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- ---------------------------------------------------------- --
	signal	cpt			: integer;
	signal	led			: std_logic;


-- ========================================================================== --
begin

	-- ---------------------------------------------------------- --		
P1:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
			cpt <= 0;
			led <= '0';

		elsif ( rising_edge(clk) ) then
			if ( cpt = 40000000 ) then
				cpt <= 0;
				led <= not led;
			else
				cpt <= cpt + 1;
			end if;
		end if;
	end process;

	-- ---------------------------------------------------------- --		
	sortie_led <= led;


end ARCH_LED_LIFE;
-- ========================================================================== --
	     
