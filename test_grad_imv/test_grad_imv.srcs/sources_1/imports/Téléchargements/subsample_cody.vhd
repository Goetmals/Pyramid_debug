library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


library work;
use work.saturn_numeric_pkg.all;

entity subsample_cody is
	generic (
		pixel_bus_width     : natural := 17;
		w_img               : natural := 640;
		h_img               : integer := 480
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
end entity;

architecture arch_subsample_cody of subsample_cody is

	-- buffer de ligne (on veut garder une ligne sur deux)
    type line_buffer_type is array (0 to w_img-1) of std_logic_vector(pixel_bus_width-1 downto 0);
    signal line_buffer : line_buffer_type;
    
	-- adresses d'écriture et de lecture
    signal ad_E : integer range 0 to w_img-1 := 0;
    signal ad_L : integer range 0 to w_img-1 := 0;
	
	-- Signal interne pour hsync
    signal hsync_int : std_logic := '1';
	
	-- États de lecture de la ligne 
    signal reading     : std_logic := '0';
	
	
begin

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
                    if ad_E < 255 then
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
            hsync_out  	<= '1';
            vsync_out  	<= '1';
            EN_out 		<= '0';
            data_out	<= (others => '0');
            ad_L	    <= 0;
            reading     <= '0';
			
        elsif rising_edge(clk) then
            
            -------------------------------------------------------------------
            -- HSYNC_OUT : Transmis 1 ligne sur 2 (lignes paires)
            -------------------------------------------------------------------
            if yin(0) = '0' then
                hsync_int <= hsync_in;
            else
                hsync_int <= '1';
            end if;

            hsync_out <= hsync_int;

            -------------------------------------------------------------------
            -- VSYNC_OUT : Suit HSYNC_OUT pendant l'image, 1 en dehors
            -------------------------------------------------------------------
            if vsync_in = '0' then
                vsync_out <= hsync_int; -- Copie conforme de HSYNC_OUT pendant l'image
            else
                vsync_out <= '1';       -- Reste verrouillé à 1 en dehors de l'image
            end if;

            -------------------------------------------------------------------
            -- Démarrage de la relecture (1 cycle après le passage à 0 de HSYNC)
            -------------------------------------------------------------------
            if (yin(0) = '0') and (hsync_in = '0') then
                reading <= '1';
                ad_L  	<= 0;
            end if;

            -------------------------------------------------------------------
            -- Relecture continue de la ligne (256 cycles)
            -------------------------------------------------------------------
            if reading = '1' then
                EN_out			<= '1';
                data_out  		<= line_buffer(ad_L);
                
                if ad_L = 255 then
                    reading <= '0'; -- Fin des 256 pixels
                else
                    ad_L  <= ad_L + 1;
                end if;
            else
                EN_out 		<= '0';
                data_out  	<= (others => '0');
            end if;

        end if;
    end process;
			
end arch_subsample_cody;
