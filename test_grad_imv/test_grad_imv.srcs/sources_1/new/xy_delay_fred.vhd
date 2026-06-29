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

library work;
use work.saturn_numeric_pkg.all;

entity xy_delay_fred is
  generic (
    DELAY_X     : natural := 1;
    DELAY_Y     : natural := 0;
    IMG_WIDTH   : natural := 640;
    IMG_HEIGHT  : natural := 480
    );
  port (
    global_clk_i    : in  std_logic;
    global_resetn_i : in  std_logic;
    
    xy_en_i         : in  std_logic;
    xy_x_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
    xy_y_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
    
    xy_en_o : out std_logic;
    xy_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
    xy_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0)
            );
end entity;


architecture arch_xy_delay_fred of xy_delay_fred is

signal output_starting : std_logic := '0'; -- allows the activation of EN_out t=delay and t=w_img*h_img-1
signal output_ending   : std_logic := '0'; -- allows the activation of EN_out and coordinates calculation between t=w_img*h_max and t=(w_img*h_img + delay)
signal s_xin  : unsigned(xy_x_o'range) := (others => '0');
signal s_yin  : unsigned(xy_x_o'range) := (others => '0');
signal s_xout : unsigned(xy_x_o'range) := (others => '0');
signal s_yout : unsigned(xy_x_o'range) := (others => '0');

signal nb_lig   : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
signal nb_lig_r : std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
signal en_rtd   : std_logic_vector(DELAY_X downto 0);


            
begin

nb_lig <= xy_y_i;

--xy_en_o <= '1' when ( (output_starting='1' and xy_en_i='1') or (output_ending='1' and xy_en_i = '1') )
--		   else '0';
		   
xy_en_o <= '1' when ((output_starting='1' and en_rtd(unsigned_num_bits(DELAY_X)-1) ='1') or (output_ending='1' and en_rtd(unsigned_num_bits(DELAY_X)-1) ='1'))
		   else '0';		   
--xy_en_o <= en_rtd(DELAY_X) and nb_lig_r(DELAY_Y-1);

xy_x_o   <= std_logic_vector(s_xout);
xy_y_o   <= std_logic_vector(s_yout);
s_xin  <= unsigned(xy_x_i);
s_yin  <= unsigned(xy_y_i);

SYN0:   process(global_resetn_i, global_clk_i)
        begin
            if (global_resetn_i='0') then
                en_rtd <= (others => '0');
--                nb_lig <= (others => '1');
--                nb_lig_r <= (others => '1');
            elsif (rising_edge(global_clk_i)) then
                nb_lig_r <= nb_lig;
                en_rtd <= en_rtd(DELAY_X-1 downto 0) & xy_en_i;
--                if (en_rtd(0)='0' and xy_en_i='1') then
--                    nb_lig <= nb_lig(DELAY_Y-1 downto 0) & xy_en_i;
--                end if;
            end if;
        end process;
        
process(global_clk_i)
begin
  if(rising_edge(global_clk_i)) then
  
    -- Output starting point
      if(s_xin=to_unsigned(DELAY_X,s_xin'length) and s_yin=to_unsigned(DELAY_Y,s_yin'length)) then
        s_xout <= (others => '0');
        s_yout <= (others => '0');
        output_starting <= '1';
      end if;
  
   -- End of input picture, output signals are always on until the end of the output picture.
      if(s_xin=to_unsigned(IMG_WIDTH-1,s_xin'length) and s_yin=to_unsigned(IMG_HEIGHT-1,s_yin'length)) then
        output_starting <= '0';
        output_ending <= '1';
      end if;
	  
  --  if(xy_en_i='1' ) then --or output_ending='1') then
      if(xy_en_i='1' or output_ending='1') then
      -- End of output picture, IP goes to sleep
      if(s_xout=to_unsigned(IMG_WIDTH-1,s_xout'length) and s_yout=to_unsigned(IMG_HEIGHT-1,s_yout'length)) then
        output_ending <= '0';
      end if;
	  end if;	
     
      if(output_starting = '1') and (output_ending = '0') then
        -- Next coordinates are calculated if count has started
        if(s_xout = to_unsigned(IMG_WIDTH-1,s_xout'length)) then
          s_xout <= (others=>'0');
          s_yout <= s_yout+1;
        else
          s_xout <= s_xout+1;
        end if;
      end if;

          
  end if;
end process;

end arch_xy_delay_fred;
