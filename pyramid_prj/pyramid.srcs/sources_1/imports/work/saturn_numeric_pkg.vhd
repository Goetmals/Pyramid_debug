library ieee;
use ieee.std_logic_1164.all;

package saturn_numeric_pkg is
	function UNSIGNED_NUM_BITS (ARG: NATURAL) return NATURAL;
	function lim (R: natural; x: integer) return natural;
	function top_1_bit(bits: std_logic_vector) return integer;
end package saturn_numeric_pkg;

