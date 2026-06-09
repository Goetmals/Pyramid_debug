----------------------------------------------------------------------------------
-- Company: ETIS Laboratory
-- Engineer: Thomas Lefebvre
-- 
-- Module Name:    delay
--
-- Description: Delays a bus by a number of clock cycles calculated by the
-- difference in coordinates.
--
----------------------------------------------------------------------------------
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

entity delay is
	generic (
		pixel_bus_width : natural := 17;
		w_img           : natural := 640;
		h_img           : natural := 480;
		delay_x         : natural := 4;
		delay_y         : natural := 3
	);
	port (
		clk, EN  : in  std_logic;
		data_in  : in  std_logic_vector(pixel_bus_width-1 downto 0);
		data_out : out std_logic_vector(pixel_bus_width-1 downto 0)
	);
end entity;

architecture arch of delay is
	constant delay_value : natural := delay_y*w_img+delay_x;
	
	type t_mem is array(delay_value downto 1) of std_logic_vector(pixel_bus_width-1 downto 0);
	
	signal s_mem_delay : t_mem;
	signal s_index     : natural range 1 to delay_value :=1;
begin
	process(clk)
	begin
		if(rising_edge(clk)) then
			if(EN='1') then
				data_out <= s_mem_delay(s_index);
				s_mem_delay(s_index) <= data_in;
				if(s_index > delay_value-1) then
					s_index <= 1;
				else
					s_index <= s_index+1;
				end if;
			end if;
		end if;
	end process;
end arch;
