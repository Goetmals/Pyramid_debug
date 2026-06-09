library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.saturn_numeric_pkg.all;
use work.pyramid_dog_pkg.all;
use work.search_pkg.all;
use work.sort_pkg.all;
use work.delay_pkg.all;
use work.xy_delay_pkg.all;
use work.extractor_pkg.all;

entity pyramid_kp is
	generic (
		-- image size in pixels
		IMG_WIDTH : positive := 480;
		IMG_HEIGHT : positive := 270;
		-- max grey scale level (2^pixel bus width-1)
		MAX_COLOR : positive := 255;
		-- radius of key-point search
		SEARCH_RADIUS_0 : real := 20.0;
		SEARCH_RADIUS_1 : real := 10.0;
		SEARCH_RADIUS_2 : real := 5.0;
		-- number of keypoint that can be found
		MAX_SIZE_LIST : positive := 16;
		-- radius of the extracted feature (yes it's the radius of a square...)
		FEATURE_RADIUS : positive := 20;
		-- it should be automatized :/
		MEMORY_BUS_WIDTH : positive := unsigned_num_bits(1680) --(2*FEATURE_RADIUS+1)*(2*FEATURE_RADIUS+1)-1;
	);
	port (
		-- clock & reset
		global_clk_i : in std_logic;
		global_reset_n_i : in std_logic;

		-- input pixel flow
		xy_en_i : in std_logic;
		xy_x_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
		xy_y_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
		xy_data_i : in std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		xy_ready_o : out std_logic;

		-- gradient output pixel flow
		xy_grad_en_o : out std_logic;
		xy_grad_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
		xy_grad_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
		xy_grad_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		xy_grad_ready_i : in std_logic;

		-- dog00 output pixel flow
		xy_dog00_en_o : out std_logic;
		xy_dog00_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
		xy_dog00_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
		xy_dog00_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		xy_dog00_ready_i : in std_logic;

		-- memory interface of the features extracted from dog00
		-- index indicates which feature to read
		cpu00_index_i : in std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
		cpu00_addr_i : in std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
		cpu00_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		cpu00_frame_counter_o : out std_logic_vector(31 downto 0);
        cpu00_kp_counter_o : out std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
        cpu00_kp_value_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
        cpu00_kp_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
        cpu00_kp_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
        cpu00_kp_cstr_tag_o : out std_logic_vector(MAX_SIZE_LIST-1 downto 0);
        
		-- same as above with dog01
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

		-- width and heigths in pixels of the constraints from low scales to up scales
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

		-- constraints of the lowest scale
		-- constraints_en_i registers the constraints
		constraints_en_i : in std_logic;
		x_constraints_i : in std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
		y_constraints_i : in std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0)
	);
end entity pyramid_kp;

