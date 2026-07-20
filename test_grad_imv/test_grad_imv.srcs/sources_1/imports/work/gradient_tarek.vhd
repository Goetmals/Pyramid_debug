----------------------------------------------------------------------------------
-- Company: ETIS Laboratory
-- Engineer: Thomas Lefebvre
--
-- Module Name:    gradient
--
-- Description: Calculates the intensity of the gradient with a Sobel operator.
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

entity gradient_tarek is
  generic(
    pixel_bus_width_in : natural := 8;
    pixel_bus_width    : natural := 17;
    w_img              : natural := 640;
    h_img              : natural := 480;
    bus_width_x        : natural := unsigned_num_bits(640);
    bus_width_y        : natural := unsigned_num_bits(480));
  port(
    clk, reset, EN  : in  std_logic;
    EN_out   : out std_logic;
    xin      : in  std_logic_vector(bus_width_x-1 downto 0);
    yin      : in  std_logic_vector(bus_width_y-1 downto 0);
    xout     : out std_logic_vector(bus_width_x-1 downto 0);
    yout     : out std_logic_vector(bus_width_y-1 downto 0);
    data_in  : in  std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0));
end entity;


architecture arch_sobel of gradient_tarek is
	constant delay_x       : natural := 4; -- sure ?   -- Commented by Fred 07/01/22
	constant delay_y       : natural := 1;
	
--	constant delay_x       : natural := 0; -- sure ?   -- Commented by Cody
--	constant delay_y       : natural := 0;
	
--	component shift_reg is
--	  generic(
--	    bus_width : natural := 17;
--	    depth     : natural := 640);
--	  port(
--	    clk, EN  : in  std_logic;
--	    data_in  : in  std_logic_vector(bus_width-1 downto 0);
--	    data_out : out std_logic_vector(bus_width-1 downto 0));
--	end component;
	
   component LR_GRAD_TAREK 
       port	(
         resetb		: in	std_logic;
         clkb		: in	std_logic;
    
         enable		: in	std_logic;
         di		    : in	std_logic_vector(7 downto 0);
         do		    : out	std_logic_vector(7 downto 0)
	);
    end component;
    
    component xy_delay_cody is
        generic (
        DELAY_X     : natural := 1;
        DELAY_Y     : natural := 0;
        IMG_WIDTH   : natural := 640;
        IMG_HEIGHT  : natural := 480
        );
        port (
        global_clk_i    : in  std_logic;
        global_resetn_i : in  std_logic;
  
        xy_en_i : in  std_logic;
        xy_x_i : in std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
        xy_y_i : in std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0);
  
        xy_en_o : out std_logic;
        xy_x_o : out std_logic_vector(unsigned_num_bits(IMG_WIDTH-1)-1 downto 0);
        xy_y_o : out std_logic_vector(unsigned_num_bits(IMG_HEIGHT-1)-1 downto 0)
            );
        end component;
    
    
	--signal s_data_out : unsigned(pixel_bus_width-1 downto 0);
	
	signal A,C,doF : std_logic_vector(7 downto 0);
	signal D0, S0, D1, S1 : std_logic_vector(9 downto 0);
	signal pixel_gx, pixel_gy : std_logic_vector(9 downto 0);
	signal vGx, vGy : std_logic_vector(8 downto 0);
	signal Gu, Gv, Gu_r, Gv_r, Gu_i: std_logic_vector(8 downto 0);
	signal Guv : std_logic_vector(9 downto 0);
	signal Gi : std_logic_vector(10 downto 0);
	signal Gvx5 : std_logic_vector(10 downto 0);
	signal Gvx3 : std_logic_vector(9 downto 0);
	signal signe : std_logic_vector(4 downto 0);
	signal sgx, sgy : std_logic_vector(2 downto 0);
	signal sxy : std_logic_vector(1 downto 0);
    signal pixel_ngd : std_logic_vector(9 downto 0);

	-- The IP uses the x_out and y_out values, therefore signals are used to keep a copy of them.
	signal s_xout : std_logic_vector(bus_width_x-1 downto 0);
	signal s_yout : std_logic_vector(bus_width_y-1 downto 0);
	
	signal xin_r1,xin_r2,xin_r3,xin_r4,xin_r5,xin_r6,xin_r7,xin_r8 : std_logic_vector(bus_width_x-1 downto 0);
	signal yin_r1,yin_r2,yin_r3,yin_r4,yin_r5,yin_r6,yin_r7,yin_r8 : std_logic_vector(bus_width_y-1 downto 0);
	
	signal s_EN, s_EN_out, s_enable : std_logic;
	signal decal_en : std_logic_vector(7 downto 0);
	signal en_rtd : std_logic;
	signal yin_int : integer;
	signal decal_data_in : std_logic_vector(7 downto 0); -- add by cody
	signal decal_data_in2 : std_logic_vector(7 downto 0); -- add by cody
	
