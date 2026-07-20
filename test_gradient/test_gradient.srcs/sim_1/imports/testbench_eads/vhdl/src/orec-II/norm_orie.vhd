-- -------------------------------------------------------------------------- --
-- File Name :	NORM_ORIE.vhd
-- Author    :	Frédéric de Melo, UBO
-- Purpose   :	calcul de la norme et de l'orientation du gradient
--		NOTE : 
-- 
-- Modification
-- History :	Author		Date		Description
--
--		l.Kessal        18.12.1997	First  Version
--		p.Lamaty        09.10.1998	Entity Update
--		p.Lamaty	12.10.1998	Header Update
--		p.Lamaty 	05.03.1999	clk   Update
--              f.de Melo         .  .2001      FPGA Version

--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

use work.all;


--  module NORM_ORIE
-- ------------------------------------------------------------------------- --
entity NORM_ORIE is
   port	(
	 resetb		: in	std_logic;
	 clk		: in	std_logic;

	 hsync_gxy	: in	std_logic;
	 vsync_gxy	: in	std_logic;
	 pixel_gx	: in	std_logic_vector(17 downto 0);
	 pixel_gy	: in	std_logic_vector(17 downto 0);

	 hsync_nrm	: out	std_logic;
	 vsync_nrm	: out	std_logic;
	 pixel_ngd	: out	std_logic_vector(17 downto 0);
	 pixel_ori	: out	std_logic_vector( 3 downto 0)
	);
end NORM_ORIE;


--  définition de l'architecture de NORM_ORIE
-- ------------------------------------------------------------------------- --
architecture ARCH_NORM_ORIE of NORM_ORIE is


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- --------------------------------------------------------- --
	signal	vGx,vGy			: std_logic_vector(16 downto 0);
	signal	Gu,Gv,Gu_r,Gu_i,Gv_r	: std_logic_vector(16 downto 0);
	signal	Guv			: std_logic_vector(17 downto 0);
	signal	Gi			: std_logic_vector(18 downto 0);
	signal	Gvx5			: std_logic_vector(18 downto 0);
	signal	Gvx3			: std_logic_vector(17 downto 0);

	signal	signe			: std_logic_vector( 4 downto 0);
	signal	sgx,sgy			: std_logic_vector( 2 downto 0);
	signal	sxy			: std_logic_vector( 1 downto 0);

	signal	decalh,decalv		: std_logic_vector( 3 downto 0);


-- ========================================================================= --
begin
	-- pipeline les calculs intermédiaires
	-- --------------------------------------------------------- --
PIP0:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0') then
			vGx  <= (others=>'0');
			vGy  <= (others=>'0');
			Gu   <= (others=>'0');
			Gv   <= (others=>'0');
			Guv  <= (others=>'0');
			Gu_r <= (others=>'0');
			Gv_r <= (others=>'0');
			Gi   <= (others=>'0');
			Gu_i <= (others=>'0');
			Gvx5 <= (others=>'0');
			Gvx3 <= (others=>'0');

			sgx   <= (others=>'0');
			sgy   <= (others=>'0');
			sxy   <= (others=>'0');
			signe <= (others=>'0');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
			-- calcul des valeurs absolues
			-- ----------------------------------------- --
--pipe 0
			if ( pixel_gx(17)='1' ) then	vGx <= not ( pixel_gx(16 downto 0) );
			else				vGx <=     ( pixel_gx(16 downto 0) );
			end if;

			if ( pixel_gy(17)='1' ) then	vGy <= not ( pixel_gy(16 downto 0) );
			else				vGy <=     ( pixel_gy(16 downto 0) );
			end if;

--pipe 1
			if ( vGx>vGy ) then	Gu <= vGx;	Gv <= vGy;
			else			Gu <= vGy;	Gv <= vGx;
			end if;

--pipe 1
			if ( vGx>vGy ) then	Gu <= vGx;	Gv <= vGy;
			else			Gu <= vGy;	Gv <= vGx;
			end if;
			
			-- calcul des variables temporaires
			-- ----------------------------------------- --
--pipe 2
			Guv <= ('0'&Gu) + ('0'&Gv);
			Gu_r <= Gu;
			Gv_r <= Gv;

			Gvx5 <= ("00"&Gv) + (Gv&"00");
			Gvx3 <= ('0'&Gv) + (Gv&'0');

--pipe 3
			Gi   <= ('0'&Guv) + ("00"&Guv(17 downto 1));
			Gu_i <= Gu_r;


			-- calcul des signes (sgy&sgx&sxy&s3&s1)
			-- ----------------------------------------- --
