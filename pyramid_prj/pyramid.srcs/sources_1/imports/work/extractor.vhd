library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.saturn_numeric_pkg.all;
use work.dpram_pkg.all;

entity extractor is
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
end entity extractor;

architecture rtl of extractor is


	function max (left, right: integer) return integer is
	begin
		if left > right then return left;
		else return right;
		end if;
	end max;

	type tab_x_t is array(0 to MAX_SIZE_LIST-1) of std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	type tab_y_t is array(0 to MAX_SIZE_LIST-1) of std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	type tab_addr_t is array(0 to MAX_SIZE_LIST-1) of std_logic_vector(MEMORY_BUS_WIDTH-1 downto 0);
	type tab_data_t is array(0 to MAX_SIZE_LIST-1) of std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
    type tab_index_t is array(0 to MAX_SIZE_LIST-1) of std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
    type tab_cstr_t is array(0 to MAX_SIZE_LIST-1) of std_logic_vector(MAX_SIZE_LIST-1 downto 0);
        
	-- store xy coordinates of a kp to extract
	signal tab_x_to_extract_r : tab_x_t;
	signal tab_x_to_extract_odd_r : tab_x_t;
	signal tab_x_to_extract_even_r : tab_x_t;

	signal tab_y_to_extract_r : tab_y_t;
	signal tab_y_to_extract_odd_r : tab_y_t;
	signal tab_y_to_extract_even_r : tab_y_t;

    signal tab_value_to_extract_r : tab_data_t;
    signal tab_value_to_extract_odd_r : tab_data_t;
    signal tab_value_to_extract_even_r : tab_data_t;

    signal tab_cstr_to_extract_r : tab_cstr_t;
    signal tab_cstr_to_extract_odd_r : tab_cstr_t;
    signal tab_cstr_to_extract_even_r : tab_cstr_t;        

	signal tab_mem_address_s : tab_addr_t;
	signal tab_mem_enable_s : std_logic_vector(0 to MAX_SIZE_LIST-1);
	signal tab_mem_even_enable_s : std_logic_vector(0 to MAX_SIZE_LIST-1);
	signal tab_mem_odd_enable_s : std_logic_vector(0 to MAX_SIZE_LIST-1);

	signal tab_cpu_data_odd_s : tab_data_t;
	signal tab_cpu_data_even_s : tab_data_t;

    signal tab_kp_index_odd_s : tab_index_t;
    signal tab_kp_index_even_s : tab_index_t;
    
	signal cpu_index_remap_s : std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
	signal cpu_index_remap_odd_s : std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
	signal cpu_index_remap_even_s : std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);

	signal kp_counter_odd_s : unsigned(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0) := (others => '0');
	signal kp_counter_even_s : unsigned(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0) := (others => '0');

    signal cpu_kp_counter_odd_s : std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0);
    signal cpu_kp_counter_even_s : std_logic_vector(unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto 0); 

    signal cpu_kp_value_odd_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);        
    signal cpu_kp_value_even_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);  

    signal cpu_kp_x_odd_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);        
    signal cpu_kp_x_even_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);        
	
    signal cpu_kp_y_odd_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);	
    signal cpu_kp_y_even_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);

    signal cpu_kp_cstr_tag_odd_s : std_logic_vector(MAX_SIZE_LIST-1 downto 0);	
    signal cpu_kp_cstr_tag_even_s : std_logic_vector(MAX_SIZE_LIST-1 downto 0);

	signal parity_r : std_logic := '0';	
	signal frame_counter_s : std_logic_vector(31 downto 0) := (others => '0');
	
