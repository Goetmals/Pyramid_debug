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


component gradient
  port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector(7 downto 0);

	 hsync_gxy	: out	std_logic;
	 vsync_gxy	: out	std_logic;
	 pixel_gx	: out	std_logic_vector(9 downto 0);
	 pixel_gy	: out	std_logic_vector(9 downto 0)
	);
end component;



	-- --------------------------------------------------------- --

     
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
	signal  pixel_out_x, pixel_out_y : std_logic_vector( 9 downto 0);

	signal	csin0,csin1,csin2	: std_logic_vector( 6 downto 0);
	signal	csin3,csin4,csin5	: std_logic_vector( 6 downto 0);

	    
   
    --signal decal_h : std_logic_vector(29 downto 0);
    signal decal_h : std_logic_vector(15 downto 0);
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

	
                  
                       
GRD0:   gradient
                           port map(
                                resetb, clkb 
                               ,hsync_int, vsync_int, pixel_int
                               ,hsync_out, vsync_out, pixel_out_x, pixel_out_y
                               
                               );
 

	-- Enregistre l'image g�n�r�e.
	-- --------------------------------------------------------- --
WI0:	WRITEIMG    generic map	(
				 nomfichier => nomDest
				)
		       port map	(
				 resetb,clk
				,hsync_out,vsync_out,pixel_out_x(9 downto 2)
				);

	-- creation des stimulis resetb,clk
	-- --------------------------------------------------------- --
	resetb <= '0','1' after 565 ns;
	
	
	clk  <= (not clk and not eof ) after Periode/2;
	clkb <= (not clk);


End ARCH_TEST_PYRAMID;
-- ========================================================================= --
