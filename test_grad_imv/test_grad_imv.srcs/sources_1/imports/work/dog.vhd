----------------------------------------------------------------------------------
-- Company: ETIS Laboratory
-- Engineer: Thomas Lefebvre
-- 
-- Module Name:    dog
--
-- Description : Difference of Gaussians, technically just a subtractor.
--
-- Signed (out only) and Unsigned  architectures
-- Unsigned adds an offset to the subtraction to avoid negative output.
--
-------------------------------------------------------------------------------
-- Copyright (c) 2012, ETIS Laboratory, Cergy-Pontoise, France
-- All rights reserved.
-- 
-- Redistribution and use in source and synthesized forms, with or without
-- modification, are permitted provided that the following conditions are met:
--     * Redistributions of source code must retain the above copyright
--       notice, this list of conditions and the following disclaimer.
--     * Redistributions in synthesized form must reproduce the above copyright
--       notice, this list of conditions and the following disclaimer in the
--       documentation and/or other materials provided with the distribution.
--     * Neither the name of the ETIS laboratory nor the
--       names of its contributors may be used to endorse or promote products
--       derived from this hardware description without specific prior written permission.
-- 
-- THIS HARDWARE DESCRIPTION IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
-- ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL ETIS LABORATORY BE LIABLE FOR ANY
-- DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
-- ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-- HARDWARE DESCRIPTION, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
----------------------------------------------------------------------------------
-- For the support of this file, please contact :
-- verdier % unice.fr   - LEAT Laboratory
-- miramond % ensea.fr  - ETIS Laboratory
-- kessal % ensea.fr    - ETIS Laboratory
-- t.lefebv % gmail.com - creator of the file
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.saturn_numeric_pkg.all;

entity dog is
	generic(
		pixel_bus_width : natural := 17;
		w_img           : natural := 640;
		h_img           : natural := 480;
		bus_width_x     : natural := UNSIGNED_NUM_BITS(640);
		bus_width_y     : natural := UNSIGNED_NUM_BITS(480)
	);
	port(
		clk, EN   : in  std_logic;
		hsync_in, vsync_in    : in  std_logic;
		xin       : in  std_logic_vector(bus_width_x-1 downto 0);
		yin       : in  std_logic_vector(bus_width_y-1 downto 0);
		data_in_a : in  std_logic_vector(pixel_bus_width-1 downto 0);
		data_in_b : in  std_logic_vector(pixel_bus_width-1 downto 0);
		
		EN_out    : out std_logic;
		hsync_out, vsync_out    : out  std_logic;
		xout      : out std_logic_vector(bus_width_x-1 downto 0);
		yout      : out std_logic_vector(bus_width_y-1 downto 0);
		data_out  : out std_logic_vector(pixel_bus_width-1 downto 0)
	);
end entity;

architecture arch_unsigned of dog is

	constant offset  : unsigned(pixel_bus_width downto 0) := (pixel_bus_width => '1', others => '0');
	
	signal s_data_in_a : unsigned(pixel_bus_width downto 0);
	signal s_data_in_b : unsigned(pixel_bus_width downto 0);
	signal s_data_temp : unsigned(pixel_bus_width downto 0);
	signal s_data_out  : unsigned(pixel_bus_width downto 0);
begin
	s_data_temp <= s_data_in_a + offset;
	s_data_out  <= s_data_temp - s_data_in_b;

	s_data_in_a <= resize(unsigned(data_in_a),s_data_in_a'length);
	s_data_in_b <= resize(unsigned(data_in_b),s_data_in_b'length);

	process(clk)
	begin
		if rising_edge(clk) then
			if (EN = '1') then
				data_out <= std_logic_vector(s_data_out(pixel_bus_width downto 1));
				xout <= xin;
				yout <= yin;
			end if;
		end if;
	end process;

	en_p : process(clk)
	begin
		if rising_edge(clk) then
			EN_out <= EN;
			hsync_out <= hsync_in;
			vsync_out <= vsync_in;
		end if;
	end process en_p;
end arch_unsigned;
