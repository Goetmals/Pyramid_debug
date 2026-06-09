-- ========================================================================== --
--
-- Fichier   :	INCRUSTE.vhd
--
-- Auteur    :	Philippe Lamaty / Jerome Michel
--
-- Copyright :	AEROSPATIALE MATRA Missiles 1998-2001
--
-- -------------------------------------------------------------------------- --
-- Modification :
--
--	Auteur		Date		Version		Commentaire
--
--	p.Lamaty	10.01.2002	1.0		création
--	j.Michel	    "		 "		    "	
--
-- -------------------------------------------------------------------------- --
-- Rôle :
--
-- Incruste une image de 100x10 dans le coin bas-droit.
--
-- ========================================================================== --


--  définition des librairies
-- -------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

-- pragma translate_off
library XilinxCoreLib;
use XilinxCoreLib.all;
-- pragma translate_on


--  module INCRUSTE
-- ------------------------------------------------------------------------- --
entity INCRUSTE is
   port	(	
	resetb		: in	std_logic;
	clk		: in	std_logic;
		
	-- mode --
	mode		: in	std_logic_vector( 3 downto 0);
		
	-- imaging technology --
	hsync_inn	: in	std_logic;
	vsync_inn	: in	std_logic;
	pixel_inn	: in	std_logic_vector( 7 downto 0);
		
	-- vesa --
	hsync_out	: out	std_logic;
	vsync_out	: out	std_logic;
	pixel_out	: out	std_logic_vector( 7 downto 0)
	);
end INCRUSTE;


--  définition de l'architecture de INCRUSTE
-- ------------------------------------------------------------------------- --
architecture ARCH_INCRUSTE of INCRUSTE is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des composants
	-- ---------------------------------------------------------- --
component rom_message
   port	(
	clk		: in	std_logic;
	addr		: in	std_logic_vector(13 downto 0);
	dout		: out	std_logic_vector( 0 downto 0)
	);
end component;

-- pragma translate_off
for MES0 : rom_message use entity XilinxCoreLib.blkmemsp_v3_1(behavioral)
		generic map(
			 c_reg_inputs		=> 0
			,c_addr_width		=> 14
			,c_has_sinit		=> 0
			,c_has_rdy		=> 0
			,c_width		=> 1
			,c_has_en		=> 0
			,c_mem_init_file	=> "src/interfaces/rom.mif"
			,c_depth		=> 16384
			,c_has_nd		=> 0
			,c_has_default_data	=> 0
			,c_default_data		=> "0"
			,c_limit_data_pitch	=> 18
			,c_pipe_stages		=> 0
			,c_has_rfd		=> 0
			,c_has_we		=> 0
			,c_sinit_value		=> "0"
			,c_has_limit_data_pitch	=> 0
			,c_enable_rlocs		=> 0
			,c_has_din		=> 0
			,c_write_mode		=> 0
			);
-- pragma translate_on

-- Synplicity black box declaration
attribute syn_black_box : boolean;
attribute syn_black_box of rom_message: component is true;

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des constantes
	-- ---------------------------------------------------------- --
constant	WIDTH			: integer := 1688;	-- impose par le standard VESA
constant	HEIGHT			: integer := 1066;	-- impose par le standard VESA

constant	HSTART			: integer :=    0;	-- debut message colonne
constant	HEND			: integer :=   63;	--   fin message colonne

constant	VSTART			: integer :=    0;	-- debut message ligne
constant	VEND			: integer :=   15;	--   fin message ligne


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux
	-- ---------------------------------------------------------- --
	signal	cpt_col			: integer;
	signal	cpt_lig			: integer;
	signal	hrtd			: std_logic;
        signal	BOI			: std_logic_vector( 1 downto 0);
	signal	addr			: std_logic_vector(13 downto 0);
	signal	dout			: std_logic_vector( 0 downto 0);
	signal	flag0			: std_logic;
	

-- ========================================================================== --
begin
	-- compteur ligne horizontale --
	-- ---------------------------------------------------------- --
HSYN0:	process ( resetb,clk)
	begin
		if    ( resetb='0' ) then
			hrtd    <= '1';
			cpt_col <= WIDTH - 1;

		elsif ( rising_edge(clk) ) then
			hrtd <= hsync_inn;
			    
			if ( hsync_inn = '0' and hrtd = '1' ) then
				cpt_col <= 0;
			else
				cpt_col <= cpt_col + 1;
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
			if ( hsync_inn = '0' and hrtd = '1') then 	
				BOI <= BOI(0) & vsync_inn;
			end if;
		end if;
	end process;

		
	-- compteur ligne verticale --
	-- ---------------------------------------------------------- --
VSYN0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
			cpt_lig <= HEIGHT - 1;
								
		elsif ( rising_edge(clk) ) then
			if ( hsync_inn = '1' and hrtd = '0') then
				if ( BOI = "10" ) then
					cpt_lig <= 0;
				else
					cpt_lig <= cpt_lig + 1;
				end if;
			end if;     
		end if;
	end process;
		

	-- ---------------------------------------------------------- --
FLG0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
			flag0 <= '0';

		elsif ( rising_edge(clk) ) then
			if (	cpt_col >= hstart and cpt_col <= hend
			    and cpt_lig >= vstart and cpt_lig <= vend ) then
				flag0 <= '1';
			else
				flag0 <= '0';
			end if;
		end if;
	end process;

	-- affichage du cartouche --
	-- ---------------------------------------------------------- --
OUT0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
			hsync_out <= '1';
			vsync_out <= '1';
			pixel_out <= "00000000";

		elsif ( rising_edge(clk) ) then
			hsync_out <= hsync_inn;
			vsync_out <= vsync_inn;
			if ( flag0='1' ) then
				if ( dout = "1" ) then
					pixel_out <= "11111111";
				else
					pixel_out <= '0' & pixel_inn(7 downto 1);
				end if;
			else
				pixel_out <= pixel_inn;
			end if;
		end if;
	end process;


	-- définition de l'adresse du message --
	-- ---------------------------------------------------------- --
	addr <= '0' & mode(2 downto 0) & conv_std_logic_vector(cpt_lig,4) & conv_std_logic_vector(cpt_col,6);


	-- lecture du cartouche --
	-- ---------------------------------------------------------- --
MES0:	rom_message    port map	(
				 clk		=> clk
				,addr		=> addr
				,dout		=> dout
				);

				
end ARCH_INCRUSTE;
-- ========================================================================== --



