library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


library work;
use work.saturn_numeric_pkg.all;

entity subsample_cody2 is
	generic (
		pixel_bus_width     : natural := 17;
		w_img               : natural := 640;
		h_img               : integer := 480;
		start_hsync         : std_logic := '0'
	);
	port (
		clk			: in  std_logic;
		reset_n 	: in std_logic;
		EN  		: in  std_logic;
		hsync_in	: in  std_logic;
		vsync_in	: in  std_logic;
		xin      	: in  std_logic_vector(unsigned_num_bits(w_img-1)-1 downto 0);
		yin      	: in  std_logic_vector(unsigned_num_bits(h_img-1)-1 downto 0);
		data_in  	: in  std_logic_vector(pixel_bus_width-1 downto 0);
		
		
		EN_out   	: out std_logic;
		hsync_out	: out std_logic;
		vsync_out	: out std_logic;
		xout     	: out std_logic_vector(unsigned_num_bits(w_img-1)-2 downto 0);
		yout     	: out std_logic_vector(unsigned_num_bits(w_img-1)-2 downto 0);
		data_out 	: out std_logic_vector(pixel_bus_width-1 downto 0)
	);
end entity subsample_cody2;

architecture arch_subsample_cody2 of subsample_cody2 is

	-- buffer de ligne (on veut garder une ligne sur deux)
    type line_buffer_type is array (0 to w_img-1) of std_logic_vector(pixel_bus_width-1 downto 0);
    signal line_buffer : line_buffer_type;
    
	-- adresses d'écriture et de lecture
    signal ad_E : integer range 0 to w_img-1 := 0;
    signal ad_L : integer range 0 to w_img-1 := 0;
	
	-- Signal interne pour hsync
    signal hsync_int, hsync_rtd : std_logic := '1';
	
	signal vsync_int, vsync_rtd : std_logic := '1';
	-- États de lecture de la ligne 
    signal reading     : std_logic := '0';
    signal next_lig   : std_logic := '0';
    
    -- Coordonnées intermédiare de x et y
    signal en_int : std_logic;
    signal xint : std_logic_vector(unsigned_num_bits(w_img-1)-2  downto 0);
    signal yint : std_logic_vector(unsigned_num_bits(w_img-1)-2  downto 0);
    signal first_lig : std_logic := '0';
    
    -- Compteur colonne pour générer hsync_int
    signal cpt_col : std_logic_vector(unsigned_num_bits(w_img-1)-1  downto 0);
    signal cpt_lig : std_logic_vector(unsigned_num_bits(w_img)-1  downto 0);
    signal cpt_start : std_logic := '0';  
    signal odd_lig :   std_logic := start_hsync;
    signal start_of_line : std_logic_vector(1 downto 0);
	
	
begin

    start_of_line <= hsync_in & hsync_rtd;
     ---------------------------------------------------------------------------
    -- 1. Écriture en mémoire (Capture 1 pixel sur 2 sur lignes paires)
    ---------------------------------------------------------------------------
    process(clk, reset_n)
    begin
        if reset_n = '0' then
            ad_E <= 0;
        elsif rising_edge(clk) then
            if (yin(0) = '0') and (EN = '1') then
                -- Capture uniquement les pixels d'indice X pair
                if xin(0) = '0' then
                    line_buffer(ad_E) <= data_in;
                    if ad_E < (w_img/2-1) then
                        ad_E <= ad_E + 1;
                    end if;
                end if;
            else
                ad_E <= 0; -- fin de ligne remise à 0 du pointeur d'écriture
            end if;
        end if;
    end process;
	
	
	 ---------------------------------------------------------------------------
    -- 2. Génération de HSYNC_OUT, VSYNC_OUT, EN_OUT et DATA_OUT
    ---------------------------------------------------------------------------
    process(clk, reset_n)
    begin
        if reset_n = '0' then
            hsync_rtd  	<= '1';
--            vsync_rtd  	<= '1';
--            hsync_int  	<= '1';
--            vsync_int  	<= '1';
--            hsync_out  	<= '1';
--            vsync_out  	<= '1';
            cpt_col <= (others => '0');
            cpt_lig <= (others => '0');
            EN_out 		<= '0';
            data_out	<= (others => '0');
            ad_L	    <= 0;
            reading     <= '0';
            next_lig    <= '0';
            xint        <= (others => '0');
            yint        <= (others => '0');
            xout        <= (others => '0');
            yout        <= (others => '0');
			
        elsif rising_edge(clk) then

              hsync_rtd <= hsync_in;

              if hsync_in = '0' and  hsync_rtd = '1' and odd_lig = '1' then
                cpt_start <= '1';
              end if;
              
              if cpt_start = '1' then
                 cpt_col <= cpt_col + '1';
                 if cpt_col = conv_std_logic_vector((w_img/2-1), unsigned_num_bits(w_img-1)) then
                    cpt_start <= '0';
                    cpt_col <= (others => '0');
                 end if;
              end if;
              
              if hsync_in = '0' and  hsync_rtd = '1' then
                odd_lig <= not(odd_lig);
              end if;
                
              
              hsync_int <= not(cpt_start);
                                                                 
            ------------------------------------------------------------------
            -- next_lig : Réinitialisation de next_lig
            -------------------------------------------------------------------
            
            if yin(0) = '0' then
                next_lig    <= '0';
            end if;

            -------------------------------------------------------------------
            -- Démarrage de la relecture (1 cycle après le passage à 0 de HSYNC)
            -------------------------------------------------------------------
--          if (yin(0) = '0') and (hsync_in = '0') then
            if (yin(0) = '1') and (hsync_in = '0') and (next_lig = '0') then
                reading <= '1';
                ad_L  	<= 0;
                next_lig <= '1';
            end if;

            -------------------------------------------------------------------
            -- Relecture continue de la ligne (256 cycles)
            -------------------------------------------------------------------
            if reading = '1' then
                EN_out			<= '1';
                en_int          <= '1';
                data_out  		<= line_buffer(ad_L);
                
                if ad_L = (w_img/2-1) then
                    reading <= '0'; -- Fin des 256 pixels
                else
                    ad_L  <= ad_L + 1;
                end if;
            else
                EN_out 		<= '0';
                en_int      <= '0';
                data_out  	<= (others => '0');
            end if;
            
            
            -------------------------------------------------------------------
            -- Incrémentation des coordonnées x et y
            -------------------------------------------------------------------
            if en_int = '1' then
                xout <= xint + 1;
                xint <= xint + 1;
            else 
                xint <= (others => '0');
            end if;
            
            if reading = '1' and en_int = '0' and first_lig = '1' then
                yout <= yint + 1;
                yint <= yint + 1;
            end if;
            
            if reading = '1' and en_int = '0' then 
                first_lig <= '1';
            end if;
            
            
        end if;
    end process;
		
vsync_int <= not(reading);
hsync_out <=  hsync_int;
vsync_out <= vsync_int;
	
end arch_subsample_cody2;
