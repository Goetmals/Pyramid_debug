 -- ========================================================================== --
--
-- Fichier   :	pb_mv13.vhd
--
-- Auteur    :	Fred de Melo
--
-- Copyright :	AEROSPATIALE MATRA Missiles 2001
--
-- -------------------------------------------------------------------------- --
-- Modification :
--
--	Auteur		Date		Version		Commentaire
--
--	f.de Melo		07.08.2001	2.0		Première version
--
-- -------------------------------------------------------------------------- --


-- ===================================================================== --
-- Modèle CMOS --
-- ===================================================================== --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

--  module PB_MV13
-- ------------------------------------------------------------------------- --
entity PB_MV13 is
	generic (
		width			: integer := 1280;   
	  	height			: integer := 1024    
		);
		
	port 	(	
		l_rst_n			: in	std_logic;
		sysclk			: in	std_logic;
		row_addr		: in	std_logic_vector(9 downto 0);
		row_strt_n		: in 	std_logic;
		ld_shift_n		: in	std_logic;
		dat_read_en_n		: in	std_logic;
		cal_strt_n		: in 	std_logic;
		tx_n			: in 	std_logic;
		pg_n			: in 	std_logic;
		dark_off_enn		: in   std_logic;
		
		row_done_n		: out 	std_logic;
		cal_done_n		: out 	std_logic;
		data			: out 	std_logic_vector(99 downto 0);
		pixel_clk_out		: out	std_logic
		
		);
end PB_MV13;

--  définition de l'architecture de PB_MV13
-- ------------------------------------------------------------------------- --
architecture ARCH_PB_MV13 of PB_MV13 is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- definition des types internes
	-- --------------------------------------------------------- --
	--type   tab  is array(0 to (height * width)) of std_logic_vector(99 downto 0);
	
	
	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- --------------------------------------------------------- --
	signal	compteur1		: integer;
	signal	compteur2		: integer;
--	signal	mem			: tab;				
	signal	cpt_col			: integer;
	signal	SHFT			: std_logic;
	signal	adresse			: integer;
	signal	row_strt_r		: std_logic;
	
	
-- ========================================================================= --
begin	


adresse <= conv_integer(row_addr);

	-- --------------------------------------------------------- --
	-- ------- génération du signal row_done_n ----------------- --
	-- --------------------------------------------------------- --
	
RD0: 	process(l_rst_n,sysclk)
	
	begin
	  if (l_rst_n = '0') 
  	   then compteur1   <= width + 1;   
       	   row_done_n <= '1';
	   elsif ( rising_edge(sysclk) )
               then if (row_strt_n = '1')
                     then compteur1 <= compteur1 + 1;
	             else compteur1 <= 0;
	            end if;
	       if ((compteur1 >= 127) and (compteur1 <= 129))
	        then  row_done_n <= '0'; 
	        else  row_done_n <= '1';
	       end if;
  	   end if;
	
	end process;

	-- --------------------------------------------------------- --
	-- ------- génération du signal cal_done_n ----------------- --
	-- --------------------------------------------------------- --
	
CD0:	process(l_rst_n,sysclk)
	
	begin
 	  if (l_rst_n = '0') 
  	   then compteur2   <= 111;
     	        cal_done_n  <= '1';
	   elsif ( rising_edge(sysclk) )
     	       then if (cal_strt_n = '0')
                     then compteur2 <= 0;
	     	     else compteur2 <= compteur2 +1;
	  	    end if;
	       if (compteur2 >= 107 and compteur2 <= 109)
	        then  cal_done_n <= '0'; 
	        else  cal_done_n <= '1';
	       end if;
    	  end if;

	end process;

	-- --------------------------------------------------------- --
	-- ------- génération du bus data -------------------------- --
	-- --------------------------------------------------------- --
	
	-- ------- génération d'un signal de "transfert possible"--- --	
	row_strt_r <= transport row_strt_n after 1 ns;

TP1:	process ( l_rst_n,sysclk )
	begin
		if    ( l_rst_n='0' ) then
			SHFT <= '0';
			
		elsif ( rising_edge(sysclk) )	then
			if    ( row_strt_r='0' ) then
				SHFT <= '1';

			elsif  (compteur1 >= 127)  then
				SHFT <= '0';
			end if;
		end if;
	end process;


	-- ------- génération du compteur colonne------------------- --	
	
	     
CPT0:	process(l_rst_n,sysclk)
	
	begin
	  if (l_rst_n = '0')
           then cpt_col <= 0;
 	   elsif ( rising_edge(sysclk) )
      	       then if (SHFT = '1')
           	     then cpt_col <= cpt_col + 1;
		     else cpt_col <= 0;
		     	 
		    end if;
	  end if;
	  
	end process;
	  
 	-- ------- transfert des données numériques----------------- --	
  
data <=  conv_std_logic_vector(adresse,100) when SHFT = '1' -- mem(adresse * width + cpt_col) when SHFT = '0'
     else (others=>'U') ;
     
pixel_clk_out <= sysclk;

end ARCH_PB_MV13;



