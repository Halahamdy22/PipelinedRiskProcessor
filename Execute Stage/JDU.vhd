Library ieee;
use ieee.std_logic_1164.all;
USE IEEE.numeric_std.all;

ENTITY JDU IS 
	PORT(disable:IN std_logic;
		 family_code:IN std_logic_vector(1 downto 0);
	     function_code:IN std_logic_vector(2 downto 0);
	     flags:IN std_logic_vector(3 downto 0);
		 sig_jump:OUT std_logic;
	     flags_jdu_out:OUT std_logic_vector(3 downto 0));
END ENTITY JDU;


ARCHITECTURE JDU OF JDU IS 

signal carryflag:std_logic;
signal zeroflag:std_logic;
signal negativeflag:std_logic;

BEGIN	

-- flags(0) : zero flag
-- flags(1) : negative flag
-- flags(2) : carry flag

-- JZ : 000
-- JC : 001
-- JN : 010
-- JMP : 011 
-- call : 100

sig_jump <= '0' WHEN disable='1'
	ELSE '1' WHEN ((family_code = "11") and (function_code = "000") and (flags(0) = '1'))
	 ELSE '1' WHEN ((family_code = "11") and (function_code = "001") and (flags(2) = '1'))
	 ELSE '1' WHEN ((family_code = "11") and (function_code = "010") and (flags(1) = '1'))
	 ELSE '1' WHEN ((family_code = "11") and (function_code = "011"))
	 ELSE '1' WHEN ((family_code = "11") and (function_code = "100"))
	 ELSE '0' ;

zeroflag <= '0' WHEN ((family_code = "11") and (function_code = "000") and (flags(0) = '1'))
	ELSE flags(0);

carryflag <= '0'  WHEN ((family_code = "11") and (function_code = "001") and (flags(2) = '1'))
	ELSE flags(2);

negativeflag <= '0' WHEN ((family_code = "11") and (function_code = "010") and (flags(1) = '1'))
	ELSE flags(1);

flags_jdu_out <= '0'& carryflag & negativeflag & zeroflag;
END JDU; 