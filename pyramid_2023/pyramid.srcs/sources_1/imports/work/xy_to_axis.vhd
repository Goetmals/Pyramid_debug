library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.saturn_numeric_pkg.all;

entity xy_to_axis is
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
end entity xy_to_axis;

architecture rtl of xy_to_axis is
	constant MAX_COUNT_X : unsigned(i_x'range) := to_unsigned(IMG_WIDTH-1, i_x'length);
	constant MAX_COUNT_Y : unsigned(i_y'range) := to_unsigned(IMG_HEIGHT-1, i_y'length);
	constant ZERO_X : unsigned(i_x'range) := to_unsigned(0, i_x'length);
	constant ZERO_Y : unsigned(i_y'range) := to_unsigned(0, i_y'length);

	signal s_count_x : unsigned(i_x'range);
	signal s_count_y : unsigned(i_y'range);
	
	signal s_en : std_logic := '0';
begin
	s_count_x <= unsigned(i_x);
	s_count_y <= unsigned(i_y);
	
	p_reg : process(aclk, aresetn)
	begin
		if (aresetn = '0') then
-- 			M_AXIS_TLAST <= '0';
			M_AXIS_TUSER <= '0';
			M_AXIS_TDATA <= (others => '0');
			s_en <= '0';
		elsif rising_edge(aclk) then
			if (i_en = '1') then
				s_en <= '1';
-- 				if (s_count_x = MAX_COUNT_X) then
-- 					M_AXIS_TLAST <= '1';
-- 				else
-- 					M_AXIS_TLAST <= '0';
-- 				end if;
				if ((s_count_x = ZERO_X) and (s_count_y = ZERO_Y)) then
					M_AXIS_TUSER <= '1';
				else
					M_AXIS_TUSER <= '0';
				end if;
				M_AXIS_TDATA <= i_value;
			end if;
		end if;
	end process p_reg;

	M_AXIS_TVALID <= s_en and i_en;
	M_AXIS_TLAST <= s_en when (s_count_x = ZERO_X) else '0';
end architecture rtl;