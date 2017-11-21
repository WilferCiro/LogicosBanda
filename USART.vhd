library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.usart_pkg.all;

entity USART is

port(
	entrada,clk_p,reset_n:in std_logic;
	NUEVO_B1,NUEVO_B2,NUEVO_B3:out std_logic_vector(1 downto 0);
	NUEVO_STOP:out std_logic;
	NUEVO_PWM:out std_logic_vector(2 downto 0)
);
end entity;

architecture rtl of USART is
signal in_contador,habilitador_out,out_enable,ya_hay_datenciun:std_logic;
signal salidenciun,Q:std_logic_vector(7 downto 0);
signal error:std_logic;


signal STOP,ENABLE: std_logic;
signal B1,B2,B3: std_logic_vector(1 downto 0);
signal PWM_BANDA: std_logic_vector(2 downto 0);

signal ACTUALSTOP: std_logic;
signal ACTUALB1,ACTUALB2,ACTUALB3: std_logic_vector(1 downto 0);
signal ACTUAL_PWM: std_logic_vector(2 downto 0);

signal nuevo_en:std_logic;
begin
	
	habi:habilitador
	port map(
		entrada		=> entrada,
		clk_p			=> clk_p,
		reset_n		=> reset_n,
		in_contador	=> in_contador,
		enable_out	=>habilitador_out
	);
	
	con:contadorUSART
	port map(
		clk_p				=> clk_p,
		reset_n			=> reset_n,
		in_habilitador	=> habilitador_out,
		out_contador	=> in_contador,
		out_enable		=> out_enable
	);
	
	corrimiento:corrimiento_registros
	port map(
		dato_en	=> entrada,  	--si
		error		=> error,
		clk_p		=> clk_p,		--si
		reset_n	=> reset_n,		--si
		enable	=> out_enable,	--si
		out_cont	=> in_contador,
		sal		=> salidenciun,		--si
		ya_dato	=> ya_hay_datenciun		--si
	);
	
	
	nuevo_en<=(ya_hay_datenciun and not(error));
	rep:repartidor
	port map(
		ya_dato		=> nuevo_en,
		clk_p			=> clk_p,
		reset_n		=> reset_n,
		ACTUALSTOP	=> ACTUALSTOP,
		entrada8		=> Q,
		ACTUALB1		=> ACTUALB1,
		ACTUALB2		=> ACTUALB2,
		ACTUALB3		=> ACTUALB3,
		ACTUAL_PWM	=> ACTUAL_PWM,
		STOP			=> STOP,
		ENABLE		=> ENABLE,
		B1				=> B1,
		B2				=> B2,
		B3				=> B3,
		PWM_BANDA	=> PWM_BANDA
	);
	
	
	guarda:guarda_reparticion
	generic map(
		INICIALB1		=> 1,
		INICIALB2		=> 2,
		INICIALB3		=> 3
	)
	port map(
		STOP			=> STOP,
		ENABLE		=> ENABLE,
		clk_p			=> clk_p,
		reset_n		=> reset_n,
		B1				=> B1,
		B2				=> B2,
		B3				=> B3,
		PWM_BANDA	=> PWM_BANDA,
		
		ACTUALSTOP	=> ACTUALSTOP,
		ACTUALB1		=> ACTUALB1,
		ACTUALB2		=> ACTUALB2,
		ACTUALB3		=> ACTUALB3,
		ACTUAL_PWM	=> ACTUAL_PWM
	);
	
	NUEVO_B1 <= ACTUALB1;
	NUEVO_B2 <= ACTUALB2;
	NUEVO_B3 <= ACTUALB3;
	
	NUEVO_PWM <= ACTUAL_PWM;
	NUEVO_STOP <= ACTUALSTOP;
	
	Q <= (others=>'0') when reset_n='0' else salidenciun when ya_hay_datenciun='1' and error='0' and rising_edge(clk_p);

end architecture;
