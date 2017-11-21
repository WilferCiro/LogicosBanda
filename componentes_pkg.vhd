library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package componentes_pkg is

component contador is
	generic(
		DATA_WIDTH:natural:=23
	);
	port(
		En_cont,clk_p,reset_n: in std_logic;
		cuanto_cuenta: in std_logic_vector(22 downto 0);
		cont: out std_logic
	);
end component;
	
	
component preescalar_reloj is
	generic(
		DATA_WIDTH:natural:=4
	);
	port(
		clk,reset_n:in std_logic;
		clk_p:out std_logic
	);
end component;


component PWM is
	generic(
		SUM_WIDTH:natural:=7;
		CONTADOR:natural:=125
	);

	port(
		clk_p,reset_n,enable:in std_logic;
		valor_porcentaje:in std_logic_vector(SUM_WIDTH-1 downto 0);
		s:out std_logic
	);
end component;


component Maquina is

	generic(
		BAN:natural:=2000;
		DEP:natural:=7000;
		ABRIR:natural:=7000;
		CERRADO:natural:=2000;
		NORM:natural:=7000;
		SEG1:natural:=3125000; --3125000
		SEG2:natural:=6250000 -- 6250000
	);

	port(
		s1,s2,s3,s5,x,clk_p,reset_n,cont:in std_logic;
		SC:in std_logic_vector(1 downto 0);
		B1,B2,B3,B4:in std_logic_vector(15 downto 0);
		
		valor_num_caja:in std_logic_vector(7 downto 0);
		num_caja:out std_logic_vector(7 downto 0);
		enable_num_caja:out std_logic;
		
		Mv,led_banda,led_brazo,En_Cont,en_color:out std_logic;
		cuanto_cuenta: out std_logic_vector(22 downto 0);
		Mbr,Mm,Mg:out std_logic_vector(15 downto 0);
		
		Tx:out std_logic_vector(7 downto 0);
		enable_tx:out std_logic;
		
		estado_actual:out std_logic_vector(4 downto 0)
	);
end component;
	
	
component USART is
	port(
		entrada,clk_p,reset_n:in std_logic;
		NUEVO_B1,NUEVO_B2,NUEVO_B3:out std_logic_vector(1 downto 0);
		NUEVO_STOP:out std_logic;
		NUEVO_PWM:out std_logic_vector(2 downto 0)
	);
end component;


component usart_t is
	port(
		d_t:  in std_logic_vector(7 downto 0);
		en_t: 	in std_logic;
		reset_n:	in std_logic;
		clk_p:		in std_logic;
		d_out:	out std_logic
	);
end component;
end package;