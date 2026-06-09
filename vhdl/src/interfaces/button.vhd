-- ========================================================================== --
--
-- Fichier   :	BUTTON.vhd
--
-- Auteur    :	Philippe Lamaty
--
-- Copyright :	AEROSPATIALE MATRA Missiles 2001-2002
--
-- -------------------------------------------------------------------------- --
-- Modification :
--
--	Auteur		Date		Version		Commentaire
--
--	p.lamaty	10.01.2002	1.0		création

-- -------------------------------------------------------------------------- --
-- Rôle :
--
-- Réalise l'anti-rebond des boutons de sélection du mode de sortie vidéo qui
-- permettent l'incrémentation et la décrémentation du signal "mode".
--
-- ========================================================================== --


-- définition des librairies
-- -------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.all;


--  module BUTTON
-- ------------------------------------------------------------------------- --
entity BUTTON is
   port	(
	resetb		: in	std_logic;
	clk		: in	std_logic;

	button_up	: in	std_logic;
	button_down	: in	std_logic;

	mode		: out	std_logic_vector( 3 downto 0)
	);
end BUTTON;


--  définition de l'ARCHitecture de BUTTON
-- ------------------------------------------------------------------------- --
architecture ARCH_BUTTON of BUTTON is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des constantes
	-- ---------------------------------------------------------- --
constant	cpt_init		: integer := 2000000;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux
	-- ---------------------------------------------------------- --
	signal	up			: std_logic_vector( 2 downto 0);
	signal	cpt_up			: integer;

	signal	down			: std_logic_vector( 2 downto 0);
	signal	cpt_down		: integer;

	signal	mode_i			: std_logic_vector( 3 downto 0);


-- ========================================================================== --
begin

	-- anti-rebond des boutons et 
	-- incrément/décrément du compteur de "mode"
	-- ---------------------------------------------------------- --
UP0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
			up	<= "111";
			cpt_up	<= cpt_init;
			down	<= "111";
			cpt_down<= cpt_init;
			mode_i	<= "0000";

		elsif ( rising_edge(clk) ) then
			-- -------------------------- --
			up(1 downto 0)	<=   up(0) & button_up;

			if ( up(1)/=up(0) or cpt_up=0 ) then
				cpt_up <= cpt_init;
			else
				cpt_up <= cpt_up - 1;
			end if;

			if    ( cpt_up=0 ) then
				up(2)  <= up(1);
			end if;

			-- -------------------------- --
			down(1 downto 0)<= down(0) & button_down;

			if ( down(1)/=down(0) or cpt_down=0 ) then
				cpt_down <= cpt_init;
			else
				cpt_down <= cpt_down - 1;
			end if;

			if ( cpt_down=0 ) then
				down(2)<= down(1);
			end if;

			-- -------------------------- --
			if    (   up(2 downto 1)="10" and cpt_up=0 ) then
				mode_i <= mode_i + '1';

			elsif ( down(2 downto 1)="10" and cpt_down=0 ) then
				mode_i <= mode_i - '1';
			end if;
		end if;
	end process;

	-- ---------------------------------------------------------- --
	mode <= mode_i;


end ARCH_BUTTON;
-- ========================================================================== --

