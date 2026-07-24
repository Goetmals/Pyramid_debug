----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.05.2015 15:44:26
-- Design Name: 
-- Module Name: user_logic - IMP
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.saturn_numeric_pkg.all;
use work.axis_xy_pkg.all;
use work.rgb_to_gs_pkg.all;
use work.pyramid_kp_pkg.all;


entity user_logic is
	generic
	(
	    MAX_SIZE_LIST                  	: positive             := 16;
		s_output_source 				: std_logic_vector(2 downto 0) := "000"
	);
	port
	(
--------------------------------------------------------------------------------
-- Global Reset
--------------------------------------------------------------------------------
		resetn							: in std_logic;
--------------------------------------------------------------------------------
-- AXIS Clock
--------------------------------------------------------------------------------
		aclk 							: in std_logic;

--------------------------------------------------------------------------------
-- AXIS Slave 0 side (from IPIPE)
--------------------------------------------------------------------------------
		S00_AXIS_TVALID					: in std_logic;
		S00_AXIS_TUSER 					: in std_logic;
		S00_AXIS_TLAST 					: in std_logic;
		S00_AXIS_TREADY					: out std_logic;
		S00_AXIS_TDATA 					: in std_logic_vector(7 downto 0);


--------------------------------------------------------------------------------
-- AXIS Master 0 side
--------------------------------------------------------------------------------
		M00_AXIS_TVALID 				: out std_logic;
		M00_AXIS_TUSER 					: out std_logic;
		M00_AXIS_TLAST 					: out std_logic;
		M00_AXIS_TREADY 				: in std_logic;
		M00_AXIS_TDATA 					: out std_logic_vector(7 downto 0);

--------------------------------------------------------------------------------
-- AXIS Master 1 side
--------------------------------------------------------------------------------
		M01_AXIS_TVALID 				: out std_logic;
		M01_AXIS_TUSER 					: out std_logic;
		M01_AXIS_TLAST 					: out std_logic;
		M01_AXIS_TREADY 				: in std_logic;
		M01_AXIS_TDATA 					: out std_logic_vector(7 downto 0);
--------------------------------------------------------------------------------
-- AXIS Master 2 side
--------------------------------------------------------------------------------
		M02_AXIS_TVALID 				: out std_logic;
		M02_AXIS_TUSER 					: out std_logic;
		M02_AXIS_TLAST 					: out std_logic;
		M02_AXIS_TREADY   				: in std_logic;
		M02_AXIS_TDATA 					: out std_logic_vector(7 downto 0);
--------------------------------------------------------------------------------
-- AXIS Master 3 side
--------------------------------------------------------------------------------
		M03_AXIS_TVALID 				: out std_logic;
		M03_AXIS_TUSER 					: out std_logic;
		M03_AXIS_TLAST 					: out std_logic;
		M03_AXIS_TREADY 				: in std_logic;
		M03_AXIS_TDATA 					: out std_logic_vector(7 downto 0)
	);

		
end entity user_logic;


architecture IMP of user_logic is
--------------------------------------------------------------------------------
-- Constants
--------------------------------------------------------------------------------
    -- General purpose constants
	constant IMG_WIDTH 					: positive := 1920;
	constant IMG_HEIGHT 				: positive := 1080;
	constant IMG_WIDTH_4				: positive := IMG_WIDTH/4;
    constant IMG_HEIGHT_4 				: positive := IMG_HEIGHT/4;
    constant IMG_WIDTH_8				: positive := IMG_WIDTH/8;
    constant IMG_HEIGHT_8 				: positive := IMG_HEIGHT/8;
    constant IMG_WIDTH_16				: positive := IMG_WIDTH/16;
    constant IMG_HEIGHT_16 				: positive := IMG_HEIGHT/16;
    constant BUS_WIDTH_RGB              : positive := 32;
    constant BUS_WIDTH_GS              : positive := 8; -- Added by Fred 210620
	constant MAX_COLOR_GS               : positive := 255;
	constant SEARCH_RADIUS_0			: real     := 20.0;
	constant SEARCH_RADIUS_1			: real     := 10.0;
	constant SEARCH_RADIUS_2			: real     := 5.0;
	constant FEATURE_RADIUS 			: positive := 20;
	constant MEMORY_BUS_WIDTH 			: positive := unsigned_num_bits(1680);
	constant MMAP_BUS_WIDTH 			: positive := unsigned_num_bits(2070);	
	constant REG_NUMBER                 : positive := 28;    -- modified by Fred
	constant SOURCES_NUMBER     		: positive := 8;

    -- Vectors sizes
    constant VEC_SIZE_IMG_WIDTH         : positive := unsigned_num_bits(IMG_WIDTH-1);
    constant VEC_SIZE_IMG_HEIGHT        : positive := unsigned_num_bits(IMG_HEIGHT-1);
    constant VEC_SIZE_IMG_WIDTH_4       : positive := unsigned_num_bits(IMG_WIDTH_4-1);
    constant VEC_SIZE_IMG_HEIGHT_4      : positive := unsigned_num_bits(IMG_HEIGHT_4-1);
    constant VEC_SIZE_IMG_WIDTH_8       : positive := unsigned_num_bits(IMG_WIDTH_8-1);
    constant VEC_SIZE_IMG_HEIGHT_8      : positive := unsigned_num_bits(IMG_HEIGHT_8-1);
    constant VEC_SIZE_IMG_WIDTH_16      : positive := unsigned_num_bits(IMG_WIDTH_16-1);
    constant VEC_SIZE_IMG_HEIGHT_16     : positive := unsigned_num_bits(IMG_HEIGHT_16-1);
    constant VEC_SIZE_MAX_COLOR_GS      : positive := unsigned_num_bits(MAX_COLOR_GS);
    constant VEC_SIZE_MAX_SIZE_LIST     : positive := unsigned_num_bits(MAX_SIZE_LIST-1);
    constant VEC_SIZE_SOURCES_NUMBER	: positive := unsigned_num_bits(SOURCES_NUMBER-1);

    -- Registers
    constant REG_KP_FEATURE        		: std_logic_vector(REG_NUMBER-1 downto 0) := ( 0 => '1', others => '0');
    constant REG_FRAME_COUNTER  		: std_logic_vector(REG_NUMBER-1 downto 0) := ( 1 => '1', others => '0');
    constant REG_KP_COUNTER     		: std_logic_vector(REG_NUMBER-1 downto 0) := ( 2 => '1', others => '0');
    constant REG_KP_X           		: std_logic_vector(REG_NUMBER-1 downto 0) := ( 3 => '1', others => '0');
    constant REG_KP_Y           		: std_logic_vector(REG_NUMBER-1 downto 0) := ( 4 => '1', others => '0');
    constant REG_KP_VALUE       		: std_logic_vector(REG_NUMBER-1 downto 0) := ( 5 => '1', others => '0');
    constant REG_KP_CONSTRAINTS_TAG		: std_logic_vector(REG_NUMBER-1 downto 0) := ( 6 => '1', others => '0');
    constant REG_KP_INDEX       		: std_logic_vector(REG_NUMBER-1 downto 0) := ( 7 => '1', others => '0');
    constant REG_X_CONSTRAINT_WIDTH_00	: std_logic_vector(REG_NUMBER-1 downto 0) := ( 8 => '1', others => '0');
    constant REG_Y_CONSTRAINT_WIDTH_00	: std_logic_vector(REG_NUMBER-1 downto 0) := ( 9 => '1', others => '0');
    constant REG_X_CONSTRAINT_WIDTH_01	: std_logic_vector(REG_NUMBER-1 downto 0) := (10 => '1', others => '0');
    constant REG_Y_CONSTRAINT_WIDTH_01	: std_logic_vector(REG_NUMBER-1 downto 0) := (11 => '1', others => '0');
    constant REG_X_CONSTRAINT_WIDTH_10	: std_logic_vector(REG_NUMBER-1 downto 0) := (12 => '1', others => '0');
    constant REG_Y_CONSTRAINT_WIDTH_10	: std_logic_vector(REG_NUMBER-1 downto 0) := (13 => '1', others => '0');
    constant REG_X_CONSTRAINT_WIDTH_11	: std_logic_vector(REG_NUMBER-1 downto 0) := (14 => '1', others => '0');
    constant REG_Y_CONSTRAINT_WIDTH_11	: std_logic_vector(REG_NUMBER-1 downto 0) := (15 => '1', others => '0');
    constant REG_X_CONSTRAINT_WIDTH_20	: std_logic_vector(REG_NUMBER-1 downto 0) := (16 => '1', others => '0');
    constant REG_Y_CONSTRAINT_WIDTH_20	: std_logic_vector(REG_NUMBER-1 downto 0) := (17 => '1', others => '0');
    constant REG_X_CONSTRAINT_WIDTH_21	: std_logic_vector(REG_NUMBER-1 downto 0) := (18 => '1', others => '0');
    constant REG_Y_CONSTRAINT_WIDTH_21	: std_logic_vector(REG_NUMBER-1 downto 0) := (19 => '1', others => '0');
    constant REG_X_CONSTRAINT   		: std_logic_vector(REG_NUMBER-1 downto 0) := (20 => '1', others => '0');
    constant REG_Y_CONSTRAINT   		: std_logic_vector(REG_NUMBER-1 downto 0) := (21 => '1', others => '0');
    constant REG_INDEX_CONSTRAINT   	: std_logic_vector(REG_NUMBER-1 downto 0) := (22 => '1', others => '0');
    constant REG_EN_CONSTRAINT    		: std_logic_vector(REG_NUMBER-1 downto 0) := (23 => '1', others => '0');
    constant REG_INPUT_SOURCE         	: std_logic_vector(REG_NUMBER-1 downto 0) := (24 => '1', others => '0');    
    constant REG_OUTPUT_SOURCE         	: std_logic_vector(REG_NUMBER-1 downto 0) := (25 => '1', others => '0'); 
	
	-- added by Fred 18/06/20
	constant REG_AXIS_CTRL				: std_logic_vector(REG_NUMBER-1 downto 0) := (26 => '1', others => '0'); 
    constant REG_S_AXIS_TDATA			: std_logic_vector(REG_NUMBER-1 downto 0) := (27 => '1', others => '0');
