library ieee;
use ieee.std_logic_1164.all;

library work;
use work.saturn_numeric_pkg.all;
use work.gradient_pkg.all;
use work.gaussian_filter_pkg.all;
use work.subsample_pkg.all;

entity pyramid is
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

		xy_grad_en_o : out std_logic;
		xy_grad_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
		xy_grad_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
		xy_grad_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		xy_grad_ready_i : in std_logic;

		xy_gauss00_en_o : out std_logic;
		xy_gauss00_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
		xy_gauss00_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
		xy_gauss00_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		xy_gauss00_ready_i : in std_logic;

		xy_gauss01_en_o : out std_logic;
		xy_gauss01_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
		xy_gauss01_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
		xy_gauss01_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		xy_gauss01_ready_i : in std_logic;

		xy_gauss02_en_o : out std_logic;
		xy_gauss02_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
		xy_gauss02_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
		xy_gauss02_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		xy_gauss02_ready_i : in std_logic;

		xy_subsample0_en_o : out std_logic;
		xy_subsample0_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
		xy_subsample0_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
		xy_subsample0_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		xy_subsample0_ready_i : in std_logic;

		xy_gauss10_en_o : out std_logic;
		xy_gauss10_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
		xy_gauss10_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
		xy_gauss10_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		xy_gauss10_ready_i : in std_logic;

		xy_gauss11_en_o : out std_logic;
		xy_gauss11_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
		xy_gauss11_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
		xy_gauss11_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		xy_gauss11_ready_i : in std_logic;

		xy_subsample1_en_o : out std_logic;
		xy_subsample1_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
		xy_subsample1_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
		xy_subsample1_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		xy_subsample1_ready_i : in std_logic;

		xy_gauss20_en_o : out std_logic;
		xy_gauss20_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
		xy_gauss20_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
		xy_gauss20_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		xy_gauss20_ready_i : in std_logic;

		xy_gauss21_en_o : out std_logic;
		xy_gauss21_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
		xy_gauss21_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
		xy_gauss21_data_o : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
		xy_gauss21_ready_i : in std_logic
	);
end entity pyramid;

architecture rtl of pyramid is

	constant sq_sigma00 : real := 1.0;
	constant sq_sigma01 : real := 1.0;
	constant sq_sigma02 : real := 2.0;
	constant sq_sigma10 : real := 1.0;
	constant sq_sigma11 : real := 2.0;
	constant sq_sigma20 : real := 1.0;
	constant sq_sigma21 : real := 2.0;
	constant kernel_width : natural := 9;
	constant bus_width_coeff_sum : natural := 24;

	signal grad0_EN_out : std_logic;
	signal grad0_xout : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal grad0_yout : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal grad0_data_out : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal gauss00_EN_out : std_logic;
	signal gauss00_xout : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal gauss00_yout : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal gauss00_data_out : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal gauss01_EN_out : std_logic;
	signal gauss01_xout : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal gauss01_yout : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal gauss01_data_out : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal gauss02_EN_out : std_logic;
	signal gauss02_xout : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
	signal gauss02_yout : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
	signal gauss02_data_out : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal subsample0_EN_out : std_logic;
	signal subsample0_xout : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
	signal subsample0_yout : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
	signal subsample0_data_out : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal gauss10_EN_out : std_logic;
	signal gauss10_xout : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
	signal gauss10_yout : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
	signal gauss10_data_out : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal gauss11_EN_out : std_logic;
	signal gauss11_xout : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-2 downto 0);
	signal gauss11_yout : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-2 downto 0);
	signal gauss11_data_out : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal subsample1_EN_out : std_logic;
	signal subsample1_xout : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
	signal subsample1_yout : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
	signal subsample1_data_out : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal gauss20_EN_out : std_logic;
	signal gauss20_xout : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
	signal gauss20_yout : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
	signal gauss20_data_out : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);

	signal gauss21_EN_out : std_logic;
	signal gauss21_xout : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-3 downto 0);
	signal gauss21_yout : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-3 downto 0);
	signal gauss21_data_out : std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
	
	
