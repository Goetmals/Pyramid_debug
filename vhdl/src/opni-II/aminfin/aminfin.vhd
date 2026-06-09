-- -------------------------------------------------------------------------- --
-- File Name :	AMINFIN.vhd
-- Author    :	Philippe Lamaty, ENSEA
-- Purpose   :	amincissement de contours avec un masque 3x3
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		p.Lamaty	26.11.1997	First    Version
--		p.Lamaty	09.10.1998	Entity   Update
--		p.Lamaty	12.10.1998	Header   Update
--		p.Lamaty	05.11.1998	Synopsys Update
--		p.Lamaty	05.03.1999	CLKB     Update
--		f.De Melo	05/09/2001	FPGA	 Version

--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;


-- module AMINFIN 
-- ------------------------------------------------------------------------- --
entity AMINFIN is
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
end AMINFIN;


--  définition de l'architecture de OPNI
-- ------------------------------------------------------------------------- --
architecture ARCH_AMINFIN of AMINFIN is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des composants internes
	-- --------------------------------------------------------- --
component LR_AMIN
   port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	
	 decalb		: in	std_logic;
	 di		: in	std_logic_vector(1 downto 0);
	 do		: out	std_logic_vector(1 downto 0)
	);
end component;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux internes
	-- --------------------------------------------------------- --
	signal	adrPr			: std_logic_vector( 7 downto 0);
	signal	Pa,Fu			: std_logic_vector( 3 downto 0);
	signal	Pr ,newPr		: std_logic;
	signal	decalh,decalv		: std_logic;
	signal	diL,doL			: std_logic_vector( 1 downto 0);
	signal	hsync_rtd		: std_logic_vector( 3 downto 0);
	signal 	nblig			: std_logic_vector( 1 downto 0);
	
	
-- ========================================================================= --
begin
	-- création des signaux de controle des FiFos
	-- --------------------------------------------------------- --
CTL0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			decalh <= '1';
			decalv <= '1';

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			decalh <= hsync_inn;
			decalv <= vsync_inn;
		end if;
	end process;


	-- lignes à retard 
	-- --------------------------------------------------------- --
	diL <= Pa(0)&Fu(2);
	
RTL0:	LR_AMIN	      port map	(
				 resetb, clkb
				,hsync_inn,diL,doL
				);


	-- élément structurant de 3x3x1
	-- --------------------------------------------------------- --
	Pa(1) <= doL(1)		when decalh='0' else '0';
	Fu(3) <= doL(0)		when decalh='0' else '0';
	Fu(0) <= pixel_inn	when decalv='0' else '0';


	-- --------------------------------------------------------- --
ELM0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			Pa(3) <= '0';		Pa(2) <= '0';
			Pa(0) <= '0';		Pr    <= '0';
			Fu(2) <= '0';		Fu(1) <= '0';

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			Pa(3) <= Pa(2);		Pa(2) <= Pa(1);
			Pa(0) <= newPr;		Pr    <= Fu(3);
			Fu(2) <= Fu(1);		Fu(1) <= Fu(0);
		end if;
	end process;


	-- test si on supprime le pixel courant (Pr)
	-- --------------------------------------------------------- --
	adrPr <= Pa&Fu;
	
AMN0:	process( resetb,Pr,adrPr,bruit )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			newPr <= '0';

		-- ------------------------------------------------- --
		elsif ( Pr='0' ) then
			newPr <= '0';

		-- ------------------------------------------------- --
		else
			case adrPr is
				when "00000000"	=>
					if ( bruit='1' ) then
						newPr <= '0';
					else
						newPr <= '1';
					end if;

				when "00000111"|"00001011"|"00001110"|"00001111"
				    |"00010011"|"00010111"|"00011011"|"00011111"
				    |"00101001"|"00101010"|"00101011"|"00101110"
				    |"00101111"|"01001110"|"01101001"|"01101011"
				    |"01101110"|"01101111"|"01110000"|"01110011"
				    |"01110100"|"01110110"|"01110111"|"01111000"
				    |"01111001"|"01111010"|"01111011"|"01111100"
				    |"01111101"|"01111110"|"01111111"|"10010010"
				    |"10010011"|"10010100"|"10010110"|"10010111"
				    |"10011011"|"10011110"|"10011111"|"11001000"
				    |"11001011"|"11001110"|"11001111"|"11010000"
				    |"11010010"|"11010011"|"11010100"|"11010110"
				    |"11010111"|"11011000"|"11011001"|"11011010"
				    |"11011011"|"11011100"|"11011110"|"11011111"
				    |"11100000"|"11101000"|"11101001"|"11101010"
				    |"11101011"|"11101110"|"11101111"|"11110000"
				    |"11110010"|"11110011"|"11110100"|"11110110"
				    |"11110111"|"11111000"|"11111001"|"11111010"
				    |"11111011"|"11111100"|"11111101"|"11111110"
				    |"11111111"	=>	newPr <= '0';
				when others	=>	newPr <= '1';
			end case;
		end if;
	end process;


	-- compteur de lignes
	-- --------------------------------------------------------- --
CPL0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			nblig <= (others=>'1');

--		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			-- ----------------------------------------- --
			if ( hsync_rtd(0)='1' and hsync_inn='0' ) then
				nblig <= nblig(0) & vsync_inn;
			end if;
		end if;
	end process;


	-- nouvelle synchro Horizontale
	-- --------------------------------------------------------- --
NSH0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			hsync_rtd <= (others=>'1');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			hsync_rtd <= hsync_rtd(2 downto 0) & hsync_inn;
		end if;
	end process;
	
	-- affectation de la synchro horizontale
	-- --------------------------------------------------------- --
	hsync_out <= hsync_rtd(3);
	vsync_out <= hsync_rtd(3) or nblig(1);

	
	-- affectation de la sortie image
	-- --------------------------------------------------------- --
	pixel_out <= Pa(0);
	
	
	
end ARCH_AMINFIN;
-- ========================================================================= --