--	constant REG_M_AXIS_TDATA			: std_logic_vector(REG_NUMBER-1 downto 0) := (28 => '1', others => '0');
	
    -- Input video sources	
	constant SOURCE_IPIPE				: std_logic := '0'; 	
	constant SOURCE_DDR_MEMORY			: std_logic := '1';

    -- Output video sources
    constant SOURCE_VIDEO_IN    		: integer := 0;
    constant SOURCE_GRADIENT    		: integer := 1;
    constant SOURCE_DOG_00      		: integer := 2;
    constant SOURCE_DOG_01      		: integer := 3;
    constant SOURCE_DOG_10      		: integer := 4;
    constant SOURCE_DOG_11      		: integer := 5;
    constant SOURCE_DOG_20      		: integer := 6;
    constant SOURCE_DOG_21      		: integer := 7;
    
    -- Output video sources mux selection
    constant SOURCE_MUX_SEL_VIDEO_IN	: std_logic := '0';
    constant SOURCE_MUX_SEL_GRADIENT	: std_logic := '1';
    constant SOURCE_MUX_SEL_DOG_00 		: std_logic := '0';
    constant SOURCE_MUX_SEL_DOG_01 		: std_logic := '1';
    constant SOURCE_MUX_SEL_DOG_10 		: std_logic := '0';
    constant SOURCE_MUX_SEL_DOG_11 		: std_logic := '1';
    constant SOURCE_MUX_SEL_DOG_20 		: std_logic := '0';
    constant SOURCE_MUX_SEL_DOG_21 		: std_logic := '1';        
	
