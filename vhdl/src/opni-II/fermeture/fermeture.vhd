-- -------------------------------------------------------------------------- --
-- File Name :	FERMETURE.vhd
-- Author    :	L. Kessal, ENSEA / Philippe Lamaty, ENSEA
-- Purpose   :	Architecture complête du circuit de FERMETURE de contours.
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		L.Kessal	19.02.1998	First    Version
--		p.Lamaty	09.10.1998	Entity   Update
--		p.Lamaty	12.10.1998	Header   Update
--		p.Lamaty	06.11.1998	Synopsys Update
--		p.Lamaty	23.11.1998	rtsto    Synchronize Update
--		p.Lamaty	05.03.1999	CLKB     Update
--
--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
-- mode de fonctionnement de l'opérateur de FERMETURE de contours
-- nbcnx :
--	 '0' :	4 connexes
--	 '1' :	8 connexes
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --


--  module FERMETURE
-- ------------------------------------------------------------------------- --
entity FERMETURE is 
   port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 nbcnx		: in	std_logic;	-- nombre de connexes

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 1 downto 0);

	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 1 downto 0)
	);
end FERMETURE;


--  définition de l'architecture de FERMETURE
-- ------------------------------------------------------------------------- --
architecture ARCH_FERMETURE of FERMETURE is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des composants externes
	-- --------------------------------------------------------- --
component DETECTEXT 
   port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;
	 
	 connexes	: in	std_logic;	-- '0': 4 connexes, '1' : 8 co.
	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 1 downto 0);

	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 1 downto 0)
	);
end component;

	-- --------------------------------------------------------- --
component PROPAGEXT
   port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 connexes	: in	std_logic;
	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 1 downto 0);

	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 1 downto 0)
	);
end component;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux internes
	-- --------------------------------------------------------- --
	signal	hsync_aed,vsync_aed	: std_logic;
	signal	pixel_aed		: std_logic_vector( 1 downto 0);

	
-- ========================================================================= --
begin
	-- recherche les extrémités des contours "CONTOUR" de l'image
	-- ---------------------------------------------------------- --
DEX0:	DETECTEXT	port map	(
					 resetb,clkb
					,nbcnx
					,hsync_inn,vsync_inn,pixel_inn
					,hsync_aed,vsync_aed,pixel_aed
					);


	-- propagation des extrémités le long des crêtes
	-- ---------------------------------------------------------- --
PEX0:	PROPAGEXT	port map	(
				 	 resetb,clkb
					,nbcnx
					,hsync_aed,vsync_aed,pixel_aed
					,hsync_out,vsync_out,pixel_out
					);


end ARCH_FERMETURE;
-- ========================================================================= --	
