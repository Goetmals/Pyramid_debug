----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.12.2021 14:31:22
-- Design Name: 
-- Module Name: imaging_to_axis - arch_imaging_to_axis
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity imaging_to_axis is
    Port ( clkb : in STD_LOGIC;
           resetb : in STD_LOGIC;
           hsync_in : in STD_LOGIC;
           vsync_in : in STD_LOGIC;
           pixel_in : in STD_LOGIC_VECTOR (7 downto 0);
           M_AXIS_TREADY : in STD_LOGIC;
           M_AXIS_TVALID : out STD_LOGIC;
 --          M_AXIS_TUSER : out STD_LOGIC;
           M_AXIS_TLAST : out STD_LOGIC;
           M_AXIS_TDATA : out STD_LOGIC_VECTOR (7 downto 0));
end imaging_to_axis;

architecture arch_imaging_to_axis of imaging_to_axis is

component shift_reg is
	  generic(
	    bus_width : natural := 17;
	    depth     : natural := 640);
	  port(
	    clk, EN  : in  std_logic;
	    data_in  : in  std_logic_vector(bus_width-1 downto 0);
	    data_out : out std_logic_vector(bus_width-1 downto 0));
end component;
	
constant  w_img : natural := 256;
constant pixel_bus_width_in : natural := 8;

signal hsync_rtd, vsync_rtd, enable : std_logic;
signal eol, sof : std_logic_vector(1 downto 0);
signal doF : std_logic_vector(7 downto 0);

begin

enable <= not(hsync_in);

--LR0:  shift_reg
--	generic map(
--	  --depth => w_img-3,                  -- Commented by Fred 07/01/22
--	  depth => w_img,
--	  bus_width => pixel_bus_width_in)
--	port map(
--	  clk      => clkb,
--	  EN       => enable,
--	  data_in  => pixel_in,
--	  data_out => doF
--	  );
	  
--M_AXIS_TDATA <= doF when (M_AXIS_TREADY = '1' and vsync_rtd = '0')
--           else (others=>'0');
           
M_AXIS_TVALID <= not vsync_rtd;

RSC0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			hsync_rtd <= '0';
			vsync_rtd <= '0';
			
		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			hsync_rtd <= hsync_in;
			vsync_rtd <= vsync_in;
		end if;
	end process;

-- detection 1ere ligne
	-- --------------------------------------------------------- --
D1L0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
				sof <= "01";

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			-- ----------------------------------------- --
			if    (  vsync_in = '0'	and hsync_in = '0' and hsync_rtd = '1' ) then
				sof <= sof(0)&'0';

			-- ----------------------------------------- --
			elsif (  vsync_in = '1'	and hsync_in = '0' and hsync_rtd = '1' ) then
			--else	sof <= "01";
			end if;
		end if;
	end process;

-- détection début/fin d'image --
	-- ---------------------------------------------------------- --
--NSV0:	process ( resetb,clkb )
--	begin
--		if    ( resetb='0' ) then	
--			sof<= "00";

--		elsif ( rising_edge(clkb) ) then
--			if ( hsync_in = '0' and hsync_rtd = '1') then 	
--				sof <= sof(0) & vsync_in;
--			end if;
--		end if;
--	end process;	
	
eol <= hsync_in & hsync_rtd;

M_AXIS_TLAST <=  '1' when eol = "10"
            else '0';
            
M_AXIS_TDATA <= pixel_in;

--M_AXIS_TUSER <= sof(1);

--M_AXIS_TUSER <= '1' when ??

end arch_imaging_to_axis;
