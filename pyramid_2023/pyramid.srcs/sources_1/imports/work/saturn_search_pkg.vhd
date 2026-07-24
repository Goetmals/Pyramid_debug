library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

use work.saturn_numeric_pkg.all;

package saturn_search_pkg is
--------------------------------------------------------------------------------
-- function offset :
-- computes the index of the first signal 
-- to be connected to the d stage with a window of side size.
--------------------------------------------------------------------------------
	function offset (d: integer; size: integer) return integer;
--------------------------------------------------------------------------------
-- function nb_sig_stage :
-- computes the number of signals we will find in the stage d
-- with a window of side size.
--------------------------------------------------------------------------------
	function nb_sig_stage (d: integer; size: integer) return integer;
--------------------------------------------------------------------------------
-- function count_signals :
-- counts the horizontal signals with a window of side size.
--------------------------------------------------------------------------------
	function count_signals (size: integer) return integer;
end package saturn_search_pkg;
