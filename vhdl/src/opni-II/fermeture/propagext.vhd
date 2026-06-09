-- -------------------------------------------------------------------------- --
-- File Name :	PROPAGEXT.vhd
-- Author    :	L. Kessal, ENSEA / Philippe Lamaty, ENSEA
-- Purpose   :	propagation des extrémités
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		L.Kessal	19.02.1998	First    Version
--		p.Lamaty	09.10.1998	Entity   Update
--		p.Lamaty	12.10.1998	Header   Update
--		p.Lamaty	06.11.1998	Synopsys Update
--		p.Lamaty	05.03.1999	CLKB     Update
--
--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;



-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
-- mode de fonctionnement de l'opérateur de propagration des extrémités
-- connexes :
--	 '0' :	4 connexes
--	 '1' :	8 connexes
--
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --


--  module PROPAGEXT
-- ------------------------------------------------------------------------- --
entity PROPAGEXT is 
   port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 connexes	: in	std_logic;

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 1 downto 0);

	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 1 downto 0)
	);
end PROPAGEXT;


--  définition de l'architecture de PROPAGEXT
-- ------------------------------------------------------------------------- --
architecture ARCH_PROPAGEXT of PROPAGEXT is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des composants externes
	-- --------------------------------------------------------- --
component LR_PEXT
   port ( 
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;
	 	 
	 decalb		: in	std_logic;
	 di		: in	std_logic_vector(9 downto 0);
	 do		: out	std_logic_vector(9 downto 0)
	);
end component;

	-- --------------------------------------------------------- --
component AE
   port	(
	  connexes	: in	std_logic;
	  Ch,Gc,Dc,Cb	: in	std_logic_vector(1 downto 0);
	  Gh,Dh,Gb,Db	: in	std_logic_vector(1 downto 0);
	  pixel_inn	: in	std_logic_vector(1 downto 0);

	  pixel_out	: out	std_logic_vector(1 downto 0)
	);
end component;


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
	-- déclaration des types internes
	-- --------------------------------------------------------- --	
type	N_AE  is array(0 to NB_AE-1) of std_logic_vector( 1 downto 0);

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des signaux internes
	-- --------------------------------------------------------- --
	signal	AEg,AEc,newAEc,AEd	: N_AE;
	signal	d_D,dnC,d_C,d_G		: std_logic_vector(NB_AE*2-1 downto 0);
	
	signal	debfin			: std_logic_vector(      1   downto 0);
	signal	hsynch			: std_logic_vector(	 1   downto 0);
	signal	nblig			: std_logic_vector(NB_AE-1 downto 0);

-- ========================================================================= --
begin
	-- Automate de fermeture de contours de 3xNB_AEx2
	-- --------------------------------------------------------- --
	d_D(1 downto 0) <= pixel_inn;

	-- --------------------------------------------------------- --
LR0:	LR_PEXT		port map	(
				 	 resetb,clkb
					,hsync_inn,d_G(9 downto 0),d_D(11 downto 2)
					);

	-- affectation des signaux des AEs
	-- --------------------------------------------------------- --
GEN0:	for i in 0 to NB_AE-1 generate
		dnC(2*i+1 downto 2*i) <= newAEc(i);

		AEd(i) <= d_D(2*i+1 downto 2*i);
		AEc(i) <= d_C(2*i+1 downto 2*i);
		AEg(i) <= d_G(2*i+1 downto 2*i);
	end generate;


	-- génération des registres
	-- --------------------------------------------------------- --
REG0:	process( resetb,clkb )
	begin
		if    ( resetb='0' ) then
			d_G <= (others=>'0');	d_C <= (others=>'0');

		elsif ( rising_edge(clkb) ) then
			d_G <= dnC;		d_C <= d_D;
		end if;
	end process;


	-- ================================================================= --
	-- UN BORD VIRTUELLE DE 1 AUTOUR DE L'IMAGE EST AJOUTE PAR DETECTEXT --
	-- ================================================================= --

	-- création de l'automate de fermeture des contours
	-- --------------------------------------------------------- --
GEN1:	for i in 1 to NB_AE-2 generate
		-- AEs IMPAIRs
		-- ------------------------------------------------- --
PAI0:		if ( (i mod 2)/=0 ) generate
		AE0:	AE	     port map	(
					 connexes
					,AEc(i-1),AEg(i  ),AEd(i  ),AEc(i+1)	-- 4 connexes
				        ,AEg(i-1),AEd(i-1),AEg(i+1),AEd(i+1)	-- 8 connexes
					,AEc(i  ),newAEc(i)
					);
		end generate;

		-- AEs PAIRs
		-- ------------------------------------------------- --
IMP0:		if ( (i mod 2)=0 ) generate
		AE1:	AE	     port map	(
					 connexes
					,newAEc(i-1),AEg(i  ),AEd(i  ),newAEc(i+1)	-- 4 connexes
				        ,AEg(i-1)   ,AEd(i-1),AEg(i+1),AEd(i+1)		-- 8 connexes
					,AEc(i  )   ,newAEc(i)
					);
		end generate;
	end generate;


	-- pas d'automate sur la première et la dernière ligne d'AEs
	-- --------------------------------------------------------- --
	newAEc(0)       <= AEc(0);
	newAEc(NB_AE-1) <= AEc(NB_AE-1);


	-- gestion des sorties de la fermeture de contours
	-- --------------------------------------------------------- --
	pixel_out <= AEg(NB_AE-1);


	-- création des synchro après fermeture
	-- --------------------------------------------------------- --

	-- détection début/fin de ligne
	-- --------------------------------------------------------- --
	debfin(0) <= hsync_inn;

	-- --------------------------------------------------------- --
NSV0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then		-- "00" : In       Line
			debfin(1) <= '1';		-- "01" : End   Of Line

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then	-- "10" : Begin Of Line
			debfin(1) <= debfin(0);		-- "11" : Out   Of Line
		end if;
	end process;


	-- compteur de lignes
	-- --------------------------------------------------------- --
CPL0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			nblig <= (others=>'1');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			-- ----------------------------------------- --
			if ( debfin="10" ) then
				nblig <= nblig(NB_AE-2 downto 0)&vsync_inn;
			end if;
		end if;
	end process;


	-- nouvelle synchro Horizontale
	-- --------------------------------------------------------- --
NSH0:	process( resetb,clkb )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			hsynch <= (others=>'1');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clkb) ) then
			hsynch <= hsynch(0)&hsync_inn;
		end if;
	end process;

	-- affectation de la synchro horizontale
	-- --------------------------------------------------------- --
	hsync_out <= hsynch(1);
	vsync_out <= hsynch(1) or nblig(NB_AE-1);


end ARCH_PROPAGEXT;
-- ========================================================================= --	
