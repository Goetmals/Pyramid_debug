-- -------------------------------------------------------------------------- --
-- File Name :	TEST_PYRAMID.vhd
-- Author    :	Fred de Melo
-- Purpose   :	testbench
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		f.de Melo	01.01.2022	First    Version
--              f.de Melo         .  .2022      FPGA     Version

--		    (c) Copyright laboratoire ETIS
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;

library work;
use work.saturn_numeric_pkg.all;


--  module TEST_PYRAMID
-- ------------------------------------------------------------------------- --
entity TEST_PYRAMID is
generic (
	  --nomSrce	: string  := "C:\Users\frede\OneDrive\Documents\testbench_eads\vhdl\tst\ImageTests\cube.imv";
	  --nomSrce	: string  := "/home/cody/Documents/img_test.imv";
	  nomSrce	: string  := "/home/demelo/vivado_prjs/testbench_eads/vhdl/tst/ImageTests/test_pyramid/bridge.imv";
	  --nomDest	: string  := "C:\Users\frede\OneDrive\Documents\testbench_eads\vhdl\tst\ImageTests\cube_gf_py.imv";
      nomDest	: string  := "/home/demelo/vivado_prjs/testbench_eads/vhdl/tst/ImageTests/test_pyramid/bridge_dog21_cody.imv";
      --nomDest	: string  := "/home/demelo/vivado_prjs/testbench_eads/vhdl/tst/ImageTests/img_test_gf_v.imv";
	  Periode	: time    := 5.000 ns
	);
end TEST_PYRAMID;

--  d�finition de l'architecture de TEST_OREC
-- ------------------------------------------------------------------------- --
architecture ARCH_TEST_PYRAMID of TEST_PYRAMID is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�claration des composants externes
	-- --------------------------------------------------------- --
	
signal  mode                    : std_logic_vector( 3 downto 0) := "1111";
	
component READIMG
generic (
	 nomfichier	: string  :="test.ima";

	 format		: string  := "IMAGING";		-- IMAGING/DATACUBE

	 nbPixDeb	: integer := 6;
	 nbPixFin	: integer := 6;
	 nbLigDeb	: integer := 6;
	 nbLigFin	: integer := 6;
	 nbLigFinSeq	: integer := 6;

	 tPHV		: time    := 0 ns;
	 pix_unknown	: std_logic_vector(7 downto 0) := (others=>'U')
	);
   port	(
	 resetb   	: in	std_logic;
	 clk     	: in	std_logic;

	 hsync_out  	: out	std_logic;
	 vsync_out  	: out	std_logic;
	 pixel_out   	: out	std_logic_vector( 7 downto 0);

	 eof		: out	std_logic
	);
end component;

	-- --------------------------------------------------------- --
component WRITEIMG
generic	(
	  nomfichier	: string := "Imaging/ima.dst.imv"
	);
   port ( 
	 resetb		: in std_logic;
	 clk		: in std_logic;

	 hsync_inn	: in std_logic;
	 vsync_inn	: in std_logic;
	 pixel_inn	: in std_logic_vector(7 downto 0)
	);
end component;

	-- --------------------------------------------------------- --
component RESYNCH_SGNX8
   port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 7 downto 0);

	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 7 downto 0)
	);
end component;

	-- --------------------------------------------------------- --
