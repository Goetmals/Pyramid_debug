-- ========================================================================== --
--
-- Fichier   :	I2C.vhd
--
-- Auteur    :	Jerome MICHEL
--
-- Copyright :	AEROSPATIALE MATRA Missiles 2001-2001
--
-- -------------------------------------------------------------------------- --
-- Modification :
--
--	Auteur		Date		Version		Commentaire
--
--	J. MICHEL	13.11.2001	1.0		création

-- -------------------------------------------------------------------------- --
-- Rôle :
--
-- Génération de trames I2C
--

--
-- ========================================================================== --


-- définition des librairies
-- -------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

use work.all;


--  module I2C
-- ------------------------------------------------------------------------- --
entity I2C is
   port	(
	reset		: in	std_logic;
	led		: in	std_logic;
	clk		: in	std_logic;
	scl		: out	std_logic;
	sda		: out	std_logic;
	watch_ack	: out	std_logic
	);
end I2C;



--  définition de l'architecture de MIRE_VESA
-- ------------------------------------------------------------------------- --
architecture arch_I2C of I2C is

type etat is (init, start1, write_DDC, write_offset, start2, read_DDC, read_128, stop);

constant DDC_write	: std_logic_vector (7 downto 0) := "10100000";
--constant DDC_write	: std_logic_vector (7 downto 0) := "10100010";
constant offset		: std_logic_vector (7 downto 0) := "00000000";
constant DDC_read	: std_logic_vector (7 downto 0) := "10100001";
--constant DDC_read	: std_logic_vector (7 downto 0) := "10100011";

constant nb_EDID	: integer range 0 to 256 := 128;
constant demi_period	: integer range 0 to 1023 := 499;	-- 1/2 periode pour compteur horloge (10 KHz)
--constant demi_period	: integer range 0 to 1023 := 1;	-- 1/2 periode pour compteur horloge (ralentie)

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- ---------------------------------------------------------- --
	signal	horloge 		: std_logic:= '0';
	signal	compte_horloge		: integer range 0 to 1023 := 0;
	signal	scl_i 			: std_logic := '1';
	signal	sda_i 			: std_logic := '1';
	signal	sda_stop 		: std_logic := '1';
	signal	sda_start 		: std_logic := '1';
	signal	sda_access 		: std_logic := '1';
	signal	sda_128 		: std_logic := '1';
	signal	watch_ack_i 		: std_logic := '0';
--	signal	ack 			: std_logic := '0';
	signal	ack_value 		: std_logic := '0';


	signal  state			: etat := init;
	signal	byte			: std_logic_vector (7 downto 0) := DDC_write;
	signal 	mot 			: std_logic_vector (6 downto 0);
	signal 	shift_out		: std_logic_vector (7 downto 0);	
	signal 	end_shift 		: std_logic;
	signal	start_128		: std_logic := '0';
	signal	start			: std_logic := '0';
	signal	end_of_trame		: std_logic := '0';
	signal	end_of_access		: std_logic := '0';
	signal	led_int			: std_logic := '0';
	signal	end_read_128		: std_logic := '0';
	signal 	i			: integer range 0 to 8 := 8;
	signal	nb_128			: integer range 0 to 256;
	signal	nb_access		: integer range 0 to 8 := 8;
	signal	nb_scl			: integer range 0 to 1;
	signal	nb_led			: integer range 0 to 3 := 0;

	signal	cpt			: integer := 0;


-- ========================================================================== --
begin

led_int <= led;
watch_ack <= watch_ack_i;
scl <= 	'1' when (state = init) else scl_i;
sda <= 	sda_i;

-- Multiplexing between 'sda_stop' and 'sda_start' and 'sda_access' and 'sda_128'
sda_i <= sda_start 	when 	(state = start1 or state = start2) else
	'1'		when (state = init) else
	sda_stop	when (state = stop) else
	sda_access	when (state = write_DDC or state = write_offset or state = read_DDC) else
	sda_128;

gene_scl_process:process (reset, horloge)
begin
if reset = '0' then 	scl_i <= '1';
			nb_scl <= 0;
