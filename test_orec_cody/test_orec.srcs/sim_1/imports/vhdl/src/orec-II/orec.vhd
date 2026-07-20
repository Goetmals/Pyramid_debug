-- ========================================================================== --
--
-- Fichier   :	OREC.vhd
--
-- Auteur    :	Frederic de Melo
--
-- Copyright :	AEROSPATIALE MATRA Missiles 2001-2001
--
-- -------------------------------------------------------------------------- --
-- Modification :
--
--	Auteur		Date		Version		Commentaire
--
--	f.de Melo	23.04.2001	1.0		Cr�ation
--
-- -------------------------------------------------------------------------- --
-- R�le :
--
--
-- mode	000	tranparent
--	001	convolueur
--	010	gradients horizontaux
--	011	gradients verticaux
--	100	norme des gradients
--	101	orientation des gradients
--	110	maxima locaux
--	111	bi-seuillage
--
-- ========================================================================== --


-- D�finition des librairies
-- -------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;

--  module OREC
-- ------------------------------------------------------------------------- --
entity OREC is
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

	 mode           : in	std_logic_vector( 2 downto 0);

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 7 downto 0);
	 
	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 7 downto 0)
	);
end OREC;


--  d�finition de l'architecture de OREC
-- ------------------------------------------------------------------------- --
architecture ARCH_OREC of OREC is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�claration des composants externes
	-- --------------------------------------------------------- --
component CONV_COL
   port (
         resetb		: in	std_logic;
	 clk		: in	std_logic;

	 csin0		: in	std_logic_vector( 6 downto 0);
	 csin1		: in	std_logic_vector( 6 downto 0);
	 csin2		: in	std_logic_vector( 6 downto 0);
	 csin3		: in	std_logic_vector( 6 downto 0);
	 csin4		: in	std_logic_vector( 6 downto 0);
	 csin5 		: in	std_logic_vector( 6 downto 0);

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 7 downto 0);

	 hsync_out 	: out	std_logic;
	 vsync_out 	: out	std_logic;
	 pixel_out 	: out	std_logic_vector(11 downto 0)
	);
end component;	

	-- --------------------------------------------------------- --
component CONV_LIG
   port (
         resetb		: in	std_logic;
	 clk		: in	std_logic;

	 csin0		: in	std_logic_vector( 6 downto 0);
	 csin1		: in	std_logic_vector( 6 downto 0);
	 csin2		: in	std_logic_vector( 6 downto 0);
	 csin3		: in	std_logic_vector( 6 downto 0);
	 csin4		: in	std_logic_vector( 6 downto 0);
	 csin5 		: in	std_logic_vector( 6 downto 0);

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector(11 downto 0);

	 hsync_out 	: out	std_logic;
	 vsync_out 	: out	std_logic;
	 pixel_out 	: out	std_logic_vector(15 downto 0)
	 );
end component;	 

	 -- --------------------------------------------------------- --
component AMPL
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 const		: in	std_logic_vector( 7 downto 0);

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector(15 downto 0);

	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector(15 downto 0)
	);
end component;

	-- --------------------------------------------------------- --
component GRADIENT
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector(15 downto 0);

	 hsync_gxy	: out	std_logic;
	 vsync_gxy	: out	std_logic;
	 pixel_gx	: out	std_logic_vector(17 downto 0);
	 pixel_gy	: out	std_logic_vector(17 downto 0)
	);
end component;

	-- --------------------------------------------------------- --
component NORM_ORIE
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 hsync_gxy	: in	std_logic;
	 vsync_gxy	: in	std_logic;
	 pixel_gx	: in	std_logic_vector(17 downto 0);
	 pixel_gy	: in	std_logic_vector(17 downto 0);

	 hsync_nrm	: out	std_logic;
	 vsync_nrm	: out	std_logic;
	 pixel_ngd	: out	std_logic_vector(17 downto 0);
	 pixel_ori	: out	std_logic_vector( 3 downto 0)
	);
end component;
	
	-- --------------------------------------------------------- --
component SNML
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 hsync_nrm	: in	std_logic;
	 vsync_nrm	: in	std_logic;
	 pixel_ngd	: in	std_logic_vector(17 downto 0);
	 pixel_nor	: in	std_logic_vector( 2 downto 0);

	 hsync_max	: out	std_logic;
	 vsync_max	: out	std_logic;
	 pixel_max	: out	std_logic_vector(17 downto 0);
	 pixel_mor	: out	std_logic_vector( 2 downto 0)
	);
end component;

	-- --------------------------------------------------------- --
component BISEUILLAGE
   port	(
	  resetb	: in	std_logic;
	  clk		: in	std_logic;

	  seuilbas	: in	std_logic_vector( 7 downto 0);
	  seuilhaut	: in	std_logic_vector( 7 downto 0);

	  hsync_inn	: in	std_logic;
	  vsync_inn	: in	std_logic;
	  pixel_inn	: in	std_logic_vector( 7 downto 0);

	  hsync_out	: out	std_logic;
	  vsync_out	: out	std_logic;
	  pixel_out	: out	std_logic_vector( 1 downto 0)
	);
