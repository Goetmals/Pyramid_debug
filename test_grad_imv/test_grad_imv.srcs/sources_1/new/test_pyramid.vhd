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
	  nomSrce	: string  := "/home/demelo/vivado_prjs/testbench_eads/vhdl/tst/ImageTests/bridge.imv";
	  --nomDest	: string  := "C:\Users\frede\OneDrive\Documents\testbench_eads\vhdl\tst\ImageTests\cube_gf_py.imv";
      --nomDest	: string  := "/home/demelo/vivado_prjs/testbench_eads/vhdl/tst/ImageTests/bridge_grd.imv";
      nomDest	: string  := "/home/demelo/vivado_prjs/testbench_eads/vhdl/tst/ImageTests/bridge_grd.imv";
	  Periode	: time    := 10.000 ns
	);
end TEST_PYRAMID;

--  d�finition de l'architecture de TEST_OREC
-- ------------------------------------------------------------------------- --
architecture ARCH_TEST_PYRAMID of TEST_PYRAMID is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�claration des composants externes
	-- --------------------------------------------------------- --
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

component gradient_tarek
generic(
    pixel_bus_width_in : natural := 8;
    pixel_bus_width    : natural := 17;
    w_img              : natural := 640;
    h_img              : natural := 480;
    bus_width_x        : natural := unsigned_num_bits(640);
    bus_width_y        : natural := unsigned_num_bits(480));
  port(
    clk, reset, EN  : in  std_logic;
    EN_out   : out std_logic;
    xin      : in  std_logic_vector(bus_width_x-1 downto 0);
    yin      : in  std_logic_vector(bus_width_y-1 downto 0);
    xout     : out std_logic_vector(bus_width_x-1 downto 0);
    yout     : out std_logic_vector(bus_width_y-1 downto 0);
    data_in  : in  std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0));
end component;

component gaussian_filter 
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
		xin      : in  std_logic_vector(bus_width_x-1 downto 0);
		yin      : in  std_logic_vector(bus_width_y-1 downto 0);
		xout     : out std_logic_vector(bus_width_x-1 downto 0);
		yout     : out std_logic_vector(bus_width_y-1 downto 0);
		data_in  : in  std_logic_vector(pixel_bus_width-1 downto 0);
		data_out : out std_logic_vector(pixel_bus_width-1 downto 0)
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

component xy_delay_fred 
  generic (
    DELAY_X     : natural := 1;
    DELAY_Y     : natural := 0;
    IMG_WIDTH   : natural := 640;
    IMG_HEIGHT  : natural := 480
    );
  port (
    global_clk_i    : in  std_logic;
    global_resetn_i : in  std_logic;
    
    xy_en_i         : in  std_logic;
    xy_x_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
    xy_y_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
    
    xy_en_o : out std_logic;
    xy_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
    xy_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0)
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
		EN_out    : out std_logic;
		xin       : in  std_logic_vector(bus_width_x-1 downto 0);
		yin       : in  std_logic_vector(bus_width_y-1 downto 0);
		xout      : out std_logic_vector(bus_width_x-1 downto 0);
		yout      : out std_logic_vector(bus_width_y-1 downto 0);
		data_in_a : in  std_logic_vector(pixel_bus_width-1 downto 0);
		data_in_b : in  std_logic_vector(pixel_bus_width-1 downto 0);
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
    
    constant sq_sigma00 : real := 1.0;
    constant sq_sigma01 : real := 1.0;
    constant sq_sigma02 : real := 2.0;
    
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

	signal	hsync_out,vsync_out	: std_logic;
	signal	pixel_out		: std_logic_vector( 7 downto 0);

	signal	csin0,csin1,csin2	: std_logic_vector( 6 downto 0);
	signal	csin3,csin4,csin5	: std_logic_vector( 6 downto 0);

	signal	camp			: std_logic_vector( 7 downto 0);
	signal	seuil_haut,seuil_bas	: std_logic_vector( 7 downto 0);
    signal  mode                    : std_logic_vector( 2 downto 0);
    
    signal M_AXIS_TREADY, M_AXIS_TVALID, M_AXIS_TUSER, M_AXIS_TLAST :  std_logic;
    signal M_AXIS_TVALID_o, M_AXIS_TUSER_o, M_AXIS_TLAST_o :  std_logic;
    signal M_AXIS_TDATA, M_AXIS_TDATA_o : std_logic_vector( 7 downto 0);
    
    signal o_en     : std_logic;
    signal o_x      : std_logic_vector(UNSIGNED_NUM_BITS(IMG_WIDTH-1)-1 downto 0);
    signal o_y      : std_logic_vector(UNSIGNED_NUM_BITS(IMG_HEIGHT-1)-1 downto 0);
    signal o_value  : std_logic_vector(BUS_WIDTH-1 downto 0);
    
    signal en_grd, en_gf00, en_gf01, en_gf02,en_dly, en_dog00     : std_logic;
    signal x_grd, x_gf00, x_gf01, x_gf02, x_dly, x_dog00      : std_logic_vector(bus_width_x-1 downto 0);
    signal y_grd, y_gf00, y_gf01, y_gf02, y_dly, y_dog00      : std_logic_vector(bus_width_y-1 downto 0);
    signal pixel_grd, pixel_gf00, pixel_gf01, pixel_gf02, pixel_dog00  : std_logic_vector(7 downto 0);
    
    --signal decal_h : std_logic_vector(29 downto 0);
    --signal decal_h : std_logic_vector(15 downto 0);
    signal decal_h : std_logic_vector(9 downto 0);
    signal delay00_data_out_s : std_logic_vector( 7 downto 0);
	
	signal nbPixDeb, nbPixFin, nbLigDeb, nbLigFin, nbLigFinSeq	: integer := 6;
	

	 
    
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
	            ,nbLigFin => nbLigFin
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
                       