architecture rtl of pyramid_kp is
	constant DELAY00_X_C : positive := 20+integer(SEARCH_RADIUS_0)+FEATURE_RADIUS;
	constant DELAY00_Y_C : positive := 9+integer(SEARCH_RADIUS_0)+FEATURE_RADIUS;
	constant DELAY01_X_C : positive := 20+integer(SEARCH_RADIUS_0)+FEATURE_RADIUS;
	constant DELAY01_Y_C : positive := 9+integer(SEARCH_RADIUS_0)+FEATURE_RADIUS;
	constant DELAY10_X_C : positive := 20+integer(SEARCH_RADIUS_1)+FEATURE_RADIUS;
	constant DELAY10_Y_C : positive := 9+integer(SEARCH_RADIUS_1)+FEATURE_RADIUS;
	constant DELAY11_X_C : positive := 20+integer(SEARCH_RADIUS_1)+FEATURE_RADIUS;
	constant DELAY11_Y_C : positive := 9+integer(SEARCH_RADIUS_1)+FEATURE_RADIUS;
	constant DELAY20_X_C : positive := 20+integer(SEARCH_RADIUS_2)+FEATURE_RADIUS;
	constant DELAY20_Y_C : positive := 9+integer(SEARCH_RADIUS_2)+FEATURE_RADIUS;
	constant DELAY21_X_C : positive := 20+integer(SEARCH_RADIUS_2)+FEATURE_RADIUS;
	constant DELAY21_Y_C : positive := 9+integer(SEARCH_RADIUS_2)+FEATURE_RADIUS;

	signal xy_grad00_en_s : std_logic;
	signal xy_grad00_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal xy_grad00_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal xy_grad00_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_grad00_ready_s : std_logic;

	signal xy_delay00_en_s : std_logic;
	signal xy_delay00_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal xy_delay00_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal xy_delay00_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_grad01_en_s : std_logic;
	signal xy_grad01_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal xy_grad01_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal xy_grad01_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_grad01_ready_s : std_logic;

	signal xy_delay01_en_s : std_logic;
	signal xy_delay01_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal xy_delay01_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal xy_delay01_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_grad10_en_s : std_logic;
	signal xy_grad10_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
	signal xy_grad10_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
	signal xy_grad10_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_grad10_ready_s : std_logic;

	signal xy_delay10_en_s : std_logic;
	signal xy_delay10_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
	signal xy_delay10_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
	signal xy_delay10_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_grad11_en_s : std_logic;
	signal xy_grad11_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
	signal xy_grad11_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
	signal xy_grad11_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_grad11_ready_s : std_logic;

	signal xy_delay11_en_s : std_logic;
	signal xy_delay11_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
	signal xy_delay11_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
	signal xy_delay11_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_grad20_en_s : std_logic;
	signal xy_grad20_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
	signal xy_grad20_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);
	signal xy_grad20_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_grad20_ready_s : std_logic;

	signal xy_delay20_en_s : std_logic;
	signal xy_delay20_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
	signal xy_delay20_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);
	signal xy_delay20_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_grad21_en_s : std_logic;
	signal xy_grad21_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
	signal xy_grad21_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);
	signal xy_grad21_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_grad21_ready_s : std_logic;

	signal xy_delay21_en_s : std_logic;
	signal xy_delay21_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
	signal xy_delay21_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);
	signal xy_delay21_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_dog00_en_s : std_logic;
	signal xy_dog00_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal xy_dog00_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal xy_dog00_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_dog00_ready_s : std_logic;

	signal xy_dog01_en_s : std_logic;
	signal xy_dog01_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal xy_dog01_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal xy_dog01_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_dog01_ready_s : std_logic;

	signal xy_dog10_en_s : std_logic;
	signal xy_dog10_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
	signal xy_dog10_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
	signal xy_dog10_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_dog10_ready_s : std_logic;

	signal xy_dog11_en_s : std_logic;
	signal xy_dog11_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
	signal xy_dog11_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
	signal xy_dog11_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_dog11_ready_s : std_logic;

	signal xy_dog20_en_s : std_logic;
	signal xy_dog20_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
	signal xy_dog20_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);
	signal xy_dog20_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_dog20_ready_s : std_logic;

	signal xy_dog21_en_s : std_logic;
	signal xy_dog21_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
	signal xy_dog21_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);
	signal xy_dog21_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_dog21_ready_s : std_logic;

	signal xy_threshold00_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_threshold01_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_threshold10_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_threshold11_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_threshold20_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_threshold21_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_search00_en_s : std_logic;
	signal xy_search00_new_keypoint_s : std_logic;
	signal xy_search00_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_search00_constraints_tag_s : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
	signal xy_search00_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal xy_search00_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);

	signal xy_search01_en_s : std_logic;
	signal xy_search01_new_keypoint_s : std_logic;
	signal xy_search01_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_search01_constraints_tag_s : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
	signal xy_search01_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal xy_search01_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);

	signal xy_search10_en_s : std_logic;
	signal xy_search10_new_keypoint_s : std_logic;
	signal xy_search10_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_search10_constraints_tag_s : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
	signal xy_search10_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
	signal xy_search10_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);

	signal xy_search11_en_s : std_logic;
	signal xy_search11_new_keypoint_s : std_logic;
	signal xy_search11_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_search11_constraints_tag_s : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
	signal xy_search11_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
	signal xy_search11_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);

	signal xy_search20_en_s : std_logic;
	signal xy_search20_new_keypoint_s : std_logic;
	signal xy_search20_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_search20_constraints_tag_s : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
	signal xy_search20_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
	signal xy_search20_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);

	signal xy_search21_en_s : std_logic;
	signal xy_search21_new_keypoint_s : std_logic;
	signal xy_search21_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_search21_constraints_tag_s : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
	signal xy_search21_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
	signal xy_search21_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);

	signal xy_sort00_en_s : std_logic;
	signal xy_sort00_new_keypoint_s : std_logic;
	signal xy_sort00_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_sort00_constraints_s : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
	signal xy_sort00_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal xy_sort00_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal xy_sort00_index_s : std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
	signal xy_sort00_tab_index_s : std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);

	signal xy_sort01_en_s : std_logic;
	signal xy_sort01_new_keypoint_s : std_logic;
	signal xy_sort01_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_sort01_constraints_s : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
	signal xy_sort01_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal xy_sort01_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal xy_sort01_index_s : std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
	signal xy_sort01_tab_index_s : std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);

	signal xy_sort10_en_s : std_logic;
	signal xy_sort10_new_keypoint_s : std_logic;
	signal xy_sort10_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_sort10_constraints_s : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
	signal xy_sort10_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
	signal xy_sort10_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
	signal xy_sort10_index_s : std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
	signal xy_sort10_tab_index_s : std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);

	signal xy_sort11_en_s : std_logic;
	signal xy_sort11_new_keypoint_s : std_logic;
	signal xy_sort11_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_sort11_constraints_s : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
	signal xy_sort11_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
	signal xy_sort11_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
	signal xy_sort11_index_s : std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
	signal xy_sort11_tab_index_s : std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);

	signal xy_sort20_en_s : std_logic;
	signal xy_sort20_new_keypoint_s : std_logic;
	signal xy_sort20_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_sort20_constraints_s : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
	signal xy_sort20_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
	signal xy_sort20_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);
	signal xy_sort20_index_s : std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
	signal xy_sort20_tab_index_s : std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);

	signal xy_sort21_en_s : std_logic;
	signal xy_sort21_new_keypoint_s : std_logic;
	signal xy_sort21_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal xy_sort21_constraints_s : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
	signal xy_sort21_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
	signal xy_sort21_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);
	signal xy_sort21_index_s : std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
	signal xy_sort21_tab_index_s : std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);

	signal x_constraints0x_s : std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal y_constraints0x_s : std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal x_constraints1x_s : std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
	signal y_constraints1x_s : std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
	signal x_constraints2x_s : std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
	signal y_constraints2x_s : std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);

	signal constraints_en_s : std_logic;
begin
	xy_grad_en_o <= xy_grad00_en_s;
	xy_grad_x_o <= xy_grad00_x_s;
	xy_grad_y_o <= xy_grad00_y_s;
	xy_grad_data_o <= xy_grad00_data_s;
	xy_grad00_ready_s <= xy_grad_ready_i;

	xy_dog00_en_o <= xy_dog00_en_s;
	xy_dog00_x_o <= xy_dog00_x_s;
	xy_dog00_y_o <= xy_dog00_y_s;
	xy_dog00_data_o <= xy_dog00_data_s;
--	xy_dog00_ready_s <= xy_dog00_ready_i;

	xy_dog01_en_o <= xy_dog01_en_s;
	xy_dog01_x_o <= xy_dog01_x_s;
	xy_dog01_y_o <= xy_dog01_y_s;
	xy_dog01_data_o <= xy_dog01_data_s;
--	xy_dog01_ready_s <= xy_dog01_ready_i;

	xy_dog10_en_o <= xy_dog10_en_s;
	xy_dog10_x_o <= xy_dog10_x_s;
	xy_dog10_y_o <= xy_dog10_y_s;
	xy_dog10_data_o <= xy_dog10_data_s;
--	xy_dog10_ready_s <= xy_dog10_ready_i;

	xy_dog11_en_o <= xy_dog11_en_s;
	xy_dog11_x_o <= xy_dog11_x_s;
	xy_dog11_y_o <= xy_dog11_y_s;
	xy_dog11_data_o <= xy_dog11_data_s;
--	xy_dog11_ready_s <= xy_dog11_ready_i;

	xy_dog20_en_o <= xy_dog20_en_s;
	xy_dog20_x_o <= xy_dog20_x_s;
	xy_dog20_y_o <= xy_dog20_y_s;
	xy_dog20_data_o <= xy_dog20_data_s;
