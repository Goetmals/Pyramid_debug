-- -------------------------------------------------------------------------- --
-- File Name :	TEST_OPNI.vhd
-- Author    :	Yves Guerin, IFITEP / Lounis Kessak, Philippe Lamaty, ENSEA / Cedric Munoz, LE2I
--
-- Purpose   :	testbench de l'amincissement de contours .
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		
--		f.De Melo	12.07.2001	
--
--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.all;


--  module TEST_OPNI
-- ------------------------------------------------------------------------- --
entity TEST_OPNI is
generic (
	  nomSrce	: string  := "./tst/ImageTests/ima.extrem.imv";
	  nomDest	: string  := "./tst/ImageTests/ima.amin.opniII.vhd.imv";
	  
	  nbcnx		: std_logic	:= '0';
	  Periode	: time		:= 9.259 ns
	);
end TEST_OPNI;

--  définition de l'architecture de TEST_OPNI
-- ------------------------------------------------------------------------- --
architecture ARCH_TEST_OPNI of TEST_OPNI is

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
component AMELIORATION
	port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 
	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 1 downto 0);

	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 1 downto 0)
	);
end component;

	-- --------------------------------------------------------- --
component FERMETURE
	port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 nbcnx		: in	std_logic;	-- nombre de connexes

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 1 downto 0);

	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 1 downto 0)
	);
end component;

	-- --------------------------------------------------------- --
component AMINFIN
	port ( 
	 resetb		: in  std_logic;
	 clkb		: in  std_logic;

	 bruit		: in  std_logic;

	 hsync_inn	: in  std_logic;
	 vsync_inn	: in  std_logic;
	 pixel_inn	: in  std_logic;

	 hsync_out	: out std_logic;
	 vsync_out	: out std_logic;
	 pixel_out	: out std_logic
	);
end component;

	-- --------------------------------------------------------- --
component WRITEIMG
	generic	(
	  	nomfichier	: string := "Imaging/ima.dst.imv"
		);
	port    ( 
		resetb		: in std_logic;
		clk		: in std_logic;

		hsync_inn	: in std_logic;
		vsync_inn	: in std_logic;
		pixel_inn	: in std_logic_vector( 7 downto 0)
		);
end component;

	-- --------------------------------------------------------- --
component RESYNCH_SGNX8
	port    ( 
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

	
	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux internes
	-- --------------------------------------------------------- --
	
	signal eof			: std_logic;
	signal resetb,clkb,clk		: std_logic :='0';
	
	signal hsync_inn		: std_logic;
	signal vsync_inn		: std_logic;
	signal pixel_inn		: std_logic_vector( 7 downto 0);
        
	signal hsync_int        	: std_logic;
	signal vsync_int		: std_logic;
	signal pixel_int		: std_logic_vector( 7 downto 0);
	
	signal pixel_ctr		: std_logic_vector( 1 downto 0);
	
	signal hsync_ame		: std_logic;
	signal vsync_ame		: std_logic;
	signal pixel_ame		: std_logic_vector( 1 downto 0);
	
	signal mode			: std_logic
					:= '0';
	signal hsync_fer		: std_logic;
	signal vsync_fer		: std_logic;
	signal pixel_fer		: std_logic_vector( 1 downto 0);
	
	signal bruit			: std_logic
					:= '0';
	signal hsync_ami		: std_logic;
	signal vsync_ami		: std_logic;
	signal pixel_ami		: std_logic;
	
	signal hsync_out 		: std_logic;
	signal vsync_out 		: std_logic;
	signal pixel_out 		: std_logic_vector(7 downto 0);
	
	signal select_output		: std_logic_vector(1 downto 0);
	                      			
	
	-- ========================================================================= --
begin	
      
      mode <= nbcnx;
      
	-- Lecture de l'image biseuillée
	-- --------------------------------------------------------- --
RI0:	READIMG		generic map	(
					 nomfichier	=> nomSrce
					,tPHV => Periode*0.35
					,pix_unknown	=> "00000000"
					)
			port map	(
					 resetb,clk
					,hsync_inn,vsync_inn,pixel_inn
					,eof
					);

	-- Resynchronisation des signaux vidéo.
	-- --------------------------------------------------------- --
RS0:	RESYNCH_SGNX8	port map	(
				 	 resetb,clkb
					,hsync_inn,vsync_inn,pixel_inn
					,hsync_int,vsync_int,pixel_int
					);

pixel_ctr <= pixel_int(1 downto 0);

	
	-- AMELIORATION des contours des contours.
	-- --------------------------------------------------------- --
--AME0:	AMELIORATION	port map	(
--					 resetb,clkb
--					,hsync_int,vsync_int,pixel_ctr
--					,hsync_ame,vsync_ame,pixel_ame
--					);
	
	-- Fermeture des contours.
	-- --------------------------------------------------------- --
--FM0:	FERMETURE	port map	(
--					 resetb,clkb
--					,mode	
--					,hsync_ame,vsync_ame,pixel_ame
--					,hsync_fer,vsync_fer,pixel_fer
--					);
	
	-- Amincissement des contours.
	-- --------------------------------------------------------- --
AM0:	AMINFIN		port map	(
					 resetb,clkb
					,bruit
					,hsync_int,vsync_int,pixel_ctr(0)
					,hsync_ami,vsync_ami,pixel_ami
					);
pixel_out <= pixel_ame & "000000"  when select_output = "00"
	else pixel_fer & "000000"  when select_output = "01"
	else "0000000" & pixel_ami;

hsync_out <= hsync_ame		  when select_output = "00"
	else hsync_fer 		  when select_output = "01"
	else hsync_ami;
	
vsync_out <= vsync_ame		  when select_output = "00"
	else vsync_fer 		  when select_output = "01"
	else vsync_ami;	 

	-- Enregistre l'image générée.
	-- --------------------------------------------------------- --
WI0:	WRITEIMG	generic map	(
					 nomfichier => nomDest
					)
			port map	(
					 resetb,clk
					,hsync_out,vsync_out,pixel_out
					);
					
	-- creation des stimulis resetb,clkb
	-- --------------------------------------------------------- --
resetb <= '0','1' after 565 ns;
clk  <= (not clk and not eof ) after Periode/2;
clkb   <= (not clk);
select_output <= "11";

end ARCH_TEST_OPNI;				