GRD0:   gradient_tarek
                           generic map(
                                8
                               ,8
                               ,IMG_WIDTH
                               ,IMG_HEIGHT
                               ,bus_width_x
                               ,bus_width_y)
                               
                             port map(
                                clkb, resetb, o_en
                               ,en_grd
                               ,o_x
                               ,o_y
                               ,x_grd
                               ,y_grd
                               ,o_value
                               ,pixel_grd
                               );
 
--DLY0:   xy_delay_fred 
--                              generic map(
--                                 DELAY_X     => 5
--                                ,DELAY_Y     => 2
--                                ,IMG_WIDTH   => 512
--                                ,IMG_HEIGHT  => 512
--                                )
--                              port map (
--                                 global_clk_i    => clkb
--                                ,global_resetn_i => resetb
                                
--                                ,xy_en_i    => en_grd
--                                ,xy_x_i     => x_grd
--                                ,xy_y_i     => y_grd
                                
--                                ,xy_en_o     => en_dly
--                                ,xy_x_o     => x_dly
--                                ,xy_y_o     => y_dly
--                                        );
                            
--GF00:     gaussian_filter 
--                            generic map(
--                                 8
--                                ,IMG_WIDTH
--                                ,IMG_HEIGHT
--                                ,bus_width_x
--                                ,bus_width_y
                            
--                                ,sq_sigma00            
--                                ,kernel_width        
--                                ,bus_width_coeff_sum 
--                            )
--                            port map(
--                                 clkb, en_grd
--                                ,resetb
--                                ,en_gf00
--                                ,x_grd
--                                ,y_grd
--                                ,x_gf00
--                                ,y_gf00
--                                ,pixel_grd
--                                ,pixel_gf00
--                            );

--GF01:     gaussian_filter 
--                            generic map(
--                                 8
--                                ,IMG_WIDTH
--                                ,IMG_HEIGHT
--                                ,bus_width_x
--                                ,bus_width_y
                            
--                                ,sq_sigma01            
--                                ,kernel_width        
--                                ,bus_width_coeff_sum 
--                            )
--                            port map(
--                                 clkb, en_gf00
--                                ,resetb
--                                ,en_gf01
--                                ,x_gf00
--                                ,y_gf00
--                                ,x_gf01
--                                ,y_gf01
--                                ,pixel_gf00
--                                ,pixel_gf01
--                            );

--DLY01:  delay
--		generic map (
--			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
--			w_img => IMG_WIDTH,
--			h_img => IMG_HEIGHT,
--			delay_x => GAUSS_DELAY_X_C,
--			delay_y => GAUSS_DELAY_Y_C
--		)
--		port map (
--			clk => clkb,
--			EN => en_gf00,
--			data_in => pixel_gf00,
--			data_out => delay00_data_out_s
--		);
		
--DOG00:  dog
--		generic map (
--			pixel_bus_width => unsigned_num_bits(MAX_COLOR),
--			w_img => IMG_WIDTH,
--			h_img => IMG_HEIGHT,
--			bus_width_x => unsigned_num_bits(IMG_WIDTH-1),
--			bus_width_y => unsigned_num_bits(IMG_HEIGHT-1)
--		)
--		port map (
--			clk => clkb,
--			EN => en_gf01,
--			EN_out => en_dog00,
--			xin => x_gf01,
--			yin => y_gf01,
--			xout => x_dog00,
--			yout => y_dog00,
--			data_in_a => pixel_gf01,
--			data_in_b => delay00_data_out_s,
--			data_out => pixel_dog00
--		);		

--GF02:     gaussian_filter 
--                            generic map(
--                                 8
--                                ,IMG_WIDTH
--                                ,IMG_HEIGHT
--                                ,bus_width_x
--                                ,bus_width_y
                            
--                                ,sq_sigma02            
--                                ,kernel_width        
--                                ,bus_width_coeff_sum 
--                            )
--                            port map(
--                                 clkb, en_grd
--                                ,resetb
--                                ,en_gf02
--                                ,x_gf01
--                                ,y_gf01
--                                ,x_gf02
--                                ,y_gf02
--                                ,pixel_gf01
--                                ,pixel_gf02
--                            );
                            
                                     
XYAS0:  xy_to_axis 
                                   generic map (
                                        MAX_COLOR
                                       ,IMG_WIDTH
                                       ,IMG_HEIGHT
                                   )
                                   port map (
                                        clkb,resetb
                               --------------------------------------------------------------------------------
                               -- XYEn side
                               --------------------------------------------------------------------------------
                                       ,en_grd
                                       ,x_grd
                                       ,y_grd
                                       ,pixel_grd
                               --------------------------------------------------------------------------------
                               -- AXIS Master side
                               --------------------------------------------------------------------------------
                                       ,M_AXIS_TVALID_o
                                       ,M_AXIS_TUSER_o
                                       ,M_AXIS_TLAST_o
                                       ,M_AXIS_TREADY
                                       ,M_AXIS_TDATA_o
                                   );                      
                               

--hsync_out <= hsync_int;
--vsync_out <= not (M_AXIS_TVALID_o);
--pixel_out <= M_AXIS_TDATA_o;
    
    
SYNC0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			decal_h <= (others=>'1');
			
		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			decal_h <= decal_h(8 downto 0) & hsync_int;
		end if;
	end process;
	
	hsync_out <= decal_h(7);
	vsync_out <= not (M_AXIS_TVALID_o);
    pixel_out <= M_AXIS_TDATA_o;
    
    
--SYNC1:	process( resetb,clkb )
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

	clk  <= (not clk and not eof ) after Periode/2;
	clkb <= (not clk);


End ARCH_TEST_PYRAMID;
-- ========================================================================= --
