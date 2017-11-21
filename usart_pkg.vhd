library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;

package usart_pkg is

component reg1bit is
	port(
		d: in std_logic;
		clk: in std_logic;
		reset_n: in std_logic;
		ena: in std_logic;
		q: out std_logic

	);
end component;


component corrimiento_registros is
	port(
		dato_en,clk_p,reset_n,enable,out_cont: in std_logic;
		sal: out std_logic_vector(7 downto 0);
		ya_dato,error:out std_logic
	);
end component;

component contadorUSART is
	port(
		clk_p,reset_n,in_habilitador:in std_logic;
		out_contador,out_enable:out std_logic
	);
end component;

component habilitador is
	port(
		entrada,clk_p,reset_n,in_contador:in std_logic;
		enable_out:out std_logic
	);
end component;

component reg8bit is
	port(
		clk,reset_n,ena: in std_logic;
		d: in std_logic_vector(7 downto 0);
		q: out std_logic_vector(7 downto 0)

	);
end component;

component guarda_reparticion is
	generic(
		INICIALB1:natural:=100;
		INICIALB2:natural:=90;
		INICIALB3:natural:=110
	);
	port(
		STOP,ENABLE,clk_p,reset_n: in std_logic;
		B1,B2,B3: in std_logic_vector(1 downto 0);
		PWM_BANDA:in std_logic_vector(2 downto 0);
		
		ACTUALSTOP:out std_logic;
		ACTUALB1,ACTUALB2,ACTUALB3: out std_logic_vector(1 downto 0);
		ACTUAL_PWM:out std_logic_vector(2 downto 0)
	);
end component;


component repartidor is
	port(
		ya_dato,clk_p,reset_n,ACTUALSTOP: in std_logic;
		entrada8: in std_logic_vector(7 downto 0);
		ACTUALB1,ACTUALB2,ACTUALB3: in std_logic_vector(1 downto 0);
		ACTUAL_PWM:in std_logic_vector(2 downto 0);
		
		STOP,ENABLE: out std_logic;
		B1,B2,B3: out std_logic_vector(1 downto 0);
		PWM_BANDA:out std_logic_vector(2 downto 0)
	);
end component;

end package;
