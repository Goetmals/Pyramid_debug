library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.saturn_numeric_pkg.all;

entity xy_delay is
	generic (
		DELAY_X : natural := 1;
		DELAY_Y : natural := 0;
		IMG_WIDTH : positive := 16;
		IMG_HEIGHT : positive := 9
	);
	port (
		global_clk_i : in std_logic;
		global_resetn_i : in std_logic;

		xy_en_i : in std_logic;
		xy_x_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
		xy_y_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);

		xy_en_o : out std_logic;
		xy_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
		xy_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0)
	);
end entity xy_delay;

architecture rtl of xy_delay is
	signal delay_x_follow_s : std_logic_vector(xy_x_i'range);
	signal delay_y_follow_s : std_logic_vector(xy_y_i'range);

	type state_t is (ST_WAIT, ST_FOLLOW, ST_END);
	
	signal state_current_r : state_t := ST_WAIT;
	signal state_next_s : state_t;

	signal xy_en_s : std_logic;
	signal xy_x_r : unsigned(xy_x_o'range) := (others => '0');
	signal xy_y_r : unsigned(xy_y_o'range) := (others => '0');
begin
	delay_x_follow_g0 : if (DELAY_X = 0) generate
		delay_x_follow_s <= std_logic_vector(to_unsigned(IMG_WIDTH-1, delay_x_follow_s'length));
	end generate delay_x_follow_g0;
	delay_x_follow_g1 : if (DELAY_X /= 0) generate
		delay_x_follow_s <= std_logic_vector(to_unsigned(DELAY_X-1,xy_x_i'length));
	end generate delay_x_follow_g1;

	delay_y_follow_g0 : if (DELAY_X = 0) generate
		delay_y_follow_s <= std_logic_vector(to_unsigned(DELAY_Y-1,xy_y_i'length));
	end generate delay_y_follow_g0;
	delay_y_follow_g1 : if (DELAY_X /= 0) generate
		delay_y_follow_s <= std_logic_vector(to_unsigned(DELAY_Y,xy_y_i'length));
	end generate delay_y_follow_g1;

	state_current_p : process(global_clk_i, global_resetn_i)
	begin
		if (global_resetn_i = '0') then
			state_current_r <= ST_WAIT;
		elsif rising_edge(global_clk_i) then
			state_current_r <= state_next_s;
		end if;
	end process state_current_p;

	state_next_p : process(state_current_r, xy_en_i, xy_x_i, xy_y_i, xy_x_r, xy_y_r)
	begin
		case state_current_r is
			when ST_WAIT =>
				if ((xy_x_i = delay_x_follow_s) and (xy_y_i = delay_y_follow_s) and (xy_en_i = '1')) then
					state_next_s <= ST_FOLLOW;
				else
					state_next_s <= ST_WAIT;
				end if;
			when ST_FOLLOW =>
				if ((xy_x_i = std_logic_vector(to_unsigned(IMG_WIDTH-1,xy_x_i'length))) and (xy_y_i = std_logic_vector(to_unsigned(IMG_HEIGHT-1,xy_y_i'length)))) then
					state_next_s <= ST_END;
				else
					state_next_s <= ST_FOLLOW;
				end if;
			when ST_END =>
				if ((xy_x_r = to_unsigned(IMG_WIDTH-1,xy_x_r'length)) and (xy_y_r = to_unsigned(IMG_HEIGHT-1,xy_y_r'length))) then
					state_next_s <= ST_WAIT;
				else
					state_next_s <= ST_END;
				end if;
			when others =>
				state_next_s <= ST_WAIT;
		end case;
	end process state_next_p;

	xy_en_p : process(state_current_r, xy_en_i)
	begin
		if (state_current_r = ST_FOLLOW) then
			xy_en_s <= xy_en_i;
		elsif (state_current_r = ST_END) then
			xy_en_s <= '1';
		else 
			xy_en_s <= '0';
		end if;
	end process xy_en_p;

	xy_p : process(global_clk_i, global_resetn_i)
	begin
		if (global_resetn_i = '0') then
			xy_x_r <= (others => '0');
			xy_y_r <= (others => '0');
		elsif rising_edge(global_clk_i) then
			if (xy_en_s = '1') then
				if (xy_x_r = to_unsigned(IMG_WIDTH-1,xy_x_r'length)) then
					xy_x_r <= (others => '0');
					if (xy_y_r = to_unsigned(IMG_HEIGHT-1, xy_y_r'length)) then
						xy_y_r <= (others => '0');
					else
						xy_y_r <= xy_y_r + 1;
					end if;
				else
					xy_x_r <= xy_x_r + 1;
				end if;
			end if;
		end if;
	end process xy_p;

	xy_en_o <= xy_en_s;
	xy_x_o <= std_logic_vector(xy_x_r);
	xy_y_o <= std_logic_vector(xy_y_r);
end architecture rtl;
