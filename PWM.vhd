library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity PWM is
	generic(
		SUM_WIDTH:natural:=7;
		CONTADOR:natural:=125
	);

	port(
		clk_p,reset_n,enable:in std_logic;
		valor_porcentaje:in std_logic_vector(SUM_WIDTH-1 downto 0);
		s:out std_logic
	);
end entity;

architecture rtl of PWM is
signal Q2,out_sum2,out_mux2:std_logic_vector(SUM_WIDTH-1 downto 0);
signal comp2,comp:std_logic;
begin
	
	Q2 <= (others => '0') when reset_n='0' else out_mux2 when enable='1' and rising_edge(clk_p);
	out_sum2 <= std_logic_Vector(unsigned(Q2)+to_unsigned(1,SUM_WIDTH));
	with comp select
	out_mux2 <= out_sum2 when '0',
				  (others=>'0') when others;
				  
	comp <= '1' when unsigned(out_sum2)=to_unsigned(CONTADOR,SUM_WIDTH) else '0';
	comp2<= '1' when unsigned(out_sum2)<unsigned(valor_porcentaje) else '0';
	s<=(comp or comp2) and enable;

end architecture;