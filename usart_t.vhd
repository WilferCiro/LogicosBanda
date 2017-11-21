library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity usart_t is

	port(
		d_t:  in std_logic_vector(7 downto 0);
		en_t: 	in std_logic;
		reset_n:	in std_logic;
		clk_p:		in std_logic;
		d_out:	out std_logic
	);
end entity;

architecture rtl of usart_t is 

component suma is
	port(
		en_sum: in std_logic;
		clk_p: in std_logic;
		reset_n: in std_logic;		
		com_out: out std_logic
	);
end component;

type transmision is (e0,e1,e2,e3,e4,e5,e6,e7,e8,e9,e10,e11);
signal CS,NS: transmision;
signal comp,en_sum,pa: std_logic; 
signal suma_par:std_logic_vector(2 downto 0);
signal A,B,C,D,E,F,G,H:std_logic_Vector(2 downto 0);
begin

CS <= e0 when reset_n='0' else NS when rising_edge(clk_p);
	A<="00"&d_t(0);
	B<="00"&d_t(1);
	C<="00"&d_t(2);
	D<="00"&d_t(3);
	E<="00"&d_t(4);
	F<="00"&d_t(5);
	G<="00"&d_t(6);
	H<="00"&d_t(7);
	suma_par<=std_logic_vector(unsigned(A)+unsigned(B)+unsigned(C)+unsigned(D)+unsigned(E)+unsigned(F)+unsigned(G)+unsigned(H));
	process(CS,comp,en_t)
	begin
	
		case CS is
			when e0=>
				if en_t='1' then
					NS<=e1;
				else
					NS<=e0;
				end if;
				
			when e1=>
				if comp='1' then
					NS<=e2;
				else
					NS<=e1;
				end if;
			
			when e2=>
				if comp='1' then
					NS<=e3;
				else
					NS<=e2;
				end if;
			
			when e3=>
				if comp='1' then
					NS<=e4;
				else
					NS<=e3;
				end if;
				
			when e4=>
				if comp='1' then
					NS<=e5;
				else
					NS<=e4;
				end if;
				
			when e5=>
				if comp='1' then
					NS<=e6;
				else
					NS<=e5;
				end if;
				
			when e6=>
				if comp='1' then
					NS<=e7;
				else
					NS<=e6;
				end if;
				
			when e7=>
				if comp='1' then
					NS<=e8;
				else
					NS<=e7;
				end if;
				
			when e8=>
				if comp='1' then
					NS<=e9;
				else
					NS<=e8;
				end if;
				
			when e9=>
				if comp='1' then
					NS<=e10;
				else
					NS<=e9;
				end if;
				
			when e10=>
				if comp='1' then
					NS<=e11;
				else
					NS<=e10;
				end if;
				
			when e11=>
				if comp='1' then
					NS<=e0;
				else
					NS<=e11;
				end if;
			end case;
				
	end process;
	
	process(CS,d_t,suma_par)
	begin
		case CS is
			when e0=>
				d_out<='1';
				en_sum<='0';
				
			when e1=>
				d_out<='0';
				en_sum<='1';
			
			when e2=>
				d_out<=d_t(0);
				en_sum<='1';
			
			when e3=>
				d_out<=d_t(1);
				en_sum<='1';
			
			when e4=>
				d_out<=d_t(2);
				en_sum<='1';
			
			when e5=>
				d_out<=d_t(3);
				en_sum<='1';
			
			when e6=>
				d_out<=d_t(4);
				en_sum<='1';
			
			when e7=>
				d_out<=d_t(5);
				en_sum<='1';
				
			when e8=>
				d_out<=d_t(6);
				en_sum<='1';
			
			when e9=>
				d_out<=d_t(7);
				en_sum<='1';
			
			when e10=>
				d_out<=not(suma_par(0));			--PARIDAD
				en_sum<='1';
				
			when e11=>
				d_out<='1';
				en_sum<='1';
			
		end case;
		
	end process;
	
sum:suma
	port map(
	en_sum=>en_sum,
	clk_p=>clk_p,
	reset_n=>reset_n,
	
	com_out=>comp
	);

	

end architecture;