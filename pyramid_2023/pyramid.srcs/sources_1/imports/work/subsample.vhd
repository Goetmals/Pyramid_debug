library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


library work;
use work.saturn_numeric_pkg.all;

entity subsample is
	generic (
		pixel_bus_width     : natural := 17;
		w_img               : natural := 640;
		h_img               : integer := 480
	);
	port (
		clk, EN  : in  std_logic;
		reset_n : in std_logic;
		EN_out   : out std_logic;
		xin      : in  std_logic_vector(unsigned_num_bits(w_img-1)-1 downto 0);
		yin      : in  std_logic_vector(unsigned_num_bits(h_img-1)-1 downto 0);
		xout     : out std_logic_vector(unsigned_num_bits(w_img-1)-2 downto 0);
		yout     : out std_logic_vector(unsigned_num_bits(w_img-1)-2 downto 0);
		data_in  : in  std_logic_vector(pixel_bus_width-1 downto 0);
		data_out : out std_logic_vector(pixel_bus_width-1 downto 0)
	);
end entity subsample;

architecture simple of subsample is
    signal last_line : std_logic;
    signal odd_height : std_logic;
    signal h_img_bus : std_logic_vector(9 downto 0);
    
begin
    h_img_bus <= conv_std_logic_vector(h_img,10);
    
    last_line <= '1' when (unsigned(yin) = h_img-1) else '0';
    odd_height <= '1' when h_img_bus(0) = '1' else '0';
    
	EN_out <= EN when ((odd_height = '0') and (xin(0) = '0') and (yin(0) = '0')) or 
	                  ((odd_height = '1') and (xin(0) = '0') and (yin(0) = '0') and last_line = '0')
	                   else '0';
	
	xout <= xin(xin'left downto 1);
	yout <= yin(yin'left downto 1);
	
	data_out <= data_in;
	
end architecture simple;
