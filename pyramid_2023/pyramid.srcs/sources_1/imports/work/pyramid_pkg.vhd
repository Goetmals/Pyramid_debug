library ieee;
use ieee.std_logic_1164.all;

library work;
use work.saturn_numeric_pkg.all;

package pyramid_pkg is
	component pyramid is
		generic (
			IMG_WIDTH : positive := 16;
			IMG_HEIGHT : positive := 9;
			MAX_COLOR : positive := 255
		);
		port (
			global_clk_i : in std_logic;
			global_reset_n_i : in std_logic;
	
			xy_en_i : in std_logic;
			xy_x_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			xy_y_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			xy_data_i : in std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_ready_o : out std_logic;
	
			xy_grad_en_o : out std_logic;
			xy_grad_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			xy_grad_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			xy_grad_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_grad_ready_i : in std_logic;
	
			xy_gauss00_en_o : out std_logic;
			xy_gauss00_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			xy_gauss00_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			xy_gauss00_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_gauss00_ready_i : in std_logic;
	
			xy_gauss01_en_o : out std_logic;
			xy_gauss01_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			xy_gauss01_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			xy_gauss01_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_gauss01_ready_i : in std_logic;
	
			xy_gauss02_en_o : out std_logic;
			xy_gauss02_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			xy_gauss02_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			xy_gauss02_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_gauss02_ready_i : in std_logic;
	
			xy_subsample0_en_o : out std_logic;
			xy_subsample0_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
			xy_subsample0_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
			xy_subsample0_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_subsample0_ready_i : in std_logic;
	
			xy_gauss10_en_o : out std_logic;
			xy_gauss10_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
			xy_gauss10_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
			xy_gauss10_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_gauss10_ready_i : in std_logic;
	
			xy_gauss11_en_o : out std_logic;
			xy_gauss11_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
			xy_gauss11_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
			xy_gauss11_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_gauss11_ready_i : in std_logic;
	
			xy_subsample1_en_o : out std_logic;
			xy_subsample1_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
			xy_subsample1_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
			xy_subsample1_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_subsample1_ready_i : in std_logic;
	
			xy_gauss20_en_o : out std_logic;
			xy_gauss20_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
			xy_gauss20_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
			xy_gauss20_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_gauss20_ready_i : in std_logic;
	
			xy_gauss21_en_o : out std_logic;
			xy_gauss21_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
			xy_gauss21_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
			xy_gauss21_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_gauss21_ready_i : in std_logic
		);
	end component pyramid;
end package pyramid_pkg;
