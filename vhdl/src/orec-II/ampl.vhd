-- -------------------------------------------------------------------------- --
-- File Name :	AMPL.vhd
-- Author    :	Lounis Kessal, Yves Guerin, Philippe Lamaty, Frédéric de Melo
-- Purpose   :	amplification
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		l.Kessal	  .  .1997	First version
--		y.Guerin	  .  .1997	Aerospatiale update
--		p.Lamaty	05.05.1998	Second version
--              f.de Melo            .2001      FPGA version

--		(c) Copyright AEROSPATIALE MATRA Missiles
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;


--  module AMPL
-- ------------------------------------------------------------------------- --
entity AMPL is
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 const		: in	std_logic_vector( 7 downto 0);

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector(15 downto 0);

	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector(15 downto 0)
	);
end AMPL;


--  definition de l'architecture de AMPL
-- ------------------------------------------------------------------------- --
architecture ARCH_AMPL of AMPL is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- definition des signaux internes
	-- --------------------------------------------------------- --
	signal	pixel_tmp	: std_logic_vector(23 downto 0);


-- ========================================================================= --
begin
	-- Synchronisation du flot vidéo amplifié
	-- --------------------------------------------------------- --
SYN0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			hsync_out <= '1';
			vsync_out <= '1';

		elsif ( rising_edge(clk) ) then
			hsync_out <= hsync_inn;
			vsync_out <= vsync_inn;
		end if;
	end process;

	-- Amplification du signal.
	-- --------------------------------------------------------- --
	pixel_tmp <= pixel_inn * const;

	-- Resynchronisation du flot pixel. 
	-- --------------------------------------------------------- --
SYN1:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			pixel_out <= (others=>'0');

		elsif ( rising_edge(clk) ) then
			pixel_out <= pixel_tmp(21 downto 6);
		end if;
	end process;

end ARCH_AMPL;
-- ========================================================================= --
