----------------------------------------------------------------------------------
-- Company: ETIS Laboratory
-- Engineer: Thomas Lefebvre
--
-- Module Name:    xy_delay
--
-- Description: delay manager for those signals :
-- EN->EN_out, xin->xout, yin->yout
--
----------------------------------------------------------------------------------
-- Copyright (c) 2012, ETIS Laboratory, Cergy-Pontoise, France
-- All rights reserved.
-- 
-- Redistribution and use in source and synthesized forms, with or without
-- modification, are permitted provided that the following conditions are met:
--     * Redistributions of source code must retain the above copyright
--       notice, this list of conditions and the following disclaimer.
--     * Redistributions in synthesized form must reproduce the above copyright
--       notice, this list of conditions and the following disclaimer in the
--       documentation and/or other materials provided with the distribution.
--     * Neither the name of the ETIS laboratory nor the
--       names of its contributors may be used to endorse or promote products
--       derived from this hardware description without specific prior written permission.
-- 
-- THIS HARDWARE DESCRIPTION IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
-- ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL ETIS LABORATORY BE LIABLE FOR ANY
-- DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
-- ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-- HARDWARE DESCRIPTION, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
----------------------------------------------------------------------------------
-- For the support of this file, please contact :
-- verdier % unice.fr   - LEAT Laboratory
-- miramond % ensea.fr  - ETIS Laboratory
-- kessal % ensea.fr    - ETIS Laboratory
-- t.lefebv % gmail.com - creator of the file
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
use ieee.STD_LOGIC_ARITH.all;

library work;
use work.saturn_numeric_pkg.all;
use work.xy_delay_pkg.all;



entity xy_delay_cody2 is
  generic (
    DELAY_X     : natural := 1;
    DELAY_Y     : natural := 0;
    IMG_WIDTH   : natural := 640;
    IMG_HEIGHT  : natural := 480
    );
  port (
    global_clk_i    : in  std_logic;
    global_resetn_i : in  std_logic;
   
    hsync_i, vsync_i : std_logic;
    xy_en_i         : in  std_logic;
    xy_x_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
    xy_y_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
    
    hsync_o, vsync_o : out std_logic;
    xy_en_o : out std_logic;
    xy_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
    xy_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0)
            );
end entity;


architecture arch_xy_delay_cody2 of xy_delay_cody2 is

--signal en_rtd   : std_logic_vector((DELAY_X+DELAY_Y*524+4) downto 0) := (others => '0');   -- commented by Fred 10/07/2026
signal en_rtd,hsync_rtd   : std_logic_vector(DELAY_X+3 downto 0) := (others => '0');
signal nblig, nblig_r : std_logic_vector(DELAY_Y downto 0);
signal valid_image, en_rtd_int, en_rtd2_int : std_logic := '0'; 
signal firstcol : std_logic_vector(1 downto 0) := "00";
signal firstlig : std_logic_vector(1 downto 0) := "00";
signal xy_x_o_int : std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
signal xy_y_o_int : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
signal xy_en_o_int, xy_en_o_int2 : std_logic := '0'; 
signal decal_y : std_logic := '0'; 
signal vsync_o_int : std_logic; 
signal hsync_o_int : std_logic; 
            
begin


--SYNC0:	process( global_clk_i, global_resetn_i )
--	begin
--		-- ---------------------------------------------------
--		if    ( global_resetn_i='0' ) then
--			en_rtd <= (others=>'0');
--			nb_lig <= (others=>'0');
--				-- ------------------------------------------------- --
--		elsif ( rising_edge(global_clk_i) ) then
--		    if (DELAY_X = 0) and (DELAY_Y = 0) then 
--		    en_rtd(DELAY_X) <= xy_en_i;
--		    else en_rtd <= en_rtd((DELAY_X+DELAY_Y*524+3) downto 0) & xy_en_i; 
--		    end if;
--		if ( hsync_rtd(0)='1' and hsync_inn='0' ) then
--			nblig <= nblig( 5 downto 0)&vsync_inn;
--		end if;    
--		end if;
--	end process;

	-- decalage de la synchronisation horizontal
	-- --------------------------------------------------------- --
