library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.math_real.all;

package saturn_dog_pkg is
	function gauss_coeff1D (
		x: integer; 
		sq_sigma: real; 
		w_kernel: natural; 
		w_bus_in: natural; 
		w_bus_out: natural
	) return natural;
end package saturn_dog_pkg;
