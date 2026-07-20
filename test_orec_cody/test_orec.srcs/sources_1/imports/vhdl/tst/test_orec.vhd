-- -------------------------------------------------------------------------- --
-- File Name :	TEST_OREC.vhd
-- Author    :	Philippe Lamaty
-- Purpose   :	testbench
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		p.Lamaty	09.03.2001	First    Version
--              f.de Melo         .  .2001      FPGA     Version

--		    (c) Copyright AEROSPATIALE MATRA Missiles
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;

library work;
use work.saturn_numeric_pkg.all;


--  module TEST_OREC
-- ------------------------------------------------------------------------- --
entity TEST_OREC is
generic (
	  nomSrce	: string  := "/home/demelo/vivado_prjs/testbench_eads/vhdl/tst/ImageTests/bridge.imv";
	  nomDest	: string  := "/home/demelo/vivado_prjs/testbench_eads/vhdl/tst/ImageTests/bridge_grd_orec.imv";

	  Periode	: time    := 9.259 ns
	);
end TEST_OREC;

--  d�finition de l'architecture de TEST_OREC
-- ------------------------------------------------------------------------- --
architecture ARCH_TEST_OREC of TEST_OREC is

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
component OREC
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 csin0		: in	std_logic_vector( 6 downto 0);
	 csin1		: in	std_logic_vector( 6 downto 0);
	 csin2		: in	std_logic_vector( 6 downto 0);
	 csin3		: in	std_logic_vector( 6 downto 0);
	 csin4		: in	std_logic_vector( 6 downto 0);
	 csin5		: in	std_logic_vector( 6 downto 0);

	 camp		: in	std_logic_vector( 7 downto 0);
	 seuil_bas	: in	std_logic_vector( 7 downto 0);
	 seuil_haut	: in	std_logic_vector( 7 downto 0);

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 7 downto 0);
         
	 mode           : in	std_logic_vector( 2 downto 0);
	 
	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 7 downto 0)
	);
end component;


      
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
    
       
    
-- ========================================================================= --
begin
	-- Lecture d'une image et g�n�ration des signaux vid�o.
	-- --------------------------------------------------------- --
RI0:	READIMG	    generic map	(
				 nomfichier => nomSrce
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

	
             
                               
OR0:	OREC           port map	(
				 resetb,clk
				,csin0,csin1,csin2,csin3,csin4,csin5
				,camp
				,seuil_bas,seuil_haut
				,hsync_int,vsync_int,pixel_int
				,mode
				,hsync_out,vsync_out,pixel_out
				);
				

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
	
	clk  <= (not clk and not eof ) after Periode/2;
	clkb <= (not clk);

	-- D�finition des constantes.
	-- --------------------------------------------------------- --
--	csin0 <= conv_std_logic_vector( 2,7 );
--	csin1 <= conv_std_logic_vector( 7,7 );
--	csin2 <= conv_std_logic_vector( 15,7 );
--	csin3 <= conv_std_logic_vector( 25,7 );
--	csin4 <= conv_std_logic_vector( 36,7 );
--	csin5 <= conv_std_logic_vector( 43,7 );

	csin0 <= conv_std_logic_vector( 3,7 );
	csin1 <= conv_std_logic_vector( 8,7 );
	csin2 <= conv_std_logic_vector( 15,7 );
	csin3 <= conv_std_logic_vector( 24,7 );
	csin4 <= conv_std_logic_vector( 33,7 );
	csin5 <= conv_std_logic_vector( 41,7 );

	camp  <= conv_std_logic_vector( 64,8 );
	
--        seuil_bas  <= conv_std_logic_vector( 2,8 );
--	seuil_haut <= conv_std_logic_vector( 4,8 );
      
    seuil_bas  <= conv_std_logic_vector( 10,8 );
	seuil_haut <= conv_std_logic_vector( 40,8 );
	
	mode  <= conv_std_logic_vector( 0,3 );


End ARCH_TEST_OREC;
-- ========================================================================= --
