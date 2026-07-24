library ieee;
use ieee.std_logic_1164.all;

package dual_clk_fifo_pkg is
	component dual_clk_fifo is
		generic (
			BUS_WIDTH : natural := 8; --! Width of the data bus
			DEPTH : natural := 512 --! Number of words of the memory
		);
		port (
			i_rst_n : in std_logic; --! Reset when '0'
		
			i_wr_clk : in std_logic; --! Write clock
			i_wr_en : in std_logic; --! Write Enable (push data)
			i_wr_data : in std_logic_vector(BUS_WIDTH-1 downto 0); --! Data to write
			o_wr_full : out std_logic; --! The FIFO is full
			
			i_rd_clk : in std_logic; --! Read clock
			i_rd_en : in std_logic; --! Read Enable (pop data)
			o_rd_data : out std_logic_vector(BUS_WIDTH-1 downto 0); --! Read data
			o_rd_empty : out std_logic --! The FIFO is empty
		);
	end component dual_clk_fifo;
end package dual_clk_fifo_pkg;
