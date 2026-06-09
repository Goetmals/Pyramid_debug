----------------------------------------------------------------------------------
-- Company: ETIS Laboratory
-- Engineers: Thomas Lefebvre and Yohan Borges
-- 
-- Module Name:    sort
--
-- Description: Sorting of pixels by their values.
-- the output contains only the coordinates of the pixel, because the application
-- doesn't need the pixel value.
--
-- Parameters : N_keypoints_per_DoG - maximum size of the sorted list
--              bus_width - width of pixel data bus
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.saturn_numeric_pkg.all;

entity sort is
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
end entity sort;

architecture Behavioral of sort is
type tab_v_t is array(0 to max_size_list-1) of std_logic_vector(pixel_bus_width-1 downto 0);
type tab_c_t is array(0 to max_size_list-1) of std_logic_vector(max_size_list-1 downto 0);
type tab_x_t is array(0 to max_size_list-1) of std_logic_vector(unsigned_num_bits(w_img-1)-1 downto 0);
type tab_y_t is array(0 to max_size_list-1) of std_logic_vector(unsigned_num_bits(h_img-1)-1 downto 0);
type tab_i_t is array(0 to max_size_list-1) of std_logic_vector(UNSIGNED_NUM_BITS(max_size_list-1)-1 downto 0);
-- lists of keypoint values and coordinates
signal tab_sort_valeur: tab_v_t := (others => (others => '0'));
signal tab_sort_constraints: tab_c_t := (others => (others => '0'));
signal tab_sort_x:      tab_x_t := (others => (others => '0'));
signal tab_sort_y:      tab_y_t := (others => (others => '0'));
signal tab_sort_i:		tab_i_t := (others => (others => '0'));
signal tab_new_keypoint: std_logic_vector(0 to max_size_list-1);

signal s_en : std_logic := '0';

-- http://www.velocityreviews.com/forums/t546678-possible-to-generate-individual-cases-within-a-case-statement.html
-- represent highest-1s bit position with an integer;
-- value -1 means no 1s at all (bits=0); value 0 means
-- only the least significant bit is set; value 1 means
-- the next-more significant bit is set (000...00010 or 11).
-- Synthesis will work out how many bits are needed for this.
--~ subtype bit_position is integer range -1 to tab_new_keypoint'length-1;

