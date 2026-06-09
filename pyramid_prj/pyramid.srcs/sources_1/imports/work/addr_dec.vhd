library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

----------------------------------------------------------------------------------
-- Registers Map
----------------------------------------------------------------------------------
-- 0 --> 1680   Key-point feature           ( RO )       ( 0x00001A40 )
-- 2048         Frame counter               ( RO )       ( 0x00002000 )
-- 2049         Key-point counter           ( RO )       ( 0x00002004 )
-- 2050         X                           ( RO )       ( 0x00002008 )
-- 2051         Y                           ( RO )       ( 0x0000200C )
-- 2052         Value                       ( RO )       ( 0x00002010 )
-- 2053         Key-point constraints tag   ( RO )       ( 0x00002014 )
-- 2054         Key-point index             ( RW )       ( 0x00002018 )
-- 2055			X constraint width 00 		( RW )		 ( 0x0000201C )
-- 2056			Y constraint width 00 		( RW )		 ( 0x00002020 )
-- 2057			X constraint width 01 		( RW )		 ( 0x00002024 )
-- 2058			Y constraint width 01 		( RW )		 ( 0x00002028 )
-- 2059			X constraint width 10 		( RW )		 ( 0x0000202C )
-- 2060			Y constraint width 10 		( RW )		 ( 0x00002030 )
-- 2061			X constraint width 11 		( RW )		 ( 0x00002034 )
-- 2062			Y constraint width 11 		( RW )		 ( 0x00002038 )
-- 2063			X constraint width 20 		( RW )		 ( 0x0000203C )
-- 2064			Y constraint width 20 		( RW )		 ( 0x00002040 )
-- 2065			X constraint width 21 		( RW )		 ( 0x00002044 )
-- 2066			Y constraint width 21 		( RW )		 ( 0x00002048 )
-- 2067         X constraint                ( RW )       ( 0x0000204C )
-- 2068         Y constraint                ( RW )       ( 0x00002050 )
-- 2069         Constraint index            ( RW )       ( 0x00002054 )
-- 2070         Constraint enable           ( RW )       ( 0x00002058 )
-- 2071         Source (2:0)                ( RW )       ( 0x0000205C )
--                  0 : 000 : Grey Scale
--                  1 : 001 : Gradient
--                  2 : 010 : DoG 00
--                  3 : 011 : DoG 01
--                  4 : 100 : DoG 10
--                  5 : 101 : DoG 11
--                  6 : 110 : DoG 20
--                  7 : 111 : DoG 21
----------------------------------------------------------------------------------
-- o_reg_sel signal selects which register (or memory) to access.
--
-- bit 0 : memory
-- bit 1 : Frame counter
-- bit 2 : Key-point counter
-- bit 3 : Key-point X
-- bit 4 : Key-point Y
-- bit 5 : Key-point value
-- bit 6 : Key-point index
-- bit 7 : X constraint
-- bit 8 : Y constraint
-- bit 9 : Source
----------------------------------------------------------------------------------

entity addr_dec is
	generic (
		REG_NUMBER : positive := 25
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
end entity addr_dec;

architecture rtl of addr_dec is
	signal s_reg_rd_ack : std_logic;
	signal s_mem_rd_ack : std_logic := '0';
begin
--------------------------------------------------------------------------------
-- p_mem_rd_ack : Process that handles the read ack signal
--     when the memory is read.
--------------------------------------------------------------------------------
	p_mem_rd_ack : process(i_clk, i_reset_n)
	begin
		if (i_reset_n = '0') then
			s_mem_rd_ack <= '0';
		elsif rising_edge(i_clk) then
			s_mem_rd_ack <= i_rd_ce;
		end if;
	end process p_mem_rd_ack;
--------------------------------------------------------------------------------
-- Select which register (or memory) is beeing accessed
--------------------------------------------------------------------------------
	o_reg_sel(0) <= not i_addr(11); -- Selects the memory
	g_sel : for i in 1 to REG_NUMBER-1 generate
		o_reg_sel(i) <= '1' 
			when ((to_integer(unsigned(i_addr(10 downto 0))) = i-1) and i_addr(11) = '1')
			else '0';
	end generate g_sel;
--------------------------------------------------------------------------------
-- Manage the read and write ack signals for the registers
--------------------------------------------------------------------------------
	s_reg_rd_ack <= i_rd_ce;
	o_wr_ack <= i_wr_ce;
--------------------------------------------------------------------------------
-- Select the right read ack signal depending on the address.
-- If i_addr(11) = '0' we read the memory, else we read a register.
--------------------------------------------------------------------------------
	o_rd_ack <= s_mem_rd_ack when (i_addr(11) = '0') else s_reg_rd_ack;
--------------------------------------------------------------------------------
-- Our architecture is errorless !
--------------------------------------------------------------------------------
	o_error <= '0';
end architecture rtl;
