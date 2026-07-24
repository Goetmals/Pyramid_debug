library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.saturn_numeric_pkg.all;

package sort_pkg is
	component sort is
		generic (
			pixel_bus_width : natural := 17;
			max_size_list : natural := 32;
			w_img : natural := 640;
			h_img : natural := 480
		);
		port (
			clk : in std_logic;
			reset_n : in std_logic;
			EN : in std_logic;
			sort : in std_logic;
			data_in : in std_logic_vector (pixel_bus_width-1 downto 0);
			constraints_tag_in : in std_logic_vector(max_size_list-1 downto 0);
			xin : in std_logic_vector (unsigned_num_bits(w_img-1)-1 downto 0);
			yin : in std_logic_vector (unsigned_num_bits(h_img-1)-1 downto 0);

			EN_out : out std_logic;
			new_keypoint : out std_logic;
			keypoint_value : out std_logic_vector (pixel_bus_width-1 downto 0);
			keypoint_constraints : out std_logic_vector (max_size_list-1 downto 0);
			keypoint_x : out std_logic_vector (unsigned_num_bits(w_img-1)-1 downto 0);
			keypoint_y : out std_logic_vector (unsigned_num_bits(h_img-1)-1 downto 0);
			keypoint_index : out  std_logic_vector (UNSIGNED_NUM_BITS(max_size_list-1)-1 downto 0);
			tab_index : out std_logic_vector (max_size_list * UNSIGNED_NUM_BITS(max_size_list-1)-1 downto 0);
			tab_x : out std_logic_vector (max_size_list * unsigned_num_bits(w_img-1)-1 downto 0);
			tab_y : out std_logic_vector (max_size_list * unsigned_num_bits(h_img-1)-1 downto 0)
	    );
	end component sort;
end package sort_pkg;
