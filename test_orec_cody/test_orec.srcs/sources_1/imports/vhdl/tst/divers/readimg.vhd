-- -------------------------------------------------------------------------- --
-- File Name :	READIMG.vhd
-- Author    :	Yves Guerin, IFITEP / Philippe Lamaty, ENSEA
-- Purpose   :	Lecture d'un fichier image IMV
--		NOTE :  les synchro vid�o peuvent �tre au format
--			Imaging Technology ou DataCube.
--		ATTENTION :	pour le format DataCube toutes les lignes de
--				l'image doivent avoir la m�me taille, sinon
--				un probl�me de synchro peut appara�tre.
-- 
-- Modification
-- History :	Author		Date		Description
--
--		Y.Guerin	  .  .1996	First Version
--		p.Lamaty	13.10.1998	Header Update
--		p.Lamaty	27.11.1998	Behavior Update
--		p.Lamaty	08.02.1999	Image Synchro Update
--
--			(c) Copyright ENSEA & Aerospatiale
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;


--  module READIMG
-- ------------------------------------------------------------------------- --
entity READIMG is
generic (
	 nomfichier	: string  :="test.ima";

	 format		: string  := "IMAGING";		-- IMAGING/DATACUB

	 nbPixDeb	: integer := 6;
	 nbPixFin	: integer := 6;
	 nbLigDeb	: integer := 6;
	 nbLigFin	: integer := 6;
	 nbLigFinSeq	: integer := 6;

	 tPHV		: time    := 0 ns;
	 pix_unknown	: std_logic_vector(7 downto 0) := (others=>'U')
	);
   port	(
	 resetb   	: in	std_logic;
	 clk     	: in	std_logic;

	 hsync_out  	: out	std_logic;
	 vsync_out  	: out	std_logic;
	 pixel_out   	: out	std_logic_vector( 7 downto 0);

	 eof		: out	std_logic
	);
end READIMG;


--  d�finition de l'architecture de READIMG
-- ------------------------------------------------------------------------- --
architecture ARCH_READIMG of READIMG is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�claration des fonctions
	-- --------------------------------------------------------- --
	Function TestChar( C : in character ) return boolean is
	begin
		if    ( C>='0' and C<='9' ) then	return( TRUE );
		elsif ( C>='A' and C<='F' ) then	return( TRUE );
		elsif ( C>='a' and C<='f' ) then	return( TRUE );
		else					return( FALSE );
		end if;
	end TestChar;

	-- --------------------------------------------------------- --
	Function To_StdLogicVector( C : in character ) return std_logic_vector is
	begin
		case C is
			when '0'	=> return "0000";
			when '1'	=> return "0001";
			when '2'	=> return "0010";
			when '3'	=> return "0011";
			when '4'	=> return "0100";
			when '5'	=> return "0101";
			when '6'	=> return "0110";
			when '7'	=> return "0111";
			when '8'	=> return "1000";
			when '9'	=> return "1001";
			when 'a' | 'A'	=> return "1010";
			when 'b' | 'B'	=> return "1011";
			when 'c' | 'C'	=> return "1100";
			when 'd' | 'D'	=> return "1101";
			when 'e' | 'E'	=> return "1110";
			when 'f' | 'F'	=> return "1111";
			when others	=> return "XXXX";
		end case;
	end To_StdLogicVector;

	-- --------------------------------------------------------- --
	Procedure readPixel(
				  chaine	: inout	line
				; pixel		: out	std_logic_vector( 7 downto 0)
			      ) is
		variable	car	: character := '_';
	begin
		read( chaine,car );

		if    ( TestChar(car) ) then
			pixel( 7 downto 4) := To_StdLogicVector( car );

			read( chaine,car );

			if ( TestChar(car) ) then
				pixel(3 downto 0) := To_StdLogicVector( car );
			else
				ASSERT FALSE REPORT "- E - Pb Image "
				SEVERITY ERROR;
			end if;

		elsif ( car = '*' ) then
			pixel := (others=>'X');
		else
			ASSERT FALSE REPORT "- E - Pb Image "
			SEVERITY ERROR;
		end if;
	end readPixel;

	-- --------------------------------------------------------- --
	Function setPixel( pixel : std_logic_vector ) return std_logic_vector is
	begin
		for i in 0 to pixel'length-1 loop
			if ( pixel(i)/='0' and pixel(i)/='1' ) then
				return pix_unknown;
			end if;
		end loop;

		return pixel;
	end setPixel;

	-- --------------------------------------------------------- --
	Procedure TailleLigne( ligne : inout line; size : out integer ) is
		variable	Ltpo	: line := null;
		variable	car	: character := '_';
		variable	L	: integer := 1;
	begin
