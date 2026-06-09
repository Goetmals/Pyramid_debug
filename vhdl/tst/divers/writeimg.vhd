-- -------------------------------------------------------------------------- --
-- File Name :	WRITEIMG.vhd
-- Author    :	Y.Guerin IFITEP / Philippe Lamaty, ENSEA
-- Purpose   :	écriture d'une image au format IMV dans un fichier
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		Gus/Phil	14.02.1997	First Version
--		p.Lamaty	09.10.1998	entity update
--		p.Lamaty	12.10.1998	header update
--		p.Lamaty	26.10.1998	'*' endfile fix
--
--              (c) Copyright IFITEP & ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
 
library std;
use std.textio.all;


-- module WRITEIMG
-- ------------------------------------------------------------------------- --
entity WRITEIMG is
generic	(
	  nomfichier	: string := "Imaging/ima.dst.imv"
	);
   port ( 
	 resetb		: in std_logic;
	 clk		: in std_logic;

	 hsync_inn	: in std_logic;
	 vsync_inn	: in std_logic;
	 pixel_inn	: in std_logic_vector( 7 downto 0)
	);
end WRITEIMG;


-- definition de l'architecture WRITEIMG
-- ------------------------------------------------------------------------- --
architecture ARCH_WRITEIMG of WRITEIMG is

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
	-- definition des signaux internes
	-- --------------------------------------------------------- --
	signal	EOI			: std_logic := '0';
	signal	M2I			: std_logic := '0';
	signal	hsync_i,vsync_i		: std_logic_vector( 1 downto 0);
	signal	htmp   ,vtmp		: std_logic;


-- ========================================================================= -- 
begin
	-- test la fin de l'image
	-- --------------------------------------------------------- --
TFI0:	process( resetb,clk )
		variable	ligne	: line := null;
	begin
		if    ( resetb='0' ) then
			EOI <= '0';
			M2I <= '0';

		elsif ( rising_edge(clk) ) then
			if    ( EOI='0' and hsync_inn='0' and vsync_inn='0' ) then
				EOI <= '1';

			elsif ( EOI='1' and hsync_inn='0' and vsync_inn='1' ) then
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
			htmp <= hsync_inn;
			vtmp <= vsync_inn;
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
				write( ligne,stdcar(pixel_inn(7 downto 4)));
				write( ligne,stdcar(pixel_inn(3 downto 0)));

			elsif ( EOI='1' and hsync_i(0)='1'
					and hsync_i(1)='0' ) then
				write( ligne,etoile );
				writeline( fichier,ligne );

			elsif ( EOI='0'
			    and hsync_inn='0' and vsync_inn='0'
			    and M2I='1' ) then
				write( ligne,etoile );
				writeline( fichier,ligne );
			end if;
		end if;
	end process;


end ARCH_WRITEIMG;
-- ========================================================================= -- 
