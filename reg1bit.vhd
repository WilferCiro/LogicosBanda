library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity reg1bit is

port(
	d: in std_logic;
	clk: in std_logic;
	reset_n: in std_logic;
	ena: in std_logic;
	q: out std_logic

);

end entity;

architecture rtl of reg1bit is

begin

	q <= '0' when reset_n='0' else d when rising_Edge(clk) and ena='1';


end architecture;
