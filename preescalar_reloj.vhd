-- Quartus Prime VHDL Template
-- Signed Adder

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity preescalar_reloj is
	generic(
		DATA_WIDTH:natural:=4
	);
	port(
		clk,reset_n:in std_logic;
		clk_p:out std_logic
	);
end entity;

architecture rtl of preescalar_reloj is
	signal Q,out_sum:std_logic_vector(DATA_WIDTH-1 downto 0);
begin
	Q <= (others => '0') when reset_n='0' else out_sum	when rising_edge(clk);
	out_sum <= std_logic_Vector(unsigned(Q)+to_unsigned(1,DATA_WIDTH));
	clk_p <= Q(DATA_WIDTH-1);
end architecture;