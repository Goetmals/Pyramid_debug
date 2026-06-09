library ieee;
use ieee.std_logic_1164.all;

package delay_pkg is
	component delay is
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
	end component delay;
end package delay_pkg;
