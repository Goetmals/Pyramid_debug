library ieee;
use ieee.std_logic_1164.all;

library work;
use work.saturn_numeric_pkg.all;

package pyramid_dog_pkg is
	component pyramid_dog is
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

			xy_grad00_en_o : out std_logic;
			xy_grad00_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			xy_grad00_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			xy_grad00_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_grad00_ready_i : in std_logic;

			xy_grad01_en_o : out std_logic;
			xy_grad01_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			xy_grad01_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			xy_grad01_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_grad01_ready_i : in std_logic;

			xy_grad10_en_o : out std_logic;
			xy_grad10_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
			xy_grad10_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
			xy_grad10_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_grad10_ready_i : in std_logic;

			xy_grad11_en_o : out std_logic;
			xy_grad11_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
			xy_grad11_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
			xy_grad11_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_grad11_ready_i : in std_logic;

			xy_grad20_en_o : out std_logic;
			xy_grad20_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
			xy_grad20_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);
			xy_grad20_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_grad20_ready_i : in std_logic;

			xy_grad21_en_o : out std_logic;
			xy_grad21_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
			xy_grad21_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);
			xy_grad21_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_grad21_ready_i : in std_logic;
	
			xy_dog00_en_o : out std_logic;
			xy_dog00_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			xy_dog00_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			xy_dog00_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_dog00_ready_i : in std_logic;
	
			xy_dog01_en_o : out std_logic;
			xy_dog01_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			xy_dog01_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			xy_dog01_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_dog01_ready_i : in std_logic;
	
			xy_dog10_en_o : out std_logic;
			xy_dog10_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
			xy_dog10_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
			xy_dog10_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_dog10_ready_i : in std_logic;
	
			xy_dog11_en_o : out std_logic;
			xy_dog11_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
			xy_dog11_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
			xy_dog11_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_dog11_ready_i : in std_logic;
	
			xy_dog20_en_o : out std_logic;
			xy_dog20_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
			xy_dog20_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
			xy_dog20_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_dog20_ready_i : in std_logic;
	
			xy_dog21_en_o : out std_logic;
			xy_dog21_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
			xy_dog21_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
			xy_dog21_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_dog21_ready_i : in std_logic
		);
	end component pyramid_dog;
end package pyramid_dog_pkg;