--------------------------------------------------------------------------------
-- Signals
--------------------------------------------------------------------------------
	signal s_input_source				: std_logic;

	signal s_axis_tvalid				: std_logic;
	signal s_axis_tuser					: std_logic;
	signal s_axis_tlast					: std_logic;
	signal s_axis_tdata					: std_logic_vector(7 downto 0);

	signal s_xy_en 						: std_logic;
	signal s_xy_x 						: std_logic_vector(VEC_SIZE_IMG_WIDTH-1 downto 0);
	signal s_xy_y 						: std_logic_vector(VEC_SIZE_IMG_HEIGHT-1 downto 0);
	signal s_xy_data 					: std_logic_vector(BUS_WIDTH_GS-1 downto 0);
	signal s_xy_ready 					: std_logic;

	signal s_sub_en 					: std_logic;
	signal s_sub_x 						: std_logic_vector(VEC_SIZE_IMG_WIDTH_4-1 downto 0);
	signal s_sub_y 						: std_logic_vector(VEC_SIZE_IMG_HEIGHT_4-1 downto 0);
	signal s_sub_data 					: std_logic_vector(BUS_WIDTH_GS-1 downto 0);

	signal s_gs_en                      : std_logic;
	signal s_gs_x                       : std_logic_vector(VEC_SIZE_IMG_WIDTH_4-1 downto 0);
	signal s_gs_y                       : std_logic_vector(VEC_SIZE_IMG_HEIGHT_4-1 downto 0);
	signal s_gs_data                    : std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	
	signal s_xy_grad_en 				: std_logic;
	signal s_xy_grad_x 					: std_logic_vector(VEC_SIZE_IMG_WIDTH_4-1 downto 0);
	signal s_xy_grad_y 					: std_logic_vector(VEC_SIZE_IMG_HEIGHT_4-1 downto 0);
	signal s_xy_grad_data 				: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_xy_grad_ready 				: std_logic;

	signal s_xy_dog00_en 				: std_logic;
	signal s_xy_dog00_x 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_4-1 downto 0);
	signal s_xy_dog00_y 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_4-1 downto 0);
	signal s_xy_dog00_data 				: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_xy_dog00_ready 			: std_logic;

	signal s_cpu00_index 				: std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);
	signal s_cpu00_addr 				: std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
	signal s_cpu00_data 				: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
    signal s_cpu00_frame_counter 		: std_logic_vector(31 downto 0);
    signal s_cpu00_kp_counter 			: std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);
    signal s_cpu00_kp_value 			: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
    signal s_cpu00_kp_x 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_4-1 downto 0);
    signal s_cpu00_kp_y 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_4-1 downto 0);
    signal s_cpu00_kp_cstr_tag          : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
    
	signal s_xy_dog01_en 				: std_logic;
	signal s_xy_dog01_x 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_4-1 downto 0);
	signal s_xy_dog01_y 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_4-1 downto 0);
	signal s_xy_dog01_data 				: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_xy_dog01_ready 			: std_logic;

	signal s_cpu01_index 				: std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);
	signal s_cpu01_addr 				: std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
	signal s_cpu01_data 				: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_cpu01_frame_counter 		: std_logic_vector(31 downto 0);
    signal s_cpu01_kp_counter 			: std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);
    signal s_cpu01_kp_value 			: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
    signal s_cpu01_kp_x 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_4-1 downto 0);
    signal s_cpu01_kp_y 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_4-1 downto 0);
    signal s_cpu01_kp_cstr_tag          : std_logic_vector(MAX_SIZE_LIST-1 downto 0);

	signal s_xy_dog10_en 				: std_logic;
	signal s_xy_dog10_x 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_8-1 downto 0);
	signal s_xy_dog10_y 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_8-1 downto 0);
	signal s_xy_dog10_data 				: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_xy_dog10_ready 			: std_logic;

	signal s_cpu10_index 				: std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);
	signal s_cpu10_addr 				: std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
	signal s_cpu10_data 				: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_cpu10_frame_counter 		: std_logic_vector(31 downto 0);
    signal s_cpu10_kp_counter 			: std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);
    signal s_cpu10_kp_value 			: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
    signal s_cpu10_kp_x 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_8-1 downto 0);
    signal s_cpu10_kp_y 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_8-1 downto 0);
    signal s_cpu10_kp_cstr_tag          : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
    
	signal s_xy_dog11_en 				: std_logic;
	signal s_xy_dog11_x 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_8-1 downto 0);
	signal s_xy_dog11_y 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_8-1 downto 0);
	signal s_xy_dog11_data 				: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_xy_dog11_ready 			: std_logic;

	signal s_cpu11_index 				: std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);
	signal s_cpu11_addr 				: std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
	signal s_cpu11_data 				: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_cpu11_frame_counter 		: std_logic_vector(31 downto 0);
    signal s_cpu11_kp_counter 			: std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);
    signal s_cpu11_kp_value 			: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
    signal s_cpu11_kp_x 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_8-1 downto 0);
    signal s_cpu11_kp_y 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_8-1 downto 0);
    signal s_cpu11_kp_cstr_tag          : std_logic_vector(MAX_SIZE_LIST-1 downto 0);

	signal s_xy_dog20_en 				: std_logic;
	signal s_xy_dog20_x 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_16-1 downto 0);
	signal s_xy_dog20_y 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_16-1 downto 0);
	signal s_xy_dog20_data 				: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_xy_dog20_ready 			: std_logic;

	signal s_cpu20_index 				: std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);
	signal s_cpu20_addr 				: std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
	signal s_cpu20_data 				: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_cpu20_frame_counter 		: std_logic_vector(31 downto 0);
    signal s_cpu20_kp_counter 			: std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);
    signal s_cpu20_kp_value 			: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
    signal s_cpu20_kp_x 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_16-1 downto 0);
    signal s_cpu20_kp_y 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_16-1 downto 0);
    signal s_cpu20_kp_cstr_tag          : std_logic_vector(MAX_SIZE_LIST-1 downto 0);

	signal s_xy_dog21_en 				: std_logic;
	signal s_xy_dog21_x 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_16-1 downto 0);
	signal s_xy_dog21_y 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_16-1 downto 0);
	signal s_xy_dog21_data 				: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_xy_dog21_ready 			: std_logic;

	signal s_cpu21_index 				: std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);
	signal s_cpu21_addr 				: std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
	signal s_cpu21_data 				: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_cpu21_frame_counter 		: std_logic_vector(31 downto 0);
    signal s_cpu21_kp_counter 			: std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);
    signal s_cpu21_kp_value 			: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
    signal s_cpu21_kp_x 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_16-1 downto 0);
    signal s_cpu21_kp_y 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_16-1 downto 0);
    signal s_cpu21_kp_cstr_tag          : std_logic_vector(MAX_SIZE_LIST-1 downto 0);

	-- width and heigths in pixels of the constraints from low scales to up scales
	signal s_x_constraints_width00 		: std_logic_vector(VEC_SIZE_IMG_WIDTH_4-1 downto 0);
	signal s_y_constraints_width00 		: std_logic_vector(VEC_SIZE_IMG_HEIGHT_4-1 downto 0);
	signal s_x_constraints_width01 		: std_logic_vector(VEC_SIZE_IMG_WIDTH_4-1 downto 0);
	signal s_y_constraints_width01 		: std_logic_vector(VEC_SIZE_IMG_HEIGHT_4-1 downto 0);
	signal s_x_constraints_width10 		: std_logic_vector(VEC_SIZE_IMG_WIDTH_8-1 downto 0);
	signal s_y_constraints_width10 		: std_logic_vector(VEC_SIZE_IMG_HEIGHT_8-1 downto 0);
	signal s_x_constraints_width11 		: std_logic_vector(VEC_SIZE_IMG_WIDTH_8-1 downto 0);
	signal s_y_constraints_width11 		: std_logic_vector(VEC_SIZE_IMG_HEIGHT_8-1 downto 0);
	signal s_x_constraints_width20 		: std_logic_vector(VEC_SIZE_IMG_WIDTH_16-1 downto 0);
	signal s_y_constraints_width20 		: std_logic_vector(VEC_SIZE_IMG_HEIGHT_16-1 downto 0);
	signal s_x_constraints_width21 		: std_logic_vector(VEC_SIZE_IMG_WIDTH_16-1 downto 0);
	signal s_y_constraints_width21 		: std_logic_vector(VEC_SIZE_IMG_HEIGHT_16-1 downto 0);

	-- constraints of the lowest scale
	-- constraints_en_i registers the constraints
	signal s_en_constraints 			: std_logic;
	signal s_x_constraints 				: std_logic_vector(MAX_SIZE_LIST*VEC_SIZE_IMG_WIDTH_16-1 downto 0);
	signal s_y_constraints 				: std_logic_vector(MAX_SIZE_LIST*VEC_SIZE_IMG_HEIGHT_16-1 downto 0);
	signal s_x_constraint 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_16-1 downto 0);
	signal s_y_constraint 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_16-1 downto 0);	
    signal s_index_constraint           : std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);

    -- AXIS Mux output shared by Grey Scale and Gradient 
	signal s_xy_final_en_0 				: std_logic;
	signal s_xy_final_x_0 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_4-1 downto 0);
	signal s_xy_final_y_0 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_4-1 downto 0);
	signal s_xy_final_data_0 			: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_xy_final_ready_0 			: std_logic;
	
    -- AXIS Mux output shared by DoG_00 and DoG_01    
	signal s_xy_final_en_1 				: std_logic;
    signal s_xy_final_x_1 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_4-1 downto 0);
    signal s_xy_final_y_1 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_4-1 downto 0);
    signal s_xy_final_data_1 			: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
    signal s_xy_final_ready_1 			: std_logic;

    -- AXIS Mux output shared by DoG_10 and DoG_11    
	signal s_xy_final_en_2 				: std_logic;
	signal s_xy_final_x_2 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_8-1 downto 0);
	signal s_xy_final_y_2 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_8-1 downto 0);
	signal s_xy_final_data_2 			: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_xy_final_ready_2 			: std_logic;	

    -- AXIS Mux output shared by DoG_20 and DoG_21    
	signal s_xy_final_en_3 				: std_logic;
	signal s_xy_final_x_3 				: std_logic_vector(VEC_SIZE_IMG_WIDTH_16-1 downto 0);
	signal s_xy_final_y_3 				: std_logic_vector(VEC_SIZE_IMG_HEIGHT_16-1 downto 0);
	signal s_xy_final_data_3 			: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
	signal s_xy_final_ready_3 			: std_logic;



	signal s_reg_sel 					: std_logic_vector(REG_NUMBER-1 downto 0);
    signal s_address                    : std_logic_vector(MMAP_BUS_WIDTH-1 downto 0);
	--signal s_output_source 				: std_logic_vector(VEC_SIZE_SOURCES_NUMBER-1 downto 0);    -- Commented by Fred 17/12/21
	signal s_final_source_0             : std_logic;
    signal s_final_source_1             : std_logic;
    signal s_final_source_2             : std_logic;
    signal s_final_source_3             : std_logic;

    signal s_selected_cpu_index 		: std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);
    signal s_selected_cpu_addr 			: std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
    signal s_selected_cpu_data 			: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
    signal s_selected_cpu_frame_counter : std_logic_vector(31 downto 0);
    signal s_selected_cpu_kp_counter 	: std_logic_vector(VEC_SIZE_MAX_SIZE_LIST-1 downto 0);
    signal s_selected_cpu_kp_value 		: std_logic_vector(VEC_SIZE_MAX_COLOR_GS-1 downto 0);
    signal s_selected_cpu_kp_x 			: std_logic_vector(VEC_SIZE_IMG_WIDTH_4-1 downto 0);
    signal s_selected_cpu_kp_y 			: std_logic_vector(VEC_SIZE_IMG_HEIGHT_4-1 downto 0);
    signal s_selected_cpu_kp_cstr_tag   : std_logic_vector(MAX_SIZE_LIST-1 downto 0);
	
	-- added by Fred 18/06/20
	signal s_axis_ctrl					: std_logic_vector(6 downto 0);
	signal s_axis_data					: std_logic_vector(31 downto 0);
	
    signal GND24 						: std_logic_vector(23 downto 0) := (others => '0');

