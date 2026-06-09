-- ========================================================================== --
--
-- Fichier   :	inter_cmos.vhd
--
-- Auteur    :	Cedric Munoz
--
-- Copyright :	AEROSPATIALE MATRA Missiles 2001-2001
--
-- -------------------------------------------------------------------------- --
-- Modification :
--
--	Auteur		Date		Version		Commentaire
--
--	c.Munoz		25.07.2001	1.0		Première version
--	f.de Melo	22.08.2001  	2.0		Deuxième version

-- -------------------------------------------------------------------------- --
-- Rôle :
--
-- Pilotage du capteur CMOS et restitution des données au format Imaging
-- Technology.
--
-- ========================================================================== --


-- Définition des librairies
-- -------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


--  module INTER_CMOS
-- ------------------------------------------------------------------------- --
entity INTER_CMOS is
   port	(	
	resetb		: in	std_logic;
	clk108MHz	: in	std_logic;

	-- signaux de contrôle du capteur CMOS --
	clk10_8		: out 	std_logic;
	row_strt_n	: out 	std_logic;
	ld_shift_n	: out	std_logic;
	dat_read_en_n	: out	std_logic;
	row_addr	: out	std_logic_vector(9 downto 0);
	tx_n		: out 	std_logic;
	pg_n		: out 	std_logic;
	cal_strt_n	: out 	std_logic;
	lrst_n		: out	std_logic;
	dark_off_enn	: out   std_logic;
	standby_n	: out   std_logic;

	-- données du capteur CMOS --
	data		: in 	std_logic_vector(99 downto 0);
	select_mode	: in 	std_logic;
	row_exposure	: in 	std_logic_vector( 9 downto 0);

	-- imaging technology --
	hsync_out	: out 	std_logic;
	vsync_out	: out	std_logic;
	pixel_out	: out	std_logic_vector( 7 downto 0)
	);
end INTER_CMOS;


--  définition de l'architecture de INTER_CMOS
-- ------------------------------------------------------------------------- --
architecture ARCH_INTER_CMOS of INTER_CMOS is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des types
	-- ---------------------------------------------------------- --
	type	tab		is array (0 to 1) of integer;

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des constantes
	-- ---------------------------------------------------------- --
constant	width			: integer := 1688;	--1688;	-- impose par le standard VESA
constant	height			: integer := 1066;	--1066;	-- impose par le standard VESA

constant	hstart			: integer :=   32;	--  32;	-- origine colonne
constant	hend			: integer := 1311;	--1312;	-- fin colonne

constant	vstart			: integer :=    0;	--   0;	-- origine ligne
constant	vend			: integer := 1023;	--1023;	-- fin ligne
	
constant	pg_n_start		: tab     :=( 660,1300);
constant	pg_n_end		: tab     :=(1300,1310);
	
constant	row_start		: integer :=   20;
constant	row_end			: integer :=   40;
constant	read_start		: integer :=    0;
constant	read_end		: integer := 1309;
constant	ldsht_start		: integer := 1680;
constant	ldsht_end		: integer := 1687;
	
constant	lrst_start		: integer :=    0;
constant	lrst_end		: integer :=   20;
constant	lrst_lig		: integer := height - 2;
constant	dark_lig		: integer := height - 4;

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux
	-- ---------------------------------------------------------- --
	signal	cpt_col			: integer;
	signal	cpt_lig 		: integer;
	signal	compt10			: integer;
	signal	af,bg,ch,di,ej		: std_logic_vector( 7 downto 0);
	signal	tempo			: std_logic_vector(10 downto 0);
	signal	flag0,flag1,vsync_int	: std_logic;
	signal	hsync_int,tx_n_int	: std_logic;
	signal	dat_read_en_n_int	: std_logic;
	signal	cal_strt_n_int		: std_logic;


			
-- ========================================================================== --
begin
	-- ---------------------------------------------------------- --
	standby_n	<= '1';


	-- mise en oeuvre des compteurs ligne et colonne --
	-- ---------------------------------------------------------- --
