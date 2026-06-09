library ieee;
use ieee.std_logic_1164.all;

library work;
use work.saturn_numeric_pkg.all;

package addr_dec_pkg is
	component addr_dec is
		generic (
			REG_NUMBER : positive := 24
		);
		port (
			i_clk : in std_logic;
			i_reset_n : in std_logic;
			i_addr : in std_logic_vector(11 downto 0);
			i_rd_ce : in std_logic;
			i_wr_ce : in std_logic;
		
			o_reg_sel : out std_logic_vector(REG_NUMBER-1 downto 0);
			o_rd_ack : out std_logic;
			o_wr_ack : out std_logic;
			o_error : out std_logic
		);
	end component addr_dec;
end package addr_dec_pkg;