begin

    S00_AXIS_TREADY <= '1';

	-- added by Fred 18/06/20
	s_axis_ctrl <= M03_AXIS_TREADY & M02_AXIS_TREADY & M01_AXIS_TREADY & M00_AXIS_TREADY & S00_AXIS_TLAST & S00_AXIS_TUSER & S00_AXIS_TVALID;					
	s_axis_data <= GND24 & S00_AXIS_TDATA; 	 					
		 					

	s_axis_tvalid	<= S00_AXIS_TVALID;
	s_axis_tuser	<= S00_AXIS_TUSER;
	s_axis_tlast	<= S00_AXIS_TLAST;
	s_axis_tdata	<= S00_AXIS_TDATA;					
		            

--------------------------------------------------------------------------------
-- AXIS to XY
--------------------------------------------------------------------------------
	axis_to_xy_inst : axis_to_xy
		generic map (
			BUS_WIDTH => BUS_WIDTH_GS,
			IMG_WIDTH => IMG_WIDTH,
			IMG_HEIGHT => IMG_HEIGHT
		)
		port map (
			aclk => aclk,
			aresetn => resetn,

			S_AXIS_TVALID => s_axis_tvalid,
			S_AXIS_TUSER => s_axis_tuser,
			S_AXIS_TLAST => s_axis_tlast,
			S_AXIS_TDATA => s_axis_tdata,

			M_AXIS_TREADY => '1',
			o_en => s_xy_en,
			o_x => s_xy_x,
			o_y => s_xy_y,
			o_value => s_xy_data
		);

--------------------------------------------------------------------------------
-- Sub-sampling
--------------------------------------------------------------------------------
	s_sub_en <= s_xy_en 
		when ((s_xy_x(1 downto 0) = "00") and 
			(s_xy_y(1 downto 0) = "00"))
		else '0';
	s_sub_data <= s_xy_data;
	s_sub_x <= s_xy_x(s_xy_x'left downto s_xy_x'right+2);
	s_sub_y <= s_xy_y(s_xy_y'left downto s_xy_y'right+2);

