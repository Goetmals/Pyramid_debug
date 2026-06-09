library ieee;
use ieee.std_logic_1164.all;

library work;
use work.saturn_numeric_pkg.all;

package gaussian_filter_pkg is
	component gaussian_filter is
		generic(
			pixel_bus_width     : natural := 17;
			w_img               : natural := 640;
			h_img               : natural := 480;
			bus_width_x         : natural := unsigned_num_bits(640);
			bus_width_y         : natural := unsigned_num_bits(480);
		-- sq_sigma is the square of the sigma coefficient for the Gaussian function.
			sq_sigma            : real    := 2.0;
			kernel_width        : natural := 7;
			bus_width_coeff_sum : natural := 24);
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
	end component gaussian_filter;
end package gaussian_filter_pkg;