--		while ( not endLine( ligne ) ) loop
        while (ligne'length /= 0) loop
			read( ligne,car );
			write( Ltpo,car );
			L := L + 1;
		end loop;

		size := (nbPixFin + (L / 2) + nbPixDeb);

		ligne := Ltpo;
	end TailleLigne;


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- d�claration des signaux
	-- --------------------------------------------------------- --
	signal	hsync_dc, vsync_dc	: std_logic;
	signal	pixel_dc		: std_logic_vector( 7 downto 0);

	signal	hsync_oD, vsync_oD	: std_logic;
	signal	pixel_oD		: std_logic_vector( 7 downto 0);


	signal	hsync_it,vsync_it	: std_logic;
	signal	pixel_it		: std_logic_vector( 7 downto 0);

	signal	hsync_oI,vsync_oI	: std_logic;
	signal	pixel_oI		: std_logic_vector( 7 downto 0);

	signal	eof_i			: std_logic := 'X';


-- ========================================================================= --
begin
	-- lecture du fichier et g�n�ration des stimulis
	-- --------------------------------------------------------- --
GEN0:	process( resetb,clk )

		-- ------------------------------------------------- --
		file	 fsrce			: text is in nomfichier;

		variable car			: character	:= '_';
		variable ligne			: line		:= null;

		variable sizeofline		: integer	:= 1;

		variable pixel_i		: std_logic_vector(7 downto 0) := pix_unknown;

		variable new_image		: std_logic	:= '1';
		variable new_line		: std_logic	:= '1';
		variable fdf			: std_logic	:= '0';

		variable nbwait, nblig, nbpix	: integer	:= 0;

		variable onetime		: std_logic	:='0';
	begin
		-- g�n�ration des signaux DATA CUBE
		-- ------------------------------------------------- --
		if    ( resetb='0' ) then

			hsync_it <= '1';	vsync_it <= '1';

			hsync_dc <= '1';	vsync_dc <= '1';
			pixel_dc <= pix_unknown;

			-- ----------------------------------------- --
			if ( onetime='0' ) then
				onetime := '1';

				-- --------------------------------- --
				if ( not endFile(fsrce) ) then
					readLine( fsrce,ligne );
					readPixel( ligne,pixel_i );

					TailleLigne( ligne,sizeofline );

					if ( nbLigDeb>0 ) then
						nbwait := sizeofline*(nbLigDeb) + nbPixDeb;
					else
						nbwait := nbPixDeb;
					end if;

					eof_i <= '0';
				else
					eof_i <= '1';
				end if;
			end if;

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) and eof_i='0' ) then
			-- ----------------------------------------- --
			if ( (nbwait mod sizeofline)=nbPixDeb ) then

				-- --------------------------------- --
				if ( nbwait=0 ) then
					hsync_dc <= not new_line;
					new_line := '0';
				else
					hsync_dc <= '0';
				end if;

				-- --------------------------------- --
				if ( nblig = 0 ) then
					vsync_dc <= not new_image;
					new_image := '0';
				else
					vsync_dc <= '1';

					nblig := nblig - 1;
				end if;
			else
				hsync_dc <= '1';	vsync_dc <= '1';
			end if;

			-- ----------------------------------------- --
			if ( nbwait>0 ) then

				-- --------------------------------- --
				if    ( (nbwait mod sizeofline)=0 ) then
					hsync_it <= '0';
				elsif ( (nbwait mod sizeofline)=(nbPixDeb+nbPixFin) ) then
					hsync_it <= '1';
				end if;

				vsync_it <= '1';
				pixel_dc <= pix_unknown;

				nbwait := nbwait - 1;

			-- ----------------------------------------- --
			else
				hsync_it <= '0';	vsync_it <= '0';
				pixel_dc <= pixel_i;

				-- --------------------------------- --
				readPixel( ligne,pixel_i );
	
				-- --------------------------------- --
				if ( pixel_i="XXXXXXXX" ) then

					-- ------------------------- --
					if ( not endFile(fsrce) ) then
						readLine( fsrce,ligne );
						readPixel( ligne,pixel_i );

						new_line := '1';
						nbwait := nbPixFin + nbPixDeb;
	
						-- ----------------- --
						if ( pixel_i="XXXXXXXX" ) then
							pixel_i := pix_unknown;
	
							-- --------- --
							if ( not endFile(fsrce) ) then
								readLine( fsrce,ligne );
								readPixel( ligne,pixel_i );

								new_line := '1';
								new_image := '1';
								if    ( nbLigDeb>0 or nbLigFin>0) then
									nbwait := nbwait + sizeofline*(nbLigDeb+nbLigFin);
								end if;
								nblig  := nbLigFin;
							end if;
						end if;

						fdf := '0';
					else
						if ( nbLigFin>0 or nbLigFinSeq>0 ) then
							nbwait := nbPixFin + nbPixDeb + sizeofline*(nbLigFin+nbLigFinSeq);
						else
							nbwait := 0;
						end if;

						nblig := nbLigFin;
						fdf := '1';
					end if;
				end if;
			end if;

			-- ----------------------------------------- --
			if ( nbwait=0 ) then
				eof_i <= fdf;
			end if;
		end if;
	end process;


	-- retarde le bus pixel_dc d'une periode d'horloge
	-- --------------------------------------------------------- --
RTD0:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0') then
			vsync_oD <= '1';
			hsync_oD <= '1';
			pixel_oD <= pix_unknown;

		-- ------------------------------------------------- --
		elsif ( falling_edge(clk) ) then
			vsync_oD <= vsync_dc after tPHV;
			hsync_oD <= hsync_dc after tPHV;

			pixel_oD <= pixel_dc after tPHV;
		end if;
		-- ------------------------------------------------- --
	end process;


	-- retarde le bus pixel_it d'une periode d'horloge
	-- --------------------------------------------------------- --
RTD1:	process( resetb,clk )
	begin
		-- ------------------------------------------------- --
		if    ( resetb='0') then
			vsync_oI <= '1';
			hsync_oI <= '1';
			pixel_it <= pix_unknown;
			pixel_oI <= pix_unknown;

		-- ------------------------------------------------- --
		elsif ( rising_edge(clk) ) then
			vsync_oI <= vsync_it after tPHV;
			hsync_oI <= hsync_it after tPHV;

			pixel_it <= pixel_dc;
			pixel_oI <= pixel_it after tPHV;
		end if;
		-- ------------------------------------------------- --
	end process;


	-- --------------------------------------------------------- --
	vsync_out <= vsync_oI when format="IMAGING" else vsync_oD;
	hsync_out <= hsync_oI when format="IMAGING" else hsync_oD;
	pixel_out <= pixel_oI when format="IMAGING" else pixel_oD;

	-- --------------------------------------------------------- --
	eof <= eof_i;


end ARCH_READIMG;
-- ========================================================================= --
