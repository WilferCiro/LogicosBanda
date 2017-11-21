library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity suma is
	port(
		en_sum: in std_logic;
		clk_p: in std_logic;
		reset_n: in std_logic;	
		com_out: out std_logic
	);
end entity;
	
architecture rtl of suma is

signal out_mux,out_sum,Q: std_logic_vector(8 downto 0);
signal com: std_logic;

begin
	Q <= (others => '0') when reset_n='0' else out_mux when en_sum='1' and rising_edge(clk_p);
	out_sum <= std_logic_vector(unsigned(Q)+to_unsigned(1,9));
	com <= '1' when unsigned(Q)=to_unsigned(325,9) else '0';

	with com select
		out_mux <= out_sum when '0',
					(others => '0') when others;
		
	com_out<=com;
end architecture;