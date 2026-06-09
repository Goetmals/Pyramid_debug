library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity max_2_xv is
	generic (
		BUS_WIDTH : positive := 16;
		X_WIDTH : positive := 6
	);
	port (
		i_clk : in std_logic;
		i_reset_n : in std_logic;

		i_en : in std_logic;
		i_val_1 : in std_logic_vector(BUS_WIDTH-1 downto 0);
		i_x_1 : in std_logic_vector(X_WIDTH-1 downto 0);
		i_val_2 : in std_logic_vector(BUS_WIDTH-1 downto 0);
		i_x_2 : in std_logic_vector(X_WIDTH-1 downto 0);

		o_en : out std_logic;
		o_val : out std_logic_vector(BUS_WIDTH-1 downto 0);
		o_x : out std_logic_vector(X_WIDTH-1 downto 0)
	);
end entity max_2_xv;

architecture rtl of max_2_xv is
	signal r_en : std_logic := '0';

	signal s_i_val_1 : unsigned(BUS_WIDTH-1 downto 0);
	signal s_i_val_2 : unsigned(BUS_WIDTH-1 downto 0);
begin
	o_en <= r_en and i_en;

	s_i_val_1 <= unsigned(i_val_1);
	s_i_val_2 <= unsigned(i_val_2);

	p_max : process (i_clk, i_reset_n)
	begin
		if (i_reset_n = '0') then
			r_en <= '0';
			o_val <= (others => '0');
			o_x <= (others => '0');
		elsif rising_edge(i_clk) then
			if (i_en = '1') then
				r_en <= '1';
				if (s_i_val_2 > s_i_val_1) then
					o_val <= i_val_2;
					o_x <= i_x_2;
				else
					o_val <= i_val_1;
					o_x <= i_x_1;
				end if;
			end if;
		end if;
	end process p_max;
end architecture rtl;
