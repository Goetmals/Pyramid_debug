-- ========================================================================== --
--
-- Fichier   :	EDCM108.vhd
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
--	c.Munoz		xx.xx.2001	1.0		Première version
--
-- -------------------------------------------------------------------------- --
-- Rôle :
--
-- génération de l'horloge à 108 MHz à partir d'une horloge à 20 MHz et d'un
-- DCM (Digital Clock Manager) du virtex-II.
--
-- ========================================================================== --


-- Définition des librairies
-- -------------------------------------------------------------------------- --
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- pragma translate_off
library unisim;
use unisim.vcomponents.all;
-- pragma translate_on

use work.all;


--  module EDCM108
-- ------------------------------------------------------------------------- --
entity EDCM108 is
   port	(
	resetb		: in	std_logic;
	clk40MHz	: in	std_logic;

	clk108MHz	: out	std_logic
	);
end EDCM108;


--  definition de l'architecture de EDCM108
-- ------------------------------------------------------------------------- --
architecture ARCH_EDCM108 of EDCM108 is

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des constantes internes
	-- ---------------------------------------------------------- --
constant	MFX		: integer := 27; --108;	--9
constant	DFX		: integer := 10; --20;	--5

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des composants
	-- ---------------------------------------------------------- --
component DCM
-- pragma translate_off
generic	(
	CLKFX_MULTIPLY	: integer := MFX;	--108;
	CLKFX_DIVIDE	: integer := DFX	--20
	);
-- pragma translate_on
 port	(
 	CLKIN		: in	std_ulogic;
	CLKFB		: in	std_ulogic;
	DSSEN		: in	std_ulogic;
	PSINCDEC	: in	std_ulogic;
	PSEN		: in	std_ulogic;
	PSCLK		: in	std_ulogic;
	RST		: in	std_ulogic;
	CLK0		: out	std_ulogic;
--	CLK90		: out	std_ulogic;
--	CLK180		: out	std_ulogic;
--	CLK270		: out	std_ulogic;
--	CLK2X		: out	std_ulogic;
--	CLK2X180	: out	std_ulogic;
--	CLKDV		: out	std_ulogic;
	CLKFX		: out	std_ulogic
--	CLKFX180	: out	std_ulogic;
--	LOCKED		: out	std_ulogic;
--	PSDONE		: out	std_ulogic;
--	STATUS		: out	std_logic_vector(7 downto 0)
	);
end component;

	-- ---------------------------------------------------------- --
component BUFG
   port	(
	O		: out	std_ulogic;
	I		: in	std_ulogic
	);
end component;

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des boîtes noires
	-- ---------------------------------------------------------- --
attribute syn_black_box			: boolean;
attribute syn_black_box of DCM		: component is true;
attribute syn_black_box of BUFG		: component is true;	

	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- déclaration des attributs
	-- ---------------------------------------------------------- --
attribute DFS_FREQUENCY_MODE		: string; 
attribute CLKFX_MULTIPLY		: integer;
attribute CLKFX_DIVIDE			: integer;
attribute CLKIN_PERIOD			: string;

attribute DFS_FREQUENCY_MODE	of DCM0	: label is "LOW";
attribute CLKFX_MULTIPLY	of DCM0	: label is MFX;		--5;	--27;
attribute CLKFX_DIVIDE		of DCM0	: label is DFX;		--4;	--10;
attribute CLKIN_PERIOD		of DCM0	: label is "25000";


	-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ --
	-- définition des signaux internes
	-- ---------------------------------------------------------- --
	signal	GND			: std_logic;
	signal 	reset			: std_logic;

	signal	clkfb0			: std_logic;
	signal	clkfb0buf		: std_logic;

	signal	clk50			: std_logic;
	signal	clk108			: std_logic;


-- ========================================================================= --
begin

	-- ---------------------------------------------------------- --
	GND	<= '0';
	reset	<= not resetb;

	-- génération de l'horloge à 108 MHz
	-- ---------------------------------------------------------- --
DCM0:	DCM    port map	(
		 	 CLKIN		=> clk40MHz
			,CLKFB		=> clkfb0buf
			,DSSEN		=> GND
			,PSINCDEC	=> GND
			,PSEN		=> GND
			,PSCLK		=> GND
			,RST		=> reset
			,CLK0		=> clkfb0

			,CLKFX		=> clk108MHz
--			,CLKFX		=> clk50
			);

	-- buffering de l'horloge à 108 MHz
	-- ---------------------------------------------------------- --		
BUF0:   BUFG   	       port map (
				 O => clkfb0buf
				,I => clkfb0
				);
	-- ---------------------------------------------------------- --
--DIV2:	process ( resetb,clk50 )
--	begin
--		if    ( resetb='0' ) then
--			clk108 <= '0';
--
--		elsif ( rising_edge(clk50) ) then
--			clk108 <= not clk108;
--		end if;
--	end process;

--	clk108MHz <= clk108;


end ARCH_EDCM108;
-- ========================================================================= --
