----------------------------------------------------------------------------------
-- Company: ETIS Laboratory
-- Engineer: Thomas Lefebvre
--
-- Module Name:    gradient
--
-- Description: Calculates the intensity of the gradient with a Sobel operator.
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

library work;
use work.saturn_numeric_pkg.all;
use work.xy_delay_pkg.all;

entity gradient is
  generic(
    pixel_bus_width_in : natural := 8;
    pixel_bus_width    : natural := 17;
    w_img              : natural := 640;
    h_img              : natural := 480;
    bus_width_x        : natural := unsigned_num_bits(640);
    bus_width_y        : natural := unsigned_num_bits(480));
  port(
    clk, EN  : in  std_logic;
    EN_out   : out std_logic;
    xin      : in  std_logic_vector(bus_width_x-1 downto 0);
    yin      : in  std_logic_vector(bus_width_y-1 downto 0);
    xout     : out std_logic_vector(bus_width_x-1 downto 0);
    yout     : out std_logic_vector(bus_width_y-1 downto 0);
    data_in  : in  std_logic_vector(pixel_bus_width_in-1 downto 0);
    data_out : out std_logic_vector(pixel_bus_width-1 downto 0));
end entity;


architecture arch_sobel of gradient is
	constant delay_x       : natural := 5; -- sure ?
	constant delay_y       : natural := 1;
	
	component shift_reg is
	  generic(
	    bus_width : natural := 17;
	    depth     : natural := 640);
	  port(
	    clk, EN  : in  std_logic;
	    data_in  : in  std_logic_vector(bus_width-1 downto 0);
	    data_out : out std_logic_vector(bus_width-1 downto 0));
	end component;
	
	signal s_data_out : unsigned(pixel_bus_width-1 downto 0);
	
	signal s_sum1a_V, s_sum1b_V : unsigned(pixel_bus_width_in   downto 0);
	signal s_sum1a_H, s_sum1b_H : unsigned(pixel_bus_width_in   downto 0);
	signal s_sum2a_V, s_sum2b_V : unsigned(pixel_bus_width_in+1 downto 0);
	signal s_sum2a_H, s_sum2b_H : unsigned(pixel_bus_width_in+1 downto 0);
	signal s_sub_V,  s_sub_H    : unsigned(pixel_bus_width_in+1 downto 0);
	signal s_grad               : unsigned(pixel_bus_width_in+2 downto 0);
	
	-- 3x3 window of raw pixels
	signal s_data_in_0_0, s_data_in_0_1, s_data_in_0_2,
	       s_data_in_1_0, s_data_in_1_1, s_data_in_1_2,
	       s_data_in_2_0, s_data_in_2_1, s_data_in_2_2 : std_logic_vector(pixel_bus_width_in-1 downto 0);
	
	-- and window of valid pixels (replaced by 0 when out of image boundaries)
	-- center is not used, therefore not present
	signal s_pixel_0_0, s_pixel_0_1, s_pixel_0_2,
	       s_pixel_1_0,              s_pixel_1_2,
	       s_pixel_2_0, s_pixel_2_1, s_pixel_2_2 : unsigned(pixel_bus_width_in-1 downto 0);
	
	-- The IP uses the x_out and y_out values, therefore signals are used to keep a copy of them.
	signal s_xout : std_logic_vector(bus_width_x-1 downto 0);
	signal s_yout : std_logic_vector(bus_width_y-1 downto 0);
	signal s_EN, s_EN_out, s_enable : std_logic;
