-- -------------------------------------------------------------------------- --
-- File Name :	CONV3X3.vhd
-- Author    :	Philippe Lamaty
-- Purpose   :	réalisation d'une convolution 3x3
--		Note : les coefficients sont supposés normés entre [0,1[
-- 
-- Modification
-- History :	Author		Date		Description
--
--		p.Lamaty	26.04.2002	creation
--
--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

-- définition des librairies
-- ------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;


--  module CONV3X3
-- ------------------------------------------------------------------------- --
entity CONV3X3 is
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 csin00		: in	std_logic_vector( 7 downto 0);
	 csin01		: in	std_logic_vector( 7 downto 0);
	 csin02		: in	std_logic_vector( 7 downto 0);
	 csin10		: in	std_logic_vector( 7 downto 0);
	 csin11		: in	std_logic_vector( 7 downto 0);
	 csin12		: in	std_logic_vector( 7 downto 0);
	 csin20		: in	std_logic_vector( 7 downto 0);
	 csin21		: in	std_logic_vector( 7 downto 0);
	 csin22		: in	std_logic_vector( 7 downto 0);

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector( 7 downto 0);
         
	 hsync_out	: out	std_logic;
	 vsync_out	: out	std_logic;
	 pixel_out	: out	std_logic_vector( 7 downto 0)
	);
end CONV3X3;


--  définition de l'architecture de CONV3X3
-- ------------------------------------------------------------------------- --
architecture ARCH_CONV3X3 of CONV3X3 is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des composants
	-- --------------------------------------------------------- --
component LR_1280x16
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 decalb		: in	std_logic;
	 di		: in	std_logic_vector(15 downto 0);
	 do		: out	std_logic_vector(15 downto 0)
	);
end component;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des types
	-- --------------------------------------------------------- --
	type	SLV8 is array(0 to 2)  of std_logic_vector( 7 downto 0);


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux
	-- --------------------------------------------------------- --
	signal	p_in			: SLV8;
	signal  doL,diL			: std_logic_vector(15 downto 0);

	signal	D,C,B			: std_logic_vector( 7 downto 0);
	signal	E,O,A			: std_logic_vector( 7 downto 0);
	signal	F,G,H			: std_logic_vector( 7 downto 0);

	signal	MD,MC,MB		: std_logic_vector(15 downto 0);
	signal	ME,MO,MA		: std_logic_vector(15 downto 0);
	signal	MF,MG,MH		: std_logic_vector(15 downto 0);

	signal	O1,O2,O3		: std_logic_vector( 7 downto 0);
	signal	AB,CD,EF,GH		: std_logic_vector( 8 downto 0);
	signal	ABCD,EFGH		: std_logic_vector( 9 downto 0);
	signal	ABCDEFGH		: std_logic_vector(10 downto 0);
	signal	p_out			: std_logic_vector(11 downto 0);

	signal	hsync_rtd		: std_logic_vector( 9 downto 0);
	signal	nblig			: std_logic_vector( 2 downto 0);


-- ========================================================================= --
begin

	-- decalage de la synchronisation horizontal
	-- --------------------------------------------------------- --
SYN0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			hsync_rtd <= (others=>'1');

		elsif ( rising_edge(clk) ) then
			hsync_rtd <= hsync_rtd(8 downto 0) & hsync_inn;
		end if;
	end process;


	-- compteur de lignes
	-- --------------------------------------------------------- --
CPL0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			nblig <= (others=>'1');

		elsif ( rising_edge(clk) ) then
			if ( hsync_rtd(0)='1' and hsync_inn='0' ) then
				nblig <= nblig(1 downto 0) & vsync_inn;
			end if;
		end if;
	end process;


	-- entree de la ligne a retard
	-- --------------------------------------------------------- --
	diL <=  p_in(1) & p_in(0);

	
	-- ligne à retard 
	-- --------------------------------------------------------- --
RTL0:	LR_1280x16     port map	(
				 resetb,clk
				,hsync_inn,diL,doL
				);


	-- registre a decalage 3x1x8
	-- --------------------------------------------------------- --
	p_in(2) <= doL(15 downto  8) when nblig(2 downto 1)/="10" else p_in(1);
	p_in(1) <= doL( 7 downto  0);
	p_in(0) <= pixel_inn         when nblig(1 downto 0)/="01" else p_in(1);


	-- creation du voisinage 3x3
	-- --------------------------------------------------------- --
