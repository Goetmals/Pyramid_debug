library ieee;
use ieee.std_logic_1164.all;

library work;
use work.saturn_numeric_pkg.all;
use work.pyramid_pkg.all;
use work.dog_pkg.all;
use work.delay_pkg.all;

entity pyramid_dog is
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
		
		xy_grad10_en_o : out std_logic;
		xy_grad10_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
		xy_grad10_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
		xy_grad10_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		
		xy_grad11_en_o : out std_logic;
		xy_grad11_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH/2-1)-1 downto 0);
		xy_grad11_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT/2-1)-1 downto 0);
		xy_grad11_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		
		xy_grad20_en_o : out std_logic;
		xy_grad20_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
		xy_grad20_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);
		xy_grad20_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		
		xy_grad21_en_o : out std_logic;
		xy_grad21_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH/4-1)-1 downto 0);
		xy_grad21_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT/4-1)-1 downto 0);
		xy_grad21_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	
		xy_dog00_en_o : out std_logic;
		xy_dog00_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
		xy_dog00_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
		xy_dog00_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	
		xy_dog01_en_o : out std_logic;
		xy_dog01_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
		xy_dog01_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
		xy_dog01_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	
		xy_dog10_en_o : out std_logic;
		xy_dog10_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
		xy_dog10_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
		xy_dog10_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	
		xy_dog11_en_o : out std_logic;
		xy_dog11_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
		xy_dog11_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
		xy_dog11_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	
		xy_dog20_en_o : out std_logic;
		xy_dog20_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
		xy_dog20_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
		xy_dog20_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		
		xy_dog21_en_o : out std_logic;
		xy_dog21_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
		xy_dog21_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
		xy_dog21_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0)
	);
end entity pyramid_dog;

architecture rtl of pyramid_dog is
	constant kernel_width : natural := 9;
	constant GAUSS_DELAY_X_C : natural := kernel_width/2+2;--+4;--4 + (kernel_width-2);
	constant GAUSS_DELAY_Y_C : natural := kernel_width/2;

	signal delay00_data_out_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal delay01_data_out_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal delay10_data_out_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal delay11_data_out_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal delay20_data_out_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	signal delay21_data_out_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_gauss00_en_s : std_logic;
	signal xy_gauss00_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal xy_gauss00_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal xy_gauss00_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_gauss01_en_s : std_logic;
	signal xy_gauss01_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal xy_gauss01_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal xy_gauss01_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_gauss02_en_s : std_logic;
	signal xy_gauss02_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal xy_gauss02_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal xy_gauss02_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_subsample0_en_s : std_logic;
	signal xy_subsample0_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
	signal xy_subsample0_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
	signal xy_subsample0_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_gauss10_en_s : std_logic;
	signal xy_gauss10_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
	signal xy_gauss10_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
	signal xy_gauss10_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_gauss11_en_s : std_logic;
	signal xy_gauss11_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
	signal xy_gauss11_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
	signal xy_gauss11_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_subsample1_en_s : std_logic;
	signal xy_subsample1_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
	signal xy_subsample1_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
	signal xy_subsample1_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_gauss20_en_s : std_logic;
	signal xy_gauss20_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
	signal xy_gauss20_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
	signal xy_gauss20_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal xy_gauss21_en_s : std_logic;
	signal xy_gauss21_x_s : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
	signal xy_gauss21_y_s : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
	signal xy_gauss21_data_s : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

		