--	xy_dog20_ready_s <= xy_dog20_ready_i;

	xy_dog21_en_o <= xy_dog21_en_s;
	xy_dog21_x_o <= xy_dog21_x_s;
	xy_dog21_y_o <= xy_dog21_y_s;
	xy_dog21_data_o <= xy_dog21_data_s;
--	xy_dog21_ready_s <= xy_dog21_ready_i;

	pyramid : pyramid_dog
		generic map (
			IMG_WIDTH => IMG_WIDTH,
			IMG_HEIGHT => IMG_HEIGHT,
			MAX_COLOR => MAX_COLOR
		)
		port map (
			global_clk_i => global_clk_i,
			global_reset_n_i => global_reset_n_i,
	
			xy_en_i => xy_en_i,
			xy_x_i => xy_x_i,
			xy_y_i => xy_y_i,
			xy_data_i => xy_data_i,
			xy_ready_o => xy_ready_o,

			xy_grad00_en_o => xy_grad00_en_s,
			xy_grad00_x_o => xy_grad00_x_s,
			xy_grad00_y_o => xy_grad00_y_s,
			xy_grad00_data_o => xy_grad00_data_s,
			xy_grad00_ready_i => xy_grad00_ready_s,
			
			xy_grad01_en_o => xy_grad01_en_s,
			xy_grad01_x_o => xy_grad01_x_s,
			xy_grad01_y_o => xy_grad01_y_s,
			xy_grad01_data_o => xy_grad01_data_s,
			xy_grad01_ready_i => xy_grad01_ready_s,

			xy_grad10_en_o => xy_grad10_en_s,
			xy_grad10_x_o => xy_grad10_x_s,
			xy_grad10_y_o => xy_grad10_y_s,
			xy_grad10_data_o => xy_grad10_data_s,
			xy_grad10_ready_i => xy_grad10_ready_s,

			xy_grad11_en_o => xy_grad11_en_s,
			xy_grad11_x_o => xy_grad11_x_s,
			xy_grad11_y_o => xy_grad11_y_s,
			xy_grad11_data_o => xy_grad11_data_s,
			xy_grad11_ready_i => xy_grad11_ready_s,

			xy_grad20_en_o => xy_grad20_en_s,
			xy_grad20_x_o => xy_grad20_x_s,
			xy_grad20_y_o => xy_grad20_y_s,
			xy_grad20_data_o => xy_grad20_data_s,
			xy_grad20_ready_i => xy_grad20_ready_s,

			xy_grad21_en_o => xy_grad21_en_s,
			xy_grad21_x_o => xy_grad21_x_s,
			xy_grad21_y_o => xy_grad21_y_s,
			xy_grad21_data_o => xy_grad21_data_s,
			xy_grad21_ready_i => xy_grad21_ready_s,
	
			xy_dog00_en_o => xy_dog00_en_s,
			xy_dog00_x_o => xy_dog00_x_s,
			xy_dog00_y_o => xy_dog00_y_s,
			xy_dog00_data_o => xy_dog00_data_s,
			--xy_dog00_ready_i => xy_dog00_ready_s,
			xy_dog00_ready_i => '1',

			xy_dog01_en_o => xy_dog01_en_s,
			xy_dog01_x_o => xy_dog01_x_s,
			xy_dog01_y_o =>xy_dog01_y_s,
			xy_dog01_data_o => xy_dog01_data_s,
			--xy_dog01_ready_i => xy_dog01_ready_s,
			xy_dog01_ready_i => '1',

			xy_dog10_en_o => xy_dog10_en_s,
			xy_dog10_x_o => xy_dog10_x_s,
			xy_dog10_y_o => xy_dog10_y_s,
			xy_dog10_data_o => xy_dog10_data_s,
			--xy_dog10_ready_i => xy_dog10_ready_s,
			xy_dog10_ready_i => '1',

			xy_dog11_en_o => xy_dog11_en_s,
			xy_dog11_x_o => xy_dog11_x_s,
			xy_dog11_y_o => xy_dog11_y_s,
			xy_dog11_data_o => xy_dog11_data_s,
			--xy_dog11_ready_i => xy_dog11_ready_s,
			xy_dog11_ready_i => '1',

			xy_dog20_en_o => xy_dog20_en_s,
			xy_dog20_x_o => xy_dog20_x_s,
			xy_dog20_y_o => xy_dog20_y_s,
			xy_dog20_data_o => xy_dog20_data_s,
			--xy_dog20_ready_i => xy_dog20_ready_s,
			xy_dog20_ready_i => '1',

			xy_dog21_en_o => xy_dog21_en_s,
			xy_dog21_x_o => xy_dog21_x_s,
			xy_dog21_y_o => xy_dog21_y_s,
			xy_dog21_data_o => xy_dog21_data_s,
			--xy_dog21_ready_i => xy_dog21_ready_s
			xy_dog21_ready_i => '1'
		);

--	xy_dog00_ready_s <= '1';
	xy_threshold00_s <= (others => '0');

	search00 : search
		generic map (
			BUS_WIDTH => unsigned_num_bits(MAX_COLOR),
			RADIUS => SEARCH_RADIUS_0,
			W_IMG => IMG_WIDTH,
			H_IMG => IMG_HEIGHT,

			MAX_SIZE_LIST => MAX_SIZE_LIST
		)
		port map (
			i_clk => global_clk_i,
			i_reset_n => global_reset_n_i,

			i_en => xy_dog00_en_s,
			i_data => xy_dog00_data_s,
			i_x => xy_dog00_x_s,
			i_y => xy_dog00_y_s,
			i_threshold => xy_threshold00_s,

			o_en => xy_search00_en_s,
			o_new_keypoint => xy_search00_new_keypoint_s,
			o_data => xy_search00_data_s,
			o_x => xy_search00_x_s,
			o_y => xy_search00_y_s,

			i_constraints_en => constraints_en_s,
			i_x_constraints => x_constraints0x_s,
			i_y_constraints => y_constraints0x_s,
			i_x_constraints_width => x_constraints_width00_i,
			i_y_constraints_width => y_constraints_width00_i,
			o_constraints_tag => xy_search00_constraints_tag_s
		);

	sort00 : sort
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			max_size_list => MAX_SIZE_LIST,
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => xy_search00_en_s,
			sort => xy_search00_new_keypoint_s,
			data_in => xy_search00_data_s,
			constraints_tag_in => xy_search00_constraints_tag_s,
			xin => xy_search00_x_s,
			yin => xy_search00_y_s,

			EN_out => xy_sort00_en_s,
			new_keypoint => xy_sort00_new_keypoint_s,
			keypoint_value => xy_sort00_data_s,
			keypoint_constraints => xy_sort00_constraints_s,
			keypoint_x => xy_sort00_x_s,
			keypoint_y => xy_sort00_y_s,
			keypoint_index => xy_sort00_index_s,
			tab_index => xy_sort00_tab_index_s