end component;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�claration des signaux internes
	-- --------------------------------------------------------- --
	signal	hsync_cvc,vsync_cvc	: std_logic;
	signal	pixel_cvc		: std_logic_vector(11 downto 0);
					
	signal	hsync_cvn,vsync_cvn	: std_logic;
	signal	pixel_cvn		: std_logic_vector(15 downto 0);
					
	signal	hsync_amp,vsync_amp	: std_logic;
	signal	pixel_amp       	: std_logic_vector(15 downto 0);

	signal	hsync_gxy,vsync_gxy	: std_logic;
	signal	pixel_gx ,pixel_gy 	: std_logic_vector(17 downto 0);
	signal	pixel_vgx,pixel_vgy	: std_logic_vector( 7 downto 0);

	signal  hsync_nrm,vsync_nrm     : std_logic;
	signal  pixel_ngd               : std_logic_vector(17 downto 0);
	signal  pixel_ori               : std_logic_vector( 3 downto 0);

	signal  hsync_max,vsync_max     : std_logic;
	signal  pixel_max		: std_logic_vector(17 downto 0);
	signal  pixel_mor		: std_logic_vector( 2 downto 0);
	
	signal	hsync_ctr,vsync_ctr	: std_logic;
	signal	pixel_ctr		: std_logic_vector( 1 downto 0);


-- ========================================================================= --
begin

	-- Convolueur 12x12
	-- --------------------------------------------------------- --
CVC0:   CONV_COL       port map	(
                                 resetb
				,clk
				,csin0,csin1,csin2,csin3,csin4,csin5
				,hsync_inn,vsync_inn,pixel_inn
				,hsync_cvc,vsync_cvc,pixel_cvc
				);
                                 	
CVL0:   CONV_LIG       port map	(
                                 resetb
				,clk
				,csin0,csin1,csin2,csin3,csin4,csin5
				,hsync_cvc,vsync_cvc,pixel_cvc
				,hsync_cvn,vsync_cvn,pixel_cvn
				);
                                 	

	-- Amplification
	-- --------------------------------------------------------- --
AMP0:	AMPL	       port map	(
				 resetb
				,clk
				,camp
				,hsync_cvn,vsync_cvn,pixel_cvn
				,hsync_amp,vsync_amp,pixel_amp	
				);
	
	     
	-- Calcul des gradients horizontaux et verticaux
	-- --------------------------------------------------------- --
GXY0:	GRADIENT      port map	( 
				 resetb
				,clk
				,hsync_amp,vsync_amp,pixel_amp
				,hsync_gxy,vsync_gxy,pixel_gx,pixel_gy
				);
	

	-- Calcul de la norme et de l'orientation des gradients
	-- --------------------------------------------------------- --
NRO:   NORM_ORIE      port map	(
                                 resetb
				,clk
				,hsync_gxy,vsync_gxy,pixel_gx,pixel_gy
				,hsync_nrm,vsync_nrm,pixel_ngd,pixel_ori
				);

		
	-- Extraction des maxima locaux
	-- (ou Seuillage des non maxima locaux)
	-- --------------------------------------------------------- --
EML0:	SNML          port map	(
                    	         resetb
				,clk
				,hsync_nrm,vsync_nrm,pixel_ngd,pixel_ori(2 downto 0)
				,hsync_max,vsync_max,pixel_max,pixel_mor
				);

	-- Bi-seuillage
	-- --------------------------------------------------------- --
SEU0:	BISEUILLAGE    port map	( 
				 resetb
				,clk
				,seuil_bas,seuil_haut
				,hsync_max,vsync_max,pixel_max(17 downto 10)
				,hsync_ctr,vsync_ctr,pixel_ctr
				);


	-- Configuration en sortie de l' OREC
	-- --------------------------------------------------------- --
	pixel_vgx <=   not pixel_gx(15 downto 8) when pixel_gx(17)='1'
		  else     pixel_gx(15 downto 8);

	pixel_vgy <=   not pixel_gy(15 downto 8) when pixel_gy(17)='1'
		  else     pixel_gy(15 downto 8);

	-- --------------------------------------------------------- --
OUT0:	process (resetb,clk)
	begin
		if    ( resetb='0' ) then
			hsync_out <= '1';
			vsync_out <= '1';
			pixel_out <= (others=>'0');

		elsif ( rising_edge(clk) ) then
			case mode is
				when "000"  =>	hsync_out <= hsync_inn;
						vsync_out <= vsync_inn;
						pixel_out <= pixel_inn;

				when "001"  =>	hsync_out <= hsync_cvn;
						vsync_out <= vsync_cvn;
						pixel_out <= pixel_cvn(15 downto 8);

				when "010"  =>	hsync_out <= hsync_gxy;
						vsync_out <= vsync_gxy;
						pixel_out <= pixel_vgx;

				when "011"  =>	hsync_out <= hsync_gxy;
						vsync_out <= vsync_gxy;
						pixel_out <= pixel_vgy;

				when "100"  =>	hsync_out <= hsync_nrm;
						vsync_out <= vsync_nrm;
						pixel_out <= pixel_ngd(17 downto 10);

				when "101"  =>	hsync_out <= hsync_nrm;
						vsync_out <= vsync_nrm;
						pixel_out <= pixel_ori & "0000";

				when "110"  =>	hsync_out <= hsync_max;
						vsync_out <= vsync_max;
						pixel_out <= pixel_max(17 downto 10);

				when others =>	hsync_out <= hsync_ctr;
						vsync_out <= vsync_ctr;
--						pixel_out <= pixel_ctr & "000000";
						case pixel_ctr is
							when "11"   => pixel_out <= "00000000";
							when "10"   => pixel_out <= "10000000";
							when others => pixel_out <= "11111111";
						end case;
			end case;
		end if;
	end process;
	
end ARCH_OREC;
-- ========================================================================= --

                 