--~ -- Function to calculate highest-1s bit position
--~ function top_1_bit(bits: std_logic_vector) return bit_position
--~ is
	--~ variable b: std_logic_vector(0 to bits'length-1);
	--~ variable result: bit_position;
--~ begin
	--~ b := bits;
	--~ result := -1;
	--~ for i in b'range loop
		--~ if b(i) = '1' then
			--~ result := i;
		--~ end if;
	--~ end loop;
	--~ return result;
--~ end;

begin

-- Sort the upper element of the list.
	process(clk,reset_n)
	begin
		if (reset_n = '0') then
			tab_sort_valeur(0) <= (others => '0');
			tab_sort_constraints(0) <= (others => '0');
			tab_sort_x(0) <= (others => '0');
			tab_sort_y(0) <= (others => '0');
			tab_sort_i(0) <= (others => '0');
			tab_new_keypoint(0) <= '0';
		elsif (rising_edge(clk)) then
			if (xin = std_logic_vector(to_unsigned(1, xin'length))) and (yin = std_logic_vector(to_unsigned(1, yin'length))) then
				tab_sort_valeur(0) <= (others => '0');
				tab_sort_constraints(0) <= (others => '0');
				tab_sort_x(0)      <= (others => '0');
				tab_sort_y(0)      <= (others => '0');
				tab_sort_i(0)		 <= (others => '0');
				tab_new_keypoint(0) <= '0';
			else
				if(EN = '1') then
					if(data_in>tab_sort_valeur(0) and sort = '1') then
						tab_sort_valeur(0) <= data_in;
						tab_sort_constraints(0) <= constraints_tag_in;
						tab_sort_x(0)      <= xin;
						tab_sort_y(0)      <= yin;
						tab_sort_i(0)		 <= tab_sort_i(max_size_list-1);
						tab_new_keypoint(0) <= '1';
					else
						tab_new_keypoint(0) <= '0';
					end if;
				end if;
			end if;
		end if;
	end process;

-- Sort the rest of the list.
	gen_sort: for i in 1 to max_size_list-1 generate
		process(clk,reset_n)
		begin
			if (reset_n = '0') then
				tab_sort_valeur(i) <= (others => '0');
				tab_sort_constraints(i)      <= (others => '0');
				tab_sort_x(i)      <= (others => '0');
				tab_sort_y(i)      <= (others => '0');
				tab_sort_i(i)		 <= std_logic_vector(to_unsigned(i, UNSIGNED_NUM_BITS(max_size_list-1)));
				tab_new_keypoint(i) <= '0';
			elsif(rising_edge(clk)) then
				if (xin = std_logic_vector(to_unsigned(1, unsigned_num_bits(w_img-1)))) and (yin = std_logic_vector(to_unsigned(1, unsigned_num_bits(h_img-1)))) then
					tab_sort_valeur(i) <= (others => '0');
					tab_sort_constraints(i)      <= (others => '0');
					tab_sort_x(i)      <= (others => '0');
					tab_sort_y(i)      <= (others => '0');
					tab_sort_i(i)		 <= std_logic_vector(to_unsigned(i, UNSIGNED_NUM_BITS(max_size_list-1)));
					tab_new_keypoint(i) <= '0';
				else
					if(EN='1') then
						if(data_in>tab_sort_valeur(i) and sort = '1') then
							if(data_in>tab_sort_valeur(i-1)) then
								tab_sort_valeur(i) <= tab_sort_valeur(i-1);
								tab_sort_constraints(i)      <= tab_sort_constraints(i-1);
								tab_sort_x(i)      <= tab_sort_x(i-1);
								tab_sort_y(i)      <= tab_sort_y(i-1);
								tab_sort_i(i)		 <= tab_sort_i(i-1);
								tab_new_keypoint(i) <= '0';
							else
								tab_sort_valeur(i) <= data_in;
								tab_sort_constraints(i)      <= constraints_tag_in;
								tab_sort_x(i)      <= xin;
								tab_sort_y(i)      <= yin;
								tab_sort_i(i)		 <= tab_sort_i(max_size_list-1);
								tab_new_keypoint(i) <= '1';
							end if;
						else
							tab_new_keypoint(i) <= '0';
						end if;
					end if;
				end if;
			end if;
		end process;
	end generate gen_sort;

	gTabs : for i in 0 to max_size_list-1 generate
	--tab_index <= tab_sort_i;
		tab_index((i+1)*unsigned_num_bits(max_size_list-1)-1 downto i*unsigned_num_bits(max_size_list-1)) <= tab_sort_i(i);
		tab_x((i+1)*unsigned_num_bits(w_img-1)-1 downto i*unsigned_num_bits(w_img-1)) <= tab_sort_x(i);
		tab_y((i+1)*unsigned_num_bits(h_img-1)-1 downto i*unsigned_num_bits(h_img-1)) <= tab_sort_y(i);
	end generate gTabs;

-- Outputs the new key point
	process(tab_sort_valeur, tab_new_keypoint)
		variable position : integer;
	begin
		position :=	top_1_bit(tab_new_keypoint);
		if (position = -1) then
			new_keypoint <= '0';
			keypoint_value <= (others => '0');
			keypoint_constraints <= (others => '0');
			keypoint_x <= (others => '0');
			keypoint_y <= (others => '0');
			keypoint_index <= (others => '0');
		else
			new_keypoint <= '1';
			keypoint_value <= tab_sort_valeur(position);
			keypoint_constraints <= tab_sort_constraints(position);
			keypoint_x <= tab_sort_x(position);
			keypoint_y <= tab_sort_y(position);
			keypoint_index <= tab_sort_i(position);
		end if;
	end process;

	p_en : process(clk,reset_n)
	begin
		if (reset_n = '0') then
			s_en <= '0';
		elsif rising_edge(clk) then
			if (EN = '1') then
				s_en <= '1';
			end if;
		end if;
	end process p_en;
	EN_out <= EN and s_en;
end Behavioral;
