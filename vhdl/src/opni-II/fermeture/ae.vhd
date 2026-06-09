-- -------------------------------------------------------------------------- --
-- File Name :	AE.vhd
-- Author    :	L. Kessal, ENSEA / Philippe Lamaty, ENSEA
-- Purpose   :	Automate Elementaire
--		NOTE : calcule l'état futur du pixel central
-- 
-- Modification
-- History :	Author		Date		Description
--
--		L.Kessal	19.12.1997	First Version
--		p.Lamaty	09.10.1998	entity update
--		p.Lamaty	12.10.1998	header update
--
--			(c) Copyright ENSEA & AErospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



--  module AE
-- ------------------------------------------------------------------------- --
entity AE is
   port	(
	 connexes	: in	std_logic;
	 Ch,Gc,Dc,Cb	: in	std_logic_vector(1 downto 0);
	 Gh,Dh,Gb,Db	: in	std_logic_vector(1 downto 0);
	 pixel_inn	: in	std_logic_vector(1 downto 0);

	 pixel_out	: out	std_logic_vector(1 downto 0)
	);
end AE;


--  définition de l'architecture de AE
-- ------------------------------------------------------------------------- --
architecture ARCH_AE of AE is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des constantes
	-- --------------------------------------------------------- --
	constant	NB_AE		: integer := 6;
	constant	CONTOUR		: std_logic_vector(1 downto 0) := "11"; 
	constant	CRETE		: std_logic_vector(1 downto 0) := "10";
	constant	EXTREMITE	: std_logic_vector(1 downto 0) := "01"; 
	constant	CRETE_FOND	: std_logic_vector(1 downto 0) := "10";
	constant	CRETE_CONTOUR	: std_logic_vector(1 downto 0) := "01"; 
	constant	FOND		: std_logic_vector(1 downto 0) := "00";
	
	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux
	-- --------------------------------------------------------- --
	signal	s4,s8			: std_logic_vector(3 downto 0);
	signal	ext1			: std_logic;


-- ========================================================================= --
begin
	-- test la présence d'une extrémité dans le voisinage 3x3
	-- --------------------------------------------------------- --
	s4(0) <= '1' when Ch=EXTREMITE else '0';	--    Ch
	s4(1) <= '1' when Gc=EXTREMITE else '0';	-- Gc    Dc
	s4(2) <= '1' when Dc=EXTREMITE else '0';	--    Cb
	s4(3) <= '1' when Cb=EXTREMITE else '0';

	-- --------------------------------------------------------- --
	s8(0) <= '1' when Gh=EXTREMITE else '0';	-- Gh    Dh
	s8(1) <= '1' when Dh=EXTREMITE else '0';	--
	s8(2) <= '1' when Gb=EXTREMITE else '0';	-- Gb    Db
	s8(3) <= '1' when Db=EXTREMITE else '0';

	-- --------------------------------------------------------- --
	ext1 <=     (s4(0) or s4(1) or s4(2) or s4(3))			-- 4 co.
		or ((s8(0) or s8(1) or s8(2) or s8(3)) and connexes);	-- 8 co.


	-- affectation du l'état du pixel central
	-- --------------------------------------------------------- --
	pixel_out <=      EXTREMITE when ( pixel_inn=CRETE and ext1='1' )
		     else pixel_inn;


end ARCH_AE;
-- ========================================================================= --

