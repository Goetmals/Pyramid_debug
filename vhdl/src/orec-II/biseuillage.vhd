-- -------------------------------------------------------------------------- --
-- File Name :	BISEUILLAGE.vhd
-- Author    :	Philippe Lamaty, ENSEA
-- Purpose   :	bi-seuillage (FOND,CRETE,CONTOUR)
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		p.Lamaty	20.02.1998	First    Version
--		p.Lamaty	09.10.1998	Entity   Update
--		p.Lamaty	12.10.1998	Header   Update
--		p.Lamaty	05.11.1998	Synopsys Update
--		p.Lamaty	05.03.1999	clk     Update
--
--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



--  module BISEUILLAGE
-- ------------------------------------------------------------------------- --
entity BISEUILLAGE is
   port	(
	  resetb	: in	std_logic;
	  clk		: in	std_logic;

	  seuilbas	: in	std_logic_vector( 7 downto 0);
	  seuilhaut	: in	std_logic_vector( 7 downto 0);

	  hsync_inn	: in	std_logic;
	  vsync_inn	: in	std_logic;
	  pixel_inn	: in	std_logic_vector( 7 downto 0);

	  hsync_out	: out	std_logic;
	  vsync_out	: out	std_logic;
	  pixel_out	: out	std_logic_vector( 1 downto 0)
	);
end BISEUILLAGE;


--  définition de l'architecture de BISEUILLAGE
-- ------------------------------------------------------------------------- --
architecture ARCH_BISEUILLAGE of BISEUILLAGE is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des contantes
	-- --------------------------------------------------------- --
constant	CONTOUR		: std_logic_vector(1 downto 0) := "11"; 
constant	CRETE		: std_logic_vector(1 downto 0) := "10";
constant	EXTREMITE	: std_logic_vector(1 downto 0) := "01"; 
constant	FOND		: std_logic_vector(1 downto 0) := "00";


-- ========================================================================= --
begin
	-- seuillage des contours
	-- --------------------------------------------------------- --
CG_0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			pixel_out <= FOND;

		elsif ( rising_edge(clk) ) then
			if    ( pixel_inn>seuilhaut ) then
				pixel_out <= CONTOUR;

			elsif ( pixel_inn>seuilbas  ) then
				pixel_out <= CRETE;

			else
				pixel_out <= FOND;
			end if;
		end if;
	end process;


	-- synchronisation de la sortie contours
	-- --------------------------------------------------------- --
SS_0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			hsync_out <= '1';
			vsync_out <= '1';

		elsif ( rising_edge(clk) ) then
			hsync_out <= hsync_inn;
			vsync_out <= vsync_inn;
		end if;
	end process;


end ARCH_BISEUILLAGE;
-- ========================================================================= --
