library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.componentes_pkg.all;
use work.usart_pkg.all;

entity ProyectoFinalCasiquenoEsteSi is
	generic(
		DATA_CUENTA:natural:=23
	);
	port(
		not_s1,not_s2,s3,s5,x,clk,reset_n,entrada_usb:in std_logic;
		SC:in std_logic_vector(1 downto 0);
		motor_brazo,motor_garra,motor_giro,motor_banda,led_banda,led_brazo,led_stop,led1,led2,salida_usb:out std_logic;
		actual_estado:out std_logic_vector(4 downto 0)
	);
end entity;

architecture inicial of ProyectoFinalCasiquenoEsteSi is
signal clk_p,En_cont,cont,nuevo_x,s1,s2:std_logic;
signal cuanto_cuenta:std_logic_vector(DATA_CUENTA-1 downto 0);

signal nuevo_motor_banda:std_logic;
signal nuevo_motor_brazo,nuevo_motor_garra,nuevo_motor_giro:std_logic_vector(15 downto 0);

signal NUEVO_B1,NUEVO_B2,NUEVO_B3:std_logic_vector(1 downto 0);
signal NUEVO_STOP:std_logic;
signal NUEVO_PWM:std_logic_vector(2 downto 0);

signal ENVIO_B1,ENVIO_B2,ENVIO_B3,ENVIO_PWM,B4:std_logic_vector(15 downto 0);

signal valor_pwm_banda:std_logic_vector(9 downto 0);

signal Tx: std_logic_vector(7 downto 0);
signal enable_tx:std_logic;
signal corrimiento:std_logic_Vector(6 downto 0);


signal en_color:std_logic;
signal Q_color:std_logic_Vector(1 downto 0);

