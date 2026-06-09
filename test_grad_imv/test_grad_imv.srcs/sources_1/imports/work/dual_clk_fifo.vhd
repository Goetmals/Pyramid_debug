--------------------------------------------------------------------------------
--! @file
--! @brief Dual clock FIFO
--! @author Laurent FIACK
--! @email laurent.fiack@ensea.fr
--! @date 2013-06-04
--! @version 1.0
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.saturn_numeric_pkg.all;

--! Dual clock FIFO.

--! Allows to synchronize data between two clock domains.
entity dual_clk_fifo is
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
end entity dual_clk_fifo;

--! @brief RTL model of the dual clock FIFO
architecture arch of dual_clk_fifo is
	component generic_fifo_dc_gray is
		generic (
			dw : natural := 16;
			aw : natural := 8
		);
		port (
			rd_clk : in std_logic;
			wr_clk : in std_logic;
			rst : in std_logic;
			clr : in std_logic;
			din : in std_logic_vector(dw-1 downto 0);
			we : in std_logic;
			dout : out std_logic_vector(dw-1 downto 0);
			re : in std_logic;
			full : out std_logic;
			empty : out std_logic;
			wr_level : out std_logic_vector(1 downto 0);
			rd_level : out std_logic_vector(1 downto 0)
		);
	end component generic_fifo_dc_gray;
	signal s_clr : std_logic;
begin
	s_clr <= not i_rst_n;
	fifo_inst : component generic_fifo_dc_gray
		generic map (
			dw => BUS_WIDTH,
			aw => unsigned_num_bits(DEPTH-1)
		)
		port map (
			rd_clk => i_rd_clk,
			wr_clk => i_wr_clk,
			rst => i_rst_n,
			clr => s_clr,
			din => i_wr_data,
			we => i_wr_en,
			dout => o_rd_data,
			re => i_rd_en,
			full => o_wr_full,
			empty => o_rd_empty
		);
end architecture arch;
