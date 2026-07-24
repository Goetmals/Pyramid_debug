library ieee;
use ieee.std_logic_1164.all;

library work;
use work.saturn_numeric_pkg.all;

package search_pkg is
	component search is
		generic (
			BUS_WIDTH : positive := 16;
			RADIUS : real := 10.0;
			W_IMG : positive := 640;
			H_IMG : positive := 480;
	
			MAX_SIZE_LIST : natural := 32
		);
		port (
			i_clk : in std_logic;
			i_reset_n : in std_logic;
	
			i_en : in std_logic;
			i_data : in std_logic_vector(BUS_WIDTH-1 downto 0);
			i_x : in std_logic_vector(unsigned_num_bits(W_IMG-1)-1 downto 0);
			i_y : in std_logic_vector(unsigned_num_bits(H_IMG-1)-1 downto 0);
			i_threshold : in std_logic_vector(BUS_WIDTH-1 downto 0);
	
			o_en : out std_logic;
			o_new_keypoint : out std_logic;
			o_data : out std_logic_vector(BUS_WIDTH-1 downto 0);
			o_x : out std_logic_vector(unsigned_num_bits(W_IMG-1)-1 downto 0);
			o_y : out std_logic_vector(unsigned_num_bits(H_IMG-1)-1 downto 0);
	
			-- latches the x,y constraints
			i_constraints_en : in std_logic;
			-- the constraints itselves
			i_x_constraints : in std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(W_IMG-1)-1 downto 0);
			i_y_constraints : in std_logic_vector(MAX_SIZE_LIST*unsigned_num_bits(H_IMG-1)-1 downto 0);
			-- the width of the constraints
			i_x_constraints_width : in std_logic_vector(unsigned_num_bits(W_IMG-1)-1 downto 0);
			i_y_constraints_width : in std_logic_vector(unsigned_num_bits(H_IMG-1)-1 downto 0);
			-- a list of which coordinates allowed the kp
			o_constraints_tag : out std_logic_vector(MAX_SIZE_LIST-1 downto 0)
		);
	end component search;
end package search_pkg;