component imaging_to_axis 
        Port ( clkb : in STD_LOGIC;
               resetb : in STD_LOGIC;
               hsync_in : in STD_LOGIC;
               vsync_in : in STD_LOGIC;
               pixel_in : in STD_LOGIC_VECTOR (7 downto 0);
               M_AXIS_TREADY : in STD_LOGIC;
               M_AXIS_TVALID : out STD_LOGIC;
         --      M_AXIS_TUSER : out STD_LOGIC;
               M_AXIS_TLAST : out STD_LOGIC;
               M_AXIS_TDATA : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
	-- --------------------------------------------------------- --
component axis_to_xy_cody
    generic (
		BUS_WIDTH : positive := 32;
		IMG_WIDTH : positive := 1920;
		IMG_HEIGHT : positive := 1080;
		
		nbPixDeb	: integer := 6;
		nbPixFin	: integer := 6
		);
	port (
		aclk : in std_logic;
		aresetn : in std_logic;
--------------------------------------------------------------------------------
-- AXIS Slave side
--------------------------------------------------------------------------------
		S_AXIS_TVALID : in std_logic;
		S_AXIS_TUSER : in std_logic;
		S_AXIS_TLAST : in std_logic;
		S_AXIS_TDATA : in std_logic_vector(BUS_WIDTH-1 downto 0);
--------------------------------------------------------------------------------
-- AXIS Master side
--------------------------------------------------------------------------------
		M_AXIS_TREADY : in std_logic;
--------------------------------------------------------------------------------
-- XYEn side
--------------------------------------------------------------------------------
		o_en : out std_logic;
		o_x : out std_logic_vector(UNSIGNED_NUM_BITS(IMG_WIDTH-1)-1 downto 0);
		o_y : out std_logic_vector(UNSIGNED_NUM_BITS(IMG_HEIGHT-1)-1 downto 0);
		o_value : out std_logic_vector(BUS_WIDTH-1 downto 0)
	);
end component;

component gradient_cody
generic(
    pixel_bus_width_in : natural := 8;
    pixel_bus_width    : natural := 17;
    w_img              : natural := 640;
    h_img              : natural := 480;
    bus_width_x        : natural := unsigned_num_bits(640);
    bus_width_y        : natural := unsigned_num_bits(480));
  port(
    clk, reset                  : in  std_logic;
    hsync_inn, vsync_inn, en_in : in  std_logic;     
    xin                         : in  std_logic_vector(bus_width_x-1 downto 0);
    yin                         : in  std_logic_vector(bus_width_y-1 downto 0);
    data_in                     : in  std_logic_vector(7 downto 0);
      
    hsync_out, vsync_out, EN_out    : out std_logic;
    xout                            : out std_logic_vector(bus_width_x-1 downto 0);
    yout                            : out std_logic_vector(bus_width_y-1 downto 0);
    data_out                        : out std_logic_vector(7 downto 0)
    );
end component;

component gaussian_filter_cody 
	generic(
		pixel_bus_width     : natural := 17;
		w_img               : natural := 640;
		h_img               : natural := 480;
		bus_width_x         : natural := unsigned_num_bits(640);
		bus_width_y         : natural := unsigned_num_bits(480);
	
		sq_sigma            : real    := 2.0;
		kernel_width        : natural := 7;
		bus_width_coeff_sum : natural := 24
	);
	port(
		clk, EN  : in  std_logic;
		reset_n : in std_logic;
		EN_out   : out std_logic;
		hsync_in, vsync_in : in  std_logic;
		xin      : in  std_logic_vector(bus_width_x-1 downto 0);
		yin      : in  std_logic_vector(bus_width_y-1 downto 0);
		hsync_out, vsync_out: out  std_logic;
		xout     : out std_logic_vector(bus_width_x-1 downto 0);
		yout     : out std_logic_vector(bus_width_y-1 downto 0);
		data_in  : in  std_logic_vector(pixel_bus_width-1 downto 0);
		data_out : out std_logic_vector(pixel_bus_width-1 downto 0)
	);
end component;

component subsample_cody2 
	generic (
		pixel_bus_width     : natural := 17;
		w_img               : natural := 640;
		h_img               : integer := 480;
		start_hsync         : std_logic := '0'
	);
	port (
		clk			: in  std_logic;
		reset_n 	: in std_logic;
		EN  		: in  std_logic;
		hsync_in	: in  std_logic;
		vsync_in	: in  std_logic;
		xin      	: in  std_logic_vector(unsigned_num_bits(w_img-1)-1 downto 0);
		yin      	: in  std_logic_vector(unsigned_num_bits(h_img-1)-1 downto 0);
		data_in  	: in  std_logic_vector(pixel_bus_width-1 downto 0);
		
		
		EN_out   	: out std_logic;
		hsync_out	: out std_logic;
		vsync_out	: out std_logic;
		xout     	: out std_logic_vector(unsigned_num_bits(w_img-1)-2 downto 0);
		yout     	: out std_logic_vector(unsigned_num_bits(w_img-1)-2 downto 0);
		data_out 	: out std_logic_vector(pixel_bus_width-1 downto 0)
	);
end component;

component xy_to_axis 
	generic (
		MAX_COLOR : positive := 255;
		IMG_WIDTH : positive := 1920;
		IMG_HEIGHT : positive := 1080
	);
	port (
		aclk : in std_logic;
		aresetn : in std_logic;
--------------------------------------------------------------------------------
-- XYEn side
--------------------------------------------------------------------------------
		i_en : in std_logic;
		i_x : in std_logic_vector(UNSIGNED_NUM_BITS(IMG_WIDTH-1)-1 downto 0);
		i_y : in std_logic_vector(UNSIGNED_NUM_BITS(IMG_HEIGHT-1)-1 downto 0);
		i_value : in std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0);
--------------------------------------------------------------------------------
-- AXIS Master side
--------------------------------------------------------------------------------
		M_AXIS_TVALID : out std_logic;
		M_AXIS_TUSER : out std_logic;
		M_AXIS_TLAST : out std_logic;
		M_AXIS_TREADY : in std_logic;
		M_AXIS_TDATA : out std_logic_vector(unsigned_num_bits(MAX_COLOR)-1 downto 0)
	);
end component;

component dog 
	generic(
		pixel_bus_width : natural := 17;
		w_img           : natural := 640;
		h_img           : natural := 480;
		bus_width_x     : natural := UNSIGNED_NUM_BITS(640);
		bus_width_y     : natural := UNSIGNED_NUM_BITS(480)
	);
	port(
		clk, EN   : in  std_logic;
		hsync_in, vsync_in    : in  std_logic;
		xin       : in  std_logic_vector(bus_width_x-1 downto 0);
		yin       : in  std_logic_vector(bus_width_y-1 downto 0);
		data_in_a : in  std_logic_vector(pixel_bus_width-1 downto 0);
		data_in_b : in  std_logic_vector(pixel_bus_width-1 downto 0);
		EN_out    : out std_logic;
		hsync_out, vsync_out    : out  std_logic;
		xout      : out std_logic_vector(bus_width_x-1 downto 0);
		yout      : out std_logic_vector(bus_width_y-1 downto 0);
		data_out  : out std_logic_vector(pixel_bus_width-1 downto 0)
	);
