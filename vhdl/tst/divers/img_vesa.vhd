-- ========================================================================== --
--
-- Fichier   :	Img_VESA.vhd
--
-- Auteur    :	Frederic de Melo
--
-- Copyright :	AEROSPATIALE MATRA Missiles 1998-2001
--
-- -------------------------------------------------------------------------- --
-- Modification :
--
--	Auteur		Date		Version		Commentaire
--
--	f.de Melo	23.07.2001	2.0		Première version
--
-- -------------------------------------------------------------------------- --
-- Rôle :
--
-- Conversion du format Imaging Technology au standard VESA.
--
-- ========================================================================== --


-- Définition des librairies
-- -------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity IMG_VESA is
   port	(
        resetb		: in	std_logic;
	clk		: in	std_logic;
	
	mode		: in	std_logic;
	data		: in 	std_logic_vector(99 downto 0);
		
	hsync_vsa	: out 	std_logic;
	vsync_vsa	: out	std_logic;
	pixel_die	: out   std_logic_vector(23 downto 0);
	pixel_dio	: out   std_logic_vector(23 downto 0);
		
	clk_vsa		: out 	std_logic
	);
end IMG_VESA;


architecture ARCH_IMG_VESA of IMG_VESA is

   --------------------------------------------------------------------------
   ------- Déclaration des composants internes  -----------------------------
   --------------------------------------------------------------------------
   
component SYNC_IMAGING
             port (
	        resetb			: in	std_logic;
		clk                     : in	std_logic;
		data			: in 	std_logic_vector(99 downto 0);
		
		
		hsync_img		: out 	std_logic;
		vsync_img		: out	std_logic;
		pixel_img		: out	std_logic_vector(7 downto 0)
				
		);
end component;

component INTER_VESA 
	     port (	
		resetb			: in	std_logic;
		clk			: in	std_logic;
		
		mode			: in    std_logic;
		
		hsync_img		: in 	std_logic;
		vsync_img       	: in	std_logic;
		pixel_img               : in    std_logic_vector(7 downto 0);
		
		hsync_vsa		: out 	std_logic;
		vsync_vsa       	: out	std_logic;
		pixel_die               : out   std_logic_vector(23 downto 0);
		pixel_dio               : out   std_logic_vector(23 downto 0);
		
		clk_vsa                 : out 	std_logic
		
		);		
end component;

  
   --------------------------------------------------------------------------
   ------- Déclaration des signaux internes  --------------------------------
   --------------------------------------------------------------------------
  

   signal hsync_img, vsync_img          : std_logic;
   signal pixel_img                     : std_logic_vector(7 downto 0);
  
  
begin

   
 SYN0:  SYNC_IMAGING  port map (
                                resetb,clk
			       ,data
			       ,hsync_img,vsync_img
			       ,pixel_img
			       );
			       
 IMVE:  INTER_VESA    port map (
                               resetb,clk
			      ,mode
			      ,hsync_img,vsync_img 
			      ,pixel_img
			      ,hsync_vsa,vsync_vsa
			      ,pixel_die,pixel_dio
			      ,clk_vsa
			      );
			        
end ARCH_IMG_VESA;

 







		
		
