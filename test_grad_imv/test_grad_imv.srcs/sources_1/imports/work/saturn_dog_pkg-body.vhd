package body saturn_dog_pkg is
-- calculates Gaussian coefficients in order to reduce error in output :
-- if data_in = image full of pixels of value "111", then data_out should be "1110[...]0", a shift gives precisely "111.0[...]0"
	function gauss_coeff1D(	x: integer; 
		sq_sigma: real; 
		w_kernel: natural; 
		w_bus_in: natural; 
		w_bus_out: natural
	) return natural is
		variable sum          : real := 0.0;
		variable max_data_in  : real := 2.0**real(w_bus_in)-1.0;
		variable max_data_out : real := (2.0**real(w_bus_in)-1.0) * (2.0**(w_bus_out-w_bus_in));
		variable max_sum      : real;
		variable coeff        : real;
	begin
-- sum of real coefficients
		for i in -(w_kernel-1)/2 to (w_kernel-1)/2 loop
			sum := sum + EXP(- real(i*i)/(2.0*sq_sigma));
		end loop;
-- maximum value that the sum of the coefficients is allowed to reach
		max_sum := max_data_out/max_data_in;
-- calculation of the coefficient
		coeff := max_sum/sum * EXP(- real(x*x)/(2.0*sq_sigma));
		return natural(coeff);
	end gauss_coeff1D;
end package body saturn_dog_pkg;