--			tab_x => --constraint
--			tab_y => --constraint
		);

	delay00: delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT,
			delay_x => DELAY00_X_C,
			delay_y => DELAY00_Y_C
		)
		port map (
			clk => global_clk_i,
			EN => xy_grad00_en_s,
			data_in => xy_grad00_data_s,
			data_out => xy_delay00_data_s
		);

	xy_delay00: xy_delay
		generic map (
			DELAY_X => DELAY00_X_C,
			DELAY_Y => DELAY00_Y_C,
			IMG_WIDTH => IMG_WIDTH,
			IMG_HEIGHT => IMG_HEIGHT
		)
		port map (
			global_clk_i => global_clk_i,
			global_resetn_i => global_reset_n_i,
	
			xy_en_i => xy_grad00_en_s,
			xy_x_i => xy_grad00_x_s,
			xy_y_i => xy_grad00_y_s,
	
			xy_en_o => xy_delay00_en_s,
			xy_x_o => xy_delay00_x_s,
			xy_y_o => xy_delay00_y_s
		);

	extractor00 : extractor
		generic map (
			IMG_WIDTH => IMG_WIDTH,
			IMG_HEIGHT => IMG_HEIGHT,
			MAX_COLOR => MAX_COLOR,
			MAX_SIZE_LIST => MAX_SIZE_LIST,
			FEATURE_RADIUS => FEATURE_RADIUS,
			MEMORY_BUS_WIDTH => MEMORY_BUS_WIDTH
		)
		port map (
			global_clk_i => global_clk_i,
			global_reset_n_i => global_reset_n_i,
	
			-- video flux to extract the features from, already delayed
			xy_en_i => xy_delay00_en_s,
			xy_x_i => xy_delay00_x_s,
			xy_y_i => xy_delay00_y_s,
			xy_data_i => xy_delay00_data_s,
--			xy_ready_o => 
			
			-- keypoint interface
			kp_en_i => xy_sort00_en_s,
			kp_x_i => xy_sort00_x_s,
			kp_y_i => xy_sort00_y_s,
			kp_new_i => xy_sort00_new_keypoint_s,
			kp_index_i => xy_sort00_index_s,
			kp_value_i => xy_sort00_data_s,
			kp_constraints_i => xy_sort00_constraints_s,
			
			-- correspondance between sorted index and extracted index
			kp_tab_index_i => xy_sort00_tab_index_s,
	
			-- cpu memory interface, index selects which memory to read
			cpu_index_i => cpu00_index_i,
			cpu_addr_i => cpu00_addr_i,
			cpu_data_o => cpu00_data_o,
			cpu_frame_counter_o => cpu00_frame_counter_o,
            cpu_kp_counter_o => cpu00_kp_counter_o,
            cpu_kp_value_o => cpu00_kp_value_o,
            cpu_kp_x_o => cpu00_kp_x_o,
            cpu_kp_y_o => cpu00_kp_y_o,
            cpu_kp_cstr_tag_o => cpu00_kp_cstr_tag_o	
		);

--	xy_dog01_ready_s <= '1';
	xy_threshold01_s <= (others => '0');

	search01 : search
		generic map (
			BUS_WIDTH => unsigned_num_bits(MAX_COLOR),
			RADIUS => SEARCH_RADIUS_0,
			W_IMG => IMG_WIDTH,
			H_IMG => IMG_HEIGHT,

			MAX_SIZE_LIST => MAX_SIZE_LIST
		)
		port map (
			i_clk => global_clk_i,
			i_reset_n => global_reset_n_i,

			i_en => xy_dog01_en_s,
			i_data => xy_dog01_data_s,
			i_x => xy_dog01_x_s,
			i_y => xy_dog01_y_s,
			i_threshold => xy_threshold01_s,

			o_en => xy_search01_en_s,
			o_new_keypoint => xy_search01_new_keypoint_s,
			o_data => xy_search01_data_s,
			o_x => xy_search01_x_s,
			o_y => xy_search01_y_s,

			i_constraints_en => constraints_en_s,
			i_x_constraints => x_constraints0x_s,
			i_y_constraints => y_constraints0x_s,
			i_x_constraints_width => x_constraints_width01_i,
			i_y_constraints_width => y_constraints_width01_i,
			o_constraints_tag => xy_search01_constraints_tag_s
		);

	sort01 : sort
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			max_size_list => MAX_SIZE_LIST,
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => xy_search01_en_s,
			sort => xy_search01_new_keypoint_s,
			data_in => xy_search01_data_s,
			constraints_tag_in => xy_search01_constraints_tag_s,
			xin => xy_search01_x_s,
			yin => xy_search01_y_s,

			EN_out => xy_sort01_en_s,
			new_keypoint => xy_sort01_new_keypoint_s,
			keypoint_value => xy_sort01_data_s,
			keypoint_constraints => xy_sort01_constraints_s,
			keypoint_x => xy_sort01_x_s,
			keypoint_y => xy_sort01_y_s,
			keypoint_index => xy_sort01_index_s,
			tab_index => xy_sort01_tab_index_s
--			tab_x => --constraint
--			tab_y => --constraint
		);

