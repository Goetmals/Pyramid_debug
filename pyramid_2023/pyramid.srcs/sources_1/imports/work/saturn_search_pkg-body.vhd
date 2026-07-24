package body saturn_search_pkg is
	function offset (d: integer; size: integer) return integer is
		variable ret : integer := 0;
	begin
		l_i : for i in 0 to d-1 loop
			ret := ret + integer(ceil(real(size)/real(2**i)));
		end loop l_i;
		return ret;
	end function offset;

	function nb_sig_stage (d: integer; size: integer) return integer is
	begin
		return integer(ceil(real(size)/real(2**d)));
	end function nb_sig_stage;
	
	function count_signals (size: integer) return integer is
		constant C_SQRT_SIZE : integer := unsigned_num_bits(size);
		variable ret : integer := 0;
	begin
		l_depth : for d in 0 to C_SQRT_SIZE-1 loop
			ret := ret + integer(ceil(real(size) / real(2**d)));
		end loop l_depth;
		return ret;
	end function count_signals;
end package body saturn_search_pkg;