begin


	gradient0 : component gradient_tarek
		generic map (
			pixel_bus_width_in => unsigned_num_bits(MAX_COLOR),
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1),
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)
		)
		port map (
			clk => global_clk_i,
			EN => xy_en_i,
			EN_out => grad0_EN_out,
			xin => xy_x_i,
			yin => xy_y_i,
			xout => grad0_xout,
			yout => grad0_yout,
			data_in => xy_data_i,
			data_out => grad0_data_out
		);


	gauss00 : component gaussian_filter
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1),
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1),
			sq_sigma => sq_sigma00,
			kernel_width => kernel_width,
			bus_width_coeff_sum => bus_width_coeff_sum
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => grad0_EN_out,
			EN_out => gauss00_EN_out,
			xin => grad0_xout,
			yin => grad0_yout,
			xout => gauss00_xout,
			yout => gauss00_yout,
			data_in => grad0_data_out,
			data_out => gauss00_data_out
		);

	gauss01 : component gaussian_filter
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1),
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1),
			sq_sigma => sq_sigma01,
			kernel_width => kernel_width,
			bus_width_coeff_sum => bus_width_coeff_sum
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => gauss00_EN_out,
			EN_out => gauss01_EN_out,
			xin => gauss00_xout,
			yin => gauss00_yout,
			xout => gauss01_xout,
			yout => gauss01_yout,
			data_in => gauss00_data_out,
			data_out => gauss01_data_out
		);

	gauss02 : component gaussian_filter
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1),
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1),
			sq_sigma => sq_sigma02,
			kernel_width => kernel_width,
			bus_width_coeff_sum => bus_width_coeff_sum
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => gauss01_EN_out,
			EN_out => gauss02_EN_out,
			xin => gauss01_xout,
			yin => gauss01_yout,
			xout => gauss02_xout,
			yout => gauss02_yout,
			data_in => gauss01_data_out,
			data_out => gauss02_data_out
		);

	subsample0 : component subsample
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => gauss02_EN_out,
			EN_out => subsample0_EN_out,
			xin => gauss02_xout,
			yin => gauss02_yout,
			xout => subsample0_xout,
			yout => subsample0_yout,
			data_in => gauss02_data_out,
			data_out => subsample0_data_out
		);

	gauss10 : component gaussian_filter
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1)-1,
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)-1,
			sq_sigma => sq_sigma10,
			kernel_width => kernel_width,
			bus_width_coeff_sum => bus_width_coeff_sum
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => subsample0_EN_out,
			EN_out => gauss10_EN_out,
			xin => subsample0_xout,
			yin => subsample0_yout,
			xout => gauss10_xout,
			yout => gauss10_yout,
			data_in => subsample0_data_out,
			data_out => gauss10_data_out
		);

	gauss11 : component gaussian_filter
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1)-1,
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)-1,
			sq_sigma => sq_sigma11,
			kernel_width => kernel_width,
			bus_width_coeff_sum => bus_width_coeff_sum
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => gauss10_EN_out,
			EN_out => gauss11_EN_out,
			xin => gauss10_xout,
			yin => gauss10_yout,
			xout => gauss11_xout,
			yout => gauss11_yout,
			data_in => gauss10_data_out,
			data_out => gauss11_data_out
		);

	subsample1 : component subsample
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => gauss11_EN_out,
			EN_out => subsample1_EN_out,
			xin => gauss11_xout,
			yin => gauss11_yout,
			xout => subsample1_xout,
			yout => subsample1_yout,
			data_in => gauss11_data_out,
			data_out => subsample1_data_out
		);

	gauss20 : component gaussian_filter
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/4,
			h_img => IMG_HEIGHT/4,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1)-2,
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)-2,
			sq_sigma => sq_sigma20,
			kernel_width => kernel_width,
			bus_width_coeff_sum => bus_width_coeff_sum
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => subsample1_EN_out,
			EN_out => gauss20_EN_out,
			xin => subsample1_xout,
			yin => subsample1_yout,
			xout => gauss20_xout,
			yout => gauss20_yout,
			data_in => subsample1_data_out,
			data_out => gauss20_data_out
		);

	gauss21 : component gaussian_filter
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/4,
			h_img => IMG_HEIGHT/4,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1)-2,
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)-2,
			sq_sigma => sq_sigma21,
			kernel_width => kernel_width,
			bus_width_coeff_sum => bus_width_coeff_sum
		)
		port map (
			clk => global_clk_i,
			reset_n => global_reset_n_i,
			EN => gauss20_EN_out,
			EN_out => gauss21_EN_out,
			xin => gauss20_xout,
			yin => gauss20_yout,
			xout => gauss21_xout,
			yout => gauss21_yout,
			data_in => gauss20_data_out,
			data_out => gauss21_data_out
		);

	xy_grad_en_o <= grad0_EN_out;
	xy_grad_x_o <= grad0_xout;
	xy_grad_y_o <= grad0_yout;
	xy_grad_data_o <= grad0_data_out;
                        
	xy_gauss00_en_o <= gauss00_EN_out;
	xy_gauss00_x_o <= gauss00_xout;
	xy_gauss00_y_o <= gauss00_yout;
	xy_gauss00_data_o <= gauss00_data_out;
                        
	xy_gauss01_en_o <= gauss01_EN_out;
	xy_gauss01_x_o <= gauss01_xout;
	xy_gauss01_y_o <= gauss01_yout;
	xy_gauss01_data_o <= gauss01_data_out;
                        
	xy_gauss02_en_o <= gauss02_EN_out;
	xy_gauss02_x_o <= gauss02_xout;
	xy_gauss02_y_o <= gauss02_yout;
	xy_gauss02_data_o <= gauss02_data_out;
                        
	xy_subsample0_en_o <= subsample0_EN_out;
	xy_subsample0_x_o <= subsample0_xout;
	xy_subsample0_y_o <= subsample0_yout;
	xy_subsample0_data_o <= subsample0_data_out;
                        
	xy_gauss10_en_o <= gauss10_EN_out;
	xy_gauss10_x_o <= gauss10_xout;
	xy_gauss10_y_o <= gauss10_yout;
	xy_gauss10_data_o <= gauss10_data_out;
                        
	xy_gauss11_en_o <= gauss11_EN_out;
	xy_gauss11_x_o <= gauss11_xout;
	xy_gauss11_y_o <= gauss11_yout;
	xy_gauss11_data_o <= gauss11_data_out;
                        
	xy_subsample1_en_o <= subsample1_EN_out;
	xy_subsample1_x_o <= subsample1_xout;
	xy_subsample1_y_o <= subsample1_yout;
	xy_subsample1_data_o <= subsample1_data_out;
                        
	xy_gauss20_en_o <= gauss20_EN_out;
	xy_gauss20_x_o <= gauss20_xout;
	xy_gauss20_y_o <= gauss20_yout;
	xy_gauss20_data_o <= gauss20_data_out;

	xy_gauss21_en_o <= gauss21_EN_out;
	xy_gauss21_x_o <= gauss21_xout;
	xy_gauss21_y_o <= gauss21_yout;
	xy_gauss21_data_o <= gauss21_data_out;
	
	
end architecture rtl;