--	x_constraints0x_s <= x_constraints1x_s & '0';
--	y_constraints0x_s <= y_constraints1x_s & '0';
	constraints_1x_to_0x_g : for i in 0 to MAX_SIZE_LIST-1 generate
		x_constraints0x_s((i+1)*unsigned_num_bits(IMG_WIDTH-1)-1 downto i*unsigned_num_bits(IMG_WIDTH-1)) <= 
				x_constraints1x_s((i+1)*unsigned_num_bits(IMG_WIDTH/2-1)-1 downto i*unsigned_num_bits(IMG_WIDTH/2-1)) & '0';
		y_constraints0x_s((i+1)*unsigned_num_bits(IMG_HEIGHT-1)-1 downto i*unsigned_num_bits(IMG_HEIGHT-1)) <= 
				y_constraints1x_s((i+1)*unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto i*unsigned_num_bits(IMG_HEIGHT/2-1)) & '0';
	end generate constraints_1x_to_0x_g;

	delay01: delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT,
			delay_x => DELAY01_X_C,
			delay_y => DELAY01_Y_C
		)
		port map (
			clk => global_clk_i,
			EN => xy_grad01_en_s,
			data_in => xy_grad01_data_s,
			data_out => xy_delay01_data_s
		);

	xy_delay01: xy_delay
		generic map (
			DELAY_X => DELAY01_X_C,
			DELAY_Y => DELAY01_Y_C,
			IMG_WIDTH => IMG_WIDTH,
			IMG_HEIGHT => IMG_HEIGHT
		)
		port map (
			global_clk_i => global_clk_i,
			global_resetn_i => global_reset_n_i,
	
			xy_en_i => xy_grad01_en_s,
			xy_x_i => xy_grad01_x_s,
			xy_y_i => xy_grad01_y_s,
	
			xy_en_o => xy_delay01_en_s,
			xy_x_o => xy_delay01_x_s,
			xy_y_o => xy_delay01_y_s
		);

	extractor01 : extractor
		generic map (
			IMG_WIDTH => IMG_WIDTH,
			IMG_HEIGHT => IMG_HEIGHT,
			MAX_COLOR => MAX_COLOR,
			MAX_SIZE_LIST => MAX_SIZE_LIST,
			FEATURE_RADIUS => FEATURE_RADIUS,
			MEMORY_BUS_WIDTH => MEMORY_BUS_WIDTH
		)
		port map (
			global_clk_i => global_clk_i,
			global_reset_n_i => global_reset_n_i,
	
			-- video flux to extract the features from, already delayed
			xy_en_i => xy_delay01_en_s,
			xy_x_i => xy_delay01_x_s,
			xy_y_i => xy_delay01_y_s,
			xy_data_i => xy_delay01_data_s,
--			xy_ready_o => 
			
			-- keypoint interface
			kp_en_i => xy_sort01_en_s,
			kp_x_i => xy_sort01_x_s,
			kp_y_i => xy_sort01_y_s,
			kp_new_i => xy_sort01_new_keypoint_s,
			kp_index_i => xy_sort01_index_s,
			kp_value_i => xy_sort01_data_s,
			kp_constraints_i => xy_sort01_constraints_s,
	
			-- correspondance between sorted index and extracted index
			kp_tab_index_i => xy_sort01_tab_index_s,
	
			-- cpu memory interface, index selects which memory to read
			cpu_index_i => cpu01_index_i,
			cpu_addr_i => cpu01_addr_i,
			cpu_data_o => cpu01_data_o,
			cpu_frame_counter_o => cpu01_frame_counter_o,
            cpu_kp_counter_o => cpu01_kp_counter_o,
            cpu_kp_value_o => cpu01_kp_value_o,
            cpu_kp_x_o => cpu01_kp_x_o,
            cpu_kp_y_o => cpu01_kp_y_o,
            cpu_kp_cstr_tag_o => cpu01_kp_cstr_tag_o
		);

--	xy_dog10_ready_s <= '1';
	xy_threshold10_s <= (others => '0');

	search10 : search
		generic map (
			BUS_WIDTH => unsigned_num_bits(MAX_COLOR),
			RADIUS => SEARCH_RADIUS_1,
			W_IMG => IMG_WIDTH/2,
			H_IMG => IMG_HEIGHT/2,

			MAX_SIZE_LIST => MAX_SIZE_LIST
		)
		port map (
			i_clk => global_clk_i,
			i_reset_n => global_reset_n_i,

			i_en => xy_dog10_en_s,
			i_data => xy_dog10_data_s,
			i_x => xy_dog10_x_s,
			i_y => xy_dog10_y_s,
			i_threshold => xy_threshold10_s,

			o_en => xy_search10_en_s,
			o_new_keypoint => xy_search10_new_keypoint_s,
			o_data => xy_search10_data_s,
			o_x => xy_search10_x_s,
			o_y => xy_search10_y_s,

			i_constraints_en => constraints_en_s,
			i_x_constraints => x_constraints1x_s,
			i_y_constraints => y_constraints1x_s,
			i_x_constraints_width => x_constraints_width10_i,
			i_y_constraints_width => y_constraints_width10_i,
			o_constraints_tag => xy_search10_constraints_tag_s
		);

	sort10 : sort
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			max_size_list => MAX_SIZE_LIST,
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => xy_search10_en_s,
			sort => xy_search10_new_keypoint_s,
			data_in => xy_search10_data_s,
			constraints_tag_in => xy_search10_constraints_tag_s,
			xin => xy_search10_x_s,
			yin => xy_search10_y_s,

			EN_out => xy_sort10_en_s,
			new_keypoint => xy_sort10_new_keypoint_s,
			keypoint_value => xy_sort10_data_s,
			keypoint_constraints => xy_sort10_constraints_s,
			keypoint_x => xy_sort10_x_s,
			keypoint_y => xy_sort10_y_s,
			keypoint_index => xy_sort10_index_s,
			tab_index => xy_sort10_tab_index_s