begin
	xy_ready_o <= '1';
	
	parity_p : process(global_reset_n_i, global_clk_i)
	begin
		if (global_reset_n_i = '0') then
			parity_r <= '0';
		elsif rising_edge(global_clk_i) then
			if (xy_en_i = '1') then
				if ((xy_x_i = std_logic_vector(to_unsigned(IMG_WIDTH-1,xy_x_i'length))) and (xy_y_i = std_logic_vector(to_unsigned(IMG_HEIGHT-1,xy_y_i'length)))) then
					parity_r <= not parity_r;
				end if;
			end if;
		end if;
	end process parity_p;

	frame_counter_p : process(global_reset_n_i, global_clk_i)
	begin
		if (global_reset_n_i = '0') then
			frame_counter_s <= (others => '0');
		elsif rising_edge(global_clk_i) then
			if (xy_en_i = '1') then
				if ((xy_x_i = std_logic_vector(to_unsigned(IMG_WIDTH-1,xy_x_i'length))) and (xy_y_i = std_logic_vector(to_unsigned(IMG_HEIGHT-1,xy_y_i'length)))) then
					frame_counter_s <= std_logic_vector(unsigned(frame_counter_s)+1);
				end if;
			end if;
		end if;
	end process frame_counter_p;

    -- tab_kp_index_s
    tab_kp_index_p : process(global_clk_i)
    begin
        if rising_edge(global_clk_i) then
            if(xy_en_i = '1') then
                if (parity_r = '1') then 
                    for i in 0 to MAX_SIZE_LIST-1 loop
                        tab_kp_index_even_s(i) <= kp_tab_index_i((i+1)*unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto i*unsigned_num_bits(MAX_SIZE_LIST-1));
                    end loop;
                else
                    for i in 0 to MAX_SIZE_LIST-1 loop
                        tab_kp_index_odd_s(i) <= kp_tab_index_i((i+1)*unsigned_num_bits(MAX_SIZE_LIST-1)-1 downto i*unsigned_num_bits(MAX_SIZE_LIST-1));
                    end loop;                
                end if;
            end if;
        end if;
    end process tab_kp_index_p;

    kp_counter_p : process(global_clk_i)
    begin
		if rising_edge(global_clk_i) then
		    if (xy_en_i = '1') then
				if ((xy_x_i = std_logic_vector(to_unsigned(IMG_WIDTH-1,xy_x_i'length))) and (xy_y_i = std_logic_vector(to_unsigned(IMG_HEIGHT-1,xy_y_i'length)))) then
					if (parity_r = '1') then
						kp_counter_odd_s <= (others => '0');
					else
						kp_counter_even_s <= (others => '0');
					end if;
				elsif kp_new_i = '1' then
					if (parity_r = '1') then
						if (to_integer(kp_counter_even_s) < MAX_SIZE_LIST) then
							kp_counter_even_s <= kp_counter_even_s + 1;
						end if;
					else
						if (to_integer(kp_counter_odd_s) < MAX_SIZE_LIST) then
							kp_counter_odd_s <= kp_counter_odd_s + 1;
						end if;
					end if;
				end if;
			end if;
		end if;    
    end process kp_counter_p;

    tab_kp_x_y_value_p : process(global_clk_i)
    begin
        if rising_edge(global_clk_i) then
            if (xy_en_i = '1') then
                if (parity_r = '1') then
                    tab_x_to_extract_even_r <= tab_x_to_extract_r;
                    tab_y_to_extract_even_r <= tab_y_to_extract_r;
                    tab_value_to_extract_even_r <= tab_value_to_extract_r;  
                    tab_cstr_to_extract_even_r <= tab_cstr_to_extract_r;       
                else
                    tab_x_to_extract_odd_r <= tab_x_to_extract_r;
                    tab_y_to_extract_odd_r <= tab_y_to_extract_r;
                    tab_value_to_extract_odd_r <= tab_value_to_extract_r;                 
                    tab_cstr_to_extract_odd_r <= tab_cstr_to_extract_r; 
                end if;                
            end if;
        end if;
    end process tab_kp_x_y_value_p;

	-- MAX_SIZE_LIST extractions occurs in parallel
	-- kp_index_i drives which extractor the coordinates are sent to
	extractors_g : for i in 0 to MAX_SIZE_LIST-1 generate
		-- store the (x,y) coordinates
		coordinantes_p : process(global_reset_n_i, global_clk_i)
		begin
			if (global_reset_n_i = '0') then
				tab_x_to_extract_r(i) <= (others => '0');
				tab_y_to_extract_r(i) <= (others => '0');
				tab_value_to_extract_r(i) <= (others => '0');
				tab_cstr_to_extract_r(i) <= (others => '0');
			elsif rising_edge(global_clk_i) then
				if (kp_new_i = '1') then
					if (kp_index_i = std_logic_vector(to_unsigned(i, kp_index_i'length))) then
						tab_x_to_extract_r(i) <= kp_x_i;
						tab_y_to_extract_r(i) <= kp_y_i;
						tab_value_to_extract_r(i) <= kp_value_i;
						tab_cstr_to_extract_r(i) <= kp_constraints_i;
					end if;
				end if;
			end if;
		end process coordinantes_p;

		-- check if the video flux' coordinates match
		-- transform the coordinates to a valid address
		addr_gen_p : process(
				xy_x_i,
				tab_x_to_extract_r(i),
				xy_y_i,
				tab_y_to_extract_r(i)
			)
			variable x_mem : unsigned(max(MEMORY_BUS_WIDTH,xy_x_i'length)-1 downto 0);
			variable y_mem : unsigned(max(MEMORY_BUS_WIDTH,xy_y_i'length)-1 downto 0);
			variable feature_width : unsigned(unsigned_num_bits(2*FEATURE_RADIUS+1)-1 downto 0) := to_unsigned(2*FEATURE_RADIUS+1,unsigned_num_bits(2*FEATURE_RADIUS+1));
			variable y_mem_mult : unsigned(y_mem'length+unsigned_num_bits(2*FEATURE_RADIUS+1)-1 downto 0);
		begin
			-- if current pixel is within current extractor's feature
			if (
				unsigned(xy_x_i) >= unsigned(tab_x_to_extract_r(i)) - to_unsigned(FEATURE_RADIUS, xy_x_i'length) and 
				unsigned(xy_x_i) <= unsigned(tab_x_to_extract_r(i)) + to_unsigned(FEATURE_RADIUS, xy_x_i'length) and 
				unsigned(xy_y_i) >= unsigned(tab_y_to_extract_r(i)) - to_unsigned(FEATURE_RADIUS, xy_y_i'length) and 
				unsigned(xy_y_i) <= unsigned(tab_y_to_extract_r(i)) + to_unsigned(FEATURE_RADIUS, xy_y_i'length)) then
				tab_mem_enable_s(i) <= '1';
			else
				tab_mem_enable_s(i) <= '0';
			end if;

			-- address generation
			-- with fine tuning, hehe
			x_mem := resize(unsigned(xy_x_i), x_mem'length) - resize(unsigned(tab_x_to_extract_r(i)), x_mem'length) + to_unsigned(FEATURE_RADIUS, x_mem'length);
			y_mem := resize(unsigned(xy_y_i), y_mem'length) - resize(unsigned(tab_y_to_extract_r(i)), y_mem'length) + to_unsigned(FEATURE_RADIUS, y_mem'length);
			y_mem_mult := y_mem * feature_width;

			tab_mem_address_s(i) <= std_logic_vector(y_mem_mult(tab_mem_address_s(i)'range) + x_mem(tab_mem_address_s(i)'range));
		end process addr_gen_p;

		-- store the feature
		tab_mem_even_enable_s(i) <= tab_mem_enable_s(i) and parity_r;
		tab_mem_odd_enable_s(i) <= tab_mem_enable_s(i) and (not parity_r);

		ram_even : dpram 
			generic map (
				ADDRESS_WIDTH => MEMORY_BUS_WIDTH,
				DATA_WIDTH => unsigned_num_bits(MAX_COLOR)
			)
			port map (
				clk_i => global_clk_i,
				reset_n_i => global_reset_n_i,
			
				read_address_i => cpu_addr_i,
				read_data_o => tab_cpu_data_even_s(i),

				write_enable_i => tab_mem_even_enable_s(i),
				write_address_i => tab_mem_address_s(i),
				write_data_i => xy_data_i
			);

		ram_odd : dpram 
			generic map (
				ADDRESS_WIDTH => MEMORY_BUS_WIDTH,
				DATA_WIDTH => unsigned_num_bits(MAX_COLOR)
			)
			port map (
				clk_i => global_clk_i,
				reset_n_i => global_reset_n_i,
			
				read_address_i => cpu_addr_i,
				read_data_o => tab_cpu_data_odd_s(i),
		
				write_enable_i => tab_mem_odd_enable_s(i),
				write_address_i => tab_mem_address_s(i),
				write_data_i => xy_data_i
			);
	end generate extractors_g;

	cpu_frame_counter_o <= frame_counter_s;
    
	cpu_index_remap_odd_s <= tab_kp_index_odd_s(to_integer(unsigned(cpu_index_i)));
	cpu_index_remap_even_s <= tab_kp_index_even_s(to_integer(unsigned(cpu_index_i)));
    cpu_index_remap_s <= cpu_index_remap_even_s when (parity_r = '0') else cpu_index_remap_odd_s;
    
	cpu_data_o <= tab_cpu_data_even_s(to_integer(unsigned(cpu_index_remap_s))) when (parity_r = '0') else tab_cpu_data_odd_s(to_integer(unsigned(cpu_index_remap_s)));	
	
	cpu_kp_counter_odd_s <= std_logic_vector(kp_counter_odd_s);
	cpu_kp_counter_even_s <= std_logic_vector(kp_counter_even_s);
	cpu_kp_counter_o <= cpu_kp_counter_even_s when (parity_r = '0') else cpu_kp_counter_odd_s;
	
	cpu_kp_value_odd_s <= tab_value_to_extract_odd_r(to_integer(unsigned(cpu_index_remap_s)));
	cpu_kp_value_even_s <= tab_value_to_extract_even_r(to_integer(unsigned(cpu_index_remap_s)));	
	cpu_kp_value_o <= cpu_kp_value_even_s when (parity_r = '0') else cpu_kp_value_odd_s;

    cpu_kp_x_odd_s <= tab_x_to_extract_odd_r(to_integer(unsigned(cpu_index_remap_s)));
    cpu_kp_x_even_s <= tab_x_to_extract_even_r(to_integer(unsigned(cpu_index_remap_s)));
    cpu_kp_x_o <= cpu_kp_x_even_s when (parity_r = '0') else cpu_kp_x_odd_s;

    cpu_kp_y_odd_s <= tab_y_to_extract_odd_r(to_integer(unsigned(cpu_index_remap_s)));
    cpu_kp_y_even_s <= tab_y_to_extract_even_r(to_integer(unsigned(cpu_index_remap_s)));
    cpu_kp_y_o <= cpu_kp_y_even_s when (parity_r = '0') else cpu_kp_y_odd_s;

    cpu_kp_cstr_tag_odd_s <= tab_cstr_to_extract_odd_r(to_integer(unsigned(cpu_index_remap_s)));
    cpu_kp_cstr_tag_even_s <= tab_cstr_to_extract_even_r(to_integer(unsigned(cpu_index_remap_s)));
    cpu_kp_cstr_tag_o <= cpu_kp_cstr_tag_even_s when (parity_r = '0') else cpu_kp_cstr_tag_odd_s;
	

end architecture rtl;
