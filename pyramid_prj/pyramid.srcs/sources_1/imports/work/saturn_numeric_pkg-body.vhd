package body saturn_numeric_pkg is
	function UNSIGNED_NUM_BITS (ARG: NATURAL) return NATURAL is
		variable NBITS: NATURAL;
		variable N: NATURAL;
	begin
		N := ARG;
		NBITS := 1;
		while N > 1 loop
			NBITS := NBITS+1;
			N := N / 2;
		end loop;
		return NBITS;
	end UNSIGNED_NUM_BITS;
	
-- lim calculates the vertical boundaries of a circle, 
-- for a value of x (centered around 0),
-- or the horizontal boundaries for a value of y.
	function lim(R: natural; x: integer) return natural is
	begin
		if (x*x > R*R) then
			return 3000;
		end if;
		for y in 1 to R+1 loop
			if((x*x)+(y*y) > (R*R)) then
				return y-1;
			end if;
		end loop;
		return 3000;
	end lim;
	
-- Function to calculate highest-1s bit position
	function top_1_bit(bits: std_logic_vector) return integer
	is
		variable b: std_logic_vector(0 to bits'length-1);
		variable result: integer;
	begin
		b := bits;
		result := -1;
		for i in b'range loop
			if b(i) = '1' then
				result := i;
			end if;
		end loop;
		return result;
	end;
end package body saturn_numeric_pkg;