begin
	xout <= s_xout;
	yout <= s_yout;
	EN_out <= s_EN_out;
	s_enable <= EN;--s_EN_out or EN;	-- Le buffer lit un pixel d'entrée à chaque pixel produit en sortie.
	
	data_out <= std_logic_vector(s_data_out) when (to_integer(unsigned(s_xout)) > 2) and (to_integer(unsigned(s_yout)) > 2) and (to_integer(unsigned(s_xout)) < w_img-3) and (to_integer(unsigned(s_yout)) < h_img-3) else (others => '0');
	--s_data_out <= rotate_left(resize(s_grad, pixel_bus_width), s_data_out'length - s_grad'length);
	s_data_out <= resize(rotate_left(s_grad, abs(s_data_out'length-s_grad'length)),pixel_bus_width);
	
	-- These additions should not be put in processes without creating a delay for the s_pixel_X_Y used for the next additions (s_sum2...<=...)
	s_sum1a_V <= resize(s_pixel_0_0,pixel_bus_width_in+1) + resize(s_pixel_0_2,pixel_bus_width_in+1); -- sum of 2 pixel (same weight = 1)
	s_sum1b_V <= resize(s_pixel_2_0,pixel_bus_width_in+1) + resize(s_pixel_2_2,pixel_bus_width_in+1);
	s_sum1a_H <= resize(s_pixel_0_0,pixel_bus_width_in+1) + resize(s_pixel_2_0,pixel_bus_width_in+1);
	s_sum1b_H <= resize(s_pixel_0_2,pixel_bus_width_in+1) + resize(s_pixel_2_2,pixel_bus_width_in+1);
	
	process(clk)
	begin
	  if(rising_edge(clk)) then
	    if(s_enable = '1') then
	      s_sum2a_V <= resize(s_sum1a_V,pixel_bus_width_in+2) + rotate_left(resize((s_pixel_0_1),pixel_bus_width_in+2),1); -- sum of previous sum and third pixel (weight = 2)
	      s_sum2b_V <= resize(s_sum1b_V,pixel_bus_width_in+2) + rotate_left(resize((s_pixel_2_1),pixel_bus_width_in+2),1);
	      s_sum2a_H <= resize(s_sum1a_H,pixel_bus_width_in+2) + rotate_left(resize((s_pixel_1_0),pixel_bus_width_in+2),1);
	      s_sum2b_H <= resize(s_sum1b_H,pixel_bus_width_in+2) + rotate_left(resize((s_pixel_1_2),pixel_bus_width_in+2),1);
	    end if;
	  end if;
	end process;
	
	process(clk)
	begin
	  if(rising_edge(clk)) then
	    if(s_enable = '1') then
	      if(s_sum2a_V > s_sum2b_V) then
	        s_sub_V <= s_sum2a_V - s_sum2b_V;
	      else
	        s_sub_V <= s_sum2b_V - s_sum2a_V;
	      end if;
	      if(s_sum2a_H > s_sum2b_H) then
	        s_sub_H <= s_sum2a_H - s_sum2b_H;
	      else
	        s_sub_H <= s_sum2b_H - s_sum2a_H;
	      end if;
	    end if;
	  end if;
	end process;
	
	process(clk)
	begin
	  if(rising_edge(clk)) then
	    if(s_enable = '1') then
	      s_grad <= resize(s_sub_H,pixel_bus_width_in+3) + resize(s_sub_V,pixel_bus_width_in+3);
	    end if;
	  end if;
	end process;
	
	
	process(clk)
	begin
	  if(rising_edge(clk)) then
	    if(s_enable = '1') then
	-- line yin - 2
	      s_data_in_2_2 <= s_data_in_1_2;
	      s_data_in_1_2 <= s_data_in_0_2;
	-- line yin - 1
	      s_data_in_2_1 <= s_data_in_1_1;
	      s_data_in_1_1 <= s_data_in_0_1;
	-- line yin
	      s_data_in_2_0 <= s_data_in_1_0;
	      s_data_in_1_0 <= s_data_in_0_0;
	      s_data_in_0_0 <= data_in;
	    end if;
	  end if;
	end process;
	
	s_pixel_0_0 <= unsigned(s_data_in_0_0);-- when (to_integer(unsigned(yin)) > 0) and (to_integer(unsigned(yin)) < h_img-3) and (to_integer(unsigned(xin)) > 1) and (to_integer(unsigned(xin)) < w_img-3) else (others => '0');
	s_pixel_1_0 <= unsigned(s_data_in_1_0);-- when (to_integer(unsigned(yin)) > 0) and (to_integer(unsigned(yin)) < h_img-3) and (to_integer(unsigned(xin)) > 2) and (to_integer(unsigned(xin)) < w_img-2) else (others => '0');
	s_pixel_2_0 <= unsigned(s_data_in_2_0);-- when (to_integer(unsigned(yin)) > 0) and (to_integer(unsigned(yin)) < h_img-3) and (to_integer(unsigned(xin)) > 3) and (to_integer(unsigned(xin)) < w_img-1) else (others => '0');
	s_pixel_0_1 <= unsigned(s_data_in_0_1);-- when (to_integer(unsigned(yin)) > 1) and (to_integer(unsigned(yin)) < h_img-2) and (to_integer(unsigned(xin)) > 1) and (to_integer(unsigned(xin)) < w_img-3) else (others => '0');
	s_pixel_2_1 <= unsigned(s_data_in_2_1);-- when (to_integer(unsigned(yin)) > 1) and (to_integer(unsigned(yin)) < h_img-2) and (to_integer(unsigned(xin)) > 3) and (to_integer(unsigned(xin)) < w_img-1) else (others => '0');
	s_pixel_0_2 <= unsigned(s_data_in_0_2);-- when (to_integer(unsigned(yin)) > 2) and (to_integer(unsigned(yin)) < h_img-1) and (to_integer(unsigned(xin)) > 1) and (to_integer(unsigned(xin)) < w_img-3) else (others => '0');
	s_pixel_1_2 <= unsigned(s_data_in_1_2);-- when (to_integer(unsigned(yin)) > 2) and (to_integer(unsigned(yin)) < h_img-1) and (to_integer(unsigned(xin)) > 2) and (to_integer(unsigned(xin)) < w_img-2) else (others => '0');
	s_pixel_2_2 <= unsigned(s_data_in_2_2);-- when (to_integer(unsigned(yin)) > 2) and (to_integer(unsigned(yin)) < h_img-1) and (to_integer(unsigned(xin)) > 3) and (to_integer(unsigned(xin)) < w_img-1) else (others => '0');
	
	--s_pixel_0_0 <= unsigned(s_data_in_0_0) when (to_integer(unsigned(s_xout)) < w_img-1 and to_integer(unsigned(s_yout)) < h_img-1)
	--   else (others => '0');
	--
	--s_pixel_1_0 <= unsigned(s_data_in_1_0) when (                                           to_integer(unsigned(s_yout)) < h_img-1)
	--   else (others => '0');
	--
	--s_pixel_2_0 <= unsigned(s_data_in_2_0) when (to_integer(unsigned(s_xout)) > 0       and to_integer(unsigned(s_yout)) < h_img-1)
	--   else (others => '0');
	--
	--s_pixel_0_1 <= unsigned(s_data_in_0_1) when (to_integer(unsigned(s_xout)) < w_img-1)
	--   else (others => '0');
	--
	--s_pixel_2_1 <= unsigned(s_data_in_2_1) when (to_integer(unsigned(s_xout)) > 0)
	--   else (others => '0');
	--
	--s_pixel_0_2 <= unsigned(s_data_in_0_2) when (to_integer(unsigned(s_xout)) < w_img-1 and to_integer(unsigned(s_yout)) > 0)
	--   else (others => '0');
	--
	--s_pixel_1_2 <= unsigned(s_data_in_1_2) when (                                           to_integer(unsigned(s_yout)) > 0)
	--   else (others => '0');
	--
	--s_pixel_2_2 <= unsigned(s_data_in_2_2) when (to_integer(unsigned(s_xout)) > 0       and to_integer(unsigned(s_yout)) > 0)
	--   else (others => '0');
	
	
	c_shift_reg_gradient1 : shift_reg
	generic map(
	  depth => w_img-3,
	  bus_width => pixel_bus_width_in)
	port map(
	  clk      => clk,
	  EN       => s_enable,
	  data_in  => s_data_in_2_0,
	  data_out => s_data_in_0_1);
	
	c_shift_reg_gradient2 : shift_reg
	generic map(
	  depth     => w_img-3,
	  bus_width => pixel_bus_width_in)
	port map(
	  clk      => clk,
	  EN       => s_enable,
	  data_in  => s_data_in_2_1,
	  data_out => s_data_in_0_2);
	
	--c_xy_delay: xy_delay
	--  generic map (
	--    delay_x     => delay_x,
	--    delay_y     => delay_y,
	--    w_img       => w_img,
	--    h_img       => h_img,
	--    bus_width_x => bus_width_x,
	--    bus_width_y => bus_width_y)
	--  port map (
	--    clk    => clk,
	--    EN     => EN,
	--    EN_out => s_EN_out,
	--    xin    => xin,
	--    yin    => yin,
	--    xout   => s_xout,
	--    yout   => s_yout);
	c_xy_delay : xy_delay
		generic map (
			DELAY_X => delay_x,
			DELAY_Y => delay_y,
			IMG_WIDTH => w_img,
			IMG_HEIGHT => h_img
		)
		port map (
			global_clk_i => clk,
			global_resetn_i => '1',

			xy_en_i => EN,
			xy_x_i => xin,
			xy_y_i => yin,

			xy_en_o => s_EN_out,
			xy_x_o => s_xout,
			xy_y_o => s_yout
		);
end arch_sobel;
