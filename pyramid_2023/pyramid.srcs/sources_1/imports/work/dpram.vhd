library ieee;
use ieee.std_logic_1164.all;

entity dpram is
	generic (
		ADDRESS_WIDTH : positive := 5;
		DATA_WIDTH : positive := 16
	);
	port (
		clk_i : in std_logic;
		reset_n_i : in std_logic;
	
		read_address_i : in std_logic_vector(ADDRESS_WIDTH-1 downto 0);
		read_data_o : out std_logic_vector(DATA_WIDTH-1 downto 0);

		write_enable_i : in std_logic;
		write_address_i : in std_logic_vector(ADDRESS_WIDTH-1 downto 0);
		write_data_i : in std_logic_vector(DATA_WIDTH-1 downto 0)
	);
end entity dpram;

 architecture rtl of dpram is
	component generic_dpram is
		generic (
			aw : positive := 5;
			dw : positive := 16
		);
		port (
			rclk : in std_logic;
			rrst : in std_logic;
			rce : in std_logic;
			oe : in std_logic;
			raddr : in std_logic_vector(aw-1 downto 0);
			do : out std_logic_vector(dw-1 downto 0);

			wclk : in std_logic;
			wrst : in std_logic;
			wce : in std_logic;
			we : in std_logic;
			waddr : in std_logic_vector(aw-1 downto 0);
			di : in std_logic_vector(dw-1 downto 0)
		);
	end component generic_dpram;

	signal reset_s : std_logic;
begin
	reset_s <= not reset_n_i;

	memory : generic_dpram
		generic map (
			aw => ADDRESS_WIDTH,
			dw => DATA_WIDTH
		)
		port map (
			rclk => clk_i,
			rrst => reset_s,
			rce => '1',
			oe => '1',
			raddr => read_address_i,
			do => read_data_o ,

			wclk => clk_i,
			wrst => reset_s,
			wce => '1',
			we => write_enable_i,
			waddr => write_address_i,
			di => write_data_i
		);
end architecture rtl;