--------------------------------------------------------------------------------
-- Pyramid KP
--------------------------------------------------------------------------------    
    pyramid_kp_inst : pyramid_kp
		generic map (
			IMG_WIDTH 				=> IMG_WIDTH_4,
			IMG_HEIGHT 				=> IMG_HEIGHT_4,
			MAX_COLOR 				=> MAX_COLOR_GS,
			SEARCH_RADIUS_0 		=> SEARCH_RADIUS_0,
			SEARCH_RADIUS_1 		=> SEARCH_RADIUS_1,
			SEARCH_RADIUS_2 		=> SEARCH_RADIUS_2,
			MAX_SIZE_LIST 			=> MAX_SIZE_LIST,
			FEATURE_RADIUS 			=> FEATURE_RADIUS,
			MEMORY_BUS_WIDTH 		=> MEMORY_BUS_WIDTH
		)
		port map (
			global_clk_i 			=> aclk,
			global_reset_n_i 		=> resetn,

            xy_en_i 				=> s_sub_en,
			xy_x_i 					=> s_sub_x,
			xy_y_i 					=> s_sub_y,
			xy_data_i 				=> s_sub_data,
			xy_ready_o 				=> s_xy_ready,

          	xy_grad_en_o 			=> s_xy_grad_en,
			xy_grad_x_o 			=> s_xy_grad_x,
			xy_grad_y_o 			=> s_xy_grad_y,
			xy_grad_data_o 			=> s_xy_grad_data,
			xy_grad_ready_i 		=> s_xy_grad_ready,
	
			xy_dog00_en_o 			=> s_xy_dog00_en,
			xy_dog00_x_o 			=> s_xy_dog00_x,
			xy_dog00_y_o 			=> s_xy_dog00_y,
			xy_dog00_data_o 		=> s_xy_dog00_data,
			xy_dog00_ready_i 		=> s_xy_dog00_ready,

			cpu00_index_i 			=> s_cpu00_index,
			cpu00_addr_i 			=> s_cpu00_addr,
			cpu00_data_o 			=> s_cpu00_data,
            cpu00_frame_counter_o 	=> s_cpu00_frame_counter,
            cpu00_kp_counter_o 		=> s_cpu00_kp_counter,
            cpu00_kp_value_o 		=> s_cpu00_kp_value,
            cpu00_kp_x_o 			=> s_cpu00_kp_x,
            cpu00_kp_y_o 			=> s_cpu00_kp_y,
            cpu00_kp_cstr_tag_o     => s_cpu00_kp_cstr_tag,
                        
			xy_dog01_en_o 			=> s_xy_dog01_en,
			xy_dog01_x_o 			=> s_xy_dog01_x,
			xy_dog01_y_o 			=> s_xy_dog01_y,
			xy_dog01_data_o 		=> s_xy_dog01_data,
			xy_dog01_ready_i 		=> s_xy_dog01_ready,

			cpu01_index_i 			=> s_cpu01_index,
			cpu01_addr_i 			=> s_cpu01_addr,
			cpu01_data_o 			=> s_cpu01_data,
			cpu01_frame_counter_o 	=> s_cpu01_frame_counter,
            cpu01_kp_counter_o 		=> s_cpu01_kp_counter,
            cpu01_kp_value_o 		=> s_cpu01_kp_value,
            cpu01_kp_x_o 			=> s_cpu01_kp_x,
            cpu01_kp_y_o 			=> s_cpu01_kp_y,
            cpu01_kp_cstr_tag_o     => s_cpu01_kp_cstr_tag,
            
			xy_dog10_en_o 			=> s_xy_dog10_en,
			xy_dog10_x_o 			=> s_xy_dog10_x,
			xy_dog10_y_o 			=> s_xy_dog10_y,
			xy_dog10_data_o 		=> s_xy_dog10_data,
			xy_dog10_ready_i 		=> s_xy_dog10_ready,

			cpu10_index_i 			=> s_cpu10_index,
			cpu10_addr_i 			=> s_cpu10_addr,
			cpu10_data_o 			=> s_cpu10_data,
			cpu10_frame_counter_o 	=> s_cpu10_frame_counter,
            cpu10_kp_counter_o 		=> s_cpu10_kp_counter,
            cpu10_kp_value_o 		=> s_cpu10_kp_value,
            cpu10_kp_x_o 			=> s_cpu10_kp_x,
            cpu10_kp_y_o 			=> s_cpu10_kp_y,
            cpu10_kp_cstr_tag_o     => s_cpu10_kp_cstr_tag,

			xy_dog11_en_o 			=> s_xy_dog11_en,
			xy_dog11_x_o 			=> s_xy_dog11_x,
			xy_dog11_y_o 			=> s_xy_dog11_y,
			xy_dog11_data_o 		=> s_xy_dog11_data,
			xy_dog11_ready_i 		=> s_xy_dog11_ready,

			cpu11_index_i 			=> s_cpu11_index,
			cpu11_addr_i 			=> s_cpu11_addr,
			cpu11_data_o 			=> s_cpu11_data,
			cpu11_frame_counter_o 	=> s_cpu11_frame_counter,
            cpu11_kp_counter_o 		=> s_cpu11_kp_counter,
            cpu11_kp_value_o 		=> s_cpu11_kp_value,
            cpu11_kp_x_o 			=> s_cpu11_kp_x,
            cpu11_kp_y_o 			=> s_cpu11_kp_y,
            cpu11_kp_cstr_tag_o     => s_cpu11_kp_cstr_tag,

			xy_dog20_en_o 			=> s_xy_dog20_en,
			xy_dog20_x_o 			=> s_xy_dog20_x,
			xy_dog20_y_o 			=> s_xy_dog20_y,
			xy_dog20_data_o 		=> s_xy_dog20_data,
			xy_dog20_ready_i 		=> s_xy_dog20_ready,

			cpu20_index_i 			=> s_cpu20_index,
			cpu20_addr_i 			=> s_cpu20_addr,
			cpu20_data_o 			=> s_cpu20_data,
			cpu20_frame_counter_o 	=> s_cpu20_frame_counter,
            cpu20_kp_counter_o 		=> s_cpu20_kp_counter,
            cpu20_kp_value_o 		=> s_cpu20_kp_value,
            cpu20_kp_x_o 			=> s_cpu20_kp_x,
            cpu20_kp_y_o 			=> s_cpu20_kp_y,
            cpu20_kp_cstr_tag_o     => s_cpu20_kp_cstr_tag,

			xy_dog21_en_o 			=> s_xy_dog21_en,
			xy_dog21_x_o 			=> s_xy_dog21_x,
			xy_dog21_y_o 			=> s_xy_dog21_y,
			xy_dog21_data_o	 		=> s_xy_dog21_data,
			xy_dog21_ready_i 		=> s_xy_dog21_ready,

			cpu21_index_i 			=> s_cpu21_index,
			cpu21_addr_i 			=> s_cpu21_addr,
			cpu21_data_o 			=> s_cpu21_data,
			cpu21_frame_counter_o 	=> s_cpu21_frame_counter,
            cpu21_kp_counter_o 		=> s_cpu21_kp_counter,
            cpu21_kp_value_o 		=> s_cpu21_kp_value,
            cpu21_kp_x_o 			=> s_cpu21_kp_x,
            cpu21_kp_y_o 			=> s_cpu21_kp_y,
            cpu21_kp_cstr_tag_o     => s_cpu21_kp_cstr_tag,
	
			x_constraints_width00_i => s_x_constraints_width00,
			y_constraints_width00_i => s_y_constraints_width00,
			x_constraints_width01_i => s_x_constraints_width01,
			y_constraints_width01_i => s_y_constraints_width01,
			x_constraints_width10_i => s_x_constraints_width10,
			y_constraints_width10_i => s_y_constraints_width10,
			x_constraints_width11_i => s_x_constraints_width11,
			y_constraints_width11_i => s_y_constraints_width11,
			x_constraints_width20_i => s_x_constraints_width20,
			y_constraints_width20_i => s_y_constraints_width20,
			x_constraints_width21_i => s_x_constraints_width21,
			y_constraints_width21_i => s_y_constraints_width21,
	
			constraints_en_i 		=> s_en_constraints,
			x_constraints_i 		=> s_x_constraints,
			y_constraints_i 		=> s_y_constraints
		);

--------------------------------------------------------------------------------
-- XY to AXIS
-- Gradient to VDMA 1
--------------------------------------------------------------------------------
	xy_to_axis_0 : xy_to_axis
		generic map (
			IMG_WIDTH 				=> IMG_WIDTH_4,
			IMG_HEIGHT 				=> IMG_HEIGHT_4,
			MAX_COLOR 				=> MAX_COLOR_GS
		)
		port map (
			aclk                    => aclk,
			aresetn                 => resetn,

			i_en                    => s_xy_final_en_0,
			i_x                     => s_xy_final_x_0,
			i_y                     => s_xy_final_y_0,
			i_value                 => s_xy_final_data_0,

			M_AXIS_TVALID           => M00_AXIS_TVALID,
			M_AXIS_TUSER            => M00_AXIS_TUSER,
			M_AXIS_TLAST            => M00_AXIS_TLAST,
			M_AXIS_TREADY           => M00_AXIS_TREADY,
			M_AXIS_TDATA            => M00_AXIS_TDATA
		);