end component;

component delay
	generic (
		pixel_bus_width : natural := 17;
		w_img           : natural := 640;
		h_img           : natural := 480;
		delay_x         : natural := 4;
		delay_y         : natural := 3
	);
	port (
		clk, EN  : in  std_logic;
		data_in  : in  std_logic_vector(pixel_bus_width-1 downto 0);
		data_out : out std_logic_vector(pixel_bus_width-1 downto 0)
	);
end component;

	-- --------------------------------------------------------- --

    constant IMG_WIDTH      : positive := 512;
    constant IMG_HEIGHT     : positive := 512;
    constant BUS_WIDTH      : positive := 8;
    
    constant bus_width_x : NATURAL := unsigned_num_bits(IMG_WIDTH-1);
    constant bus_width_y : NATURAL := unsigned_num_bits(IMG_HEIGHT-1);
    
    constant MAX_COLOR : positive := 255;
    
    constant sq_sigma00 : real := 0.2;
    constant sq_sigma01 : real := 0.2;
    constant sq_sigma02 : real := 0.3;
    
    constant sq_sigma10 : real := 0.2;
    constant sq_sigma11 : real := 0.3;
    
    constant sq_sigma20 : real := 0.2;
    constant sq_sigma21 : real := 0.3;
    
    constant kernel_width : natural := 9;
    constant bus_width_coeff_sum : natural := 24;
    
    constant GAUSS_DELAY_X_C : natural := kernel_width/2+2;--+4;--4 + (kernel_width-2);
	constant GAUSS_DELAY_Y_C : natural := kernel_width/2;
    
	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�claration des signaux internes
	-- --------------------------------------------------------- --
	signal	eof			: std_logic;
	signal	resetb ,clk,clkb	: std_logic := '0';

	signal	hsync_inn,vsync_inn	: std_logic;
	signal	pixel_inn		: std_logic_vector( 7 downto 0);

	signal	hsync_int,vsync_int	: std_logic;
	signal	pixel_int		: std_logic_vector( 7 downto 0);
	
	signal scale   : positive;
	
	signal  en_proc : std_logic;
	signal	hsync_proc,vsync_proc	: std_logic;
	signal  x_proc         : std_logic_vector(bus_width_x-1 downto 0);
	signal  y_proc         : std_logic_vector(bus_width_x-1 downto 0);
	signal	pixel_proc		: std_logic_vector( 7 downto 0);
	
	
	signal	hsync_out, vsync_out	: std_logic;
	signal	pixel_out		: std_logic_vector( 7 downto 0);

	
    
    
    signal M_AXIS_TREADY, M_AXIS_TVALID, M_AXIS_TUSER, M_AXIS_TLAST :  std_logic;
    signal M_AXIS_TVALID_o, M_AXIS_TUSER_o, M_AXIS_TLAST_o :  std_logic;
    signal M_AXIS_TDATA, M_AXIS_TDATA_o : std_logic_vector( 7 downto 0);
    
    signal o_en     : std_logic;
    signal o_x      : std_logic_vector(UNSIGNED_NUM_BITS(IMG_WIDTH-1)-1 downto 0);
    signal o_y      : std_logic_vector(UNSIGNED_NUM_BITS(IMG_HEIGHT-1)-1 downto 0);
    signal o_value  : std_logic_vector(BUS_WIDTH-1 downto 0);
    
    signal en_grd, en_gf00, en_gf01, en_gf02, en_dog00, en_dog01: std_logic;
    signal en_sub0, en_gf10, en_gf11, en_dog10, en_dog11 : std_logic;
    signal en_sub1, en_gf20, en_gf21, en_dog20, en_dog21 : std_logic;
    
    signal hsync_grd, hsync_gf00, hsync_gf01, hsync_gf02, hsync_dog00, hsync_dog01: std_logic;
    signal hsync_sub0, hsync_gf10, hsync_gf11, hsync_dog10, hsync_dog11 : std_logic;
    signal hsync_sub1, hsync_gf20, hsync_gf21, hsync_dog20, hsync_dog21 : std_logic;
    
    signal vsync_grd, vsync_gf00, vsync_gf01, vsync_gf02, vsync_dog00, vsync_dog01: std_logic;
    signal vsync_sub0, vsync_gf10, vsync_gf11, vsync_dog10, vsync_dog11 : std_logic;
    signal vsync_sub1, vsync_gf20, vsync_gf21, vsync_dog20, vsync_dog21 : std_logic;
    
    signal x_grd, x_gf00, x_gf01, x_gf02, x_dog00, x_dog01  : std_logic_vector(bus_width_x-1 downto 0);
    signal x_sub0, x_gf10, x_gf11, x_dog10, x_dog11         : std_logic_vector(bus_width_y-2 downto 0);
    signal x_sub1, x_gf20, x_gf21, x_dog20, x_dog21         : std_logic_vector(bus_width_y-3 downto 0);  
    
    signal y_grd, y_gf00, y_gf01, y_gf02, y_dog00, y_dog01  : std_logic_vector(bus_width_x-1 downto 0);
    signal y_sub0, y_gf10, y_gf11, y_dog10, y_dog11         : std_logic_vector(bus_width_y-2 downto 0);
    signal y_sub1, y_gf20, y_gf21, y_dog20, y_dog21         : std_logic_vector(bus_width_y-3 downto 0);      
    
    
    signal pixel_grd, pixel_gf00, pixel_gf01, pixel_gf02, pixel_dog00, pixel_dog01 : std_logic_vector(7 downto 0);
    signal pixel_sub0, pixel_gf10, pixel_gf11, pixel_dog10, pixel_dog11 : std_logic_vector(7 downto 0);
    signal pixel_sub1, pixel_gf20, pixel_gf21, pixel_dog20, pixel_dog21 : std_logic_vector(7 downto 0);  
    
    
    
    --signal decal_h : std_logic_vector(29 downto 0);
    --signal decal_h : std_logic_vector(15 downto 0);
    --signal decal_h : std_logic_vector(9 downto 0); -- gradient seul
    signal decal_h : std_logic_vector(8 downto 0);
    
    signal delay00_data_out_s, delay01_data_out_s: std_logic_vector( 7 downto 0);
	signal delay10_data_out_s, delay11_data_out_s : std_logic_vector( 7 downto 0);
	signal delay20_data_out_s, delay21_data_out_s : std_logic_vector( 7 downto 0);
	
	signal nbPixDeb, nbPixFin 	: integer := 6;
	signal nbLigFin, nbLigFinSeq, nbLigDeb : integer := 6;
	
	signal eof_delayed : std_logic := '0';	 
    
