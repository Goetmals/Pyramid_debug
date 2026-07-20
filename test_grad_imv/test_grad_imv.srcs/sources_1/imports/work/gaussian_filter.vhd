----------------------------------------------------------------------------------
-- Company: ETIS Laboratory
-- Engineer: Thomas Lefebvre
-- 
-- Module Name:    gaussian_filter
--
-- Description: Gaussian filtering of a pixel flow.
-- 1D 2 pass architecture : arch_1D (for separable 2D coefficient kernels)
--
--------------------------------------------------------------------------------
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
use work.saturn_dog_pkg.all;
use work.xy_delay_pkg.all;
use work.dual_clk_fifo_pkg.all;
use work.math_real.all;

entity gaussian_filter is
	generic(
		pixel_bus_width     : natural := 17;
		w_img               : natural := 640;
		h_img               : natural := 480;
		bus_width_x         : natural := unsigned_num_bits(640);
		bus_width_y         : natural := unsigned_num_bits(480);
	-- sq_sigma is the square of the sigma coefficient for the Gaussian function.
		sq_sigma            : real    := 2.0;
		kernel_width        : natural := 7;
		bus_width_coeff_sum : natural := 24
	);
	port(
		clk, EN  : in  std_logic;
		reset_n : in std_logic;
		EN_out   : out std_logic;
		xin      : in  std_logic_vector(bus_width_x-1 downto 0);
		yin      : in  std_logic_vector(bus_width_y-1 downto 0);
		xout     : out std_logic_vector(bus_width_x-1 downto 0);
		yout     : out std_logic_vector(bus_width_y-1 downto 0);
		data_in  : in  std_logic_vector(pixel_bus_width-1 downto 0);
		data_out : out std_logic_vector(pixel_bus_width-1 downto 0)
	);
end entity;


architecture arch_1D of gaussian_filter is

component xy_delay_cody is
  generic (
  DELAY_X     : natural := 1;
  DELAY_Y     : natural := 0;
  IMG_WIDTH   : natural := 640;
  IMG_HEIGHT  : natural := 480
  );
port (
  global_clk_i    : in  std_logic;
  global_resetn_i : in  std_logic;
  
  xy_en_i         : in  std_logic;
  xy_x_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
  xy_y_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
  
  xy_en_o : out std_logic;
  xy_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
  xy_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0)
    );
end component;

component xy_delay_cody2 is
  generic (
  DELAY_X     : natural := 1;
  DELAY_Y     : natural := 0;
  IMG_WIDTH   : natural := 640;
  IMG_HEIGHT  : natural := 480
  );
port (
  global_clk_i    : in  std_logic;
  global_resetn_i : in  std_logic;
  
  xy_en_i         : in  std_logic;
  xy_x_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
  xy_y_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
  
  xy_en_o : out std_logic;
  xy_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
  xy_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0)
    );
end component;


-- delay from data_in to the intput of the second pass
	constant delay_x_H     : natural := kernel_width/2;--+1;
	constant delay_y_H     : natural := kernel_width/2;
-- delay from data_in to data_out
-- X : 2*(2) for mult/acc operators (2 passes), kernel_width/2-1 to go through the last half of the horizontal pass
-- Y : kernel_width/2 to go upwards through the first half of the vertical pass
	--constant delay_x_total : natural := kernel_width/2+4;--4 + (kernel_width-2);
	constant delay_x_total : natural := 4 + (kernel_width-2);
	constant delay_y_total : natural := kernel_width/2;

--	component fifo is
--		generic (
--			bus_width : natural := 16;
--			depth     : natural := 320
--		);
--		port (
--			clk, EN, R, W : in  std_logic;
--			data_in : in  std_logic_vector(bus_width-1 downto 0);
--			data_out : out std_logic_vector(bus_width-1 downto 0)
--		);
--	end component fifo;

	signal s_xin : std_logic_vector(bus_width_x-1 downto 0);
	signal s_yin : std_logic_vector(bus_width_y-1 downto 0);

-- First pass : vertical
	type t_kernel_data_in is array(0 to kernel_width-1) of std_logic_vector(pixel_bus_width-1 downto 0);
	signal s_v_mul_in  : t_kernel_data_in;

	type t_kernel_data_out is array(0 to kernel_width-1) of unsigned(pixel_bus_width+bus_width_coeff_sum-1 downto 0);
	signal s_v_mul_out : t_kernel_data_out := (others=>(others=>'0'));
	signal s_v_acc_in1 : t_kernel_data_out := (others=>(others=>'0'));
	signal s_v_acc_out : t_kernel_data_out := (others=>(others=>'0'));
	type t_kernel_data_out_shorter_v is array(0 to kernel_width-2) of unsigned(pixel_bus_width+bus_width_coeff_sum-1 downto 0);
	signal s_v_acc_in2 : t_kernel_data_out_shorter_v := (others=>(others=>'0'));

