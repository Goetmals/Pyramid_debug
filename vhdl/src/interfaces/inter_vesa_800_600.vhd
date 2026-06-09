-- ========================================================================== --
--
-- Fichier   :	INTER_VESA.vhd
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
--	f.de Melo	23.07.2001	1.0		Première version
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


--  module INTER_VESA
-- ------------------------------------------------------------------------- --
entity INTER_VESA is
   port	(	
	resetb		: in	std_logic;
	clk		: in	std_logic;
		
	-- mode even/odd --
	pixel_mode	: in	std_logic;
		
	-- imaging technology --
	hsync_img	: in	std_logic;
	vsync_img	: in	std_logic;
	pixel_img	: in	std_logic_vector( 7 downto 0);
		
	-- vesa --
	idck_2		: out	std_logic;
	die		: out	std_logic_vector( 7 downto 0);
	dio		: out	std_logic_vector( 7 downto 0);
	de		: out	std_logic;
	hsyn		: out	std_logic;
	vsyn		: out	std_logic
	);
end INTER_VESA;


--  définition de l'architecture de INTER_VESA
-- ------------------------------------------------------------------------- --
architecture ARCH_INTER_VESA of INTER_VESA is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des attributs
	-- ---------------------------------------------------------- --
attribute syn_macro : boolean;
attribute syn_macro of DIO0 : label is true;
attribute syn_macro of DIE0 : label is true;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des constantes
	-- ---------------------------------------------------------- --
constant	WIDTH			: integer := 1688;	-- impose par le standard VESA
constant	HEIGHT			: integer := 1066;	-- impose par le standard VESA

constant	HSTART			: integer := 1329;	-- debut colonne
constant	HEND			: integer := 1440;	--   fin colonne

constant	VSTART			: integer :=    0;	--0;	-- debut ligne
constant	VEND			: integer :=    2;	--2;	--   fin ligne


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux
	-- ---------------------------------------------------------- --
	signal cpt_col,	cpt_lig		: integer;
	signal hrtd, vrtd, vdly		: std_logic;
        signal BOI			: std_logic_vector( 1 downto 0);
        signal pixel_rtd		: std_logic_vector( 7 downto 0);
        signal pixel_die		: std_logic_vector( 7 downto 0);
	signal std_cpt_col		: std_logic_vector(11 downto 0);
	

-- ========================================================================== --
begin
	-- ---------------------------------------------------------- --
	std_cpt_col <= conv_std_logic_vector(cpt_col,12);


	-- mise en oeuvre de la synchro horizontale --
	-- ---------------------------------------------------------- --
HSYN0:	process ( resetb,clk)
	begin
		if    ( resetb='0' ) then
		        hsyn    <= '1';
			hrtd    <= '1';
			cpt_col <= WIDTH - 1;

		elsif ( rising_edge(clk) ) then
			hrtd <= hsync_img;
			    
			if ( hsync_img = '0' and hrtd = '1' ) then
				cpt_col <= 0;
			else
				cpt_col <= cpt_col + 1;
			end if;
	    
			if ( cpt_col >= HSTART and cpt_col <= HEND ) then
				hsyn <= '1';
			else
				hsyn <= '0';
			end if;
		end if;		
        end process;
		

	-- détection début/fin d'image --
	-- ---------------------------------------------------------- --
NSV0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then	
			BOI <= "00";

		elsif ( rising_edge(clk) ) then
			if ( hsync_img = '0' and hrtd = '1') then 	
				BOI <= BOI(0) & vsync_img;
			end if;
		end if;
	end process;

		
	-- mise en oeuvre de la synchro verticale --
	-- ---------------------------------------------------------- --
VSYN0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
			vrtd    <= '1';
			vdly    <= '1';
			vsyn    <= '0';
			cpt_lig <= HEIGHT - 1;
								
		elsif ( rising_edge(clk) ) then
			vrtd <= vsync_img;
			vdly <= vrtd;
				
			if ( hsync_img = '1' and hrtd = '0') then
				if ( BOI = "01" ) then
					cpt_lig <= 0;
				else
					cpt_lig <= cpt_lig + 1;
				end if;
			end if;     
				
			if ( cpt_col = HSTART ) then
				if ( cpt_lig >= VSTART and cpt_lig <= VEND ) then
					vsyn <= '1';
				else
					vsyn <= '0';
				end if;
			end if;
		end if;
	end process;
		

	-- mise en oeuvre de la synchro verticale --
	-- ---------------------------------------------------------- --
DE0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
			de  <= '1';
								
		elsif ( rising_edge(clk) ) then
			de <= not vdly;
		end if;
	end process;
		

	-- retarde l'entrée pixel 2 fois --
	-- ---------------------------------------------------------- --
RTD0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
			pixel_rtd <= (others=>'0');
			   	   
		elsif ( rising_edge(clk) ) then
			pixel_rtd <= pixel_img;
		end if;
	end process;


	-- sortie des pixels pairs (even) --
	-- ---------------------------------------------------------- --
DIE0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
			pixel_die <= (others=>'0');
			die       <= (others=>'0');
			   	   
		elsif ( rising_edge(clk) ) then
			if ( vrtd='1' ) then
				pixel_die <= (others=>'0');
			else
				if ( pixel_mode='1' ) then 
					if ( std_cpt_col(0)='0' ) then
						pixel_die <= pixel_img;
					else
						pixel_die <= pixel_rtd;
					end if;
				else
					pixel_die <= pixel_img;
				end if;
			end if;

			die <= pixel_die;
		end if;  	
	end process;


	-- sortie des pixels impairs (odd) --
	-- ---------------------------------------------------------- --
DIO0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
			dio <= (others=>'0');
			   	   
		elsif ( rising_edge(clk) ) then
			if ( vdly='1' ) then
				dio <= (others=>'0');
			else
				if ( std_cpt_col(0)='1' ) then
					dio <= pixel_img;
				else
					dio <= pixel_rtd;
				end if;
			end if;
		end if;
	end process;


	-- ---------------------------------------------------------- --
	idck_2	<= std_cpt_col(0);

				
end ARCH_INTER_VESA;
-- ========================================================================== --