-- ========================================================================= --
begin
	-- Lecture d'une image et g�n�ration des signaux vid�o.
	-- --------------------------------------------------------- --
RI0:	READIMG	    generic map	(
				 nomfichier => nomSrce
				,format	=> "IMAGING"
				,nbPixDeb => nbPixDeb
	            ,nbPixFin => nbPixFin
	            ,nbLigDeb => nbLigDeb
	            ,nbLigFin => 80
	            ,nbLigFinSeq => nbLigFinSeq
				,tPHV => Periode*0.35
				,pix_unknown => "11111111"
				)
		       port map	(
				 resetb,clk
				,hsync_inn,vsync_inn,pixel_inn
				,eof
				);

	-- Resynchronisation des signaux vid�o.
	-- --------------------------------------------------------- --
RS0:	RESYNCH_SGNX8  port map	(
				 resetb,clkb
				,hsync_inn,vsync_inn,pixel_inn
				,hsync_int,vsync_int,pixel_int
				);

	
	-- Interface imaging vers axi4stream.
    -- --------------------------------------------------------- --
AXIS0:  imaging_to_axis	 port map	(
                        clkb,resetb
                       ,hsync_int,vsync_int,pixel_int
                       ,M_AXIS_TREADY,M_AXIS_TVALID
                  --     ,M_AXIS_TUSER
                       ,M_AXIS_TLAST
                       ,M_AXIS_TDATA
                       );
 
M_AXIS_TUSER <= '0','1' after 15544.182 ns,'0' after 15553.440 ns;

ASXY0:  axis_to_xy_cody
                           generic map  (
                                BUS_WIDTH
                               ,IMG_WIDTH
                               ,IMG_HEIGHT
							   
							   ,NbPixDeb
							   ,NbPixFin
                           )
                           port map (
                               clkb,resetb
                       --------------------------------------------------------------------------------
                       -- AXIS Slave side
                       --------------------------------------------------------------------------------
                               ,M_AXIS_TVALID
                               ,M_AXIS_TUSER
                               ,M_AXIS_TLAST
                               ,M_AXIS_TDATA
                       --------------------------------------------------------------------------------
                       -- AXIS Master side
                       --------------------------------------------------------------------------------
                               ,M_AXIS_TREADY
                       --------------------------------------------------------------------------------
                       -- XYEn side
                       --------------------------------------------------------------------------------
                               ,o_en
                               ,o_x
                               ,o_y
                               ,o_value
                           );                      
                       
GRD0:   gradient_cody
                           generic map(
                                8
                               ,8
                               ,IMG_WIDTH
                               ,IMG_HEIGHT
                               ,bus_width_x
                               ,bus_width_y)
                               
                             port map(
                                clkb, resetb
                               ,hsync_int, vsync_int, o_en
                               ,o_x
                               ,o_y
                               ,o_value
                               
                               ,hsync_grd,vsync_grd ,en_grd
                               ,x_grd
                               ,y_grd
                               
                               ,pixel_grd
                               );
 
                            
GF00:     gaussian_filter_cody 
                            generic map(
                                 8
                                ,IMG_WIDTH
                                ,IMG_HEIGHT
                                ,bus_width_x
                                ,bus_width_y
                            
                                ,sq_sigma00            
                                ,kernel_width        
                                ,bus_width_coeff_sum 
                            )
                            port map(
                                 clkb, en_grd
                                ,resetb
                                ,en_gf00
                                ,hsync_grd,vsync_grd
                                ,x_grd
                                ,y_grd
                                ,hsync_gf00, vsync_gf00
                                ,x_gf00
                                ,y_gf00
                                ,pixel_grd
                                ,pixel_gf00
                            );

