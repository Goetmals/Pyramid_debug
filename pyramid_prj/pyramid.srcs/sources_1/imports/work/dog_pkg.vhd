library ieee;
use ieee.std_logic_1164.all;

library work;
use work.saturn_numeric_pkg.all;

package dog_pkg is
	component dog is
		generic(
			pixel_bus_width : natural := 17;
			w_img           : natural := 640;
			h_img           : natural := 480;
			bus_width_x     : natural := UNSIGNED_NUM_BITS(640);
			bus_width_y     : natural := UNSIGNED_NUM_BITS(480)
		);
		port(
			clk, EN   : in  std_logic;
			EN_out    : out std_logic;
			xin       : in  std_logic_vector(bus_width_x-1 downto 0);
			yin       : in  std_logic_vector(bus_width_y-1 downto 0);
			xout      : out std_logic_vector(bus_width_x-1 downto 0);
			yout      : out std_logic_vector(bus_width_y-1 downto 0);
			data_in_a : in  std_logic_vector(pixel_bus_width-1 downto 0);
			data_in_b : in  std_logic_vector(pixel_bus_width-1 downto 0);
			data_out  : out std_logic_vector(pixel_bus_width-1 downto 0)
		);
	end component dog;
end package dog_pkg;