elsif (horloge'event and horloge = '1') then 
--	if (nb_scl = 0 and end_of_trame = '0') then nb_scl <= 1;
--	elsif end_of_trame = '1' then scl_i <= '1';
--	else 	scl_i <= not scl_i;
--		nb_scl <= 0;
--	end if;
	nb_scl <= (nb_scl + 1) mod 2;
	if (state = init) then 	scl_i <= '1';
				nb_scl <= 0;
	elsif (end_of_trame = '1') then 
				scl_i <= '1';
				nb_scl <= 1;
	elsif (nb_scl = 1) then scl_i <= not (scl_i);
	end if;
end if;
end process;

-- constant DDC_write	: std_logic_vector (7 downto 0) := "10100000";
-- constant offset	: std_logic_vector (7 downto 0) := "00000000";
-- constant DDC_read	: std_logic_vector (7 downto 0) := "10100001";
word_I2C_process:process (reset, horloge)
begin
if reset = '0' then byte <= DDC_write;
elsif (horloge'event and horloge = '1') then
	if state = start1 then byte <= DDC_write;
	elsif state = write_DDC and nb_access = 7 then byte <= offset;
	elsif state = start2 then byte <= DDC_read;
	end if;
end if;
end process;

nb_led_process: process (state, led_int)
begin
if (state = init) then nb_led <= 0;
elsif (led_int'event and led_int = '1') then
	if (state = stop) then nb_led <= (nb_led + 1) mod 4;
--	else nb_led <= 0;
	end if;
end if;
end process;

main_process:process (reset, horloge)
begin
if reset = '0' then 	state <= init;
elsif (horloge'event and horloge = '1') then
	if (state = init) then		state <= start1;
	elsif (state = start1 and sda_i = '0' and scl_i = '1' and start = '1') then
				 	state <= write_DDC;
	elsif (state = write_DDC and nb_access = 8 and scl_i = '0' and nb_scl = 0 and start = '0') then
			 		state <= write_offset;
	elsif (state = write_offset and nb_access = 8 and scl_i = '0' and nb_scl = 0) then
			 		state <= start2;
	elsif (state = start2 and sda_i = '0' and scl_i = '1' and start = '1') then
				 	state <= read_DDC;
	elsif (state = read_DDC and nb_access = 8 and scl_i = '1' and nb_scl = 1) then
			 		state <= read_128;
 	elsif (state = read_128 and nb_128 = 256 and scl_i = '1' and nb_scl = 1 and i = 8 and end_read_128 = '1') then state <= stop;
-- 	elsif (state = read_128 and nb_128 = 2 and scl_i = '1' and nb_scl = 1) then state <= stop;
	elsif (state = stop and nb_led = 3) then state <= init;
--	elsif (state = stop) then state <= stop;	-- pour debuggage
	end if;
end if;
end process;

access_I2C_process:process (reset,horloge)
begin
if reset = '0' then 	nb_access <= 8;
			mot <= (others => '0');
			sda_access <= '0';
			end_of_access <= '0';
elsif (horloge'event and horloge = '1') then
	if (state = write_DDC or state = write_offset or state = read_DDC )
	   and (scl_i ='0' and nb_scl = 0) then
		if nb_access = 0 then 	sda_access <= mot (6);
--					mot <= byte (6 downto 0);
					nb_access <= nb_access + 1;
					end_of_access <= '0';
					mot <= mot (5 downto 0) & '1';	--ack_value;
		elsif nb_access = 7 then 	sda_access <= '1';	-- 'Z' car 'acknowledge' par display
						nb_access <= nb_access + 1;
						end_of_access <= '1';
		elsif (nb_access < 7) then
			sda_access <= mot(6);
			mot <= mot (5 downto 0) & ack_value;
			nb_access <= nb_access + 1;
		else	nb_access <= 0;
			sda_access <= byte (7);
			mot <= byte (6 downto 0);
		end if;
		elsif not (state = write_DDC or state = write_offset or state = read_DDC ) then
			nb_access <= 8;
			sda_access <= not (start);
	end if;
end if;
end process;
 
start_process:process (reset,horloge)
begin
if reset = '0' then 
	sda_start <= '0';
	start <= '0';
elsif (horloge'event and horloge = '1') then
	if (state = start1 or state = start2) then 
--		if (scl_i = '0' and nb_scl = 0 and start = '0') then
--				sda_start <= '1';
--				start <= not (start);
--		elsif (scl_i = '1') then
		if (scl_i = '1') then
			 	start <= '1';
--				sda_start <= not (sda_start);
				sda_start <= '0';
		end if;
	else 
		start <= '0';
		sda_start <= '1';
	end if;
end if;
end process;

read_128_process:process (reset,horloge)
begin
if reset = '0' then 	nb_128 <= 0;
			sda_128 <= '1';
			i <= 8;
			end_read_128 <= '0';
elsif (horloge'event and horloge = '1') then
	if (state = read_128 and i < 7 and scl_i = '0' and nb_scl = 0) then	i <= i + 1;
										sda_128 <= '1';
	elsif (state = read_128 and i = 8 and scl_i = '0' and nb_scl = 0 and nb_128 < 256) then
										i <= 0;
										sda_128 <= '1';
	elsif (state = read_128 and i = 7 and scl_i = '0' and nb_scl = 0 and nb_128 = 256) then
										i <= i + 1;
										sda_128 <= '1';
--										nb_128 <= (nb_128 + 1) mod 128;
										nb_128 <= 256;
	elsif (state = read_128 and i = 7 and scl_i = '0' and nb_scl = 0 and nb_128 < 256) then
										i <= i + 1;
--										sda_128 <= '0';
										sda_128 <= end_read_128;
										nb_128 <= nb_128 + 1;
	elsif not (state = read_128) then 	sda_128 <= '1';
						nb_128 <= 0;
	end if;
	if (state = init) then end_read_128 <= '0';
	elsif  (state = read_128 and i = 3 and nb_128 = 255) then end_read_128 <= '1';
	end if;
end if;
end process;

ack_value <= 	'0' when (state = read_128 and nb_128 < 256) else
--ack_value <= 	'0' when (state = read_128 and nb_128 < 2) else
		'1';

-- Generation de l'horloge pour la liaison I2C
process_gene_clk: process (reset, clk)
begin
if reset = '0' then
		compte_horloge <= 0;
		horloge <= '0';
elsif clk'event and clk = '1' then
		compte_horloge <= compte_horloge + 1;
		if compte_horloge = demi_period then 
			horloge <= not horloge;
			compte_horloge <= 0;
		else compte_horloge <= (compte_horloge + 1) mod 1024;
		end if;
end if;
end process;

stop_process: process (reset, horloge)
begin
if reset = '0' then 	sda_stop <= '1';
			end_of_trame <= '0';
elsif (horloge'event and horloge = '1') then
	if (state = stop and scl_i = '0' and end_of_trame = '0') then sda_stop <= '0';
	elsif not (state = stop) then end_of_trame <= '0';
	elsif (state = stop and scl_i = '1') then
						sda_stop <= '1';
						end_of_trame <= '1';
	else sda_stop <= '1';
	end if;
end if;
end process;


end arch_I2C;
-- ========================================================================== --

			

