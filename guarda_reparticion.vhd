library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity guarda_reparticion is
generic(
	INICIALB1:natural:=1;
	INICIALB2:natural:=2;
	INICIALB3:natural:=3
);
port(
	STOP,ENABLE,clk_p,reset_n: in std_logic;
	B1,B2,B3: in std_logic_vector(1 downto 0);
	PWM_BANDA:in std_logic_vector(2 downto 0);
	
	ACTUALSTOP:out std_logic;
	ACTUALB1,ACTUALB2,ACTUALB3: out std_logic_vector(1 downto 0);
	ACTUAL_PWM:out std_logic_vector(2 downto 0)
);
end entity;

architecture rtl of guarda_reparticion is
begin
	ACTUALSTOP <= '0' when reset_n='0' else STOP when rising_edge(clk_p) and ENABLE='1';
	
	ACTUALB1 <= (std_logic_vector(to_unsigned(INICIALB1,2))) when reset_n='0' else B1 when rising_edge(clk_p) and ENABLE='1';
	ACTUALB2 <= (std_logic_vector(to_unsigned(INICIALB2,2))) when reset_n='0' else B2 when rising_edge(clk_p) and ENABLE='1';
	ACTUALB3 <= (std_logic_vector(to_unsigned(INICIALB3,2))) when reset_n='0' else B3 when rising_edge(clk_p) and ENABLE='1';
	
	ACTUAL_PWM <= (std_logic_vector(to_unsigned(5,3))) when reset_n='0' else PWM_BANDA when rising_edge(clk_p) and ENABLE='1';

end architecture;