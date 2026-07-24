library ieee;
use ieee.std_logic_1164.all;

library work;
use work.saturn_numeric_pkg.all;

package rgb_to_gs_pkg is
	component rgb_to_gs is
		generic (
			BUS_WIDTH : positive := 8;
			IMG_WIDTH : positive := 1920;
			IMG_HEIGHT : positive := 1080
		);
		port (
			aclk : in std_logic;
			aresetn : in std_logic;
		
			i_en : in std_logic;
			i_x : in std_logic_vector(UNSIGNED_NUM_BITS(IMG_WIDTH-1)-1 downto 0);
			i_y : in std_logic_vector(UNSIGNED_NUM_BITS(IMG_HEIGHT-1)-1 downto 0);
			i_value : in std_logic_vector(31 downto 0);
		
			o_en : out std_logic;
			o_x : out std_logic_vector(UNSIGNED_NUM_BITS(IMG_WIDTH-1)-1 downto 0);
			o_y : out std_logic_vector(UNSIGNED_NUM_BITS(IMG_HEIGHT-1)-1 downto 0);
			o_value : out std_logic_vector(BUS_WIDTH-1 downto 0)
		);
	end component rgb_to_gs;
end package rgb_to_gs_pkg;

