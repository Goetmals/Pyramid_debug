--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.saturn_numeric_pkg.all;

entity rgb_to_gs is
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
end entity rgb_to_gs;

architecture rtl of rgb_to_gs is
	signal s_red : unsigned(9 downto 0);
	signal s_green : unsigned(9 downto 0);
	signal s_blue : unsigned(9 downto 0);
	signal s_gs : unsigned(9 downto 0);
	signal s_en : std_logic := '0';
begin
	s_red <= unsigned("00" & i_value(7 downto 0));
	s_green <= unsigned("00" & i_value(15 downto 8));
	s_blue <= unsigned("00" & i_value(23 downto 16));
	
	p_gs : process (aclk, aresetn)
	begin
		if (aresetn = '0') then
			s_gs <= (others => '0');
		elsif rising_edge(aclk) then
			if i_en = '1' then
				s_gs <= s_red + s_green + s_green + s_blue;
			end if;
		end if;
	end process p_gs;
	
	g_resize_a : if (BUS_WIDTH <= 10) generate
		o_value <= std_logic_vector(s_gs(9 downto (10-BUS_WIDTH)));
	end generate g_resize_a;
	g_resize_b : if (BUS_WIDTH > 10) generate
		o_value <= std_logic_vector(to_unsigned(0, BUS_WIDTH-10) & s_gs);
	end generate g_resize_b;
	
	p_fifo : process (aclk, aresetn)
	begin
		if (aresetn = '0') then
			s_en <= '0';
			o_x <= (others => '0');
			o_y <= (others => '0');
		elsif rising_edge(aclk) then
			if (i_en = '1') then
				s_en <= '1';
				o_x <= i_x;
				o_y <= i_y;
			end if;
		end if;
	end process p_fifo;
	o_en <= i_en and s_en;
end architecture rtl;
