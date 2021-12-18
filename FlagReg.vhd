LIBRARY IEEE;
USE IEEE.std_logic_1164.all;


ENTITY FlagReg IS
	PORT(en,clk,rst:IN std_logic;
	d:IN std_logic_vector (3 DOWNTO 0);
	q:OUT std_logic_vector (3 DOWNTO 0));
END ENTITY FlagReg ;


ARCHITECTURE my_reg OF FlagReg IS 
BEGIN
	--made to be asynchronous flip flop
	PROCESS(clk,rst)
	BEGIN
		IF rst='1' THEN 
			q<=(OTHERS=>'0');
		ELSIF RISING_EDGE(clk) and en='1' THEN
			q<=d;
		END IF;
		--no need to add else ,since we need a latch effect
	END PROCESS;
END my_reg;