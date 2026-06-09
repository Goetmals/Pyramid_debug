library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.saturn_numeric_pkg.all;

entity axis_to_xy is
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
end entity axis_to_xy;

architecture rtl of axis_to_xy is
	constant MAX_COUNT_X : unsigned(o_x'range) := to_unsigned(IMG_WIDTH-1, o_x'length);
	constant MAX_COUNT_Y : unsigned(o_y'range) := to_unsigned(IMG_HEIGHT-1, o_y'length);

	signal r_count_x : unsigned(o_x'range);
	signal r_count_y : unsigned(o_y'range);
	signal s_en : std_logic;
	signal s_y_en : std_logic;
begin
	s_en <= S_AXIS_TVALID and M_AXIS_TREADY;
	s_y_en <= s_en and S_AXIS_TLAST;
	
	p_count_x : process (aclk, aresetn)
	begin
		if (aresetn = '0') then
			r_count_x <= (others => '0');
		elsif rising_edge(aclk) then
			if (s_en = '1') then
				if (S_AXIS_TLAST = '1') then
					r_count_x <= (others => '0');
				else
					r_count_x <= r_count_x + 1;
				end if;
			end if;

		end if;
	end process p_count_x;
	
	p_count_y : process (aclk, S_AXIS_TUSER)
	begin
		if (S_AXIS_TUSER = '1') then
			r_count_y <= (others => '0');
		elsif rising_edge(aclk) then
			if (s_y_en = '1') then
				r_count_y <= r_count_y + 1;
			end if;
		end if;
	end process p_count_y;
	
	o_en <= s_en;
	o_x <= std_logic_vector(r_count_x);
	o_y <= std_logic_vector(r_count_y);
	o_value <= S_AXIS_TDATA;
end architecture rtl;