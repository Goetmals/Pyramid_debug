library ieee;
use ieee.std_logic_1164.all;

library work;
use work.saturn_numeric_pkg.all;

package xy_delay_pkg is
	component xy_delay is
		generic (
			DELAY_X : natural := 1;
			DELAY_Y : natural := 0;
			IMG_WIDTH : positive := 16;
			IMG_HEIGHT : positive := 9
		);
		port (
			global_clk_i : in std_logic;
			global_resetn_i : in std_logic;
	
			xy_en_i : in std_logic;
			xy_x_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			xy_y_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	
			xy_en_o : out std_logic;
			xy_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			xy_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0)
		);
	end component xy_delay;
end package xy_delay_pkg;
