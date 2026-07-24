library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


library work;
use work.saturn_numeric_pkg.all;

entity subsample is
	generic (
		pixel_bus_width     : natural := 17;
		w_img               : natural := 640;
		h_img               : integer := 480
	);
	port (
		clk                   : in  std_logic;
		reset_n               : in std_logic;
		EN                    : in std_logic;
		hsync_in, vsync_in    : in std_logic;
		xin, yin              : in  std_logic_vector(unsigned_num_bits(w_img-1)-1 downto 0);
		data_in               : in  std_logic_vector(pixel_bus_width-1 downto 0);
		
		EN_out                : out std_logic;
		hsync_out, vsync_out  : out std_logic;
        xout, yout            : out std_logic_vector(unsigned_num_bits(w_img-1)-2 downto 0);
		data_out              : out std_logic_vector(pixel_bus_width-1 downto 0)
	);
end entity subsample;

architecture simple of subsample is

component clk_wiz_0
    port ( 
        clk_in1     : in std_logic;
        resetn      : in std_logic;
        
        clk_out1    : out std_logic;
        locked      : out std_logic
         );
end component;

    signal clk_buf  : std_logic;
    signal last_line : std_logic;
    signal odd_height : std_logic;
    signal h_img_bus : std_logic_vector(9 downto 0);
    signal xint, yint : std_logic_vector(unsigned_num_bits(w_img-1)-2 downto 0);
    signal lig_inc : std_logic;
    signal hsync_o_int, vsync_o_int : std_logic;
    signal vsync_rtd, hsync_rtd : std_logic;
    signal hsync_o_int_rtd, hsync_o_int_rtd2 : std_logic;
    signal div_lig : std_logic;
    signal first_lig : std_logic;
    
begin

MMC0: clk_wiz_0
    port map ( 
        clk_in1     => clk,
        resetn      => reset_n,
        
        clk_out1    => clk_buf,
        locked      => open
         );
         
    h_img_bus <= conv_std_logic_vector(h_img,10);
    
    last_line <= '1' when (unsigned(yin) = h_img-1) else '0';
    odd_height <= '1' when h_img_bus(0) = '1' else '0';
    
--	EN_out <= EN when ((odd_height = '0') and (xin(0) = '0') and (yin(0) = '0')) or 
--	                  ((odd_height = '1') and (xin(0) = '0') and (yin(0) = '0') and last_line = '0')
--	                   else '0';
	                   
--	hsync_out <= hsync_in when ((odd_height = '0') and (xin(0) = '0') and (yin(0) = '0')) or 
--	                  ((odd_height = '1') and (xin(0) = '0') and (yin(0) = '0') and last_line = '0')
--	                   else '0';
	                   
--	vsync_out <= vsync_in when ((odd_height = '0') and (xin(0) = '0') and (yin(0) = '0')) or 
--	                  ((odd_height = '1') and (xin(0) = '0') and (yin(0) = '0') and last_line = '0')
--	                   else '0';
	
--	xout <= xin(xin'left downto 1);
--	yout <= yin(yin'left downto 1);
	
--	data_out <= data_in;


xout <= xint;
yout <= yint;
hsync_out <= hsync_o_int;
vsync_out <= hsync_o_int or vsync_rtd;
EN_out <= vsync_rtd;



VSY0 : process(clk, reset_n)
        begin
            if (reset_n='0') then vsync_rtd <= '1';
            elsif (rising_edge(clk)) then vsync_rtd <= vsync_in;
            end if;
        end process;
        
HSY0 : process(clk, reset_n)
        begin
            if (reset_n='0') then hsync_rtd <= '1';
            elsif (rising_edge(clk)) then 
                hsync_rtd <= hsync_in;
                hsync_o_int_rtd <= hsync_o_int;
                hsync_o_int_rtd2 <= hsync_o_int_rtd;
            end if;
        end process;

HSYI0: process(clk, reset_n)
        begin
            if (reset_n='0') then 
                hsync_o_int <= '1';
                div_lig <= '0';
            elsif (rising_edge(clk)) then
                if hsync_in = '0' and hsync_rtd = '1' and div_lig = '0' then 
                    hsync_o_int <= hsync_in;
                end if;
                
                if hsync_in = '1' and hsync_rtd = '0' and div_lig = '1' then 
                    hsync_o_int <= hsync_in;
                end if;
                
                if hsync_in = '0' and hsync_rtd = '1' then 
                    if div_lig ='0' then
                        div_lig <= '1';
                    else
                        div_lig <= '0';
                    end if;
                end if;                                                      
            end if;
        end process; 


SUB0:  process(clk_buf, reset_n)
        begin
            if (reset_n='0') then data_out <= (others =>'0');
            elsif (rising_edge(clk_buf)) then data_out <= data_in;
            end if;
        end process;

INCX0: process(clk_buf, reset_n)
        begin
            if (reset_n='0') then 
                xint <= (others =>'0');
            elsif (rising_edge(clk_buf)) then 
                if (hsync_o_int_rtd2 = '0' and vsync_rtd = '0') then
                    xint <= xint + '1';
                else
                    xint <= (others =>'0');
                end if;
            end if;
        end process;
        
        
        

INCY0: process(clk, reset_n)
        begin
            if (reset_n='0') then 
                yint <= (others =>'0');
                first_lig <= '0';
            elsif (rising_edge(clk)) then
                if hsync_o_int = '0' and hsync_o_int_rtd = '1' and vsync_rtd = '0' and first_lig = '1' then
                    yint <= yint + '1';
                end if;
                if   hsync_o_int = '0' and hsync_o_int_rtd = '1' and vsync_rtd = '0' then    
                    first_lig <= '1';
                end if;
         
            end if;   
                
        end process; 
	
end architecture simple;