GF01:     gaussian_filter_cody 
                            generic map(
                                 8
                                ,IMG_WIDTH
                                ,IMG_HEIGHT
                                ,bus_width_x
                                ,bus_width_y
                            
                                ,sq_sigma01            
                                ,kernel_width        
                                ,bus_width_coeff_sum 
                            )
                            port map(
                                 clkb, en_gf00
                                ,resetb
                                ,en_gf01
                                ,hsync_gf00, vsync_gf00
                                ,x_gf00
                                ,y_gf00
                                ,hsync_gf01, vsync_gf01
                                ,x_gf01
                                ,y_gf01
                                ,pixel_gf00
                                ,pixel_gf01
                            );

DLY00:  delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT,
			delay_x => GAUSS_DELAY_X_C,
			delay_y => GAUSS_DELAY_Y_C
		)
		port map (
			clk => clkb,
			EN => en_gf00,
			data_in => pixel_gf00,
			data_out => delay00_data_out_s
		);
		
DOG00:  dog
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1),
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)
		)
		port map (
			clk => clkb,
			EN => en_gf01,
			hsync_in => hsync_gf01,
			vsync_in => vsync_gf01,
			xin => x_gf01,
			yin => y_gf01,
			data_in_a => pixel_gf01,
			data_in_b => delay00_data_out_s,
			
			EN_out => en_dog00,
			hsync_out => hsync_dog00,
			vsync_out => vsync_dog00,
			xout => x_dog00,
			yout => y_dog00,
			data_out => pixel_dog00
		);		

GF02:     gaussian_filter_cody 
                            generic map(
                                 8
                                ,IMG_WIDTH
                                ,IMG_HEIGHT
                                ,bus_width_x
                                ,bus_width_y
                            
                                ,sq_sigma02            
                                ,kernel_width        
                                ,bus_width_coeff_sum 
                            )
                            port map(
                                 clkb, en_gf01
                                ,resetb
                                ,en_gf02
                                ,hsync_gf01, vsync_gf01
                                ,x_gf01
                                ,y_gf01
                                ,hsync_gf02, vsync_gf02
                                ,x_gf02
                                ,y_gf02
                                ,pixel_gf01
                                ,pixel_gf02
                            );

DLY01:  delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT,
			delay_x => GAUSS_DELAY_X_C,
			delay_y => GAUSS_DELAY_Y_C
		)
		port map (
			clk => clkb,
			EN => en_gf01,
			data_in => pixel_gf01,
			data_out => delay01_data_out_s
		);
		  
DOG01:  dog
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH,
			h_img => IMG_HEIGHT,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1),
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)
		)
		port map (
			clk => clkb,
			EN => en_gf02,
			hsync_in => hsync_gf02,
			vsync_in => vsync_gf02,
			xin => x_gf02,
			yin => y_gf02,
			data_in_a => pixel_gf02,
			data_in_b => delay01_data_out_s,
			
			EN_out => en_dog01,
			hsync_out => hsync_dog01,
			vsync_out => vsync_dog01,
			xout => x_dog01,
			yout => y_dog01,
			data_out => pixel_dog01
		);                            

SUB0: subsample_cody2 
          generic map (
                    pixel_bus_width => unsigned_num_bits(MAX_COLOR),
                    w_img => IMG_WIDTH,
                    h_img => IMG_HEIGHT,
                    start_hsync => '0'
                    
		)  
		  port map (
                    clk                   => clkb,
                    reset_n               => resetb,
                    EN                    => en_gf02,
                    hsync_in              => hsync_gf02,
                    vsync_in              => vsync_gf02,
                    xin                   => x_gf02, 
                    yin                   => y_gf02,
                    data_in               => pixel_gf02,
                    
                    EN_out                => en_sub0,
                    hsync_out             => hsync_sub0,
                    vsync_out             => vsync_sub0,
                    xout                  => x_sub0,
                    yout                  => y_sub0,
                    data_out              => pixel_sub0
                    );   
                
GF10:     gaussian_filter_cody 
                            generic map(
                                 8
                                ,IMG_WIDTH/2
                                ,IMG_HEIGHT/2
                                ,bus_width_x-1
                                ,bus_width_y-1
                            
                                ,sq_sigma01            
                                ,kernel_width        
                                ,bus_width_coeff_sum 
                            )
                            port map(
                                 clkb, en_sub0
                                ,resetb
                                ,en_gf10
                                ,hsync_sub0, vsync_sub0
                                ,x_sub0
                                ,y_sub0
                                ,hsync_gf10, vsync_gf10
                                ,x_gf10
                                ,y_gf10
                                ,pixel_sub0
                                ,pixel_gf10
                            );


DLY10:  delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2,
			delay_x => GAUSS_DELAY_X_C,
			delay_y => GAUSS_DELAY_Y_C
		)
		port map (
			clk => clkb,
			EN => en_sub0,
			data_in => pixel_sub0,
			data_out => delay10_data_out_s
		); 

DOG10:  dog
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1)-1,
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)-1
		)
		port map (
			clk => clkb,
			EN => en_gf10,
			hsync_in => hsync_gf10,
			vsync_in => vsync_gf10,
			xin => x_gf10,
			yin => y_gf10,
			data_in_a => pixel_gf10,
			data_in_b => delay10_data_out_s,
			
			EN_out => en_dog10,
			hsync_out => hsync_dog10,
			vsync_out => vsync_dog10,
			xout => x_dog10,
			yout => y_dog10,
			data_out => pixel_dog10
		);