signal valor_num_caja: std_logic_vector(7 downto 0);
signal enable_num_caja:std_logic;
signal num_caja:std_logic_vector(7 downto 0);
begin
	B4<=std_logic_Vector(to_unsigned(3850,16));
	nuevo_x<=NUEVO_STOP;
	s1<=not(not_s1);
	s2<=not(not_s2);
	
	PRES:preescalar_reloj
	generic map(
		DATA_WIDTH	=>	4
	)
	port map(
		clk			=>	clk,
		reset_n		=>	reset_n,
		clk_p			=>	clk_p		
	);

	
	CONTADORENCIUN:contador
	generic map(
		DATA_WIDTH	=> DATA_CUENTA
	)
	port map(
		En_cont			=>	En_cont,
		clk_p				=>	clk_p,
		reset_n			=>	reset_n,
		cuanto_cuenta	=>	cuanto_cuenta,
		cont				=>	cont
	);
	PWMBANDA:PWM
	generic map(
		SUM_WIDTH		=> 7,
		CONTADOR			=> 125
	)
	port map(
		clk_p					=> clk_p,
		reset_n				=> reset_n,
		enable				=>	nuevo_motor_banda,
		valor_porcentaje	=> corrimiento,  -- Ojos
		s						=> motor_banda
	);
	
	
	
	
	PWMBRAZO:PWM
	generic map(
		SUM_WIDTH		=> 16,
		CONTADOR			=> 62500
	)
	port map(
		clk_p					=> clk_p,
		reset_n				=> reset_n,
		enable				=>	'1',
		valor_porcentaje	=> nuevo_motor_brazo,
		s						=> motor_brazo
	);
	
	
	PWMGARRA:PWM
	generic map(
		SUM_WIDTH		=> 16,
		CONTADOR			=> 62500
	)
	port map(
		clk_p					=> clk_p,
		reset_n				=> reset_n,
		enable				=>	'1',
		valor_porcentaje	=> nuevo_motor_garra,
		s						=> motor_garra
	);
	
	PWMGIRO:PWM
	generic map(
		SUM_WIDTH		=> 16,
		CONTADOR			=> 62500
	)
	port map(
		clk_p					=> clk_p,
		reset_n				=> reset_n,
		enable				=>	'1',
		valor_porcentaje	=> nuevo_motor_giro,
		s						=> motor_giro
	);
	
	
	MAQ:Maquina
	generic map(
		BAN		=>	2755,
		DEP		=> 7178,
		ABRIR		=> 5230,
		CERRADO	=> 5977,
		NORM		=> 3800,		
		SEG1		=> 3125000, --3125000
		SEG2		=> 6250000 -- 6250000
	)
	port map(
		s1					=> s1,
		s2					=> s2,
		s3					=> s3,
		s5					=> s5,
		x					=> nuevo_x,
		clk_p				=> clk_p,
		reset_n			=> reset_n,
		cont				=> cont,
		SC					=> Q_color,
		en_color			=> en_color,
		B1					=> ENVIO_B1, -- Ojos
		B2					=> ENVIO_B2,	
		B3					=>	ENVIO_B3,
		B4					=> B4,
		Mv					=> nuevo_motor_banda,
		led_banda		=> led_banda,
		led_brazo		=> led_brazo,
		En_Cont			=>	En_cont,
		cuanto_cuenta	=> cuanto_cuenta,
		Mbr				=> nuevo_motor_brazo,
		Mm					=> nuevo_motor_garra,
		Mg					=> nuevo_motor_giro,
		estado_actual	=> actual_estado,
		Tx					=> Tx,
		enable_tx		=> enable_tx,
		valor_num_caja	=> valor_num_caja,
		num_caja			=> num_caja,
		enable_num_caja=> enable_num_caja
	);
	
	US:USART
	port map(
		entrada		=> entrada_usb,
		clk_p			=> clk_p,
		reset_n		=> reset_n,
		NUEVO_B1		=> NUEVO_B1,
		NUEVO_B2		=> NUEVO_B2,
		NUEVO_B3		=>	NUEVO_B3,
		NUEVO_STOP	=> NUEVO_STOP,
		NUEVO_PWM	=> NUEVO_PWM
	);
	
	us_envio: usart_t
		port map(
			d_t		=> Tx,
			en_t		=> enable_tx,
			reset_n	=> reset_n,
			clk_p		=> clk_p,
			d_out		=> salida_usb
		);

	Q_color<=(others=>'0') when reset_n='0' else SC when rising_edge(clk_p) and en_color='1';
	
	valor_pwm_banda<=std_logic_vector( (unsigned(NUEVO_PWM) * to_unsigned(56,7) ) + to_unsigned(720,10));
	corrimiento<=valor_pwm_banda(9 downto 3);

	valor_num_caja <= (others => '0') when reset_n='0' else num_caja when enable_num_caja = '1' and rising_edge(clk_p);
	-- B4 -> 6550
	-- B3 -> 6077
	-- B2 -> 5400
	-- B1 -> 3990
	
	with NUEVO_B1 select
		ENVIO_B1 <= std_logic_vector(to_unsigned(4700,16)) when "01",
						std_logic_vector(to_unsigned(5977,16)) when "10",
						std_logic_vector(to_unsigned(6550,16)) when "11",
						std_logic_vector(to_unsigned(3850,16)) when others; -- Sin color
						
	with NUEVO_B2 select
		ENVIO_B2 <= std_logic_vector(to_unsigned(4700,16)) when "01",
						std_logic_vector(to_unsigned(5977,16)) when "10",
						std_logic_vector(to_unsigned(6550,16)) when "11",
						std_logic_vector(to_unsigned(3850,16)) when others; -- Sin color
	
	with NUEVO_B3 select
		ENVIO_B3 <= std_logic_vector(to_unsigned(4700,16)) when "01",
						std_logic_vector(to_unsigned(5977,16)) when "10",
						std_logic_vector(to_unsigned(6550,16)) when "11",
						std_logic_vector(to_unsigned(3850,16)) when others; -- Sin color

	led_stop <= nuevo_x;
	led1	<= s1;
	led2	<= s2;
	
	
end architecture;