CPT0:	process ( resetb,clk108MHz )
	begin
		if    ( resetb='0' ) then
			cpt_col  <= width - 1;
			cpt_lig  <=  vend + 1;
			row_addr <= (others=>'0');
				
		elsif ( rising_edge(clk108MHz) ) then
			if ( cpt_col >= width - 1 ) then
				cpt_col <= 0;
					
				if ( cpt_lig >= height - 1 ) then
					cpt_lig <= 0;
				else
					cpt_lig <= cpt_lig + 1;
				end if;
			else
				cpt_col <= cpt_col + 1;
			end if;				

			row_addr <= conv_std_logic_vector (cpt_lig, row_addr'length);			
		end if;		
	end process;
	

	-- génération des synchros horizontale et verticale imaging --
	-- ---------------------------------------------------------- --
SHV0:	process ( resetb,clk108MHz )
	begin
		if    ( resetb='0' ) then 
			vsync_int <= '1';
			hsync_int <= '1';
			
		elsif ( rising_edge(clk108MHz) ) then 
			if ( cpt_col >= hstart and cpt_col <= hend ) then
				hsync_int <= '0';
					
				if ( cpt_lig > vstart and cpt_lig <= vend + 1 ) then
					vsync_int <= '0';
				else
					vsync_int <= '1';
				end if;
			else
				hsync_int <= '1';
				vsync_int <= '1';
			end if;
		end if;	 
	end process;

	-- ---------------------------------------------------------- --
	vsync_out <= vsync_int;
	hsync_out <= hsync_int;



	-- génération du compteur modulo 10 --
	-- ---------------------------------------------------------- --
CPT1:	process ( resetb,clk108MHz )
	begin
		if    ( resetb='0' ) then
			compt10 <= 0;
				
		elsif ( rising_edge(clk108MHz) ) then
			if (compt10 = 9 or cpt_col = 0) then
				compt10 <= 0;
			else
				compt10 <= compt10 + 1;
			end if;
		end if;
	end process; 			


	-- génération de l'horloge 10,8MHz --
	-- ---------------------------------------------------------- --
GCK0:	process ( resetb,clk108MHz )
	begin
		if ( resetb='0' ) then
			clk10_8 <= '0';
				
		elsif ( rising_edge(clk108MHz) ) then
			if    ( compt10=9 or cpt_col=0 ) then
				clk10_8 <= '1';

			elsif ( compt10=4 ) then
				clk10_8 <= '0';
			end if;
		end if;
	end process;

			
	-- mémorisation des 10 bus de 10 bits du CMOS en 2 fois  --
	-- ---------------------------------------------------------- --
MUX0:	process ( resetb, clk108MHz )
	begin
		if ( resetb='0' ) then
			af <= ( others => '0');
			bg <= ( others => '0');			
			ch <= ( others => '0');
			di <= ( others => '0');
			ej <= ( others => '0');
				
		elsif ( rising_edge(clk108MHz) ) then
			if    ( compt10 = 2 ) then
				af <= data ( 9 downto  2);	--(99 downto 92);
				bg <= data (19 downto 12);	--(89 downto 82);
				ch <= data (29 downto 22);	--(79 downto 72);
				di <= data (39 downto 32);	--(69 downto 62);
				ej <= data (49 downto 42);	--(59 downto 52);
				
			elsif ( compt10 = 7 ) then
				af <= data (59 downto 52);	--(49 downto 42);
				bg <= data (69 downto 62);	--(39 downto 32);
				ch <= data (79 downto 72);	--(29 downto 22);
				di <= data (89 downto 82);	--(19 downto 12);
				ej <= data (99 downto 92);	--( 9 downto  2);
			end if;
		end if;
	end process;


	-- mise en serie des 10 bus paralleles du capteur CMOS --
	-- ---------------------------------------------------------- --
P_S0:	process ( resetb, clk108MHz )
	begin
		if ( resetb='0' ) then
			pixel_out <= (others => '0');
				
		elsif ( rising_edge(clk108MHz) ) then
			if ( vsync_int = '0') then
				case compt10 is
					when 3|8 	=> pixel_out <= af;
					when 4|9 	=> pixel_out <= bg;
					when 5|0 	=> pixel_out <= ch;	
					when 6|1 	=> pixel_out <= di;
					when others 	=> pixel_out <= ej;
				end case;
			else pixel_out <= (others => '1');
			end if;
		end if;
	end process;


	-- pilotage du capteur CMOS Photobit PB-MV13 --
	-- ---------------------------------------------------------- --

	-- génération du signal row_strt_n --
	-- ---------------------------------------------------------- --
RWST0:	process ( resetb,clk108MHz )
	begin
		if ( resetb='0' ) then
			row_strt_n <= '1';
				
		elsif ( rising_edge(clk108MHz) ) then
			if ( cpt_col >= row_start and cpt_col < row_end and cpt_lig <= vend ) then
				row_strt_n <= '0';
			else
				row_strt_n <= '1';
			end if;
		end if;
	end process;
	
	-- génération du signal ld_shift_n --
	-- ---------------------------------------------------------- --
LDS0:	process ( resetb,clk108MHz )
	begin
		if ( resetb='0' ) then
			ld_shift_n <= '0';
				
		elsif ( rising_edge(clk108MHz) ) then
			if ( cpt_col >= ldsht_start and cpt_col <= ldsht_end and (cpt_lig <= vend ) ) then	--or cpt_lig = height - 1
				ld_shift_n 	<= '1';
			else
				ld_shift_n 	<= '0';
			end if;
		end if;
	end process;	
				
	-- génération du signal dat_read_en_n --
	-- ---------------------------------------------------------- --
DTR0:	process ( resetb,clk108MHz )
	begin
		if ( resetb='0' ) then
			dat_read_en_n <= '1';
			dat_read_en_n_int	<= '1';
				
		elsif ( rising_edge(clk108MHz) ) then	
			if ( cpt_col >= read_start and cpt_col <= read_end and cpt_lig <= vend ) then
				dat_read_en_n_int	<= '0';
			else
				dat_read_en_n_int	<= '1';
			end if;
				dat_read_en_n	<= dat_read_en_n_int;
		end if;
	end process;
	
	-- génération des signaux flag0 et flag1 --
	-- ---------------------------------------------------------- --
FG0:	process ( resetb,clk108MHz )
	begin
		if ( resetb='0' ) then
			flag0 <= '0'; 
							
		elsif ( rising_edge(clk108MHz) ) then
			if ( (cpt_col >= pg_n_start(0) - 1) and (cpt_col < pg_n_end(0) - 1 ) ) then
				flag0 <= '1';
			else 
				flag0 <= '0';
			end if;
		end if;
	end process;
		
	-- ---------------------------------------------------------- --
FG1:	process ( resetb,clk108MHz )
	begin
		if ( resetb='0' ) then
			flag1 <= '0';
			
		elsif ( rising_edge(clk108MHz) ) then
			if ( (cpt_col >= pg_n_start(1) - 1) and (cpt_col < pg_n_end(1) - 1) ) then
				flag1 <= '1';
			else
				flag1 <= '0';
			end if;
		end if;
	end process;
						
	-- génération du signal tx_n --
	-- ---------------------------------------------------------- --
TX0:	process ( resetb,clk108MHz )
	begin
		if ( resetb='0' ) then
			tx_n_int <= '1';
			tx_n <= '1';
				
		elsif ( rising_edge(clk108MHz) ) then	

			if ( cpt_lig = vend - 1 ) then
				tx_n_int <= not (flag0);
			end if;
			tx_n <= tx_n_int;
		end if;
	end process;

	-- génération du signal pg_n --
	-- ---------------------------------------------------------- --
PG0:	process ( resetb,select_mode,clk108MHz )
	begin
		if ( resetb='0' ) then
			pg_n <= not select_mode;
				
		elsif ( rising_edge(clk108MHz) ) then

			-- TrueSNAP Simultaneous Mode --
			if ( select_mode = '0' ) then
				if    ( cpt_lig < conv_integer(row_exposure) ) then 
					pg_n <= not (flag1);

				elsif ( cpt_lig =  conv_integer(row_exposure) ) then
					pg_n <= not (flag0) and not (flag1);

				end if;	
			
			-- TrueSNAP Sequentiel Mode --
			else
				if    ( cpt_lig = 0  and cpt_col = pg_n_start(1) -1) then
					pg_n <= '0';

				elsif ( cpt_lig = conv_integer(row_exposure) and cpt_col = pg_n_end(1) - 1  ) then
					pg_n <= '1';
				end if;
			end if;
		end if;
	end process;

	-- ---------------------------------------------------------- --
DRK0:	process ( resetb, clk108MHz )
	begin
		if    ( resetb='0' ) then
			dark_off_enn <= '1';

		elsif ( rising_edge(clk108MHz) ) then
			if ( cpt_lig = dark_lig ) then
				dark_off_enn <= '0';
			else
				dark_off_enn <= '1';
			end if;
		end if;
	end process;

	-- calibrage du capteur CMOS --
	-- ---------------------------------------------------------- --
CAL0:	process ( resetb, clk108MHz )
	begin
		if ( resetb='0' ) then
--			cal_strt_n 	<= '1';
			cal_strt_n_int	<= '1';
				
		elsif ( rising_edge(clk108MHz) ) then
			if (    cpt_col >= lrst_start and cpt_col < lrst_end
			    and cpt_lig = lrst_lig ) then
				cal_strt_n_int 	<= '0';
--				cal_strt_n 	<= '0';
			else
				cal_strt_n_int 	<= '1';
--				cal_strt_n 	<= '1';
			end if;	
--		cal_strt_n <= cal_strt_n_int;			
		end if;
	end process;

	cal_strt_n <= '1';		--cal_strt_n_int;
	lrst_n	  <= cal_strt_n_int;	--'1';	


end ARCH_INTER_CMOS;
-- ========================================================================== --



