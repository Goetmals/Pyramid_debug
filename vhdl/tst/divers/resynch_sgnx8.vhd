-- -------------------------------------------------------------------------- --
-- File Name :	RESYNCH_SGNX8.vhd
-- Author    :	Philippe Lamaty, ENSEA
-- Purpose   :	resynchronisation des signaux vidéo
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		p.Lamaty	12.12.1997	First Version
--		p.Lamaty	09.10.1998	entity update
--		p.Lamaty	12.10.1998	header update
--
--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;


--  module RESYNCH_SGNX8
-- ------------------------------------------------------------------------- --
entity RESYNCH_SGNX8 is
   port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 7 downto 0);

	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 7 downto 0)
	);
end RESYNCH_SGNX8;


--  définition de l'architecture de RESYNCH_SGNX8
-- ------------------------------------------------------------------------- --
architecture ARCH_RESYNCH_SGNX8 of RESYNCH_SGNX8 is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux internes
	-- --------------------------------------------------------- --
	signal	clk			: std_logic;

	signal	hsync_ech,vsync_ech	: std_logic;
	signal	pixel_ech		: std_logic_vector( 7 downto 0);


-- ========================================================================= --
begin
	-- inversion de l'horloge
	-- --------------------------------------------------------- --
	clk <= not (clkb);

	-- resynchronise les signaux de synchro au format 'imaging'
	-- --------------------------------------------------------- --
RSC0:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			hsync_ech <= '1';
			vsync_ech <= '1';
			pixel_ech <= (others=>'0');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
			hsync_ech <= hsync_inn;
			vsync_ech <= vsync_inn;
			pixel_ech <= pixel_inn;
		end if;
	end process;


	-- --------------------------------------------------------- --
RSC1:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			hsync_out <= '1';
			vsync_out <= '1';
			pixel_out <= (others=>'0');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			hsync_out <= hsync_ech;
			vsync_out <= vsync_ech;
			pixel_out <= pixel_ech;
		end if;
	end process;


end ARCH_RESYNCH_SGNX8;
-- ========================================================================= --