MSK0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			D <= (others=>'0');	C <= (others=>'0');	B <= (others=>'0');
			E <= (others=>'0');	O <= (others=>'0');	A <= (others=>'0');
			F <= (others=>'0');	G <= (others=>'0');	H <= (others=>'0');

		elsif ( rising_edge(clk) ) then
			case hsync_rtd(1 downto 0) is
				when "10"   =>	-- bord gauche
					D <= C;		C <= p_in(2);	B <= p_in(2);
					E <= O;		O <= p_in(1);	A <= p_in(1);
					F <= G;		G <= p_in(0);	H <= p_in(0);

				when "01"   =>	-- bord droit
					D <= C;		C <= B;		B <= B;
					E <= O;		O <= A;		A <= A;
					F <= G;		G <= H;		H <= H;

				when others =>
					D <= C;		C <= B;		B <= p_in(2);
					E <= O;		O <= A;		A <= p_in(1);
					F <= G;		G <= H;		H <= p_in(0);
			end case;
		end if;
	end process;


	-- multiplication par les coefficients
	-- --------------------------------------------------------- --
COE0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			MD <= (others=>'0');	MC <= (others=>'0');	MB <= (others=>'0');
			ME <= (others=>'0');	MO <= (others=>'0');	MA <= (others=>'0');
			MF <= (others=>'0');	MG <= (others=>'0');	MH <= (others=>'0');

		elsif ( rising_edge(clk) ) then
			MD <= D * csin00;	MC <= C * csin01;	MB <= B * csin02;
			ME <= E * csin10;	MO <= O * csin11;	MA <= A * csin12;
			MF <= F * csin20;	MG <= G * csin21;	MH <= H * csin22;
		end if;
	end process;


	-- premier étage d'additionneur
	-- --------------------------------------------------------- --
ADD0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			AB <= (others=>'0');
			CD <= (others=>'0');
			EF <= (others=>'0');
			GH <= (others=>'0');
			O1 <= (others=>'0');

		elsif ( rising_edge(clk) ) then
--			AB <= ('0' & MB(15 downto 8)) + ('0' & MA(15 downto 8));
--			CD <= ('0' & MC(15 downto 8)) + ('0' & MD(15 downto 8));
--			EF <= ('0' & ME(15 downto 8)) + ('0' & MF(15 downto 8));
--			GH <= ('0' & MG(15 downto 8)) + ('0' & MH(15 downto 8));
--			O1 <=        MO(15 downto 8);

			AB <= ('0' & MB(7 downto 0)) + ('0' & MA(7 downto 0));
			CD <= ('0' & MC(7 downto 0)) + ('0' & MD(7 downto 0));
			EF <= ('0' & ME(7 downto 0)) + ('0' & MF(7 downto 0));
			GH <= ('0' & MG(7 downto 0)) + ('0' & MH(7 downto 0));
			O1 <=        MO(7 downto 0);
		end if;
	end process;


	-- deuxième étage d'additionneur
	-- --------------------------------------------------------- --
ADD1:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			ABCD <= (others=>'0');
			EFGH <= (others=>'0');
			O2   <= (others=>'0');

		elsif ( rising_edge(clk) ) then
			ABCD <= ('0' & AB) + ('0' & CD);
			EFGH <= ('0' & EF) + ('0' & GH);
			O2   <=        O1;
		end if;
	end process;


	-- troisième étage d'additionneur
	-- --------------------------------------------------------- --
ADD2:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			ABCDEFGH <= (others=>'0');
			O3       <= (others=>'0');

		elsif ( rising_edge(clk) ) then
			ABCDEFGH <= ('0' & ABCD) + ('0' & EFGH);
			O3       <= O2;
		end if;
	end process;


	-- dernier étage d'additionneur
	-- définition des signaux de sortie
	-- --------------------------------------------------------- --
ADD3:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			p_out <= (others=>'0');

		elsif ( rising_edge(clk) ) then
			if ( hsync_rtd(6)='0' ) then
				p_out <= ('0' & ABCDEFGH) + ("0000" & O3);
			else
				p_out <= (others=>'0');
			end if;
		end if;
	end process;


	-- affectation des signaux de sortie
	-- --------------------------------------------------------- --
	hsync_out <= hsync_rtd(6);
	vsync_out <= hsync_rtd(6) or nblig(1);
	pixel_out <= p_out(11 downto 4);


end ARCH_CONV3X3;
-- ========================================================================= --