SYN0:	process( global_resetn_i,global_clk_i )
	begin
		if    ( global_resetn_i='0' ) then
			hsync_rtd <= (others=>'1');
		elsif ( rising_edge(global_clk_i) ) then
			hsync_rtd <= hsync_rtd(DELAY_X+2 downto 0) & hsync_i;
		end if;
	end process;

--HSYN0: process( global_resetn_i,global_clk_i )
--	begin
--		if    ( global_resetn_i='0' ) then
--			hsync_o <= '0';

--		elsif ( rising_edge(global_clk_i) ) then
--			hsync_o <= hsync_rtd(DELAY_X);
--		end if;
--	end process;

	-- compteur de lignes
	-- --------------------------------------------------------- --
CPL0:	process( global_resetn_i,global_clk_i )
	begin
		-- ------------------------------------------------- --
		if    ( global_resetn_i='0' ) then
			nblig <= (others=>'1');
            nblig_r 	<= (others=>'0');
            vsync_o_int <= '1';
 --           hsync_o <= '1'; 
		-- ------------------------------------------------- --
		elsif ( rising_edge(global_clk_i) ) then
			-- ----------------------------------------- --
			if ( hsync_rtd(0)='1' and hsync_i='0' ) then
				nblig <= nblig( DELAY_Y-1 downto 0) & vsync_i;
			end if;
			nblig_r <= nblig;
			vsync_o_int <= hsync_rtd(DELAY_X) or nblig(DELAY_Y);		
		end if;
	end process;



   
-- en_rtd <= en_rtd((DELAY_X+3) downto 0) & xy_en_i;    
-- en_rtd_int <= en_rtd(DELAY_X+DELAY_Y*524);				-- commented by Fred 10/07/2026

															

DLY_LINE0: 	process(global_clk_i, global_resetn_i )
					begin
					if    ( global_resetn_i='0' ) then
						valid_image <= '0';
						elsif(rising_edge(global_clk_i)) then
							if xy_y_i=std_logic_vector(to_unsigned(DELAY_Y,xy_y_i'length)) then 
								valid_image <= '1';
							end if;
					end if;
					end process;

--xy_en_o_int <= en_rtd_int and valid_image;    -- commented by Fred 13/07/2026 
--xy_en_o <= xy_en_o_int2;                       -- commented by Fred 13/07/2026 
xy_x_o <= xy_x_o_int;
xy_y_o <= xy_y_o_int;



vsync_o <= hsync_rtd(DELAY_X) or nblig(DELAY_Y);   
hsync_o <= hsync_rtd(DELAY_X); 
xy_en_o <= not(vsync_o_int);



firstcol <= vsync_o_int & hsync_rtd(DELAY_X);
firstlig <= vsync_o_int & hsync_rtd(DELAY_X);

XCAL0:	process(global_clk_i, global_resetn_i)
				begin
				if (global_resetn_i = '0') then 
					xy_x_o_int <= (others => '0');
					elsif(rising_edge(global_clk_i)) then 
						if (firstcol ="00" or firstcol="01") then 
							xy_x_o_int <= xy_x_o_int + '1';
						else xy_x_o_int <= (others => '0');
						end if;
				end if;
				end process;

STARTLINE0:	process(global_clk_i, global_resetn_i)
						begin
						if (global_resetn_i = '0') then 
							en_rtd2_int <= '0';
							xy_en_o_int2 <= '0';
						elsif(rising_edge(global_clk_i)) then 
							en_rtd2_int <= en_rtd_int;
							xy_en_o_int2 <= xy_en_o_int;
						end if;
						end process;	
		
--starting_line <= en_rtd_int & en_rtd2_int;					-- start of line when starting_line = "10"

	
YCAL0:	process(global_clk_i, global_resetn_i)
				begin
				if (global_resetn_i = '0') then 
					xy_y_o_int <= (others => '0');
					elsif(rising_edge(global_clk_i)) then 
						if (firstlig = "10") and decal_y ='1' then --and (valid_image = '1') then 
						xy_y_o_int <= xy_y_o_int + '1';
						end if;
						
						if (firstlig = "01") then --and (valid_image = '1')) then
						decal_y <= '1';
						end if;
						
						if xy_x_o_int = IMG_WIDTH-1 and xy_y_o_int = IMG_HEIGHT-1 then 
						xy_y_o_int <= (others => '0');
						decal_y <= '0';
						end if;

			
						
				end if;
				end process;	
					


end arch_xy_delay_cody2;
