library ieee;
use ieee.std_logic_1164.all;

library work;
use work.saturn_numeric_pkg.all;

package pyramid_kp_pkg is
	component pyramid_kp is
		generic (
			IMG_WIDTH : positive := 16;
			IMG_HEIGHT : positive := 9;
			MAX_COLOR : positive := 255;
			SEARCH_RADIUS_0 : real := 20.0;
			SEARCH_RADIUS_1 : real := 10.0;
			SEARCH_RADIUS_2 : real := 5.0;
			MAX_SIZE_LIST : positive := 16;
			FEATURE_RADIUS : positive := 20;
			MEMORY_BUS_WIDTH : positive := unsigned_num_bits(1680) --(2*FEATURE_RADIUS+1)*(2*FEATURE_RADIUS+1)-1;
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

			xy_dog00_en_o : out std_logic;
			xy_dog00_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			xy_dog00_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			xy_dog00_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_dog00_ready_i : in std_logic;

			cpu00_index_i : in std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
			cpu00_addr_i : in std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
			cpu00_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			cpu00_frame_counter_o : out std_logic_vector(31 downto 0);
		    cpu00_kp_counter_o : out std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
		    cpu00_kp_value_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		    cpu00_kp_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
		    cpu00_kp_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
            cpu00_kp_cstr_tag_o : out std_logic_vector(MAX_SIZE_LIST-1 downto 0);

			xy_dog01_en_o : out std_logic;
			xy_dog01_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			xy_dog01_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			xy_dog01_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_dog01_ready_i : in std_logic;

			cpu01_index_i : in std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
			cpu01_addr_i : in std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
			cpu01_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			cpu01_frame_counter_o : out std_logic_vector(31 downto 0);
		    cpu01_kp_counter_o : out std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
		    cpu01_kp_value_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		    cpu01_kp_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
		    cpu01_kp_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
            cpu01_kp_cstr_tag_o : out std_logic_vector(MAX_SIZE_LIST-1 downto 0);
            
			xy_dog10_en_o : out std_logic;
			xy_dog10_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
			xy_dog10_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
			xy_dog10_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_dog10_ready_i : in std_logic;

			cpu10_index_i : in std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
			cpu10_addr_i : in std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
			cpu10_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			cpu10_frame_counter_o : out std_logic_vector(31 downto 0);
		    cpu10_kp_counter_o : out std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
		    cpu10_kp_value_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		    cpu10_kp_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
		    cpu10_kp_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
            cpu10_kp_cstr_tag_o : out std_logic_vector(MAX_SIZE_LIST-1 downto 0);
            
			xy_dog11_en_o : out std_logic;
			xy_dog11_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
			xy_dog11_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
			xy_dog11_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_dog11_ready_i : in std_logic;

			cpu11_index_i : in std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
			cpu11_addr_i : in std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
			cpu11_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			cpu11_frame_counter_o : out std_logic_vector(31 downto 0);
		    cpu11_kp_counter_o : out std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
		    cpu11_kp_value_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		    cpu11_kp_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
		    cpu11_kp_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
            cpu11_kp_cstr_tag_o : out std_logic_vector(MAX_SIZE_LIST-1 downto 0);

			xy_dog20_en_o : out std_logic;
			xy_dog20_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
			xy_dog20_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
			xy_dog20_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_dog20_ready_i : in std_logic;

			cpu20_index_i : in std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
			cpu20_addr_i : in std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
			cpu20_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			cpu20_frame_counter_o : out std_logic_vector(31 downto 0);
		    cpu20_kp_counter_o : out std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
		    cpu20_kp_value_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		    cpu20_kp_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
		    cpu20_kp_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
            cpu20_kp_cstr_tag_o : out std_logic_vector(MAX_SIZE_LIST-1 downto 0);
                        
			xy_dog21_en_o : out std_logic;
			xy_dog21_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
			xy_dog21_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
			xy_dog21_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_dog21_ready_i : in std_logic;

			cpu21_index_i : in std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
			cpu21_addr_i : in std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
			cpu21_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			cpu21_frame_counter_o : out std_logic_vector(31 downto 0);
		    cpu21_kp_counter_o : out std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
		    cpu21_kp_value_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		    cpu21_kp_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
		    cpu21_kp_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
            cpu21_kp_cstr_tag_o : out std_logic_vector(MAX_SIZE_LIST-1 downto 0);

			x_constraints_width00_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			y_constraints_width00_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			x_constraints_width01_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			y_constraints_width01_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			x_constraints_width10_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
			y_constraints_width10_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
			x_constraints_width11_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
			y_constraints_width11_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
			x_constraints_width20_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
			y_constraints_width20_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);
			x_constraints_width21_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
			y_constraints_width21_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);
	
			constraints_en_i : in std_logic;
			x_constraints_i : in std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
			y_constraints_i : in std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0)
		);
	end component pyramid_kp;
end package pyramid_kp_pkg;