GF11:     gaussian_filter_cody 
                            generic map(
                                 8
                                ,IMG_WIDTH/2
                                ,IMG_HEIGHT/2
                                ,bus_width_x-1
                                ,bus_width_y-1
                            
                                ,sq_sigma02            
                                ,kernel_width        
                                ,bus_width_coeff_sum 
                            )
                            port map(
                                 clkb, en_gf10
                                ,resetb
                                ,en_gf11
                                ,hsync_gf10, vsync_gf10
                                ,x_gf10
                                ,y_gf10
                                ,hsync_gf11, vsync_gf11
                                ,x_gf11
                                ,y_gf11
                                ,pixel_gf10
                                ,pixel_gf11
                            );  

DLY11:  delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2,
			delay_x => GAUSS_DELAY_X_C,
			delay_y => GAUSS_DELAY_Y_C
		)
		port map (
			clk => clkb,
			EN => en_gf10,
			data_in => pixel_gf10,
			data_out => delay11_data_out_s
		); 

DOG11:  dog
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/2,
			h_img => IMG_HEIGHT/2,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1)-1,
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)-1
		)
		port map (
			clk => clkb,
			EN => en_gf11,
			hsync_in => hsync_gf11,
			vsync_in => vsync_gf11,
			xin => x_gf11,
			yin => y_gf11,
			data_in_a => pixel_gf11,
			data_in_b => delay11_data_out_s,
			
			EN_out => en_dog11,
			hsync_out => hsync_dog11,
			vsync_out => vsync_dog11,
			xout => x_dog11,
			yout => y_dog11,
			data_out => pixel_dog11
		);
         
 SUB1: subsample_cody2 
          generic map (
                    pixel_bus_width => unsigned_num_bits(MAX_COLOR),
                    w_img => IMG_WIDTH/2,
                    h_img => IMG_HEIGHT/2,
                    start_hsync => '1'
		)  
		  port map (
                    clk                   => clkb,
                    reset_n               => resetb,
                    EN                    => en_gf11,
                    hsync_in              => hsync_gf11,
                    vsync_in              => vsync_gf11,
                    xin                   => x_gf11, 
                    yin                   => y_gf11,
                    data_in               => pixel_gf11,
                    
                    EN_out                => en_sub1,
                    hsync_out             => hsync_sub1,
                    vsync_out             => vsync_sub1,
                    xout                  => x_sub1,
                    yout                  => y_sub1,
                    data_out              => pixel_sub1
                    );
                                                
 GF20:     gaussian_filter_cody 
                            generic map(
                                 8
                                ,IMG_WIDTH/4
                                ,IMG_HEIGHT/4
                                ,bus_width_x-2
                                ,bus_width_y-2
                            
                                ,sq_sigma20            
                                ,kernel_width        
                                ,bus_width_coeff_sum 
                            )
                            port map(
                                 clkb, en_sub1
                                ,resetb
                                ,en_gf20
                                ,hsync_sub1, vsync_sub1
                                ,x_sub1
                                ,y_sub1
                                ,hsync_gf20, vsync_gf20
                                ,x_gf20
                                ,y_gf20
                                ,pixel_sub1
                                ,pixel_gf20
                            );  

DLY20:  delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/4,
			h_img => IMG_HEIGHT/4,
			delay_x => GAUSS_DELAY_X_C,
			delay_y => GAUSS_DELAY_Y_C
		)
		port map (
			clk => clkb,
			EN => en_sub1,
			data_in => pixel_sub1,
			data_out => delay20_data_out_s
		); 

DOG20:  dog
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/4,
			h_img => IMG_HEIGHT/4,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1)-2,
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)-2
		)
		port map (
			clk => clkb,
			EN => en_gf20,
			hsync_in => hsync_gf20,
			vsync_in => vsync_gf20,
			xin => x_gf20,
			yin => y_gf20,
			data_in_a => pixel_gf20,
			data_in_b => delay20_data_out_s,
			
			EN_out => en_dog20,
			hsync_out => hsync_dog20,
			vsync_out => vsync_dog20,
			xout => x_dog20,
			yout => y_dog20,
			data_out => pixel_dog20
		);          

GF21:     gaussian_filter_cody 
                            generic map(
                                 8
                                ,IMG_WIDTH/4
                                ,IMG_HEIGHT/4
                                ,bus_width_x-2
                                ,bus_width_y-2
                            
                                ,sq_sigma20            
                                ,kernel_width        
                                ,bus_width_coeff_sum 
                            )
                            port map(
                                 clkb, en_gf20
                                ,resetb
                                ,en_gf21
                                ,hsync_gf20, vsync_gf20
                                ,x_gf20
                                ,y_gf20
                                ,hsync_gf21, vsync_gf21
                                ,x_gf21
                                ,y_gf21
                                ,pixel_gf20
                                ,pixel_gf21
                            );  

DLY21:  delay
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/4,
			h_img => IMG_HEIGHT/4,
			delay_x => GAUSS_DELAY_X_C,
			delay_y => GAUSS_DELAY_Y_C
		)
		port map (
			clk => clkb,
			EN => en_gf20,
			data_in => pixel_gf20,
			data_out => delay21_data_out_s
		); 