-- FIFO are used to delay data_in for input of vertical pass. (delay = 1 line +/- operator delay)
	type t_kernel_x is array(0 to kernel_width-1) of std_logic_vector(bus_width_x-1 downto 0);
	signal s_x_fifo : t_kernel_x;
	type t_kernel_y is array(0 to kernel_width-1) of std_logic_vector(bus_width_y-1 downto 0);
	signal s_y_fifo : t_kernel_y;
-- R/W signals for the FIFO
	signal s_R_fifo : std_logic_vector(kernel_width-2 downto 0);
	signal s_W_fifo : std_logic_vector(kernel_width-2 downto 0);

	type t_kernel_coeffs is array(0 to kernel_width-1) of unsigned(bus_width_coeff_sum-1 downto 0);
	signal s_v_coeff        : t_kernel_coeffs;
-- result of first pass
	signal s_v_gauss_result : unsigned(pixel_bus_width-1 downto 0):= (others=>'0');

-- Second pass : horizontal
	signal s_h_mul_out      : t_kernel_data_out := (others=>(others=>'0'));
	signal s_h_acc_in1      : t_kernel_data_out := (others=>(others=>'0'));
	type t_kernel_data_out_shorter_h is array(1 to kernel_width-1) of unsigned(pixel_bus_width+bus_width_coeff_sum-1 downto 0);
	signal s_h_acc_in2      : t_kernel_data_out_shorter_h := (others=>(others=>'0'));
	signal s_h_acc_out      : t_kernel_data_out := (others=>(others=>'0'));
	signal s_h_coeff        : t_kernel_coeffs;
-- result of Gaussian filtering
	signal s_h_gauss_result : unsigned(pixel_bus_width-1 downto 0)  := (others => '0');
-- coordinates of input pixel of second pass
	signal s_h_xin          : std_logic_vector(bus_width_x-1 downto 0);
	signal s_h_yin          : std_logic_vector(bus_width_y-1 downto 0);

	signal s_xout           : std_logic_vector(bus_width_x-1 downto 0);
	signal s_yout           : std_logic_vector(bus_width_y-1 downto 0);

	signal s_v_coordOK, s_h_coordOK : std_logic_vector(0 to kernel_width-1);

	signal s_EN_out, s_h_EN : std_logic;

begin
	data_out <= std_logic_vector(s_h_gauss_result);
	EN_out   <= s_EN_out;
	xout     <= std_logic_vector(s_xout);
	yout     <= std_logic_vector(s_yout);
	s_xin    <= xin;
	s_yin    <= yin;

--	process(clk)
--	begin
--		if (rising_edge(clk)) then
--			if (EN = '1') then
--				s_v_mul_in(0) <= data_in;
--			end if;
--		end if;
--	end process;
	s_v_mul_in(0) <= data_in;


