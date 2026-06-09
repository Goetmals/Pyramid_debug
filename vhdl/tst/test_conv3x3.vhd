-- -------------------------------------------------------------------------- --
-- File Name :	TEST_CONV3X3.vhd
-- Author    :	Philippe Lamaty
-- Purpose   :	testbench de conv3x3
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		p.Lamaty	26.04.2002	creation

--		    (c) Copyright AEROSPATIALE MATRA Missiles
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;


--  module TEST_CONV3X3
-- ------------------------------------------------------------------------- --
entity TEST_CONV3X3 is
generic (
	  nomSrce	: string  := "./tst/ImageTests/ima6x6.imv";
	  nomDest	: string  := "./tst/ImageTests/result.vhd.imv";

	  Periode	: time    := 9.259 ns
	);
end TEST_CONV3X3;

--  définition de l'architecture de TEST_CONV3X3
-- ------------------------------------------------------------------------- --
architecture ARCH_TEST_CONV3X3 of TEST_CONV3X3 is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des composants externes
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
component CONV3X3
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 csin00		: in	std_logic_vector( 7 downto 0);
	 csin01		: in	std_logic_vector( 7 downto 0);
	 csin02		: in	std_logic_vector( 7 downto 0);
	 csin10		: in	std_logic_vector( 7 downto 0);
	 csin11		: in	std_logic_vector( 7 downto 0);
	 csin12		: in	std_logic_vector( 7 downto 0);
	 csin20		: in	std_logic_vector( 7 downto 0);
	 csin21		: in	std_logic_vector( 7 downto 0);
	 csin22		: in	std_logic_vector( 7 downto 0);

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 7 downto 0);
         
	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 7 downto 0)
	);
end component;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux internes
	-- --------------------------------------------------------- --
	signal	eof			: std_logic;
	signal	resetb ,clk,clkb	: std_logic := '0';

	signal	hsync_inn,vsync_inn	: std_logic;
	signal	pixel_inn		: std_logic_vector( 7 downto 0);

	signal	hsync_int,vsync_int	: std_logic;
	signal	pixel_int		: std_logic_vector( 7 downto 0);

	signal	hsync_out,vsync_out	: std_logic;
	signal	pixel_out		: std_logic_vector( 7 downto 0);

	signal	csin00,csin01,csin02	: std_logic_vector( 7 downto 0);
	signal	csin10,csin11,csin12	: std_logic_vector( 7 downto 0);
	signal	csin20,csin21,csin22	: std_logic_vector( 7 downto 0);


-- ========================================================================= --
begin
	-- Lecture d'une image et génération des signaux vidéo.
	-- --------------------------------------------------------- --
RI0:	READIMG	    generic map	(
				 nomfichier => nomSrce
				,tPHV => Periode*0.35
				,pix_unknown => "ZZZZZZZZ"
				)
		       port map	(
				 resetb,clk
				,hsync_inn,vsync_inn,pixel_inn
				,eof
				);

	-- Resynchronisation des signaux vidéo.
	-- --------------------------------------------------------- --
RS0:	RESYNCH_SGNX8  port map	(
				 resetb,clkb
				,hsync_inn,vsync_inn,pixel_inn
				,hsync_int,vsync_int,pixel_int
				);

	-- convolution 3x3
	-- --------------------------------------------------------- --
CVN0:	CONV3X3        port map	(
				 resetb,clkb
				,csin00,csin01,csin02
				,csin10,csin11,csin12
				,csin20,csin21,csin22
				,hsync_int,vsync_int,pixel_int
				,hsync_out,vsync_out,pixel_out
				);


	-- Enregistre l'image générée.
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


	-- coefficients de convolution
	-- --------------------------------------------------------- --
	csin00 <= "00000001";	csin01 <= "00000001";	csin02 <= "00000001";
	csin10 <= "00000001";	csin11 <= "00000001";	csin12 <= "00000001";
	csin20 <= "00000001";	csin21 <= "00000001";	csin22 <= "00000001";


End ARCH_TEST_CONV3X3;
-- ========================================================================= --
