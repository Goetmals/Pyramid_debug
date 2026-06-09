-- -------------------------------------------------------------------------- --
--
-- File Name :	WRITE_VESA.vhd
-- Author    :	Fred de Melo, UBO
-- Purpose   :	écriture d'une image en standard VESA au format IMV 
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		f. de Melo    01/08/2001	First Version ( inspired by Philippe Lamaty's writeimg file )
--
--              (c) Copyright IFITEP & ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
 
library std;
use std.textio.all;


-- module WRITE_VESA
-- ------------------------------------------------------------------------- --
entity WRITE_VESA is
generic	(
	 nomfichier		: string := "Imaging/ima.dst.imv";
	 
	 width			: integer := 1688;
	 height			: integer := 1066;
	 hstart			: integer :=  247;
	 hend			: integer := 1527;
	 vstart			: integer :=   37;
	 vend			: integer := 1061
	);
	
   port ( 
	 resetb		: in    std_logic;
	 clk		: in    std_logic;

	 mode		: in	std_logic;
	 
	 hsync_vsa	: in	std_logic;
	 vsync_vsa	: in	std_logic;
	 pixel_die	: in	std_logic_vector(23 downto 0);
	 pixel_dio	: in	std_logic_vector(23 downto 0)
	);
end WRITE_VESA;


-- definition de l'architecture WRITE_VESA
-- ------------------------------------------------------------------------- --
architecture ARCH_WRITE_VESA of WRITE_VESA is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- definition des fonctions internes
	-- --------------------------------------------------------- --
	function stdcar(std:in std_logic_vector(3 downto 0))return character is
	begin
		case std is
			when "0000" => return '0';
			when "0001" => return '1';
			when "0010" => return '2';
			when "0011" => return '3';
			when "0100" => return '4';
			when "0101" => return '5';
			when "0110" => return '6';
			when "0111" => return '7';
			when "1000" => return '8';
			when "1001" => return '9';
			when "1010" => return 'A';
			when "1011" => return 'B';
			when "1100" => return 'C';
			when "1101" => return 'D';
			when "1110" => return 'E';
			when "1111" => return 'F';
			when others => return 'U';
		end case;
	end stdcar;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- definition des signaux
	-- --------------------------------------------------------- --
	signal	EOI			: std_logic := '0';
	signal	M2I			: std_logic := '0';
	signal	hsync_i  ,vsync_i	: std_logic_vector( 1 downto 0);
	signal	htmp   ,  vtmp		: std_logic;
	signal  hsync_img,vsync_img	: std_logic;
	signal  hsync_rtd,vsync_rtd	: std_logic;
	signal  cpt_lig,cpt_col		: integer;
	signal  std_cpt_col		: std_logic_vector(11 downto 0);
	signal  pixel_img		: std_logic_vector(23 downto 0);


-- ========================================================================= -- 
begin
	
	-- Conversion   standard VESA ---> format Imaging Technology --
	-- --------------------------------------------------------- --
	std_cpt_col <= conv_std_logic_vector(cpt_col,12);

	
	-- Mise en oeuvre de la synchro horizontale --
	-- --------------------------------------------------------- --
HSYN0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
		        hsync_img <= '1';
			hsync_rtd <= '1';
			cpt_col   <= width - 1;
							
		elsif ( rising_edge(clk) ) then
			hsync_rtd <= hsync_vsa;
			    
			if ( hsync_vsa = '0' and hsync_rtd = '1') then
				cpt_col <= 0;
			else
				cpt_col <= cpt_col + 1;
			end if;
			    
			if    ( cpt_col = hend   ) then
				hsync_img <= '1';

			elsif ( cpt_col = hstart ) then
				hsync_img <= '0';
			end if;				
		end if;		
	end process;


	-- Mise en oeuvre de la synchro verticale --
	-- --------------------------------------------------------- --
VSYN0:	process ( resetb,clk )
	begin
		if    ( resetb='0' ) then
			vsync_rtd  <= '1';
			cpt_lig    <= height - 1;
								
		elsif ( rising_edge(clk) ) then
			vsync_rtd <= vsync_vsa;
			    
			if    ( vsync_vsa = '0' and vsync_rtd = '1') then
				cpt_lig <= 0;

			elsif ( hsync_vsa = '0' and hsync_rtd = '1' ) then
				cpt_lig <= cpt_lig + 1;
			end if;
		end if;		
	end process;


	vsync_img <=   hsync_img  when ( cpt_lig > vstart and cpt_lig <= vend ) 
	          else '1';
	
	
	-- Réécriture des pixels en sortie au format Imaging --
	-- --------------------------------------------------------- --
PIMG0:  process ( resetb,clk )
	begin
		if    ( resetb = '0' ) then
			pixel_img <= (others =>'0');
	
		elsif ( rising_edge(clk) ) then 
			if ( mode = '0' ) then
				pixel_img <= pixel_die;
	     
			elsif std_cpt_col(0) = '0' then
				pixel_img <= pixel_die;
			else
				pixel_img <= pixel_dio;
			end if;
		end if;
	end process;
	         	

	-- test la fin de l'image
	-- --------------------------------------------------------- --
TFI0:	process( resetb,clk )
		variable	ligne	: line := null;
	begin
		if    ( resetb='0' ) then
			EOI <= '0';
			M2I <= '0';

		elsif ( rising_edge(clk) ) then
			if    ( EOI='0' and hsync_img='0' and vsync_img='0' ) then
				EOI <= '1';

			elsif ( EOI='1' and hsync_img='0' and vsync_img='1' ) then
				EOI <= '0';
				M2I <= '1';
				write( ligne,string'(" IMAGE ECRITE ") );
				writeline( OUTPUT,ligne );
			end if;
		end if;
	end process;


	-- retarde les synchros H/V
	-- --------------------------------------------------------- --
SYN0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			htmp <= '1';
			vtmp <= '1';

		elsif ( rising_edge(clk) ) then
			htmp <= hsync_img;
			vtmp <= vsync_img;
		end if;
	end process;

	-- --------------------------------------------------------- --
SYN1:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			hsync_i <= (others=>'1');
			vsync_i <= (others=>'1');

		elsif ( falling_edge(clk) ) then
			hsync_i <= hsync_i(0)&htmp;
			vsync_i <= vsync_i(0)&vtmp;
		end if;
	end process;


	-- écriture des données
	-- --------------------------------------------------------- --
EDD0:	process( resetb,clk )
		file	 fichier	: text is out nomfichier;
		variable ligne		: line := null;
		variable car		: character;
		variable etoile		: character :='*';
	begin
		if ( rising_edge(clk) ) then
			if    ( EOI='1' and hsync_i(0)='0' ) then
				write( ligne,stdcar(pixel_img(7 downto 4)));
				write( ligne,stdcar(pixel_img(3 downto 0)));

			elsif ( EOI='1' and hsync_i(0)='1'
					and hsync_i(1)='0' ) then
				write( ligne,etoile );
				writeline( fichier,ligne );

			elsif ( EOI='0'
			    and hsync_img='0' and vsync_img='0'
			    and M2I='1' ) then
				write( ligne,etoile );
				writeline( fichier,ligne );
			end if;
		end if;
	end process;


end ARCH_WRITE_VESA;
-- ========================================================================= -- 