-------------------
-- Vertical pass --
-------------------

	gen_mul_vertical: for y in 0 to (kernel_width-1) generate
		s_v_mul_out(y) <= unsigned(s_v_mul_in(y)) * s_v_coeff(y);
		s_v_coeff(y)   <= to_unsigned(gauss_coeff1D(y-(kernel_width-1)/2, sq_sigma, kernel_width, data_in'length, data_in'length + s_v_coeff(y)'length), s_v_coeff(y)'length);
--		s_v_coeff(y) <= to_unsigned(1, s_v_coeff(y)'length);
		process(clk)
		begin
			if (rising_edge(clk)) then
				if (EN = '1') then
					if ( s_v_coordOK(y) = '1' ) then
						s_v_acc_in1(y) <= s_v_mul_out(y);
					else
						s_v_acc_in1(y) <= (others => '0');
					end if;
				end if;
			end if;
		end process;
	end generate gen_mul_vertical;

	gen_acc_vertical: for y in 0 to (kernel_width-2) generate
		s_v_acc_out(y) <= s_v_acc_in1(y) + s_v_acc_in2(y);
		process(clk)
		begin
			if (rising_edge(clk)) then
				if (EN = '1') then
					s_v_acc_in2(y) <= s_v_acc_out(y+1);
				end if;
			end if;
		end process;
	end generate gen_acc_vertical;
-- first value of accumulation, no acc_in2 here, so acc_in1 is copied to acc_out
	s_v_acc_out(kernel_width-1) <= s_v_acc_in1(kernel_width-1);

	process(clk)
	begin
		if (rising_edge(clk)) then
			s_v_gauss_result <= s_v_acc_out(0)(pixel_bus_width+bus_width_coeff_sum-1 downto bus_width_coeff_sum);
		end if;
	end process;

	gen_EN_vertical: for y in 1 to (kernel_width-1) generate
		process(clk)
		begin
			if(rising_edge(clk)) then
				if (EN = '1') then
					s_v_coordOK(y) <= s_R_fifo(y-1);
				end if;
			end if;
		end process;
	end generate gen_EN_vertical;
	s_v_coordOK(0) <= EN;




---------------------
-- Horizontal pass --
---------------------

	c_xy_delay_horizontal : xy_delay_cody2
	generic map (
		DELAY_X => delay_x_H,
		DELAY_Y => delay_y_H,
		IMG_WIDTH => w_img,
		IMG_HEIGHT => h_img
	)
	port map (
		 global_clk_i => clk,
		 global_resetn_i => reset_n,

		 xy_en_i => EN,
		 xy_x_i => xin,
		 xy_y_i => yin,

		 xy_en_o => s_h_EN,
		 xy_x_o => s_h_xin,
		 xy_y_o => s_h_yin
	 );


	gen_mul_horizontal: for x in 0 to (kernel_width-1) generate
		s_h_mul_out(x) <= s_v_gauss_result * s_h_coeff(x);
		s_h_coeff(x) <= to_unsigned(gauss_coeff1D(x-(kernel_width-1)/2, sq_sigma, kernel_width, data_in'length, data_in'length + s_v_coeff(x)'length), s_v_coeff(x)'length);
		process(clk)
		begin
			if (rising_edge(clk)) then
				if (s_h_EN = '1') then
					if (s_h_coordOK(x) = '1') then
						s_h_acc_in1(x) <= s_h_mul_out(x);
					else
						s_h_acc_in1(x) <= (others => '0');
					end if;
				end if;
			end if;
		end process;
	end generate gen_mul_horizontal;
	s_h_acc_out(0) <= s_h_acc_in1(0);

	gen_mul_horizontal_2: for x in 1 to (kernel_width-1) generate
		s_h_acc_out(x) <= s_h_acc_in1(x) + s_h_acc_in2(x);
		process(clk)
		begin
			if (rising_edge(clk)) then
				if (s_h_EN = '1') then
					s_h_acc_in2(x) <= s_h_acc_out(x-1);
				end if;
			end if;
		end process;
	end generate gen_mul_horizontal_2;

	process(clk)
	begin
		if (rising_edge(clk)) then
			if (s_h_EN = '1') then
				s_h_gauss_result <= s_h_acc_out(kernel_width-1)(pixel_bus_width+bus_width_coeff_sum-1 downto bus_width_coeff_sum);
			end if;
		end if;
	end process;

-- Enable : check if pixels are inside image boundaries, to allow multiplication or replace its product with the value O.
	gen_EN_horizontal_left: for x in 0 to (kernel_width/2-1) generate
		s_h_coordOK(x) <= '1' when ( unsigned(s_h_xin) > x ) else '0';
	end generate gen_EN_horizontal_left;

	s_h_coordOK(kernel_width/2) <= '1';

	gen_EN_horizontal_right: for x in 0 to (kernel_width/2-1) generate
		s_h_coordOK(kernel_width-1-x) <= '1' when ( unsigned(s_h_xin) < w_img - 1 - x ) else '0';
	end generate gen_EN_horizontal_right;

	c_fifo_vertical_0: dual_clk_fifo
		generic map (
			BUS_WIDTH => pixel_bus_width,
			DEPTH => w_img+1
		)
		port map (
			i_rst_n => reset_n,
		
			i_wr_clk => clk,
			i_wr_en => s_W_fifo(0),
			i_wr_data => s_v_mul_in(0),
--			o_wr_full => 
			
			i_rd_clk => clk,
			i_rd_en => s_R_fifo(0),
			o_rd_data => s_v_mul_in(1)
--			o_rd_empty => 
		);

	gen_fifo_vertical_others: for y in 1 to (kernel_width-2) generate
		c_fifo_vertical_others: dual_clk_fifo
			generic map (
				BUS_WIDTH => pixel_bus_width,
				DEPTH => w_img+1
			)
			port map (
				i_rst_n => reset_n,
			
				i_wr_clk => clk,
				i_wr_en => s_W_fifo(y),
				i_wr_data => s_v_mul_in(y),
--				o_wr_full => 
				
				i_rd_clk => clk,
				i_rd_en => s_R_fifo(y),
				o_rd_data => s_v_mul_in(y+1)
--				o_rd_empty => 
			);
	end generate gen_fifo_vertical_others;

	-- Delay for x,y,R,W signals, for input pixels of first pass
	--process(clk)
	--begin
	--  if(rising_edge(clk)) then
	s_W_fifo(0) <= EN;
	--  end if;
	--end process;

	-- c_xy_delay_vertical_0: xy_delay_fred
	-- generic map (
		-- DELAY_X => w_img-1,
		-- DELAY_Y => 0,
		-- IMG_WIDTH => w_img,
		-- IMG_HEIGHT => h_img
	-- )
	-- port map (
		-- global_clk_i => clk,
		-- global_resetn_i => '1',
		
		-- xy_en_i => EN,
		-- xy_x_i => s_xin,
		-- xy_y_i => s_yin,
		
		-- xy_en_o => s_R_fifo(0),
		-- xy_x_o => s_x_fifo(0),
		-- xy_y_o => s_y_fifo(0)
	-- );

	-- gen_s_W_fifo: for i in 1 to (kernel_width-2) generate
		-- s_W_fifo(i) <= s_R_fifo(i-1);
	-- end generate gen_s_W_fifo;

	-- gen_xy_delay_vertical_others: for i in 1 to (kernel_width-2) generate
		-- c_xy_delay_vertical_others : xy_delay_fred
		-- generic map (
			-- DELAY_X => w_img-1,
			-- DELAY_Y => 0,
			-- IMG_WIDTH => w_img,
			-- IMG_HEIGHT => h_img
		-- )
		-- port map (
			 -- global_clk_i => clk,
			 -- global_resetn_i => '1',

			 -- xy_en_i => s_R_fifo(i-1),
			 -- xy_x_i => s_x_fifo(i-1),
			 -- xy_y_i => s_y_fifo(i-1),

			 -- xy_en_o => s_R_fifo(i),
			 -- xy_x_o => s_x_fifo(i),
			 -- xy_y_o => s_y_fifo(i)
		 -- );
	-- end generate gen_xy_delay_vertical_others;


	c_xy_delay_vertical_0: xy_delay_cody2
	generic map (
		DELAY_X => 0,
		DELAY_Y => 1,
		IMG_WIDTH => w_img,
		IMG_HEIGHT => h_img
	)
	port map (
		global_clk_i => clk,
		global_resetn_i => reset_n,
		
		xy_en_i => EN,
		xy_x_i => s_xin,
		xy_y_i => s_yin,
		
		xy_en_o => s_R_fifo(0),
		xy_x_o => s_x_fifo(0),
		xy_y_o => s_y_fifo(0)
	);



	gen_s_W_fifo: for i in 1 to (kernel_width-2) generate
		s_W_fifo(i) <= s_R_fifo(i-1);
	end generate gen_s_W_fifo;

	gen_xy_delay_vertical_others: for i in 1 to (kernel_width-2) generate
		c_xy_delay_vertical_others : xy_delay_cody2
		generic map (
			DELAY_X => 0,
			DELAY_Y => 1,
			IMG_WIDTH => w_img,
			IMG_HEIGHT => h_img
		)
		port map (
			 global_clk_i => clk,
			 global_resetn_i => reset_n,

			 xy_en_i => s_R_fifo(i-1),
			 xy_x_i => s_x_fifo(i-1),
			 xy_y_i => s_y_fifo(i-1),

			 xy_en_o => s_R_fifo(i),
			 xy_x_o => s_x_fifo(i),
			 xy_y_o => s_y_fifo(i)
		 );
	end generate gen_xy_delay_vertical_others;
	
	
	c_xy_delay_out : xy_delay_cody2
	generic map (
    			DELAY_X => delay_x_total ,
			DELAY_Y => delay_y_total,
			IMG_WIDTH => w_img,
			IMG_HEIGHT => h_img
	)
	port map (
	    		global_clk_i => clk,
	    		global_resetn_i => reset_n,
	
	    		xy_en_i => EN,
	    		xy_x_i => xin,
	    		xy_y_i => yin,
	
	    		xy_en_o => s_EN_out,
	    		xy_x_o => s_xout,
			xy_y_o => s_yout
	);
end arch_1D;
