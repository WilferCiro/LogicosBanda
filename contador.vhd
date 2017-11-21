library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity contador is
generic(
	DATA_WIDTH:natural:=23
);
port(
	En_cont,clk_p,reset_n: in std_logic;
	cuanto_cuenta: in std_logic_vector(22 downto 0);
	cont: out std_logic
);
end entity;

architecture arc of contador is
signal Q,out_sum,out_mux:std_logic_vector(DATA_WIDTH-1 downto 0);
signal comp:std_logic;
begin

	Q <= (others => '0') when reset_n='0' else out_mux when En_cont='1' and rising_edge(clk_p);
	out_sum <= std_logic_vector(unsigned(Q)+to_unsigned(1,DATA_WIDTH));
	with comp select
	out_mux <= out_sum when '0',
				  (others=>'0') when others;
				  
	comp <= '1' when unsigned(out_sum)=unsigned(cuanto_cuenta) else '0';

	cont <= comp;
end architecture;