--------------------------------------------------------------------------------
-- XY to AXIS
-- DoG_01 to VDMA 2
--------------------------------------------------------------------------------
	xy_to_axis_1 : xy_to_axis
		generic map (
			IMG_WIDTH 				=> IMG_WIDTH_4,
			IMG_HEIGHT 				=> IMG_HEIGHT_4,
			MAX_COLOR 				=> MAX_COLOR_GS
		)
		port map (
			aclk                    => aclk,
			aresetn                 => resetn,

			i_en                    => s_xy_final_en_1,
			i_x                     => s_xy_final_x_1,
			i_y                     => s_xy_final_y_1,
			i_value                 => s_xy_final_data_1,

			M_AXIS_TVALID           => M01_AXIS_TVALID,
			M_AXIS_TUSER            => M01_AXIS_TUSER,
			M_AXIS_TLAST            => M01_AXIS_TLAST,
			M_AXIS_TREADY           => M01_AXIS_TREADY,
			M_AXIS_TDATA            => M01_AXIS_TDATA
		);

--------------------------------------------------------------------------------
-- XY to AXIS
-- DoG_11 to VDMA 3
--------------------------------------------------------------------------------
	xy_to_axis_2 : xy_to_axis
		generic map (
			IMG_WIDTH 				=> IMG_WIDTH_8,
			IMG_HEIGHT 				=> IMG_HEIGHT_8,
			MAX_COLOR 				=> MAX_COLOR_GS
		)
		port map (
			aclk                    => aclk,
			aresetn                 => resetn,

			i_en                    => s_xy_final_en_2,
			i_x                     => s_xy_final_x_2,
			i_y                     => s_xy_final_y_2,
			i_value                 => s_xy_final_data_2,

			M_AXIS_TVALID           => M02_AXIS_TVALID,
			M_AXIS_TUSER            => M02_AXIS_TUSER,
			M_AXIS_TLAST            => M02_AXIS_TLAST,
			M_AXIS_TREADY           => M02_AXIS_TREADY,
			M_AXIS_TDATA            => M02_AXIS_TDATA
		);
		
--------------------------------------------------------------------------------
-- XY to AXIS
-- DoG_20 to VDMA 4
--------------------------------------------------------------------------------
	xy_to_axis_3 : xy_to_axis
		generic map (
			IMG_WIDTH 				=> IMG_WIDTH_16,
			IMG_HEIGHT 				=> IMG_HEIGHT_16,
			MAX_COLOR 				=> MAX_COLOR_GS
		)
		port map (
			aclk                    => aclk,
			aresetn                 => resetn,

			i_en                    => s_xy_final_en_3,
			i_x                     => s_xy_final_x_3,
			i_y                     => s_xy_final_y_3,
			i_value                 => s_xy_final_data_3,

			M_AXIS_TVALID           => M03_AXIS_TVALID,
			M_AXIS_TUSER            => M03_AXIS_TUSER,
			M_AXIS_TLAST            => M03_AXIS_TLAST,
			M_AXIS_TREADY           => M03_AXIS_TREADY,
			M_AXIS_TDATA            => M03_AXIS_TDATA
		);

s_xy_final_en_0 	<= s_xy_grad_en;
s_xy_final_x_0 		<= s_xy_grad_x;
s_xy_final_y_0 		<= s_xy_grad_y;
s_xy_final_data_0 	<= s_xy_grad_data;
s_xy_final_ready_0 	<= s_xy_grad_ready;

s_xy_final_en_1 	<= s_xy_dog01_en;
s_xy_final_x_1 		<= s_xy_dog01_x;
s_xy_final_y_1 		<= s_xy_dog01_y;
s_xy_final_data_1 	<= s_xy_dog01_data;
s_xy_final_ready_1 	<= s_xy_dog01_ready;

s_xy_final_en_2 	<= s_xy_dog11_en;
s_xy_final_x_2 		<= s_xy_dog11_x;
s_xy_final_y_2 		<= s_xy_dog11_y;
s_xy_final_data_2 	<= s_xy_dog11_data;
s_xy_final_ready_2 	<= s_xy_dog11_ready;

s_xy_final_en_3 	<= s_xy_dog20_en;
s_xy_final_x_3 		<= s_xy_dog20_x;
s_xy_final_y_3 		<= s_xy_dog20_y;
s_xy_final_data_3 	<= s_xy_dog20_data;
s_xy_final_ready_3 	<= s_xy_dog20_ready;