DOG21:  dog
		generic map (
			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
			w_img => IMG_WIDTH/4,
			h_img => IMG_HEIGHT/4,
			bus_width_x => unsigned_num_bits(IMG_WIDTH-1)-2,
			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)-2
		)
		port map (
			clk => clkb,
			EN => en_gf21,
			hsync_in => hsync_gf21,
			vsync_in => vsync_gf21,
			xin => x_gf21,
			yin => y_gf21,
			data_in_a => pixel_gf21,
			data_in_b => delay21_data_out_s,
			
			EN_out => en_dog21,
			hsync_out => hsync_dog21,
			vsync_out => vsync_dog21,
			xout => x_dog21,
			yout => y_dog21,
			data_out => pixel_dog21
		);                       
                                                 
XYAS0:  xy_to_axis 
                                   generic map (
                                        MAX_COLOR
                                       ,IMG_WIDTH/scale
                                       ,IMG_HEIGHT/scale
                                   )
                                   port map (
                                        clkb,resetb
                               --------------------------------------------------------------------------------
                               -- XYEn side
                               --------------------------------------------------------------------------------
                                       ,en_proc
                                       ,x_proc
                                       ,y_proc
                                       ,pixel_proc
                               --------------------------------------------------------------------------------
                               -- AXIS Master side
                               --------------------------------------------------------------------------------
                                       ,M_AXIS_TVALID_o
                                       ,M_AXIS_TUSER_o
                                       ,M_AXIS_TLAST_o
                                       ,M_AXIS_TREADY
                                       ,M_AXIS_TDATA_o
                                   );                      
                               
en_proc             <=  en_grd      when mode = "0000"
                   else en_gf00     when mode = "0001"
                   else en_gf01     when mode = "0010"
                   else en_gf02     when mode = "0011"
                   else en_dog00    when mode = "0100"
                   else en_dog01    when mode = "0101"
                   else en_sub0     when mode = "0110"
                   else en_gf10     when mode = "0111"
                   else en_gf11     when mode = "1000"
                   else en_dog10    when mode = "1001"
                   else en_dog11    when mode = "1010"
                   else en_sub1    when mode = "1011"
                   else en_gf20     when mode = "1100"
                   else en_gf21     when mode = "1101"
                   else en_dog20    when mode = "1110"
                   else en_dog21    when mode = "1111"
                   else '0';      
                   
                   
 hsync_proc         <=  hsync_grd      when mode = "0000"
                   else hsync_gf00     when mode = "0001"
                   else hsync_gf01     when mode = "0010"
                   else hsync_gf02     when mode = "0011"
                   else hsync_dog00    when mode = "0100"
                   else hsync_dog01    when mode = "0101"
                   else hsync_sub0     when mode = "0110"
                   else hsync_gf10     when mode = "0111"
                   else hsync_gf11     when mode = "1000"
                   else hsync_dog10    when mode = "1001"
                   else hsync_dog11    when mode = "1010"
                   else hsync_sub1    when mode = "1011"
                   else hsync_gf20     when mode = "1100"
                   else hsync_gf21     when mode = "1101"
                   else hsync_dog20    when mode = "1110"
                   else hsync_dog21    when mode = "1111"
                   else '0';     
                                     
 vsync_proc         <=  vsync_grd      when mode = "0000"
                   else vsync_gf00     when mode = "0001"
                   else vsync_gf01     when mode = "0010"
                   else vsync_gf02     when mode = "0011"
                   else vsync_dog00    when mode = "0100"
                   else vsync_dog01    when mode = "0101"
                   else vsync_sub0     when mode = "0110"
                   else vsync_gf10     when mode = "0111"
                   else vsync_gf11     when mode = "1000"
                   else vsync_dog10    when mode = "1001"
                   else vsync_dog11    when mode = "1010"
                   else vsync_sub1    when mode = "1011"
                   else vsync_gf20     when mode = "1100"
                   else vsync_gf21     when mode = "1101"
                   else vsync_dog20    when mode = "1110"
                   else vsync_dog21    when mode = "1111"
                   else '0';                                         
 
 x_proc             <=  x_grd           when mode = "0000"
                   else x_gf00          when mode = "0001"
                   else x_gf01          when mode = "0010"
                   else x_gf02          when mode = "0011"
                   else x_dog00         when mode = "0100"
                   else x_dog01         when mode = "0101"
                   else '0' & x_sub0    when mode = "0110"
                   else '0' & x_gf10    when mode = "0111"
                   else '0' & x_gf11    when mode = "1000"
                   else '0' & x_dog10   when mode = "1001"
                   else '0' & x_dog11   when mode = "1010"
                   else "00" & x_sub1   when mode = "1011"
                   else "00" & x_gf20   when mode = "1100"
                   else "00" & x_gf21   when mode = "1101"
                   else "00" & x_dog20  when mode = "1110"
                   else "00" & x_dog21  when mode = "1111"
                   else (others=>'0'); 
                   
  y_proc             <=  y_grd           when mode = "0000"
                   else y_gf00          when mode = "0001"
                   else y_gf01          when mode = "0010"
                   else y_gf02          when mode = "0011"
                   else y_dog00         when mode = "0100"
                   else y_dog01         when mode = "0101"
                   else '0' & y_sub0    when mode = "0110"
                   else '0' & y_gf10    when mode = "0111"
                   else '0' & y_gf11    when mode = "1000"
                   else '0' & y_dog10   when mode = "1001"
                   else '0' & y_dog11   when mode = "1010"
                   else "00" & y_sub1   when mode = "1011"
                   else "00" & y_gf20   when mode = "1100"
                   else "00" & y_gf21   when mode = "1101"
                   else "00" & y_dog20  when mode = "1110"
                   else "00" & y_dog21  when mode = "1111"
                   else (others=>'0');                          
                   
                     
 pixel_proc         <=  pixel_grd      when mode = "0000"
                   else pixel_gf00     when mode = "0001"
                   else pixel_gf01     when mode = "0010"
                   else pixel_gf02     when mode = "0011"
                   else pixel_dog00    when mode = "0100"
                   else pixel_dog01    when mode = "0101"
                   else pixel_sub0     when mode = "0110"
                   else pixel_gf10     when mode = "0111"
                   else pixel_gf11     when mode = "1000"
                   else pixel_dog10    when mode = "1001"
                   else pixel_dog11    when mode = "1010"
                   else pixel_sub1     when mode = "1011"
                   else pixel_gf20     when mode = "1100"
                   else pixel_gf21     when mode = "1101"
                   else pixel_dog20    when mode = "1110"
                   else pixel_dog21    when mode = "1111"
                   else (others=>'0'); 
 
 with mode select 
 scale              <=  1              when "0000" | "0001" | "0010" | "0011" | "0100" | "0101",
                        2              when "0110" | "0111" | "1000" | "1001" | "1010",
                        4              when "1011" | "1100" | "1101" | "1110" | "1111",
                        1              when others;
                                                                      
