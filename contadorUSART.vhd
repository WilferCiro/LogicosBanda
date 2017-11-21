library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--library work;
--use work.componentes_pkg.all;

entity contadorUSART is
port(
	clk_p,reset_n,in_habilitador:in std_logic;
	out_contador,out_enable:out std_logic
);
end entity;

architecture rtl of contadorUSART is
signal Q,out_mux,out_sum,para_comparar:std_logic_vector(8 downto 0);
signal out_mux2,Q2,out_sum11:std_logic_vector(3 downto 0);
signal comparador,comp11,compara_menor:std_logic;
begin
	Q <= (others=>'0') when reset_n='0' else out_mux when in_habilitador='1' and rising_edge(clk_p);
	
	with comparador select
		out_mux <= out_sum when '0',
						(others=>'0') when others;
	out_sum <= std_logic_vector(unsigned(Q) + to_unsigned(1,9));
	
	comparador <= '1' when unsigned(out_sum)=unsigned(para_comparar) else '0';
	out_enable <= comparador;
	with compara_menor select
		para_comparar <= std_logic_vector(to_unsigned(162,9)) when '0',
							  std_logic_vector(to_unsigned(325,9)) when others;
	
	compara_menor <= '1' when unsigned(Q2)>=to_unsigned(1,4) else '0';
	
	Q2 <= (others=>'0') when reset_n='0' else out_mux2 when comparador='1' and rising_edge(clk_p);
	
	with comp11 select
		out_mux2 <= out_sum11 when '0',
						(others=>'0') when others;
	
	out_sum11 <= std_logic_vector(unsigned(Q2) + to_unsigned(1,3));
	
	comp11 <= '1' when unsigned(Q2) = to_unsigned(11,4) else '0';
	
	out_contador<=comp11 and comparador;
end architecture;