--------------------------------------------------------------------------------
-- Scale selection mux
--------------------------------------------------------------------------------
    p_scale_index : process(aclk)
    begin
		if rising_edge(aclk) then
		
		    case to_integer(unsigned(s_output_source)) is
			
		        when SOURCE_DOG_00 =>        
		            s_cpu00_index                	<= s_selected_cpu_index;
		            s_cpu00_addr                 	<= s_selected_cpu_addr;
		            s_selected_cpu_data          	<= s_cpu00_data;      
		            s_selected_cpu_frame_counter 	<= s_cpu00_frame_counter;
		            s_selected_cpu_kp_counter    	<= s_cpu00_kp_counter;
		            s_selected_cpu_kp_value      	<= s_cpu00_kp_value;
		            s_selected_cpu_kp_x 			<= s_cpu00_kp_x;
		            s_selected_cpu_kp_y 			<= s_cpu00_kp_y;
                    s_selected_cpu_kp_cstr_tag      <= s_cpu00_kp_cstr_tag;
                    
		        when SOURCE_DOG_01 =>
		            s_cpu01_index					<= s_selected_cpu_index;
		            s_cpu01_addr					<= s_selected_cpu_addr;
		            s_selected_cpu_data				<= s_cpu01_data;      
		            s_selected_cpu_frame_counter	<= s_cpu01_frame_counter;
		            s_selected_cpu_kp_counter		<= s_cpu01_kp_counter;
		            s_selected_cpu_kp_value			<= s_cpu01_kp_value;
		            s_selected_cpu_kp_x 			<= s_cpu01_kp_x;
		            s_selected_cpu_kp_y 			<= s_cpu01_kp_y;
                    s_selected_cpu_kp_cstr_tag      <= s_cpu01_kp_cstr_tag;

		        when SOURCE_DOG_10 =>
		            s_cpu10_index					<= s_selected_cpu_index;
		            s_cpu10_addr					<= s_selected_cpu_addr;
		            s_selected_cpu_data				<= s_cpu10_data;      
		            s_selected_cpu_frame_counter	<= s_cpu10_frame_counter;
		            s_selected_cpu_kp_counter		<= s_cpu10_kp_counter;
		            s_selected_cpu_kp_value			<= s_cpu10_kp_value;
		            s_selected_cpu_kp_x 			<= std_logic_vector(resize(unsigned(s_cpu10_kp_x), s_selected_cpu_kp_x'length));
		            s_selected_cpu_kp_y 			<= std_logic_vector(resize(unsigned(s_cpu10_kp_y), s_selected_cpu_kp_y'length));
                    s_selected_cpu_kp_cstr_tag      <= s_cpu10_kp_cstr_tag;

		        when SOURCE_DOG_11 =>
		            s_cpu11_index					<= s_selected_cpu_index;
		            s_cpu11_addr					<= s_selected_cpu_addr;
		            s_selected_cpu_data				<= s_cpu11_data;      
		            s_selected_cpu_frame_counter	<= s_cpu11_frame_counter;
		            s_selected_cpu_kp_counter		<= s_cpu11_kp_counter;
		            s_selected_cpu_kp_value			<= s_cpu11_kp_value;
		            s_selected_cpu_kp_x 			<= std_logic_vector(resize(unsigned(s_cpu11_kp_x), s_selected_cpu_kp_x'length));
		            s_selected_cpu_kp_y 			<= std_logic_vector(resize(unsigned(s_cpu11_kp_y), s_selected_cpu_kp_y'length));
                    s_selected_cpu_kp_cstr_tag      <= s_cpu11_kp_cstr_tag;

		        when SOURCE_DOG_20 =>
		            s_cpu20_index					<= s_selected_cpu_index;
		            s_cpu20_addr					<= s_selected_cpu_addr;
		            s_selected_cpu_data				<= s_cpu20_data;      
		            s_selected_cpu_frame_counter	<= s_cpu20_frame_counter;
		            s_selected_cpu_kp_counter		<= s_cpu20_kp_counter;
		            s_selected_cpu_kp_value			<= s_cpu20_kp_value;
		            s_selected_cpu_kp_x 			<= std_logic_vector(resize(unsigned(s_cpu20_kp_x), s_selected_cpu_kp_x'length));
		            s_selected_cpu_kp_y 			<= std_logic_vector(resize(unsigned(s_cpu20_kp_y), s_selected_cpu_kp_y'length));
                    s_selected_cpu_kp_cstr_tag      <= s_cpu20_kp_cstr_tag;

		        when SOURCE_DOG_21 =>
		            s_cpu21_index					<= s_selected_cpu_index;
		            s_cpu21_addr					<= s_selected_cpu_addr;
		            s_selected_cpu_data				<= s_cpu21_data;      
		            s_selected_cpu_frame_counter	<= s_cpu21_frame_counter;
		            s_selected_cpu_kp_counter		<= s_cpu21_kp_counter;
		            s_selected_cpu_kp_value			<= s_cpu21_kp_value;
		            s_selected_cpu_kp_x 			<= std_logic_vector(resize(unsigned(s_cpu21_kp_x), s_selected_cpu_kp_x'length));
		            s_selected_cpu_kp_y 			<= std_logic_vector(resize(unsigned(s_cpu21_kp_y), s_selected_cpu_kp_y'length));
                    s_selected_cpu_kp_cstr_tag      <= s_cpu21_kp_cstr_tag;

		        when others =>
		            s_cpu01_index					<= s_selected_cpu_index;
		            s_cpu01_addr					<= s_selected_cpu_addr;
		            s_selected_cpu_data				<= s_cpu01_data;      
		            s_selected_cpu_frame_counter	<= s_cpu01_frame_counter;
		            s_selected_cpu_kp_counter		<= s_cpu01_kp_counter;
		            s_selected_cpu_kp_value			<= s_cpu01_kp_value;
		            s_selected_cpu_kp_x 			<= s_cpu01_kp_x;
		            s_selected_cpu_kp_y 			<= s_cpu01_kp_y;
                    s_selected_cpu_kp_cstr_tag      <= s_cpu01_kp_cstr_tag;
		    end case;
		end if;
    end process p_scale_index;

--------------------------------------------------------------------------------
-- Address decoder
--------------------------------------------------------------------------------
 	addr_dec_inst : addr_dec
 		generic map (
 			REG_NUMBER 	=> REG_NUMBER
 		)
 		port map (
 			i_clk 		=> Bus2IP_Clk,
 			i_reset_n 	=> Bus2IP_Resetn,
 			i_addr 		=> s_address,
 			i_rd_ce 	=> Bus2IP_RdCE(0),
 			i_wr_ce 	=> Bus2IP_WrCE(0),
 			
 			o_reg_sel 	=> s_reg_sel,
 			o_rd_ack 	=> IP2Bus_RdAck,
 			o_wr_ack 	=> IP2Bus_WrAck,
 			o_error 	=> IP2Bus_Error
 		);
	s_address <= Bus2IP_Addr(18 to 29);
    s_selected_cpu_addr <= s_address(s_selected_cpu_addr'range);
    
--------------------------------------------------------------------------------
-- Registers write process
--------------------------------------------------------------------------------
	p_write : process(Bus2IP_Clk, Bus2IP_Resetn) is
	begin
	
			if Bus2IP_Resetn = '0' then
			
				s_selected_cpu_index 	<= (others => '0');
				s_x_constraints_width00 <= (others => '0');
				s_y_constraints_width00 <= (others => '0');
				s_x_constraints_width01 <= (others => '0');
				s_y_constraints_width01 <= (others => '0');
				s_x_constraints_width10 <= (others => '0');
				s_y_constraints_width10 <= (others => '0');
				s_x_constraints_width11 <= (others => '0');
				s_y_constraints_width11 <= (others => '0');
				s_x_constraints_width20 <= (others => '0');
				s_y_constraints_width20 <= (others => '0');
				s_x_constraints_width21 <= (others => '0');
				s_y_constraints_width21 <= (others => '0');				
				s_x_constraint 		    <= (others => '0');
				s_y_constraint 		    <= (others => '0');
				s_index_constraint 	    <= (others => '0');
				s_en_constraints		<= '0';
				s_input_source	 		<= '0';				
				s_output_source 		<= (others => '0');
				s_x_constraints((to_integer(unsigned(s_index_constraint))+1)*VEC_SIZE_IMG_WIDTH_16-1 downto to_integer(unsigned(s_index_constraint))*VEC_SIZE_IMG_WIDTH_16)   <= (others => '0');
				s_y_constraints((to_integer(unsigned(s_index_constraint))+1)*VEC_SIZE_IMG_HEIGHT_16-1 downto to_integer(unsigned(s_index_constraint))*VEC_SIZE_IMG_HEIGHT_16) <= (others => '0');
	
			elsif rising_edge(Bus2IP_Clk) then
				if Bus2IP_WrCE(0) = '1' then
					case s_reg_sel is
					    when REG_KP_INDEX =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_selected_cpu_index <= Bus2IP_Data(s_selected_cpu_index'range);
                            end if;
                        when REG_X_CONSTRAINT_WIDTH_00 =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_x_constraints_width00 <= Bus2IP_Data(s_x_constraints_width00'range);    
                            end if;                            
                        when REG_Y_CONSTRAINT_WIDTH_00 =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_y_constraints_width00 <= Bus2IP_Data(s_y_constraints_width00'range);    
                            end if;                            
                        when REG_X_CONSTRAINT_WIDTH_01 =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_x_constraints_width01 <= Bus2IP_Data(s_x_constraints_width01'range);    
                            end if;                            
                        when REG_Y_CONSTRAINT_WIDTH_01 =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_y_constraints_width01 <= Bus2IP_Data(s_y_constraints_width01'range);    
                            end if;                            
                        when REG_X_CONSTRAINT_WIDTH_10 =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_x_constraints_width10 <= Bus2IP_Data(s_x_constraints_width10'range);    
                            end if;                            
                        when REG_Y_CONSTRAINT_WIDTH_10 =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_y_constraints_width10 <= Bus2IP_Data(s_y_constraints_width10'range);    
                            end if;                            
                        when REG_X_CONSTRAINT_WIDTH_11 =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_x_constraints_width11 <= Bus2IP_Data(s_x_constraints_width11'range);    
                            end if;                            
                        when REG_Y_CONSTRAINT_WIDTH_11 =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_y_constraints_width11 <= Bus2IP_Data(s_y_constraints_width11'range);    
                            end if;                            
                        when REG_X_CONSTRAINT_WIDTH_20 =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_x_constraints_width20 <= Bus2IP_Data(s_x_constraints_width20'range);    
                            end if;                            
                        when REG_Y_CONSTRAINT_WIDTH_20 =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_y_constraints_width20 <= Bus2IP_Data(s_y_constraints_width20'range);    
                            end if;                            
                        when REG_X_CONSTRAINT_WIDTH_21 =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_x_constraints_width21 <= Bus2IP_Data(s_x_constraints_width21'range);    
                            end if;                            
                        when REG_Y_CONSTRAINT_WIDTH_21 =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_y_constraints_width21 <= Bus2IP_Data(s_y_constraints_width21'range);    
                            end if;                            
					    when REG_X_CONSTRAINT =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_x_constraint <= Bus2IP_Data(s_x_constraint'range);
                            end if;
                        when REG_Y_CONSTRAINT =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_y_constraint <= Bus2IP_Data(s_y_constraint'range);
                            end if; 
                        when REG_INDEX_CONSTRAINT =>
                            if( Bus2IP_BE(0) = '1' ) then
                                s_index_constraint <= Bus2IP_Data(s_index_constraint'range);
                            end if;
                        when REG_EN_CONSTRAINT =>
                            if( Bus2IP_BE(0) = '1' ) then
                                s_en_constraints <= Bus2IP_Data(0);
                            end if;
                        when REG_INPUT_SOURCE =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_input_source <= Bus2IP_Data(0);
                            end if;
                        when REG_OUTPUT_SOURCE =>
                            if ( Bus2IP_BE(0) = '1' ) then
                                s_output_source <= Bus2IP_Data(s_output_source'range);
                            end if;
						when others => null;
					end case;
				end if;
			
				s_x_constraints((to_integer(unsigned(s_index_constraint))+1)*VEC_SIZE_IMG_WIDTH_16-1 downto to_integer(unsigned(s_index_constraint))*VEC_SIZE_IMG_WIDTH_16) <= s_x_constraint;
				s_y_constraints((to_integer(unsigned(s_index_constraint))+1)*VEC_SIZE_IMG_HEIGHT_16-1 downto to_integer(unsigned(s_index_constraint))*VEC_SIZE_IMG_HEIGHT_16) <= s_y_constraint;			
		
		end if;
		
	end process p_write;

--------------------------------------------------------------------------------
-- Registers read process
--------------------------------------------------------------------------------
 	p_read : process(
        s_reg_sel,
       s_selected_cpu_data, 
       s_selected_cpu_frame_counter, 
 		s_selected_cpu_kp_counter, 
 		s_selected_cpu_kp_x, 
 		s_selected_cpu_kp_y, 
 		s_selected_cpu_kp_value,
 		s_selected_cpu_kp_cstr_tag, 		
 		s_selected_cpu_index,
 		s_x_constraints_width00,
 		s_y_constraints_width00,
 		s_x_constraints_width01,
 		s_y_constraints_width01,
 		s_x_constraints_width10,
 		s_y_constraints_width10,
 		s_x_constraints_width11,
 		s_y_constraints_width11,
 		s_x_constraints_width20,
 		s_y_constraints_width20,
 		s_x_constraints_width21,
 		s_y_constraints_width21,
 		s_x_constraint,
 		s_y_constraint,
 		s_index_constraint,
 		s_en_constraints,
		s_input_source,
 		s_output_source,
	--	 added by Fred 18/06/20
		s_axis_ctrl,
		s_axis_data
	) is
 	begin
 		case s_reg_sel is
 		    when REG_KP_FEATURE         	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_selected_cpu_data), IP2Bus_Data'length));
            when REG_FRAME_COUNTER      	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_selected_cpu_frame_counter), IP2Bus_Data'length));
            when REG_KP_COUNTER         	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_selected_cpu_kp_counter), IP2Bus_Data'length));
            when REG_KP_X               	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_selected_cpu_kp_x), IP2Bus_Data'length));
            when REG_KP_Y               	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_selected_cpu_kp_y), IP2Bus_Data'length));
            when REG_KP_VALUE           	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_selected_cpu_kp_value), IP2Bus_Data'length));
            when REG_KP_CONSTRAINTS_TAG    	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_selected_cpu_kp_cstr_tag), IP2Bus_Data'length));            
            when REG_KP_INDEX           	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_selected_cpu_index), IP2Bus_Data'length));
            when REG_X_CONSTRAINT_WIDTH_00 	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_x_constraints_width00), IP2Bus_Data'length));
            when REG_Y_CONSTRAINT_WIDTH_00 	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_y_constraints_width00), IP2Bus_Data'length));
            when REG_X_CONSTRAINT_WIDTH_01 	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_x_constraints_width01), IP2Bus_Data'length));
            when REG_Y_CONSTRAINT_WIDTH_01 	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_y_constraints_width01), IP2Bus_Data'length));
            when REG_X_CONSTRAINT_WIDTH_10 	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_x_constraints_width10), IP2Bus_Data'length));
            when REG_Y_CONSTRAINT_WIDTH_10 	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_y_constraints_width10), IP2Bus_Data'length));
            when REG_X_CONSTRAINT_WIDTH_11 	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_x_constraints_width11), IP2Bus_Data'length));
            when REG_Y_CONSTRAINT_WIDTH_11 	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_y_constraints_width11), IP2Bus_Data'length));
            when REG_X_CONSTRAINT_WIDTH_20 	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_x_constraints_width20), IP2Bus_Data'length));
            when REG_Y_CONSTRAINT_WIDTH_20 	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_y_constraints_width20), IP2Bus_Data'length));
            when REG_X_CONSTRAINT_WIDTH_21 	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_x_constraints_width21), IP2Bus_Data'length));
            when REG_Y_CONSTRAINT_WIDTH_21 	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_y_constraints_width21), IP2Bus_Data'length));
            when REG_X_CONSTRAINT       	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_x_constraint), IP2Bus_Data'length));
            when REG_Y_CONSTRAINT       	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_y_constraint), IP2Bus_Data'length));
            when REG_INDEX_CONSTRAINT   	=> 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_index_constraint), IP2Bus_Data'length));
            when REG_EN_CONSTRAINT      	=> 	IP2Bus_Data  <=  (0 => s_en_constraints, others => '0');
            when REG_INPUT_SOURCE	      	=> 	IP2Bus_Data  <=  (0 => s_input_source, others => '0');
            when REG_OUTPUT_SOURCE          => 	IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_output_source), IP2Bus_Data'length));
			-- added by Fred 18/06/20
			when REG_AXIS_CTRL				=>  IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_axis_ctrl), IP2Bus_Data'length));
			when REG_S_AXIS_TDATA			=>  IP2Bus_Data  <=  std_logic_vector(resize(unsigned(s_axis_data), IP2Bus_Data'length));
            when others                     => 	IP2Bus_Data  <=  (others => '0'); 
 		end case;
 	end process p_read;

end IMP;