--			tab_x => --constraint
--			tab_y => --constraint
		);

	delay10: delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2,
			delay_x => DELAY10_X_C,
			delay_y => DELAY10_Y_C
		)
		port map (
			clk => global_clk_i,
			EN => xy_grad10_en_s,
			data_in => xy_grad10_data_s,
			data_out => xy_delay10_data_s
		);

	xy_delay10: xy_delay
		generic map (
			DELAY_X => DELAY10_X_C,
			DELAY_Y => DELAY10_Y_C,
			IMG_WIDTH => IMG_WIDTH/2,
			IMG_HEIGHT => IMG_HEIGHT/2
		)
		port map (
			global_clk_i => global_clk_i,
			global_resetn_i => global_reset_n_i,
	
			xy_en_i => xy_grad10_en_s,
			xy_x_i => xy_grad10_x_s,
			xy_y_i => xy_grad10_y_s,
	
			xy_en_o => xy_delay10_en_s,
			xy_x_o => xy_delay10_x_s,
			xy_y_o => xy_delay10_y_s
		);

	extractor10 : extractor
		generic map (
			IMG_WIDTH => IMG_WIDTH/2,
			IMG_HEIGHT => IMG_HEIGHT/2,
			MAX_COLOR => MAX_COLOR,
			MAX_SIZE_LIST => MAX_SIZE_LIST,
			FEATURE_RADIUS => FEATURE_RADIUS,
			MEMORY_BUS_WIDTH => MEMORY_BUS_WIDTH
		)
		port map (
			global_clk_i => global_clk_i,
			global_reset_n_i => global_reset_n_i,
	
			-- video flux to extract the features from, already delayed
			xy_en_i => xy_delay10_en_s,
			xy_x_i => xy_delay10_x_s,
			xy_y_i => xy_delay10_y_s,
			xy_data_i => xy_delay10_data_s,
--			xy_ready_o => 
			
			-- keypoint interface
			kp_en_i => xy_sort10_en_s,
			kp_x_i => xy_sort10_x_s,
			kp_y_i => xy_sort10_y_s,
			kp_new_i => xy_sort10_new_keypoint_s,
			kp_index_i => xy_sort10_index_s,
			kp_value_i => xy_sort10_data_s,
			kp_constraints_i => xy_sort10_constraints_s,
	
			-- correspondance between sorted index and extracted index
			kp_tab_index_i => xy_sort10_tab_index_s,
	
			-- cpu memory interface, index selects which memory to read
			cpu_index_i => cpu10_index_i,
			cpu_addr_i => cpu10_addr_i,
			cpu_data_o => cpu10_data_o,
			cpu_frame_counter_o => cpu10_frame_counter_o,
            cpu_kp_counter_o => cpu10_kp_counter_o,
            cpu_kp_value_o => cpu10_kp_value_o,
            cpu_kp_x_o => cpu10_kp_x_o,
            cpu_kp_y_o => cpu10_kp_y_o,				
            cpu_kp_cstr_tag_o => cpu10_kp_cstr_tag_o
		);

--	xy_dog11_ready_s <= '1';
	xy_threshold11_s <= (others => '0');

	search11 : search
		generic map (
			BUS_WIDTH => unsigned_num_bits(MAX_COLOR),
			RADIUS => SEARCH_RADIUS_1,
			W_IMG => IMG_WIDTH/2,
			H_IMG => IMG_HEIGHT/2,

			MAX_SIZE_LIST => MAX_SIZE_LIST
		)
		port map (
			i_clk => global_clk_i,
			i_reset_n => global_reset_n_i,

			i_en => xy_dog11_en_s,
			i_data => xy_dog11_data_s,
			i_x => xy_dog11_x_s,
			i_y => xy_dog11_y_s,
			i_threshold => xy_threshold11_s,

			o_en => xy_search11_en_s,
			o_new_keypoint => xy_search11_new_keypoint_s,
			o_data => xy_search11_data_s,
			o_x => xy_search11_x_s,
			o_y => xy_search11_y_s,

			i_constraints_en => constraints_en_s,
			i_x_constraints => x_constraints1x_s,
			i_y_constraints => y_constraints1x_s,
			i_x_constraints_width => x_constraints_width11_i,
			i_y_constraints_width => y_constraints_width11_i,
			o_constraints_tag => xy_search11_constraints_tag_s
		);

	sort11 : sort
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			max_size_list => MAX_SIZE_LIST,
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => xy_search11_en_s,
			sort => xy_search11_new_keypoint_s,
			data_in => xy_search11_data_s,
			constraints_tag_in => xy_search11_constraints_tag_s,
			xin => xy_search11_x_s,
			yin => xy_search11_y_s,

			EN_out => xy_sort11_en_s,
			new_keypoint => xy_sort11_new_keypoint_s,
			keypoint_value => xy_sort11_data_s,
			keypoint_constraints => xy_sort11_constraints_s,
			keypoint_x => xy_sort11_x_s,
			keypoint_y => xy_sort11_y_s,
			keypoint_index => xy_sort11_index_s,
			tab_index => xy_sort11_tab_index_s
--			tab_x => --constraint
--			tab_y => --constraint
		);
	
	constraints_2x_to_1x_g : for i in 0 to MAX_SIZE_LIST-1 generate
		x_constraints1x_s((i+1)*unsigned_num_bits(IMG_WIDTH/2-1)-1 downto i*unsigned_num_bits(IMG_WIDTH/2-1)) <= 
				x_constraints2x_s((i+1)*unsigned_num_bits(IMG_WIDTH/4-1)-1 downto i*unsigned_num_bits(IMG_WIDTH/4-1)) & '0';
		y_constraints1x_s((i+1)*unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto i*unsigned_num_bits(IMG_HEIGHT/2-1)) <= 
				y_constraints2x_s((i+1)*unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto i*unsigned_num_bits(IMG_HEIGHT/4-1)) & '0';
	end generate constraints_2x_to_1x_g;

	delay11: delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2,
			delay_x => DELAY11_X_C,
			delay_y => DELAY11_Y_C
		)
		port map (
			clk => global_clk_i,
			EN => xy_grad11_en_s,
			data_in => xy_grad11_data_s,
			data_out => xy_delay11_data_s
		);

	xy_delay11: xy_delay
		generic map (
			DELAY_X => DELAY11_X_C,
			DELAY_Y => DELAY11_Y_C,
			IMG_WIDTH => IMG_WIDTH/2,
			IMG_HEIGHT => IMG_HEIGHT/2
		)
		port map (
			global_clk_i => global_clk_i,
			global_resetn_i => global_reset_n_i,
	
			xy_en_i => xy_grad11_en_s,
			xy_x_i => xy_grad11_x_s,
			xy_y_i => xy_grad11_y_s,
	
			xy_en_o => xy_delay11_en_s,
			xy_x_o => xy_delay11_x_s,
			xy_y_o => xy_delay11_y_s
		);

	extractor11 : extractor
		generic map (
			IMG_WIDTH => IMG_WIDTH/2,
			IMG_HEIGHT => IMG_HEIGHT/2,
			MAX_COLOR => MAX_COLOR,
			MAX_SIZE_LIST => MAX_SIZE_LIST,
			FEATURE_RADIUS => FEATURE_RADIUS,
			MEMORY_BUS_WIDTH => MEMORY_BUS_WIDTH
		)
		port map (
			global_clk_i => global_clk_i,
			global_reset_n_i => global_reset_n_i,
	
			-- video flux to extract the features from, already delayed
			xy_en_i => xy_delay11_en_s,
			xy_x_i => xy_delay11_x_s,
			xy_y_i => xy_delay11_y_s,
			xy_data_i => xy_delay11_data_s,
--			xy_ready_o => 
			
			-- keypoint interface
			kp_en_i => xy_sort11_en_s,
			kp_x_i => xy_sort11_x_s,
			kp_y_i => xy_sort11_y_s,
			kp_new_i => xy_sort11_new_keypoint_s,
			kp_index_i => xy_sort11_index_s,
			kp_value_i => xy_sort11_data_s,
			kp_constraints_i => xy_sort11_constraints_s,
	
			-- correspondance between sorted index and extracted index
			kp_tab_index_i => xy_sort11_tab_index_s,
	
			-- cpu memory interface, index selects which memory to read
			cpu_index_i => cpu11_index_i,
			cpu_addr_i => cpu11_addr_i,
			cpu_data_o => cpu11_data_o,
			cpu_frame_counter_o => cpu11_frame_counter_o,
            cpu_kp_counter_o => cpu11_kp_counter_o,
            cpu_kp_value_o => cpu11_kp_value_o,
            cpu_kp_x_o => cpu11_kp_x_o,
            cpu_kp_y_o => cpu11_kp_y_o,
            cpu_kp_cstr_tag_o => cpu11_kp_cstr_tag_o            
		);

