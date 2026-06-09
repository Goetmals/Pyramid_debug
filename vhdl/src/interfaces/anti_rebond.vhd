-- -------------------------------------------------------------------------- --
-- File Name :	ANTI_REBOND.vhd
-- Author    :	Cedric MUNOZ LE2i
-- Purpose   :	Permet la gestion d'un bouton poussoir
--		avec ANTI_REBOND
-- 
-- Modification
-- History :	Author		Date		Description
--
--		c.munoz	  	30.08.2001	First Version
--
--			(c) Copyright LE2i & Aerospatiale Matra Missiles
-- -------------------------------------------------------------------------- --

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- definition du module 
entity ANTI_REBOND is
	port (
		clk		: in std_logic;
		reset_b		: in std_logic;
		rplus		: in std_logic;
		splus		: in std_logic;
		rmoins		: in std_logic;
		smoins		: in std_logic;
		cpt_high	: out std_logic_vector (3 downto 0));
end ANTI_REBOND;


--  définition de l'ARCHitecture de ANTI_REBOND
-- ------------------------------------------------------------------------- --
ARCHitecture ARCH_ANTI_REBOND of ANTI_REBOND is

	signal up		: std_logic;
	signal down		: std_logic;
	signal plus		: std_logic_vector (1 downto 0);
	signal moins		: std_logic_vector (1 downto 0);
	signal rplus_ff		: std_logic;
	signal splus_ff		: std_logic;
	signal rmoins_ff	: std_logic;
	signal smoins_ff	: std_logic;
	signal cpt_high_i	: unsigned (3 downto 0);

begin


sync : 	process( clk )
	begin
		if ( falling_edge(clk) ) then
			rplus_ff  <= rplus;
			splus_ff  <= splus;
			rmoins_ff <= rmoins;
			smoins_ff <= smoins;
		end if;
	end process;


high : 	process(clk, reset_b)
	begin
		if (reset_b = '0') then
			cpt_high_i <= "0000";
		
		elsif ( falling_edge(clk) ) then
		
			if (up = '1') then
				cpt_high_i <= cpt_high_i + 1;
			elsif (down = '0') then
				cpt_high_i <= cpt_high_i + 1;
			end if;
		end if;
	end process;
	
	cpt_high <= std_logic_vector (cpt_high_i);
	

plus0 : process (clk, reset_b)
	begin
		if (reset_b = '0') then
			plus 	<= "00";
			up 	<= '0';	
				
		elsif ( falling_edge(clk)) then
			case plus is
				when "00" =>
					if (rplus_ff = '0') then
						plus <= "00";
					elsif splus_ff = '0' then 
						plus <= "01";
					else
						plus <= "00";
					end if;
					
					up <= '0';
					
				when "01" =>
					if (splus_ff = '0') then
						plus <= "01";
					elsif splus_ff = '0' then 
						plus <= "10";
					else
						plus <= "10";
					end if;
					
				when "10" =>
						plus  <= "00";
						up    <= '1';
				when others =>
						up    <= '0';
						plus  <= "00";
			end case;
		end if;
	end process;
	
moins0 : process (clk, reset_b)
	 begin
	 	if (reset_b = '0') then
			moins <= "00";
			down  <= '0';
		elsif ( falling_edge(clk) ) then
			case moins is
				when "00" =>
						if (rmoins_ff = '0') then
							moins <= "00";
						elsif smoins_ff = '0' then
							moins <= "01";
						else
							moins <= "00";
						end if;
						
						down <= '0';
				when "01" =>
						if (smoins_ff = '0') then
							moins <= "01";
						elsif rmoins_ff = '0' then
							moins <= "10";
						else
							moins <= "10";
						end if;
				
				when "10" =>
						moins  <= "00";
						down    <= '1';
				when others =>
						down    <= '0';
						moins  <= "00";
						
			end case;
		end if;
	end process;
end ARCH_ANTI_REBOND;
						
				

