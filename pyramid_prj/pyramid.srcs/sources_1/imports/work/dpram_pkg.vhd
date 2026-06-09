library ieee;
use ieee.std_logic_1164.all;

package dpram_pkg is
	component dpram is
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
	end component dpram;
end package dpram_pkg;
