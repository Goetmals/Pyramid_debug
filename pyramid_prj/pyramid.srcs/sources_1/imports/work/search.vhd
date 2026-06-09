--------------------------------------------------------------------------------
-- search.vhd
-- Laurent FIACK
-- 18/04/2013
--------------------------------------------------------------------------------
-- Search the local maximum in a squared window.
--------------------------------------------------------------------------------
-- Each iteration, check where is the maximum in the first line of the window
-- and store the result in shift registers (depending on the size of the window).
-- The X coordinate of the pixel in the window is also stored.
-- 
-- We then get columns of horizontal maxima. We can check if the central value
-- of this column is the maximum.
-- If so, we check the X coordinate of the horizontal max to see if it is in
-- the midle.
-- 
-- If these two conditions are respected, the pixel is a local max !
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


library work;
use work.saturn_numeric_pkg.all;
use work.saturn_search_pkg.all;
use work.xy_delay_pkg.all;

use work.math_real.all;


entity search is
	generic (
		BUS_WIDTH : positive := 16;
		RADIUS : real := 10.0;
		W_IMG : positive := 640;
		H_IMG : positive := 480;

		MAX_SIZE_LIST : natural := 32
	);
	port (
		i_clk : in std_logic;
		i_reset_n : in std_logic;

		i_en : in std_logic;
		i_data : in std_logic_vector(BUS_WIDTH-1 downto 0);
		i_x : in std_logic_vector(unsigned_num_bits(W_IMG-1)-1 downto 0);
		i_y : in std_logic_vector(unsigned_num_bits(H_IMG-1)-1 downto 0);
		i_threshold : in std_logic_vector(BUS_WIDTH-1 downto 0);

		o_en : out std_logic;
		o_new_keypoint : out std_logic;
		o_data : out std_logic_vector(BUS_WIDTH-1 downto 0);
		o_x : out std_logic_vector(unsigned_num_bits(W_IMG-1)-1 downto 0);
		o_y : out std_logic_vector(unsigned_num_bits(H_IMG-1)-1 downto 0);

		-- latches the x,y constraints
		i_constraints_en : in std_logic;
		-- the constraints itselves
		i_x_constraints : in std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(W_IMG-1)-1 downto 0);
		i_y_constraints : in std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(H_IMG-1)-1 downto 0);
		-- the width of the constraints
		i_x_constraints_width : in std_logic_vector(unsigned_num_bits(W_IMG-1)-1 downto 0);
		i_y_constraints_width : in std_logic_vector(unsigned_num_bits(H_IMG-1)-1 downto 0);
		-- a list of which coordinates allowed the kp
		o_constraints_tag : out std_logic_vector(MAX_SIZE_LIST-1 downto 0)
	);
end entity search;

architecture rtl of search is
--------------------------------------------------------------------------------
-- We will need to know the number of pixels in the side of the window
-- and the square root of the next power of 2 of this number.
--------------------------------------------------------------------------------
	constant C_SIDE : integer := (integer(RADIUS) * 2 + 1);
	constant C_SQRT_SIDE : integer := unsigned_num_bits(C_SIDE);
	constant C_X_MID : std_logic_vector(unsigned_num_bits(C_SIDE-1)-1 downto 0) 
		:= std_logic_vector(to_unsigned(integer(floor(real(C_SIDE)/2.0)), unsigned_num_bits(C_SIDE-1)));

	component max_2_xv is
		generic (
			BUS_WIDTH : positive := 16;
			X_WIDTH : positive := 6
		);
		port (
			i_clk : in std_logic;
			i_reset_n : in std_logic;

			i_en : in std_logic;
			i_val_1 : in std_logic_vector(BUS_WIDTH-1 downto 0);
			i_x_1 : in std_logic_vector(X_WIDTH-1 downto 0);
			i_val_2 : in std_logic_vector(BUS_WIDTH-1 downto 0);
			i_x_2 : in std_logic_vector(X_WIDTH-1 downto 0);

			o_en : out std_logic;
			o_val : out std_logic_vector(BUS_WIDTH-1 downto 0);
			o_x : out std_logic_vector(X_WIDTH-1 downto 0)
		);
	end component max_2_xv;
	
	component shift_reg is
	  generic(
		 bus_width : natural := 17;
		 depth     : natural := 640);
	  port(
		 clk, EN  : in  std_logic;
		 data_in  : in  std_logic_vector(bus_width-1 downto 0);
		 data_out : out std_logic_vector(bus_width-1 downto 0));
	end component shift_reg;

	signal s_x_out : std_logic_vector(unsigned_num_bits(W_IMG-1)-1 downto 0);
	signal s_y_out : std_logic_vector(unsigned_num_bits(H_IMG-1)-1 downto 0);

