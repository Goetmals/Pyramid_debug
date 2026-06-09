library ieee;
use ieee.std_logic_1164.all;

library work;
use work.saturn_numeric_pkg.all;

package axis_xy_pkg is
	component axis_to_xy is
		generic (
			BUS_WIDTH : positive := 32;
			IMG_WIDTH : positive := 1920;
			IMG_HEIGHT : positive := 1080
		);
		port (
			aclk : in std_logic;
			aresetn : in std_logic;
	--------------------------------------------------------------------------------
	-- AXIS Slave side
	--------------------------------------------------------------------------------
			S_AXIS_TVALID : in std_logic;
			S_AXIS_TUSER : in std_logic;
			S_AXIS_TLAST : in std_logic;
			S_AXIS_TDATA : in std_logic_vector(BUS_WIDTH-1 downto 0);
	--------------------------------------------------------------------------------
	-- AXIS Master side
	--------------------------------------------------------------------------------
			M_AXIS_TREADY : in std_logic;
	--------------------------------------------------------------------------------
	-- XYEn side
	--------------------------------------------------------------------------------
			o_en : out std_logic;
			o_x : out std_logic_vector(UNSIGNED_NUM_BITS(IMG_WIDTH-1)-1 downto 0);
			o_y : out std_logic_vector(UNSIGNED_NUM_BITS(IMG_HEIGHT-1)-1 downto 0);
			o_value : out std_logic_vector(BUS_WIDTH-1 downto 0)
		);
	end component axis_to_xy;
	component xy_to_axis is
		generic (
			MAX_COLOR : positive := 255;
			IMG_WIDTH : positive := 1920;
			IMG_HEIGHT : positive := 1080
		);
		port (
			aclk : in std_logic;
			aresetn : in std_logic;
	--------------------------------------------------------------------------------
	-- XYEn side
	--------------------------------------------------------------------------------
			i_en : in std_logic;
			i_x : in std_logic_vector(UNSIGNED_NUM_BITS(IMG_WIDTH-1)-1 downto 0);
			i_y : in std_logic_vector(UNSIGNED_NUM_BITS(IMG_HEIGHT-1)-1 downto 0);
			i_value : in std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	--------------------------------------------------------------------------------
	-- AXIS Master side
	--------------------------------------------------------------------------------
			M_AXIS_TVALID : out std_logic;
			M_AXIS_TUSER : out std_logic;
			M_AXIS_TLAST : out std_logic;
			M_AXIS_TREADY : in std_logic;
			M_AXIS_TDATA : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0)
		);
	end component xy_to_axis;
end package axis_xy_pkg;
