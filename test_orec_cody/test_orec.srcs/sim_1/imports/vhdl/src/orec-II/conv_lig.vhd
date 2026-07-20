-- -------------------------------------------------------------------------- --
-- File Name :	CONV_LIG.vhd
-- Author    :	Yves Guerin, IFITEP / Lounis Kessak, Philippe Lamaty, ENSEA / Cedric Munoz, LE2I
--              Frédéric de Melo, UBO
--
-- Purpose   :	convolution ligne de l'image.
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		l.Kessal	  .  .1996	First Version
--		y.Guerin	  .  .1997	Aero update
--		p.Lamaty	07.05.1998	header update + add pipe line
--		c.Munoz		12.03.2001	FPGA Version
--              f.de Melo       12.07.2001      FPGA Version
--
--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

--  module CONV_LIG
-- ------------------------------------------------------------------------- --
entity CONV_LIG is
   port	(	
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 csin0		: in	std_logic_vector( 6 downto 0);
	 csin1		: in	std_logic_vector( 6 downto 0);
	 csin2		: in	std_logic_vector( 6 downto 0);
	 csin3		: in	std_logic_vector( 6 downto 0);
	 csin4		: in	std_logic_vector( 6 downto 0);
	 csin5 		: in	std_logic_vector( 6 downto 0);

	 hsync_inn	: in	std_logic;
	 vsync_inn	: in	std_logic;
	 pixel_inn	: in	std_logic_vector(11 downto 0);

	 hsync_out 	: out	std_logic;
	 vsync_out 	: out	std_logic;
	 pixel_out 	: out	std_logic_vector(15 downto 0)
	);
end CONV_LIG;


--  definition de l'architecture de CONV_LIG
-- ------------------------------------------------------------------------- --
architecture ARCH_CONV_LIG of CONV_LIG is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- definition des types internes
	-- --------------------------------------------------------- --
	type	SLV12_12 is array(0 to 12) of std_logic_vector(11 downto 0);


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- definition des signaux internes
	-- --------------------------------------------------------- --
	signal	add_0_11,add_1_10	: std_logic_vector(12 downto 0);
	signal	add_2_9,add_3_8		: std_logic_vector(12 downto 0);
	signal	add_4_7,add_5_6		: std_logic_vector(12 downto 0);

	signal	mult_1,mult_2		: std_logic_vector(19 downto 0);
	signal	mult_3,mult_4		: std_logic_vector(19 downto 0);
	signal	mult_5,mult_6		: std_logic_vector(19 downto 0);

	signal	temp_21,temp_22,temp_23	: std_logic_vector(20 downto 0);
	signal	temp_a2,temp_a3,temp_a4	: std_logic_vector(20 downto 0);

	signal	p_in			: SLV12_12;
	signal	p_in_11			: std_logic_vector(11 downto 0);

	signal	hsync_rtd		: std_logic_vector( 12 downto 0);
	signal	vsync_rtd		: std_logic_vector( 12 downto 0);


-- ========================================================================= --
begin

	-- Decalage des synchronisations
	-- --------------------------------------------------------- --
SYN0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			hsync_rtd <= (others=>'1');
			vsync_rtd <= (others=>'1');

		elsif ( rising_edge(clk) ) then
			hsync_rtd <= hsync_rtd(11 downto 0)&hsync_inn;
			vsync_rtd <= vsync_rtd(11 downto 0)&vsync_inn;
		end if;
	end process;


	-- Entree du registre a decalage 12x1x12
	-- --------------------------------------------------------- --
	p_in( 0) <=   p_in( 1)	when vsync_rtd(1 downto 0)="01"	-- pixel N-5
		 else p_in( 3)	when vsync_rtd(2 downto 1)="01"	-- pixel N-4
		 else p_in( 5)	when vsync_rtd(3 downto 2)="01"	-- pixel N-3
		 else p_in( 7)	when vsync_rtd(4 downto 3)="01"	-- pixel N-2
		 else p_in( 9)	when vsync_rtd(5 downto 4)="01"	-- pixel N-1
		 else p_in(11)	when vsync_rtd(6 downto 5)="01"	-- pixel N
		 else pixel_inn;				-- INL


	-- Registre a decalage 12x1x12
	-- --------------------------------------------------------- --
