-- ========================================================================== --
--
-- Fichier   :	SYNC_IMAGING.vhd
--
-- Auteur    :	Cedric Munoz
--
-- Copyright :	AEROSPATIALE MATRA Missiles 2001
--
-- -------------------------------------------------------------------------- --
-- Modification :
--
--	Auteur		Date		Version		Commentaire
--
--	c.Munoz		25.07.2001	2.0		Première version
--
-- -------------------------------------------------------------------------- --


-- ===================================================================== --
--									 --
-- Pilotage du capteur CMOS et restitution des donnees au format IMAGING --
--									 --
-- ===================================================================== --




-- Définition des librairies
-- -------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


--  module SYNC_IMAGING
-- ------------------------------------------------------------------------- --
entity SYNC_IMAGING is
	port 	(	
		resetb			: in	std_logic;
		clk                     : in	std_logic;
		data			: in 	std_logic_vector(99 downto 0);
		
		
		hsync_img		: out 	std_logic;
		vsync_img			: out	std_logic;
		pixel_img		: out	std_logic_vector(7 downto 0)
				
		);
end SYNC_IMAGING;


--  définition de l'architecture de SYNC_IMAGING
-- ------------------------------------------------------------------------- --
architecture ARCH_SYNC_IMAGING of SYNC_IMAGING is

	-- ---------------------------------- --
	-- définition des constantes internes --
	-- ---------------------------------- --

	constant width	: integer := 169; -- 1688;	-- impose par le standard VESA
	constant height	: integer := 107; -- 1066; 	-- impose par le standard VESA
	constant hstart	: integer := 1;		        -- origine colonne
	constant hend	: integer := 128; -- 1280;	-- fin colonne
	constant vstart	: integer := 0;		        -- origine ligne
	constant vend	: integer := 102; -- 1024;	-- fin ligne
	
	
	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- ---------------------------------------------------------- --
	signal cpt_col		: 	integer;
	signal cpt_lig 		: 	integer;
	signal compt10		:	integer;
	signal af,bg,ch,di,ej	:	std_logic_vector(7 downto 0);
	
-- ========================================================================== --

begin



-------------------------------------------------------------
------- Mise en oeuvre des compteurs ligne et colonne -------
-------------------------------------------------------------

compt 	:	process ( resetb,clk )
		begin
	
			if    ( resetb='0' ) then
			
				cpt_col <= width  - 1;
				cpt_lig <= height - 1;
				
			elsif ( rising_edge(clk) ) then
	
				if cpt_col >= width  - 1 then
					cpt_col <= 0;
					
					if cpt_lig >= height - 1 then
						cpt_lig <= 0;
					else
						cpt_lig <= cpt_lig + 1;
					end if;
				else
					cpt_col <= cpt_col + 1;
				end if;				
							
			end if;		
	end process;
	

	
----------------------------------------------------------------------------------
------- Generation des synchros horizontale et verticale au format imaging -------
----------------------------------------------------------------------------------
		
shv 	:	process ( resetb,clk )
		begin
			
			if    ( resetb='0' ) then 
				
				hsync_img <= '1';
				vsync_img <= '1';
			
			elsif ( rising_edge(clk) ) then 
				
				if ( cpt_col >= hstart and cpt_col < hend ) then
					hsync_img <= '0';
					
					if ( cpt_lig >= vstart and cpt_lig < vend ) then
						vsync_img <= '0';
					else
						vsync_img <= '1';
					end if;
				else
					
					hsync_img <= '1';
					vsync_img <= '1';
				end if;
			end if;	 
		
	end process;


----------------------------------------------
------ Generation du compteur modulo 10 ------
----------------------------------------------

cpt1	:	process ( resetb,clk )
		begin
	
			if    ( resetb='0' ) then
			
				compt10 <= 0;
				
			elsif ( rising_edge(clk) ) then
			
				if (compt10 = 9 or cpt_col = 0) then
					compt10 <= 0;
				else
					compt10 <= compt10 + 1;
				end if;
			end if;
		end process; 			


			
-------------------------------------------------------------------
------ Memorisation des 10 bus de 10 bits du CMOS en 2 fois  ------
-------------------------------------------------------------------

mux	:	process ( resetb, clk )
		begin
			if    ( resetb='0' ) then
			
				af <= ( others => '0');
				bg <= ( others => '0');			
				ch <= ( others => '0');
				di <= ( others => '0');
				ej <= ( others => '0');
				
			elsif ( rising_edge(clk) ) then
				
				if compt10 = 1 then
				
					af <= data (99 downto 92);
					bg <= data (89 downto 82);
					ch <= data (79 downto 72);
					di <= data (69 downto 62);
					ej <= data (59 downto 52);
				
				elsif compt10 = 6 then
					
					af <= data (49 downto 42);
					bg <= data (39 downto 32);
					ch <= data (29 downto 22);
					di <= data (19 downto 12);
					ej <= data ( 9 downto  2);
					
				end if;
			end if;
		end process;


-------------------------------------------------------------------
------ 	Mise en serie des 10 bus paralleles du capteur CMOS  ------
-------------------------------------------------------------------		

p_s	:	process ( resetb, clk )
		begin
		
			if    ( resetb='0' ) then
				
				pixel_img <= (others => '0');
				
			elsif ( rising_edge(clk) ) then
				
				case compt10 is
					
					when 2|7 =>
						pixel_img <= af;
					when 3|8 =>
						pixel_img <= bg;
					when 4|9 =>
						pixel_img <= ch;	
					when 5|0 =>
						pixel_img <= di;
					when others =>
						pixel_img <= ej;
				end case;
			end if;
		end process;


end ARCH_SYNC_IMAGING;
-- ========================================================================== --