--	xy_dog20_ready_s <= '1';
	xy_threshold20_s <= (others => '0');

	search20 : search
		generic map (
			BUS_WIDTH => unsigned_num_bits(MAX_COLOR),
			RADIUS => SEARCH_RADIUS_2,
			W_IMG => IMG_WIDTH/4,
			H_IMG => IMG_HEIGHT/4,

			MAX_SIZE_LIST => MAX_SIZE_LIST
		)
		port map (
			i_clk => global_clk_i,
			i_reset_n => global_reset_n_i,

			i_en => xy_dog20_en_s,
			i_data => xy_dog20_data_s,
			i_x => xy_dog20_x_s,
			i_y => xy_dog20_y_s,
			i_threshold => xy_threshold20_s,

			o_en => xy_search20_en_s,
			o_new_keypoint => xy_search20_new_keypoint_s,
			o_data => xy_search20_data_s,
			o_x => xy_search20_x_s,
			o_y => xy_search20_y_s,

			i_constraints_en => constraints_en_s,
			i_x_constraints => x_constraints2x_s,
			i_y_constraints => y_constraints2x_s,
			i_x_constraints_width => x_constraints_width20_i,
			i_y_constraints_width => y_constraints_width20_i,
			o_constraints_tag => xy_search20_constraints_tag_s
		);

	sort20 : sort
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			max_size_list => MAX_SIZE_LIST,
			w_img => IMG_WIDTH/4,
			h_img => IMG_HEIGHT/4
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => xy_search20_en_s,
			sort => xy_search20_new_keypoint_s,
			data_in => xy_search20_data_s,
			constraints_tag_in => xy_search20_constraints_tag_s,
			xin => xy_search20_x_s,
			yin => xy_search20_y_s,

			EN_out => xy_sort20_en_s,
			new_keypoint => xy_sort20_new_keypoint_s,
			keypoint_value => xy_sort20_data_s,
			keypoint_constraints => xy_sort20_constraints_s,
			keypoint_x => xy_sort20_x_s,
			keypoint_y => xy_sort20_y_s,
			keypoint_index => xy_sort20_index_s,
			tab_index => xy_sort20_tab_index_s
--			tab_x => --constraint
--			tab_y => --constraint
		);

	delay20: delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/4,
			h_img => IMG_HEIGHT/4,
			delay_x => DELAY20_X_C,
			delay_y => DELAY20_Y_C
		)
		port map (
			clk => global_clk_i,
			EN => xy_grad20_en_s,
			data_in => xy_grad20_data_s,
			data_out => xy_delay20_data_s
		);

	xy_delay20: xy_delay
		generic map (
			DELAY_X => DELAY20_X_C,
			DELAY_Y => DELAY20_Y_C,
			IMG_WIDTH => IMG_WIDTH/4,
			IMG_HEIGHT => IMG_HEIGHT/4
		)
		port map (
			global_clk_i => global_clk_i,
			global_resetn_i => global_reset_n_i,
	
			xy_en_i => xy_grad20_en_s,
			xy_x_i => xy_grad20_x_s,
			xy_y_i => xy_grad20_y_s,
	
			xy_en_o => xy_delay20_en_s,
			xy_x_o => xy_delay20_x_s,
			xy_y_o => xy_delay20_y_s
		);

	extractor20 : extractor
		generic map (
			IMG_WIDTH => IMG_WIDTH/4,
			IMG_HEIGHT => IMG_HEIGHT/4,
			MAX_COLOR => MAX_COLOR,
			MAX_SIZE_LIST => MAX_SIZE_LIST,
			FEATURE_RADIUS => FEATURE_RADIUS,
			MEMORY_BUS_WIDTH => MEMORY_BUS_WIDTH
		)
		port map (
			global_clk_i => global_clk_i,
			global_reset_n_i => global_reset_n_i,
	
			-- video flux to extract the features from, already delayed
			xy_en_i => xy_delay20_en_s,
			xy_x_i => xy_delay20_x_s,
			xy_y_i => xy_delay20_y_s,
			xy_data_i => xy_delay20_data_s,
--			xy_ready_o => 
			
			-- keypoint interface
			kp_en_i => xy_sort20_en_s,
			kp_x_i => xy_sort20_x_s,
			kp_y_i => xy_sort20_y_s,
			kp_new_i => xy_sort20_new_keypoint_s,
			kp_index_i => xy_sort20_index_s,
			kp_value_i => xy_sort20_data_s,
			kp_constraints_i => xy_sort20_constraints_s,

			-- correspondance between sorted index and extracted index
			kp_tab_index_i => xy_sort20_tab_index_s,
	
			-- cpu memory interface, index selects which memory to read
			cpu_index_i => cpu20_index_i,
			cpu_addr_i => cpu20_addr_i,
			cpu_data_o => cpu20_data_o,
			cpu_frame_counter_o => cpu20_frame_counter_o,
            cpu_kp_counter_o => cpu20_kp_counter_o,
            cpu_kp_value_o => cpu20_kp_value_o,
            cpu_kp_x_o => cpu20_kp_x_o,
            cpu_kp_y_o => cpu20_kp_y_o,
            cpu_kp_cstr_tag_o => cpu20_kp_cstr_tag_o            				
		);

