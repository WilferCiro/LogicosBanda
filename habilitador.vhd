library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--library work;
--use work.componentes_pkg.all;

entity habilitador is
port(
	entrada,clk_p,reset_n,in_contador:in std_logic;
	enable_out:out std_logic
);
end entity;

architecture rtl of habilitador is
signal Q,salida_xor,salida_and,nuevo_enable,nuevo_or:std_logic;
begin
	Q <= '0' when reset_n='0' else entrada when rising_edge(clk_p);
	
	salida_xor <= Q xor entrada;
	
	salida_and <= not(entrada) and salida_xor;
	
	nuevo_or <= not(in_contador) or salida_and;
	
	nuevo_enable <= salida_and or in_contador;
	
	enable_out <= '0' when reset_n='0' else nuevo_or when nuevo_enable='1' and rising_edge(clk_p);

end architecture;