--pipe 0
			sgy <= sgy(1 downto 0)&pixel_gy(pixel_gx'length-1);
			sgx <= sgx(1 downto 0)&pixel_gx(pixel_gx'length-1);
--pipe 1
			if (vGx <vGy ) then	sxy <= sxy(0)&'1';
			else			sxy <= sxy(0)&'0';
			end if;

--pipe 3
			signe(4 downto 2) <= sgy(2)&sgx(2)&sxy(1);

			if ( ((Gu_r&'0')<Gvx3) ) then	signe(1) <= '1';
			else					signe(1) <= '0';
			end if;

			if ( (  ("00"&Gu_r)<Gvx5) ) then	signe(0) <= '1';
			else					signe(0) <= '0';
			end if;
		end if;
	end process;


	-- affectation des sorties du module
	-- --------------------------------------------------------- --
NRM0:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			pixel_ngd <= (others=>'0');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
			-- ----------------------------------------- --
			if ( Gi(18 downto 1)>('0'&Gu_i) ) then
				pixel_ngd <= Gi(18 downto 1);
			-- ----------------------------------------- --
			else
				pixel_ngd <= ('0'&Gu_i);
			end if;
		end if;
	end process;

	-- --------------------------------------------------------- --
ORI0:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			pixel_ori <= "0000";

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
			-- ----------------------------------------- --
			case signe is
				when "00000" =>	pixel_ori <= "0000";	--  0,
				when "00001" =>	pixel_ori <= "0001";	--  1,
-- NotUsed			when "00010" =>	pixel_ori <= "0000";
				when "00011" =>	pixel_ori <= "0010";	--  2,
				when "00100" =>	pixel_ori <= "0100";    --  4,
				when "00101" => pixel_ori <= "0011";	--  3,
-- NotUsed			when "00110" =>	pixel_ori <= "0000";
				when "00111" =>	pixel_ori <= "0010";	--  2,
				when "01000" =>	pixel_ori <= "1000";	--  8,
				when "01001" => pixel_ori <= "0111";	--  7,
-- NotUsed			when "01010" =>	pixel_ori <= "0000";
				when "01011" =>	pixel_ori <= "0110";	--  6,
				when "01100" =>	pixel_ori <= "0100";	--  4,
				when "01101" =>	pixel_ori <= "0101";	--  5,
-- NotUsed			when "01110" =>	pixel_ori <= "0000";
				when "01111" =>	pixel_ori <= "0110";	--  6,
				when "10000" =>	pixel_ori <= "0000";	--  0,
				when "10001" =>	pixel_ori <= "1111";	-- 15,
-- NotUsed			when "10010" =>	pixel_ori <= "0000";
				when "10011" =>	pixel_ori <= "1110";	-- 14,
				when "10100" =>	pixel_ori <= "1100";	-- 12,
				when "10101" =>	pixel_ori <= "1101";	-- 13,
-- NotUsed			when "10110" =>	pixel_ori <= "0000";
				when "10111" =>	pixel_ori <= "1110";	-- 14,
				when "11000" =>	pixel_ori <= "1000";	--  8,
				when "11001" =>	pixel_ori <= "1001";	--  9,
-- NotUsed			when "11010" =>	pixel_ori <= "0000";
				when "11011" =>	pixel_ori <= "1010";	-- 10,
				when "11100" =>	pixel_ori <= "1100";	-- 12,
				when "11101" =>	pixel_ori <= "1011";	-- 11,
-- NotUsed			when "11110" =>	pixel_ori <= "0000";
				when "11111" =>	pixel_ori <= "1010";	-- 10

				when others  =>	pixel_ori <= "0000";
			end case;
		end if;
	end process;


	-- synchronisation des sorties pixel_ngd et pixel_ori
	-- --------------------------------------------------------- --
SS_0:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			decalh    <= (others=>'1');
			decalv    <= (others=>'1');

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
			decalh    <= decalh(2 downto 0)&hsync_gxy;
			decalv    <= decalv(2 downto 0)&vsync_gxy;
		end if;
	end process;


	-- --------------------------------------------------------- --
SS_1:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then
			hsync_nrm <= '1';
			vsync_nrm <= '1';

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
			hsync_nrm <= decalh(3);
			vsync_nrm <= decalv(3);
		end if;
	end process;

end ARCH_NORM_ORIE;
-- ========================================================================= --