begin

    yin_int <= conv_integer(yin);
	xout <= s_xout;
	yout <= s_yout;
	EN_out <= s_EN_out;
	--EN_out <= s_EN_out or EN;
	
	s_enable <= EN;--s_EN_out or EN;	-- Le buffer lit un pixel d'entrée à chaque pixel produit en sortie.
	--s_enable <= s_EN_out or EN;	-- Le buffer lit un pixel d'entrée à chaque pixel produit en sortie.
	
	
LRG0:   LR_GRAD_TAREK 
           port map   (
             resetb        => reset,
             clkb          => clk,
        
             enable        => EN,
             di            => A,
             do            => doF
        );

ENR0:   process(clk,reset)
	begin
	   if (reset='0') then 
	   en_rtd <= '0';
	   elsif(rising_edge(clk)) then 
	   en_rtd <= EN;
	   end if;
	end process;  
	         
--	A <=    data_in    when en_rtd ='1'    -- ligne i
--	  else (others=>'0');
	  
--	C <=   A                when yin_int = 0 -- ligne i-1
--	 else  doF              when en_rtd = '1'
--	 else (others=>'0');          
	
	
--	A <=    decal_data_in    when EN ='1'    -- ligne i
--	  else (others=>'0');
	  
--	C <=   A                when yin_int = 0 -- ligne i-1
--	 else  doF              when EN = '1'
--	 else (others=>'0');	
	 
	A <=    decal_data_in    when en_rtd ='1'    -- ligne i
	  else (others=>'0');
	  
	C <=   A                when yin_int = 0 -- ligne i-1
	 else  doF              when en_rtd = '1'
	 else (others=>'0');         
	 
	
	
	      
ELM0:	process(clk,reset)
	begin
	   if (reset='0') then 
	   D0 <= (others=>'0');        D1 <= (others=>'0');
	   S0 <= (others=>'0');        S1 <= (others=>'0');
	  elsif(rising_edge(clk)) then
	--    if(s_enable = '1') then
		decal_data_in <= data_in; -- add by cody
		decal_data_in2 <= decal_data_in; -- add by cody
		D0 <= D1;
		S0 <= S1;
		D1 <= ("00"&C) - ("00"&A);
		S1 <= ("00"&C) + ("00"&A);
	 --   end if;
	  end if;
	end process;

CG0:	process(clk)
	begin
	  if (reset='0') then 
	  pixel_gx <= (others=>'0');       pixel_gy    <= (others=>'0');
	  vGx      <= (others=>'0');       vGy         <= (others=>'0');
	  Gu       <= (others=>'0');       Gv          <= (others=>'0');
	  Guv      <= (others=>'0');       Gi          <= (others=>'0'); 
	  Gu_r     <= (others=>'0');       Gv_r        <= (others=>'0');
	  Gvx5     <= (others=>'0');       Gvx3        <= (others=>'0');
	  Gu_i     <= (others=>'0');  
	  sgx      <= (others=>'0');       sgy         <= (others=>'0');
	  sxy      <= (others=>'0');       signe       <= (others=>'0'); 
	     
	  elsif(rising_edge(clk)) then
	--    if(s_enable = '1') then
		pixel_gx <= S1 - S0;
		pixel_gy <= D1 + D0;

		if ( pixel_gx(9) = '1' ) then vGx <= not (pixel_gx(8 downto 0));      -- on prend valeur absolue du gradient en x
		else vGx <= pixel_gx(8 downto 0);
		end if;
		if ( pixel_gy(9) = '1' ) then vGy <= not (pixel_gy(8 downto 0));      -- on prend valeur absolue du gradient en y
		else vGy <= pixel_gy(8 downto 0);
		end if;

