library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
use work.usart_pkg.all;

entity corrimiento_registros is
port(
	dato_en,clk_p,reset_n,enable,out_cont: in std_logic;
	sal: out std_logic_vector(7 downto 0);
	ya_dato,error:out std_logic
);
end entity;

architecture rtl of corrimiento_registros is
signal p: std_logic_vector(11 downto 0);
signal suma:std_logic_vector(3 downto 0);
signal comparacion,comparacion2:std_logic;
signal A,B,C,D,E,F,G,H:std_logic_vector(3 downto 0);
begin

regs:
	for i in 1 to 11 generate
	begin
		nombre_Generico: reg1bit
		port map (
			d			=>	p(i-1),
			q			=>	p(i),
			clk		=>	clk_p,
			reset_n	=> reset_n,
			ena		=> enable
		);	
	end generate;
		
	sal	<=	p(3) & p(4) & p(5) & p(6) & p(7) & p(8) & p(9) & p(10);
	p(0)	<=	dato_en;
	A		<=	"000"&P(3);
	B		<=	"000"&p(4);
	D		<=	"000"&p(5);
	E		<=	"000"&p(6);
	F		<=	"000"&p(7);
	G		<=	"000"&p(8);
	H		<=	"000"&p(9);
	C		<=	"000"&p(10);
	suma 	<=	std_logic_vector(unsigned(A) + unsigned(B) + unsigned(C) + unsigned(D) + unsigned(E) + unsigned(F) + unsigned(G) + unsigned(H));

	comparacion <= not(suma(0)) xor p(2);
	
	ya_dato 	<= out_cont;
	error		<=	comparacion;
end architecture;
