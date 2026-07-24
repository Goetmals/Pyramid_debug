-- -------------------------------------------------------------------------- --
-- File Name :	LR_CODY.vhd
-- Author    :	Frederic DE MELO / Mises à jour XPM 2026
-- Purpose   :	Ligne à retard générique avec XPM Dual Port Ram.
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- Préférable pour la compatibilité moderne
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

library work;
use work.saturn_numeric_pkg.all;

-- Ajout de la bibliothèque XPM requise par Vivado
library xpm;
use xpm.vcomponents.all;

--  module LR_CODY
-- ------------------------------------------------------------------------- --
entity LR_CODY is
   generic (
     G_WIDTH : natural := 8;   -- Largeur du pixel (8 bits)
     G_DEPTH : natural := 512  -- Profondeur (640 ou 512 selon ton image, ici 512 pour coller aux adresses 9 bits)
   );
   port	(
	 resetb		: in	std_logic;
	 clkb		: in	std_logic;

	 decalb		: in	std_logic;
	 di		    : in	std_logic_vector(G_WIDTH-1 downto 0);
	 do		    : out	std_logic_vector(G_WIDTH-1 downto 0)
	);
end LR_CODY;

--  définition de l'architecture de LR_GRAD
-- ------------------------------------------------------------------------- --
architecture ARCH_LR_CODY of LR_CODY is

	-- Plus besoin de d'instancier de composant "dp_grad_tarek" (IP Catalog) !
	
	-- Détermination automatique de la taille du bus d'adresse
	constant ADDR_WIDTH : natural := unsigned_num_bits(G_DEPTH-1); -- Correspond à "8 downto 0" pour 512 mots

	-- déclaration des signaux internes
	signal	adL, adE, adE_int 	: std_logic_vector(ADDR_WIDTH-1 downto 0);
	signal	we			: std_logic_vector(0 downto 0);
	signal cnt_high_en      : std_logic_vector( 3 downto 0);
    
begin
         	
	-- Instanciation de la Mémoire XPM Double Port épurée
	-- --------------------------------------------------------- --
DPG0 : xpm_memory_tdpram
   generic map (
      MEMORY_SIZE        => (G_DEPTH * G_WIDTH), -- Taille totale en bits
      MEMORY_PRIMITIVE   => "block",             -- Force l'usage de BRAM
      CLOCKING_MODE      => "common_clock",      -- Une seule horloge (clkb)
      MEMORY_INIT_FILE   => "none",
      
      -- Configuration Port A (Écriture)
      WRITE_DATA_WIDTH_A => G_WIDTH,
      READ_DATA_WIDTH_A  => G_WIDTH,
      BYTE_WRITE_WIDTH_A => G_WIDTH,
      ADDR_WIDTH_A       => ADDR_WIDTH,
      WRITE_MODE_A       => "read_first",
      
      -- Configuration Port B (Lecture)
      WRITE_DATA_WIDTH_B => G_WIDTH,
      READ_DATA_WIDTH_B  => G_WIDTH,
      BYTE_WRITE_WIDTH_B => G_WIDTH,
      ADDR_WIDTH_B       => ADDR_WIDTH,
      WRITE_MODE_B       => "read_first"
   )
   port map (
      sleep => '0',
      -- Port A : Configuré uniquement en ÉCRITURE
      clka   => clkb,
      ena    => '1',        -- Port toujours actif
      wea    => we,         -- Signal d'écriture (1 bit vector)
      addra  => adE,
      dina   => di,
      douta  => open,       -- Non utilisé en lecture
      
      -- Port B : Configuré uniquement en LECTURE
      clkb   => clkb,
      enb    => '1',        -- Port toujours actif
      web    => "0",        -- Jamais d'écriture sur le port B
      addrb  => adL,
      dinb   => (others => '0'),
      doutb  => do,         -- Donnée de sortie lue
      
      -- Signaux de contrôle optionnels/système (mis au repos)
      rsta   => '0',
      rstb   => '0',
      regcea => '1',
      regceb => '1',
      injectdbiterra => '0',
      injectsbiterra => '0',
      injectdbiterrb => '0',
      injectsbiterrb => '0',
      sbiterra       => open,
      dbiterra       => open,
      sbiterrb       => open,
      dbiterrb      => open
   );


	-- génération du signal d'écriture
	-- --------------------------------------------------------- --
RW0:	process( resetb,clkb )
	begin
		if    ( resetb = '0' ) then
			we <= (others=>'0');

		elsif ( rising_edge(clkb) ) then
			we <= conv_std_logic_vector(not decalb,1);
		end if;
	end process;

	
	-- incrémentation de l'adresse de lecture
	-- --------------------------------------------------------- --
CPT0: process( resetb,clkb )
        begin
		if    ( resetb = '0' ) then
			adL <= (others=>'0');

		elsif ( rising_edge(clkb) ) then
			if    ( cnt_high_en = 11 or decalb='0' ) then
				adL <= adL + '1';
			else
				adL <= (others=>'0');
			end if;
		end if;
	end process;
	
	-- incrémentation de l'adresse d'écriture
	-- --------------------------------------------------------- --
WRI:   process( resetb,clkb )
        begin
		if    ( resetb = '0' ) then
			adE_int <= (others=>'0');

		elsif ( rising_edge(clkb) ) then
			if    ( decalb='1' ) then
				adE_int <= (others=>'0');
			else
				adE_int <= adE_int + '1';
			end if;
		end if;
	end process;

	
	-- génération de l'adresse d'écriture
	-- --------------------------------------------------------- --
WR0:	process( resetb,clkb )
        begin
		if    ( resetb='0' ) then
			adE <= (others=>'0');
		elsif ( rising_edge(clkb) ) then 
		      adE <= adE_int;
		  end if; 
	end process;	
	
CNT0:	process( resetb,clkb )
        begin
		if    ( resetb='0' ) then
			cnt_high_en <= (others=>'0');

		elsif ( rising_edge(clkb) ) then
			if  ( decalb='1' ) then
			 cnt_high_en <= cnt_high_en + '1';
			else
			 cnt_high_en <= (others=>'0');
			end if;
		end if;
	end process;		
	
end ARCH_LR_CODY;
