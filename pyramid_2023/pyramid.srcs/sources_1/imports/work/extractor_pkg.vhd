library ieee;
use ieee.std_logic_1164.all;

library work;
use work.saturn_numeric_pkg.all;

package extractor_pkg is
	component extractor is
		generic (
			IMG_WIDTH : positive := 16;
			IMG_HEIGHT : positive := 9;
			MAX_COLOR : positive := 255;
			MAX_SIZE_LIST : positive := 16;
			FEATURE_RADIUS : positive := 20;
			MEMORY_BUS_WIDTH : positive := unsigned_num_bits(1680) --(2*FEATURE_RADIUS+1)*(2*FEATURE_RADIUS+1)-1;
		);
		port (
			global_clk_i : in std_logic;
			global_reset_n_i : in std_logic;

			-- video flux to extract the features from, already delayed
			xy_en_i : in std_logic;
			xy_x_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			xy_y_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			xy_data_i : in std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			xy_ready_o : out std_logic;
		
			-- keypoint interface
			kp_en_i : in std_logic;
			kp_x_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
			kp_y_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
			kp_new_i : in std_logic;
			kp_index_i : in std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
            kp_value_i : in std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
            kp_constraints_i : in std_logic_vector (MAX_SIZE_LIST-1 downto 0);
            
			-- correspondance between sorted index and extracted index
			kp_tab_index_i : in std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);

			-- cpu memory interface, index selects which memory to read
			cpu_index_i : in std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
			cpu_addr_i : in std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
			cpu_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
			cpu_frame_counter_o : out std_logic_vector(31 downto 0);
		    cpu_kp_counter_o : out std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
		    cpu_kp_value_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		    cpu_kp_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
		    cpu_kp_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
		    cpu_kp_cstr_tag_o : out std_logic_vector(MAX_SIZE_LIST-1 downto 0)
		);
	end component extractor;
end package extractor_pkg;