DEC0:	process( resetb,clk )									-- On traite le masque en début de ligne
	begin
		if    ( resetb='0' ) then
			p_in( 1) <= (others=>'0');
			p_in( 2) <= (others=>'0');
			p_in( 3) <= (others=>'0');
			p_in( 4) <= (others=>'0');
			p_in( 5) <= (others=>'0');
			p_in( 6) <= (others=>'0');
			p_in( 7) <= (others=>'0');
			p_in( 8) <= (others=>'0');
			p_in( 9) <= (others=>'0');
			p_in(10) <= (others=>'0');
			p_in_11  <= (others=>'0');
			p_in(12) <= (others=>'0');

		elsif ( rising_edge(clk) ) then
			p_in( 1) <= p_in( 0);
			p_in( 2) <= p_in( 1);
			p_in( 3) <= p_in( 2);
			p_in( 4) <= p_in( 3);
			p_in( 5) <= p_in( 4);
			p_in(12) <= p_in_11;

			if ( vsync_rtd(5 downto 4)="10" ) then
				p_in( 6) <= p_in(4);		-- miroir
				p_in( 7) <= p_in(3);
				p_in( 8) <= p_in(2);
				p_in( 9) <= p_in(1);
				p_in(10) <= p_in(0);
			else
				p_in( 6) <= p_in( 5);		-- decalage
				p_in( 7) <= p_in( 6);
				p_in( 8) <= p_in( 7);
				p_in( 9) <= p_in( 8);
				p_in(10) <= p_in( 9);
				p_in_11  <= p_in(10);
			end if;
		 end if;
	end process;


	-- Sortie du registre a decalage 12x1x12
	-- --------------------------------------------------------- --
	p_in(11) <=   pixel_inn when vsync_rtd(6 downto 5)="10"
		 else p_in_11;


	-- addition 12 bits + 12 bits = pix_ress sur 13 bits
	-- --------------------------------------------------------- --
ADD0:	process( resetb,clk ) 
	begin
		if    ( resetb='0' ) then
			add_0_11 <= (others=>'0');
			add_1_10 <= (others=>'0');
			add_2_9 <=  (others=>'0');
			add_3_8 <=  (others=>'0');
			add_4_7 <=  (others=>'0');
			add_5_6 <=  (others=>'0');

		elsif ( rising_edge(clk) ) then
			add_0_11 <= ('0'&p_in(1)) + ('0'&p_in(12));
			add_1_10 <= ('0'&p_in(2)) + ('0'&p_in(11));
			add_2_9 <=  ('0'&p_in(3)) + ('0'&p_in(10));
			add_3_8 <=  ('0'&p_in(4)) + ('0'&p_in( 9));
			add_4_7 <=  ('0'&p_in(5)) + ('0'&p_in( 8));
			add_5_6 <=  ('0'&p_in(6)) + ('0'&p_in( 7));
		end if;
	end process;


	-- Multiplications 13 bits * 7 bits = pix_ress sur 20 bits
	-- --------------------------------------------------------- --
MUL0:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			mult_1 <= (others=>'0');
			mult_2 <= (others=>'0');
			mult_3 <= (others=>'0');
			mult_4 <= (others=>'0');
			mult_5 <= (others=>'0');
			mult_6 <= (others=>'0');

		elsif ( rising_edge(clk) ) then
			mult_1 <= csin0 * add_0_11;	
			mult_2 <= csin1 * add_1_10;	
			mult_3 <= csin2 * add_2_9;	
		 	mult_4 <= csin3 * add_3_8;	
			mult_5 <= csin4 * add_4_7;	
			mult_6 <= csin5 * add_5_6;	
		end if;
	end process;


	-- Additions de 20 bits + 20 bits = pix_ress sur 20 bits
	-- Resultat final est sur 16 bits (poids fort)
	-- --------------------------------------------------------- --
ADD1:	process( resetb,clk )
	begin
		if    ( resetb='0' ) then
			temp_21 <= (others=>'0');
			temp_22 <= (others=>'0');
			temp_23 <= (others=>'0');
			temp_a2 <= (others=>'0');
			temp_a3 <= (others=>'0');
			temp_a4 <= (others=>'0');

		elsif  ( rising_edge(clk) ) then
			temp_21 <= ('0'&mult_1) + ('0'&mult_2);	
			temp_22 <= ('0'&mult_3) + ('0'&mult_4);	
			temp_23 <= ('0'&mult_5) + ('0'&mult_6);	
			temp_a2 <= temp_23;
			temp_a3 <= temp_21 + temp_22;		
			temp_a4 <= temp_a3 + temp_a2;		
		end if;
	end process;

	-- Affectation des signaux de sortie
	-- --------------------------------------------------------- --
	hsync_out <= hsync_rtd(11);
	vsync_out <= vsync_rtd(11);
	pixel_out <=   temp_a4(19 downto 4) when hsync_rtd(12)='0'
	          else (others=>'0');


end ARCH_CONV_LIG;
-- ========================================================================= --