--	xy_dog21_ready_s <= '1';
	xy_threshold21_s <= (others => '0');

	search21 : search
		generic map (
			BUS_WIDTH => unsigned_num_bits(MAX_COLOR),
			RADIUS => SEARCH_RADIUS_2,
			W_IMG => IMG_WIDTH/4,
			H_IMG => IMG_HEIGHT/4,

			MAX_SIZE_LIST => MAX_SIZE_LIST
		)
		port map (
			i_clk => global_clk_i,
			i_reset_n => global_reset_n_i,

			i_en => xy_dog21_en_s,
			i_data => xy_dog21_data_s,
			i_x => xy_dog21_x_s,
			i_y => xy_dog21_y_s,
			i_threshold => xy_threshold21_s,

			o_en => xy_search21_en_s,
			o_new_keypoint => xy_search21_new_keypoint_s,
			o_data => xy_search21_data_s,
			o_x => xy_search21_x_s,
			o_y => xy_search21_y_s,

			i_constraints_en => constraints_en_i,
			i_x_constraints => x_constraints_i,
			i_y_constraints => y_constraints_i,
			i_x_constraints_width => x_constraints_width21_i,
			i_y_constraints_width => y_constraints_width21_i,
			o_constraints_tag => xy_search21_constraints_tag_s
		);

	sort21 : sort
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			max_size_list => MAX_SIZE_LIST,
			w_img => IMG_WIDTH/4,
			h_img => IMG_HEIGHT/4
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => xy_search21_en_s,
			sort => xy_search21_new_keypoint_s,
			data_in => xy_search21_data_s,
			constraints_tag_in => xy_search21_constraints_tag_s,
			xin => xy_search21_x_s,
			yin => xy_search21_y_s,

			EN_out => xy_sort21_en_s,
			new_keypoint => xy_sort21_new_keypoint_s,
			keypoint_value => xy_sort21_data_s,
			keypoint_constraints => xy_sort21_constraints_s,
			keypoint_x => xy_sort21_x_s,
			keypoint_y => xy_sort21_y_s,
			keypoint_index => xy_sort21_index_s,
			tab_index => xy_sort21_tab_index_s,
			tab_x => x_constraints2x_s,
			tab_y => y_constraints2x_s
		);

	constraints_en_s <= '1' when (
						(xy_search21_x_s = std_logic_vector(to_unsigned(IMG_WIDTH/4-1,xy_search21_x_s'length))) and 
						(xy_search21_y_s = std_logic_vector(to_unsigned(IMG_HEIGHT/4-1,xy_search21_y_s'length))))
					else '0';

	delay21: delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/4,
			h_img => IMG_HEIGHT/4,
			delay_x => DELAY21_X_C,
			delay_y => DELAY21_Y_C
		)
		port map (
			clk => global_clk_i,
			EN => xy_grad21_en_s,
			data_in => xy_grad21_data_s,
			data_out => xy_delay21_data_s
		);

	xy_delay21: xy_delay
		generic map (
			DELAY_X => DELAY21_X_C,
			DELAY_Y => DELAY21_Y_C,
			IMG_WIDTH => IMG_WIDTH/4,
			IMG_HEIGHT => IMG_HEIGHT/4
		)
		port map (
			global_clk_i => global_clk_i,
			global_resetn_i => global_reset_n_i,
	
			xy_en_i => xy_grad21_en_s,
			xy_x_i => xy_grad21_x_s,
			xy_y_i => xy_grad21_y_s,
	
			xy_en_o => xy_delay21_en_s,
			xy_x_o => xy_delay21_x_s,
			xy_y_o => xy_delay21_y_s
		);

	extractor21 : extractor
		generic map (
			IMG_WIDTH => IMG_WIDTH/4,
			IMG_HEIGHT => IMG_HEIGHT/4,
			MAX_COLOR => MAX_COLOR,
			MAX_SIZE_LIST => MAX_SIZE_LIST,
			FEATURE_RADIUS => FEATURE_RADIUS,
			MEMORY_BUS_WIDTH => MEMORY_BUS_WIDTH
		)
		port map (
			global_clk_i => global_clk_i,
			global_reset_n_i => global_reset_n_i,
	
			-- video flux to extract the features from, already delayed
			xy_en_i => xy_delay21_en_s,
			xy_x_i => xy_delay21_x_s,
			xy_y_i => xy_delay21_y_s,
			xy_data_i => xy_delay21_data_s,
--			xy_ready_o => 
			
			-- keypoint interface
			kp_en_i => xy_sort21_en_s,
			kp_x_i => xy_sort21_x_s,
			kp_y_i => xy_sort21_y_s,
			kp_new_i => xy_sort21_new_keypoint_s,
			kp_index_i => xy_sort21_index_s,
			kp_value_i => xy_sort21_data_s,
			kp_constraints_i => xy_sort21_constraints_s,

			-- correspondance between sorted index and extracted index
			kp_tab_index_i => xy_sort21_tab_index_s,
	
			-- cpu memory interface, index selects which memory to read
			cpu_index_i => cpu21_index_i,
			cpu_addr_i => cpu21_addr_i,
			cpu_data_o => cpu21_data_o,
			cpu_frame_counter_o => cpu21_frame_counter_o,
            cpu_kp_counter_o => cpu21_kp_counter_o,
            cpu_kp_value_o => cpu21_kp_value_o,
            cpu_kp_x_o => cpu21_kp_x_o,
            cpu_kp_y_o => cpu21_kp_y_o,
            cpu_kp_cstr_tag_o => cpu21_kp_cstr_tag_o            				
		);
end architecture rtl;