--Pipe 1	
		if (vGx > vGy) then Gu <= vGx;	Gv <= vGy;
		else 		    Gu <= vGy;	Gv <= vGy;
		end if;

--pipe 2 
		Guv <= ('0'&Gu) + ('0'&Gv);
		Gu_r <= Gu;
		Gv_r <= Gv;
		Gvx5 <= ("00"&Gv) + (Gv&"00");
		Gvx3 <= ('0'&Gv) + (Gv&'0');
--pipe 3 
		Gi <= ('0'&Guv) + ("00"&Guv(9 downto 1));
		Gu_i <= Gu_r;

		-- Calcul des signes (sgy&sgx&sxy&s3&s1)
		-------------------------------------------------
--pipe 0
		sgy <= sgy (1 downto 0)&pixel_gy(pixel_gy'length - 1);
		sgx <= sgx (1 downto 0)&pixel_gx(pixel_gx'length - 1);
-- pipe 1 
		if (vGx < vGy) then sxy <= sxy(0)&'1';
		else 		    sxy <= sxy(0)&'0';
		end if;
-- pipe 3
		signe(4 downto 2) <= sgy(2)&sgx(2)&sxy(1);
		if ( ((Gu_r&'0')<Gvx3) ) then signe (1) <= '1';
		else 			      signe (1) <= '0';
		end if;
		
		if ( (("00"&Gu_r)<Gvx5) ) then  signe (0) <= '1';
		else 				signe (0) <= '0';
		end if;
	    end if;
	--  end if;
	end process;
	

		-- affectation des sorties du module 
		--------------------------------------------------------

	NRM0: process (clk)
		begin
		  if (reset='0') then
		      pixel_ngd <= (others=>'0');
		     --------------------------------------------------
			elsif(rising_edge(clk)) then
			   if (Gi(10 downto 1) > ('0'&Gu_i)  ) then 
				pixel_ngd <= Gi(10 downto 1);
			   else 
				pixel_ngd <= ('0'&Gu_i);
			   end if;

			end if;
  		end process;

	data_out <= pixel_ngd(9 downto 2);
	
			
--	lr_grad : shift_reg
--	generic map(
--	  --depth => w_img-3,                  -- Commented by Fred 07/01/22
--	  depth => w_img,
--	  bus_width => pixel_bus_width_in)
--	port map(
--	  clk      => clk,
--	  EN       => EN,
--	  data_in  => A,
--	  data_out => doF);
	
	
	-- resynchronisation des coordonn�es x y et du enable 
	-- le calcul du gradient n�cessite deux coups d'horloge
	-- le calcul de la norme n�cessite trois coups d'horloge
	
	c_xy_delay : xy_delay_cody
		generic map (
			DELAY_X => delay_x,
			DELAY_Y => delay_y,
			IMG_WIDTH => w_img,
			IMG_HEIGHT => h_img
		)
		port map (
			global_clk_i => clk,
			global_resetn_i => reset,

			xy_en_i => EN,
			xy_x_i => xin,
			xy_y_i => yin,

			xy_en_o => s_EN_out,
			xy_x_o => s_xout,
			xy_y_o => s_yout
		);

--SYNC0:  process(clk)                                       -- Commented by Cody
--        begin
--        if (rising_edge(clk)) then
--            decal_en <= decal_en(6 downto 0) & EN;
--        end if;
--        end process;
        
--XY0:    process(clk)
--        begin
--        if (rising_edge(clk)) then
--            xin_r1 <= xin;
--            xin_r2 <= xin_r1;
--            xin_r3 <= xin_r2;
--            xin_r4 <= xin_r3;
--            xin_r5 <= xin_r4;
--            -- Agrandissement des fifo
--            xin_r6 <= xin_r5;
--            xin_r7 <= xin_r6;
--            xin_r8 <= xin_r7;
            
--            yin_r1 <= yin;
--            yin_r2 <= yin_r1;
--            yin_r3 <= yin_r2;
--            yin_r4 <= yin_r3;
--            yin_r5 <= yin_r4;
--            -- Agrandissement des fifo
--            yin_r6 <= yin_r5;
--            yin_r7 <= yin_r6;
--            yin_r8 <= yin_r7;
            
            
--            end if;
--            end process;
            
            
--    s_EN_out <= decal_en(7);
--    xout <= xin_r8;
--    yout <= yin_r8;
       
end arch_sobel;