begin

	xy_grad01_en_o <= xy_gauss01_en_s;
	xy_grad01_x_o <= xy_gauss01_x_s;
	xy_grad01_y_o <= xy_gauss01_y_s;
	xy_grad01_data_o <= xy_gauss01_data_s;

	xy_grad10_en_o <= xy_subsample0_en_s;
	xy_grad10_x_o <= xy_subsample0_x_s;
	xy_grad10_y_o <= xy_subsample0_y_s;
	xy_grad10_data_o <= xy_subsample0_data_s;

	xy_grad11_en_o <= xy_gauss10_en_s;
	xy_grad11_x_o <= xy_gauss10_x_s;
	xy_grad11_y_o <= xy_gauss10_y_s;
	xy_grad11_data_o <= xy_gauss10_data_s;

	xy_grad20_en_o <= xy_subsample1_en_s;
	xy_grad20_x_o <= xy_subsample1_x_s;
	xy_grad20_y_o <= xy_subsample1_y_s;
	xy_grad20_data_o <= xy_subsample1_data_s;

	xy_grad21_en_o <= xy_gauss20_en_s;
	xy_grad21_x_o <= xy_gauss20_x_s;
	xy_grad21_y_o <= xy_gauss20_y_s;
	xy_grad21_data_o <= xy_gauss20_data_s;

	pyramid_inst : component pyramid
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
	
			xy_grad_en_o => xy_grad00_en_o,
			xy_grad_x_o => xy_grad00_x_o,
			xy_grad_y_o => xy_grad00_y_o,
			xy_grad_data_o => xy_grad00_data_o,
			xy_grad_ready_i => '1',
	
			xy_gauss00_en_o => xy_gauss00_en_s,
			xy_gauss00_x_o => xy_gauss00_x_s,
			xy_gauss00_y_o => xy_gauss00_y_s,
			xy_gauss00_data_o => xy_gauss00_data_s,
			xy_gauss00_ready_i => '1',
	
			xy_gauss01_en_o => xy_gauss01_en_s,
			xy_gauss01_x_o => xy_gauss01_x_s,
			xy_gauss01_y_o => xy_gauss01_y_s,
			xy_gauss01_data_o => xy_gauss01_data_s,
			xy_gauss01_ready_i => '1',
	
			xy_gauss02_en_o => xy_gauss02_en_s,
			xy_gauss02_x_o => xy_gauss02_x_s,
			xy_gauss02_y_o => xy_gauss02_y_s,
			xy_gauss02_data_o => xy_gauss02_data_s,
			xy_gauss02_ready_i => '1',
	
			xy_subsample0_en_o => xy_subsample0_en_s,
			xy_subsample0_x_o => xy_subsample0_x_s,
			xy_subsample0_y_o => xy_subsample0_y_s,
			xy_subsample0_data_o => xy_subsample0_data_s,
			xy_subsample0_ready_i => '1',
	
			xy_gauss10_en_o => xy_gauss10_en_s,
			xy_gauss10_x_o => xy_gauss10_x_s,
			xy_gauss10_y_o => xy_gauss10_y_s,
			xy_gauss10_data_o => xy_gauss10_data_s,
			xy_gauss10_ready_i => '1',
	
			xy_gauss11_en_o => xy_gauss11_en_s,
			xy_gauss11_x_o => xy_gauss11_x_s,
			xy_gauss11_y_o => xy_gauss11_y_s,
			xy_gauss11_data_o => xy_gauss11_data_s,
			xy_gauss11_ready_i => '1',
	
			xy_subsample1_en_o => xy_subsample1_en_s,
			xy_subsample1_x_o => xy_subsample1_x_s,
			xy_subsample1_y_o => xy_subsample1_y_s,
			xy_subsample1_data_o => xy_subsample1_data_s,
			xy_subsample1_ready_i => '1',
	
			xy_gauss20_en_o => xy_gauss20_en_s,
			xy_gauss20_x_o => xy_gauss20_x_s,
			xy_gauss20_y_o => xy_gauss20_y_s,
			xy_gauss20_data_o => xy_gauss20_data_s,
			xy_gauss20_ready_i => '1',
	
			xy_gauss21_en_o => xy_gauss21_en_s,
			xy_gauss21_x_o => xy_gauss21_x_s,
			xy_gauss21_y_o => xy_gauss21_y_s,
			xy_gauss21_data_o => xy_gauss21_data_s,
			xy_gauss21_ready_i => '1'
		);


	delay00 : component delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT,
			delay_x => GAUSS_DELAY_X_C,
			delay_y => GAUSS_DELAY_Y_C
		)
		port map (
			clk => global_clk_i,
			EN => xy_gauss00_en_s,
			data_in => xy_gauss00_data_s,
			data_out => delay00_data_out_s
		);

	dog00 : component dog
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1),
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)
		)
		port map (
			clk => global_clk_i,
			EN => xy_gauss01_en_s,
			EN_out => xy_dog00_en_o,
			xin => xy_gauss01_x_s,
			yin => xy_gauss01_y_s,
			xout => xy_dog00_x_o,
			yout => xy_dog00_y_o,
			data_in_a => xy_gauss01_data_s,
			data_in_b => delay00_data_out_s,
			data_out => xy_dog00_data_o
		);


	delay01 : component delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT,
			delay_x => GAUSS_DELAY_X_C,
			delay_y => GAUSS_DELAY_Y_C
		)
		port map (
			clk => global_clk_i,
			EN => xy_gauss01_en_s,
			data_in => xy_gauss01_data_s,
			data_out => delay01_data_out_s
		);

	dog01 : component dog
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1),
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)
		)
		port map (
			clk => global_clk_i,
			EN => xy_gauss02_en_s,
			EN_out => xy_dog01_en_o,
			xin => xy_gauss02_x_s,
			yin => xy_gauss02_y_s,
			xout => xy_dog01_x_o,
			yout => xy_dog01_y_o,
			data_in_a => xy_gauss02_data_s,
			data_in_b => delay01_data_out_s,
			data_out => xy_dog01_data_o
		);


	delay10 : component delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2,
			delay_x => GAUSS_DELAY_X_C,
			delay_y => GAUSS_DELAY_Y_C
		)
		port map (
			clk => global_clk_i,
			EN => xy_subsample0_en_s,
			data_in => xy_subsample0_data_s,
			data_out => delay10_data_out_s
		);

	dog10 : component dog
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1)-1,
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)-1
		)
		port map (
			clk => global_clk_i,
			EN => xy_gauss10_en_s,
			EN_out => xy_dog10_en_o,
			xin => xy_gauss10_x_s,
			yin => xy_gauss10_y_s,
			xout => xy_dog10_x_o,
			yout => xy_dog10_y_o,
			data_in_a => xy_gauss10_data_s,
			data_in_b => delay10_data_out_s,
			data_out => xy_dog10_data_o
		);


	delay11 : component delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2,
			delay_x => GAUSS_DELAY_X_C,
			delay_y => GAUSS_DELAY_Y_C
		)
		port map (
			clk => global_clk_i,
			EN => xy_gauss10_en_s,
			data_in => xy_gauss10_data_s,
			data_out => delay11_data_out_s
		);

	dog11 : component dog
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1)-1,
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)-1
		)
		port map (
			clk => global_clk_i,
			EN => xy_gauss11_en_s,
			EN_out => xy_dog11_en_o,
			xin => xy_gauss11_x_s,
			yin => xy_gauss11_y_s,
			xout => xy_dog11_x_o,
			yout => xy_dog11_y_o,
			data_in_a => xy_gauss11_data_s,
			data_in_b => delay11_data_out_s,
			data_out => xy_dog11_data_o
		);


	delay20 : component delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/4,
			h_img => IMG_HEIGHT/4,
			delay_x => GAUSS_DELAY_X_C,
			delay_y => GAUSS_DELAY_Y_C
		)
		port map (
			clk => global_clk_i,
			EN => xy_subsample1_en_s,
			data_in => xy_subsample1_data_s,
			data_out => delay20_data_out_s
		);

	dog20 : component dog
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/4,
			h_img => IMG_HEIGHT/4,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1)-2,
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)-2
		)
		port map (
			clk => global_clk_i,
			EN => xy_gauss20_en_s,
			EN_out => xy_dog20_en_o,
			xin => xy_gauss20_x_s,
			yin => xy_gauss20_y_s,
			xout => xy_dog20_x_o,
			yout => xy_dog20_y_o,
			data_in_a => xy_gauss20_data_s,
			data_in_b => delay20_data_out_s,
			data_out => xy_dog20_data_o
		);


	delay21 : component delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/4,
			h_img => IMG_HEIGHT/4,
			delay_x => GAUSS_DELAY_X_C,
			delay_y => GAUSS_DELAY_Y_C
		)
		port map (
			clk => global_clk_i,
			EN => xy_gauss20_en_s,
			data_in => xy_gauss20_data_s,
			data_out => delay21_data_out_s
		);

	dog21 : component dog
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/4,
			h_img => IMG_HEIGHT/4,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1)-2,
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)-2
		)
		port map (
			clk => global_clk_i,
			EN => xy_gauss21_en_s,
			EN_out => xy_dog21_en_o,
			xin => xy_gauss21_x_s,
			yin => xy_gauss21_y_s,
			xout => xy_dog21_x_o,
			yout => xy_dog21_y_o,
			data_in_a => xy_gauss21_data_s,
			data_in_b => delay21_data_out_s,
			data_out => xy_dog21_data_o
		);
end architecture rtl;