--------------------------------------------------------------------------------
-- Signals needed for the horizontal tree of comparators
--------------------------------------------------------------------------------
	type val_array_t is array (0 to count_signals(C_SIDE)) of std_logic_vector(i_data'range);
	type x_array_t is array (0 to count_signals(C_SIDE)) of std_logic_vector(unsigned_num_bits(C_SIDE-1)-1 downto 0);
	
	signal s_val_array : val_array_t;
	signal s_x_array : x_array_t;

--------------------------------------------------------------------------------
-- Signals needed for the vertical comparators
--------------------------------------------------------------------------------	
	type v_max_array_t is array (0 to C_SIDE-1) of std_logic_vector(i_data'range);
	type v_x_array_t is array (0 to integer(floor(real(C_SIDE)/2.0))) of std_logic_vector(unsigned_num_bits(C_SIDE-1)-1 downto 0);
	signal s_v_max_array : v_max_array_t;
	signal s_v_x_array : v_x_array_t;
	signal s_v_max_test_array : std_logic_vector(0 to C_SIDE-1);
	
	signal s_v_max_center : std_logic_vector(i_data'range);
	signal s_v_x_center : std_logic_vector(unsigned_num_bits(C_SIDE-1)-1 downto 0);
	signal s_v_max_test_center : std_logic;
	signal s_v_x_test : std_logic;

--------------------------------------------------------------------------------
-- Signals needed for the constraints management
--------------------------------------------------------------------------------	
	signal r_x_constraints : std_logic_vector(i_x_constraints'range);
	signal r_y_constraints : std_logic_vector(i_y_constraints'range);

	signal r_x_constraints_width : std_logic_vector(i_x_constraints_width'range) := std_logic_vector(to_unsigned(W_IMG, i_x_constraints_width'length));
	signal r_y_constraints_width : std_logic_vector(i_y_constraints_width'range) := std_logic_vector(to_unsigned(H_IMG, i_y_constraints_width'length));

	signal s_x_constraints_width_half : std_logic_vector(i_x_constraints_width'range);
	signal s_y_constraints_width_half : std_logic_vector(i_y_constraints_width'range);

	signal s_constraints_tag : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
	signal s_constraints_valid : std_logic;
	
	
begin

--------------------------------------------------------------------------------
-- Let's connect the input pixel to the architecture!
--------------------------------------------------------------------------------
	s_val_array(0) <= i_data;
	
--------------------------------------------------------------------------------
-- g_horizontal_delays :
-- Generates the input horizontal pipeline to fill the first line of the window.
--------------------------------------------------------------------------------
	g_horizontal_delays : for i in 1 to C_SIDE-1 generate
	begin
		p_horizontal_delay : process (i_clk, i_reset_n)
		begin
			if (i_reset_n = '0') then
				s_val_array(i) <= (others => '0');
			elsif rising_edge(i_clk) then
				if (i_en = '1') then
					s_val_array(i) <= s_val_array(i-1);
				end if;
			end if;
		end process p_horizontal_delay;
	end generate g_horizontal_delays;
	
--------------------------------------------------------------------------------
-- g_first :
-- Connect the inputs of the first stage.
-- The X coordinates are static.
--------------------------------------------------------------------------------
	g_first : for s in 0 to C_SIDE-1 generate
	begin
		s_x_array(s) <= std_logic_vector(to_unsigned(s, unsigned_num_bits(C_SIDE-1)));
	end generate g_first;

--------------------------------------------------------------------------------
-- g_depth :
-- Generates the different stages of the tree.
--------------------------------------------------------------------------------
	g_depth : for d in 0 to C_SQRT_SIDE-1 generate
	begin
--------------------------------------------------------------------------------
-- g_width :
-- Generates the comparators in a given stage of the tree.
--------------------------------------------------------------------------------
		g_width : for w in 0 to integer(floor(real(nb_sig_stage(d, C_SIDE))/2.0))-1 generate
		begin
			max_2_xv_inst : component max_2_xv
				generic map (
					BUS_WIDTH => BUS_WIDTH,
					X_WIDTH => unsigned_num_bits(C_SIDE-1)
				)
				port map (
					i_clk => i_clk,
					i_reset_n => i_reset_n,
					
					i_en => i_en,
					i_val_1 => s_val_array(2*w+offset(d,C_SIDE)), 
					i_x_1 => s_x_array(2*w+offset(d,C_SIDE)), 
					i_val_2 => s_val_array(2*w+offset(d,C_SIDE)+1), 
					i_x_2 => s_x_array(2*w+offset(d,C_SIDE)+1), 

					o_val => s_val_array(w+offset(d,C_SIDE)+nb_sig_stage(d,C_SIDE)),
					o_x => s_x_array(w+offset(d,C_SIDE)+nb_sig_stage(d,C_SIDE))
				);
		end generate g_width;
--------------------------------------------------------------------------------
-- g_odd :
-- When in a stage the number of signals to compare is odd,
-- the value is registered to meet the latency of the comparators,
-- and sent to the next stage.
--------------------------------------------------------------------------------
		g_odd : if (nb_sig_stage(d,C_SIDE) mod 2 = 1) generate
--------------------------------------------------------------------------------
-- As the X coordinates are static, it don't have to be registered.
--------------------------------------------------------------------------------
			s_x_array(nb_sig_stage(d,C_SIDE)+offset(d,C_SIDE)+integer(floor(real(nb_sig_stage(d, C_SIDE))/2.0)))
				<= s_x_array(nb_sig_stage(d,C_SIDE)+offset(d,C_SIDE)-1);
--------------------------------------------------------------------------------
-- p_delay :
-- Register that delays the un-compared signal.
--------------------------------------------------------------------------------
			p_delay : process (i_clk, i_reset_n)
			begin
				if (i_reset_n = '0') then
					s_val_array(nb_sig_stage(d,C_SIDE)+offset(d,C_SIDE)+integer(floor(real(nb_sig_stage(d, C_SIDE))/2.0))) <= (others => '0');
				elsif rising_edge(i_clk) then
					if (i_en = '1') then
						s_val_array(nb_sig_stage(d,C_SIDE)+offset(d,C_SIDE)+integer(floor(real(nb_sig_stage(d, C_SIDE))/2.0)))
							<= s_val_array(nb_sig_stage(d,C_SIDE)+offset(d,C_SIDE)-1);
					end if;
				end if;
			end process p_delay;
		end generate g_odd;
	end generate g_depth;
	
--------------------------------------------------------------------------------
-- Let's connect the output of the horizontal to the input of the vertical part.
--------------------------------------------------------------------------------
	s_v_max_array(0) <= s_val_array(offset(C_SQRT_SIDE-1,C_SIDE)+nb_sig_stage(C_SQRT_SIDE-1,C_SIDE));
	s_v_x_array(0) <= s_x_array(offset(C_SQRT_SIDE-1,C_SIDE)+nb_sig_stage(C_SQRT_SIDE-1,C_SIDE));
	
--------------------------------------------------------------------------------
-- g_shift_regs_max :
-- Generate the shift registers needed for the vertical maximum detection
--------------------------------------------------------------------------------
	g_shift_regs_max : for i in 1 to C_SIDE-1 generate
	begin
		shift_reg_max_inst : component shift_reg
			generic map (
				bus_width => BUS_WIDTH,
				depth => W_IMG-1
			)
			port map (
				clk => i_clk,
				EN => i_en,
				data_in => s_v_max_array(i-1),
				data_out => s_v_max_array(i)
			);
	end generate g_shift_regs_max;
	
	s_v_max_center <= s_v_max_array(integer(floor(real(C_SIDE)/2.0)));
	
--------------------------------------------------------------------------------
-- g_shift_regs_x :
-- Generate the shift registers needed for the vertical x
-- Only need to store until the mid-column.
--------------------------------------------------------------------------------
	g_shift_regs_x : for i in 1 to integer(floor(real(C_SIDE)/2.0)) generate
	begin
		shift_reg_x_inst : component shift_reg
			generic map (
				bus_width => unsigned_num_bits(C_SIDE-1),
				depth => W_IMG-1
			)
			port map (
				clk => i_clk,
				EN => i_en,
				data_in => s_v_x_array(i-1),
				data_out => s_v_x_array(i)
			);
	end generate g_shift_regs_x;

	s_v_x_center <= s_v_x_array(s_v_x_array'right);
	
--------------------------------------------------------------------------------
-- g_v_comp :
-- Generates the vertical comparators
--------------------------------------------------------------------------------
	g_v_comp : for i in 0 to C_SIDE-1 generate
	begin
		s_v_max_test_array(i) <= '0' when (s_v_max_center < s_v_max_array(i)) else '1';
	end generate g_v_comp;


--------------------------------------------------------------------------------
-- Constraints management
--------------------------------------------------------------------------------
	s_x_constraints_width_half <= '0' & r_x_constraints_width(r_x_constraints_width'left downto r_x_constraints_width'right+1);--r_x_constraints_width srl 1;
	s_y_constraints_width_half <= '0' & r_y_constraints_width(r_y_constraints_width'left downto r_y_constraints_width'right+1);--r_y_constraints_width srl 1;

	p_constraints_latch : process (i_clk, i_reset_n)
	begin
		if (i_reset_n = '0') then
			for i in 0 to MAX_SIZE_LIST-1 loop
				r_x_constraints((i+1)*unsigned_num_bits(W_IMG-1)-1 downto i*unsigned_num_bits(W_IMG-1)) <= std_logic_vector(to_unsigned(W_IMG/2, unsigned_num_bits(W_IMG-1)));
				r_y_constraints((i+1)*unsigned_num_bits(H_IMG-1)-1 downto i*unsigned_num_bits(H_IMG-1)) <= std_logic_vector(to_unsigned(H_IMG/2, unsigned_num_bits(H_IMG-1)));

				r_x_constraints_width <= std_logic_vector(to_unsigned(W_IMG, r_x_constraints_width'length));
				r_y_constraints_width <= std_logic_vector(to_unsigned(H_IMG, r_y_constraints_width'length));
			end loop;
		elsif rising_edge(i_clk) then
			if (i_constraints_en = '1') then
				r_x_constraints <= i_x_constraints;
				r_y_constraints <= i_y_constraints;
	
				r_x_constraints_width <= i_x_constraints_width;
				r_y_constraints_width <= i_y_constraints_width;
			end if;
		end if;
	end process p_constraints_latch;

	g_constraints : for i in 0 to MAX_SIZE_LIST-1 generate
		p_constraints : process(s_x_out, s_y_out, r_x_constraints, r_y_constraints, s_x_constraints_width_half, s_y_constraints_width_half)
			variable x : unsigned(unsigned_num_bits(W_IMG-1)-1 downto 0);
			variable y : unsigned(unsigned_num_bits(H_IMG-1)-1 downto 0);

			variable x_const : unsigned(unsigned_num_bits(W_IMG-1)-1 downto 0);
			variable y_const : unsigned(unsigned_num_bits(H_IMG-1)-1 downto 0);

			variable x_width_half : unsigned(unsigned_num_bits(W_IMG-1)-1 downto 0);
			variable y_width_half : unsigned(unsigned_num_bits(H_IMG-1)-1 downto 0);
		begin
			x := unsigned(s_x_out);
			y := unsigned(s_y_out);

			x_const := unsigned(r_x_constraints((i+1)*unsigned_num_bits(W_IMG-1)-1 downto i*unsigned_num_bits(W_IMG-1)));
			y_const := unsigned(r_y_constraints((i+1)*unsigned_num_bits(H_IMG-1)-1 downto i*unsigned_num_bits(H_IMG-1)));

			x_width_half := unsigned(s_x_constraints_width_half);
			y_width_half := unsigned(s_y_constraints_width_half);

			if ((x > x_const-x_width_half) and (x < x_const+x_width_half) and (y > y_const-y_width_half) and (y < y_const+y_width_half)) then
				s_constraints_tag(i) <= '1';
			else
				s_constraints_tag(i) <= '0';
			end if;
		end process p_constraints;
	end generate g_constraints;

	s_constraints_valid <= '0' when (s_constraints_tag = std_logic_vector(to_unsigned(0, s_constraints_tag'length))) else '1';
	
--------------------------------------------------------------------------------
-- Final tests
--------------------------------------------------------------------------------
	s_v_max_test_center <= '1' when s_v_max_test_array = (s_v_max_test_array'range => '1') else '0';
	s_v_x_test <= '1' when (s_v_x_center = C_X_MID) else '0';
	
	o_new_keypoint <= s_v_max_test_center and s_v_x_test and s_constraints_valid;
	o_data <= s_v_max_center;

--------------------------------------------------------------------------------
-- Generation of the X, Y and enable outputs
--------------------------------------------------------------------------------

	c_xy_delay : xy_delay
		generic map (
			DELAY_X => C_SQRT_SIDE + integer(RADIUS)-1,
			DELAY_Y => integer(RADIUS),
			IMG_WIDTH => W_IMG,
			IMG_HEIGHT => H_IMG
		)
		port map (
			global_clk_i => i_clk,
			global_resetn_i => i_reset_n,

			xy_en_i => i_en,
			xy_x_i => i_x,
			xy_y_i => i_y,

			xy_en_o => o_en,
			xy_x_o => s_x_out,
			xy_y_o => s_y_out
		);

	o_x <= s_x_out;
	o_y <= s_y_out;

	o_constraints_tag <= s_constraints_tag;
	
	
end architecture rtl;