--hsync_out <= hsync_gf00;
--vsync_out <= not (M_AXIS_TVALID_o);
--pixel_out <= M_AXIS_TDATA_o;
    
    
--SYNC2:	process( resetb,clkb )
--	begin
--		-- ------------------------------------------------- --
--		if    ( resetb='0' ) then
--			decal_h <= (others=>'1');
			
--		-- ------------------------------------------------- --
--		elsif ( rising_edge(clkb) ) then
--			decal_h <= decal_h(7 downto 0) & hsync_gf00;
--		end if;
--	end process;
	
--	hsync_out <= decal_h(0);
--	vsync_out <= not (M_AXIS_TVALID_o);
--    pixel_out <= M_AXIS_TDATA_o;
    
SYNC2:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			decal_h <= (others=>'1');
			
		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			decal_h <= decal_h(7 downto 0) & hsync_proc;
		end if;
	end process;
	
	hsync_out <= decal_h(0);
	vsync_out <= not (M_AXIS_TVALID_o);
    pixel_out <= M_AXIS_TDATA_o;
    
        
--SYNC1:	process( resetb,clkb )
--	begin
--		-- ------------------------------------------------- --
--		if    ( resetb='0' ) then
--			decal_h <= (others=>'1');
			
--		-- ------------------------------------------------- --
--		elsif ( rising_edge(clkb) ) then
--			decal_h <= decal_h(7 downto 0) & hsync_int;
--		end if;
--	end process;
	
--	hsync_out <= decal_h(8);
--	vsync_out <= not (M_AXIS_TVALID_o);
--    pixel_out <= M_AXIS_TDATA_o;
    
    
--SYNC0:	process( resetb,clkb )
--	begin
--		-- ------------------------------------------------- --
--		if    ( resetb='0' ) then
--			decal_h <= (others=>'1');
			
--		-- ------------------------------------------------- --
--		elsif ( rising_edge(clkb) ) then
--			decal_h <= decal_h(14 downto 0) & hsync_int;
--		end if;
--	end process;
	
--	hsync_out <= decal_h(15);
--	vsync_out <= not (M_AXIS_TVALID_o);
--    pixel_out <= M_AXIS_TDATA_o;
    
	-- Enregistre l'image g�n�r�e.
	-- --------------------------------------------------------- --
WI0:	WRITEIMG    generic map	(
				 nomfichier => nomDest
				)
		       port map	(
				 resetb,clk
				,hsync_out,vsync_out,pixel_out
				);

	-- creation des stimulis resetb,clk
	-- --------------------------------------------------------- --
	resetb <= '0','1' after 565 ns;
	
	M_AXIS_TREADY <= '0', '1' after 580 ns;

--	clk  <= (not clk and not eof ) after Periode/2;
	clk <= (not clk and not eof_delayed) after Periode/2;
    clkb <= (not clk);

    -- Process qui laisse tourner l'horloge le temps d'expulser les pixels du pipeline
    process(clkb, resetb)
        variable count : integer := 0;
    begin
        if (resetb = '0') then
            count := 0;
            eof_delayed <= '0';
        elsif rising_edge(clkb) then
            if eof = '1' then
                -- À l'échelle 4, 1 ligne demande beaucoup de cycles : 
                -- 50 000 cycles d'horloge suffisent largement à vider la fin du buffer
                if count < 100000 then
                    count := count + 1;
                else
                    eof_delayed <= '1';
                end if;
            end if;
        end if;
    end process;
 


End ARCH_TEST_PYRAMID;
-- ========================================================================= --
