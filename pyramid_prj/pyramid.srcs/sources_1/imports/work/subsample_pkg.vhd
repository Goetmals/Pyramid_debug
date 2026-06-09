library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

library work;
use work.saturn_numeric_pkg.all;

package subsample_pkg is
	component subsample is
		generic (
			pixel_bus_width     : natural := 17;
			w_img               : natural := 640;
			h_img               : integer := 480
		);
		port (
			clk, EN  : in  std_logic;
			reset_n : in std_logic;
			EN_out   : out std_logic;
			xin      : in  std_logic_vector(unsigned_num_bits(w_img-1)-1 downto 0);
			yin      : in  std_logic_vector(unsigned_num_bits(h_img-1)-1 downto 0);
			xout     : out std_logic_vector(unsigned_num_bits(w_img-1)-2 downto 0);
			yout     : out std_logic_vector(unsigned_num_bits(w_img-1)-2 downto 0);
			data_in  : in  std_logic_vector(pixel_bus_width-1 downto 0);
			data_out : out std_logic_vector(pixel_bus_width-1 downto 0)
		);
	end component subsample;
end package subsample_pkg;
