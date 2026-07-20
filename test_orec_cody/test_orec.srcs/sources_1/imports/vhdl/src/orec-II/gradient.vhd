-- -------------------------------------------------------------------------- --
-- File Name :	GRADIENT.vhd
-- Author    :	Philippe Lamaty, ENSEA / Fr�d�ric de Melo, UBO
-- Purpose   :	calcul des gradients Horizontaux et Verticaux d'une image
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		p.Lamaty	18.02.1998	First    Version
--		p.Lamaty	09.10.1998	Entity   Update
--		p.Lamaty	12.10.1998	Header   Update
--		p.Lamaty	06.11.1998	Synopsys Update
--		p.Lamaty	05.03.1999	clk     Update
--              f.de Melo         .  .2001      FPGA     Version
--
--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;


--  module GRADIENT
-- ------------------------------------------------------------------------- --
entity GRADIENT is
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
end GRADIENT;


--  d�finition de l'architecture de GRADIENT
-- ------------------------------------------------------------------------- --
architecture ARCH_GRADIENT of GRADIENT is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�claration des composants internes
	-- --------------------------------------------------------- --
component LR_GRAD
   port	(
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 decalb		: in	std_logic;
	 di		: in	std_logic_vector(15 downto 0);
	 do		: out	std_logic_vector(15 downto 0)
	);
end component;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�finition des signaux internes
	-- --------------------------------------------------------- --
	signal	A,C, doF		: std_logic_vector(15 downto 0);
	signal	D0,S0, D1,S1		: std_logic_vector(17 downto 0);

	signal	decalh,decalv		: std_logic;
	signal	FirstCol,FirstLig	: std_logic_vector( 1 downto 0);


-- ========================================================================= --
begin
	-- retarde le signal de synchronisation horizontale 'hsync'
	-- --------------------------------------------------------- --
CTL0:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			decalh <= '1';
			decalv <= '1';

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
			decalh <= hsync_inn;
			decalv <= vsync_inn;
		end if;
	end process;


	-- ligne � retard 
	-- --------------------------------------------------------- --
RTL0:	LR_GRAD        port map	(
				 resetb,clk
				,hsync_inn,A,doF
				);


	-- �l�ment structurant de 2x2x8
	-- --------------------------------------------------------- --
	C <=   A		when FirstLig(1)='1'
	  else doF		when decalh='0'
	  else (others=>'0');

	A <=   pixel_inn	when decalv='0'
	  else (others=>'0');


	-- calcul de D1 et S1 (avec un retard pixel)
	-- --------------------------------------------------------- --
ELM0:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			D0 <= (others=>'0');	D1 <= (others=>'0');
			S0 <= (others=>'0');	S1 <= (others=>'0');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
	
			D0 <= D1;		D1 <= ("00"&C) - ("00"&A);
			S0 <= S1;		S1 <= ("00"&C) + ("00"&A);
		end if;
	end process;


	-- calcul du gradient pixel_gx et pixel_gy
	-- --------------------------------------------------------- --
CG_0:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			pixel_gx  <= (others=>'0');
			pixel_gy  <= (others=>'0');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
			if ( FirstCol(1)='1' ) then
				pixel_gx <= (others=>'0');
				pixel_gy <= D1(D1'length-2 downto 0)&'0';
			else
				pixel_gx <= S1 - S0;
				pixel_gy <= D1 + D0;
			end if;
			
		end if;
	end process;



	-- synchronisation des sorties pixel_gx et pixel_gy
	-- --------------------------------------------------------- --
SS_0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			                    
			hsync_gxy <= '1';
			vsync_gxy <= '1';
			
		elsif ( rising_edge(clk) ) then
			hsync_gxy <= decalh;
			vsync_gxy <= decalv;
			
		end if;
	end process;

	-- d�tection 1�re colonne
	-- --------------------------------------------------------- --
D1C0:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0') then
			FirstCol <= (others=>'0');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
			FirstCol <= FirstCol(0)&(decalh and not hsync_inn);
		end if;
	end process;


	-- d�tection 1�re ligne
	-- --------------------------------------------------------- --
D1L0:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
				FirstLig <= "01";

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
			-- ----------------------------------------- --
			if    (  vsync_inn='0'	and hsync_inn='0'
						and decalh='1' ) then
				FirstLig <= FirstLig(0)&'0';

			-- ----------------------------------------- --
			elsif (  vsync_inn='1'	and hsync_inn='0'
						and decalh='1' ) then
				FirstLig <= "01";
			end if;
		end if;
	end process;


end ARCH_GRADIENT;
-- ========================================================================= --
