library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;


entity repartidor is

port(
	ya_dato,clk_p,reset_n,ACTUALSTOP: in std_logic;
	entrada8: in std_logic_vector(7 downto 0);
	ACTUALB1,ACTUALB2,ACTUALB3: in std_logic_vector(1 downto 0);
	ACTUAL_PWM:in std_logic_vector(2 downto 0);
	STOP,ENABLE: out std_logic;
	B1,B2,B3: out std_logic_vector(1 downto 0);
	PWM_BANDA:out std_logic_vector(2 downto 0)
);

end entity;

architecture rtl of repartidor is
type estado_repartidor is (E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E12);
signal CS,NS: estado_repartidor;
begin
	CS <= E1 when reset_n='0' else NS when rising_edge(clk_p);
	
	process(CS,ya_dato,entrada8)
	begin	
		case CS is
			when E1=>
				if ya_dato='1' and entrada8="01010011" then
					NS<=E2;
				else
					NS<=E1;
				end if;
				
			when E2=>
				if ya_dato='1' and entrada8="00110001" then
					NS<=E3;
				elsif ya_dato='1' and entrada8="00110010" then 
					NS <= E7;
				elsif ya_dato='1' and entrada8="00110011" then
					NS <= E9;
				else
					NS<=E2;
				end if;
			
			when E3=>
				if ya_dato='1' then
					NS<=E4;
				else
					NS<=E3;
				end if;
			
			when E4=>
				if ya_dato='1' then
					NS<=E5;
				else
					NS<=E4;
				end if;
			
			when E5=>
				if ya_dato='1' then
					NS<=E6;
				else
					NS<=E5;
				end if;
			
			when E6=>
				NS<=E1;
			
			when E7=>
				NS<=E8;
			
			when E8=>
				NS<=E1;
				
			when E9 =>
				if ya_dato='1' and entrada8="01011001" then
					NS<=E10;
				elsif ya_dato='1' and entrada8="01001110" then
					NS<=E12;
				else
					NS<=E9;
				end if;
			
			when E10 =>
				NS<=E1;
				
			when E12 =>
				NS<=E1;
				
		end case;
			
	end process;
	
	
	
	process(CS,ACTUALB1,ACTUALB2,ACTUALB3,ACTUALSTOP,ACTUAL_PWM,entrada8)
	begin
		case CS is
			when E1=>
				B1 <= ACTUALB1;
				B2 <= ACTUALB2;
				B3 <= ACTUALB3;
				STOP <= ACTUALSTOP;
				PWM_BANDA <= ACTUAL_PWM;
				ENABLE <= '0';
			
			when E2=>
				B1 <= ACTUALB1;
				B2 <= ACTUALB2;
				B3 <= ACTUALB3;
				STOP <= ACTUALSTOP;
				PWM_BANDA <= ACTUAL_PWM;
				ENABLE <= '0';
			
			when E3=>
				B1 <= entrada8(1 downto 0);
				B2 <= ACTUALB2;
				B3 <= ACTUALB3;
				STOP <= ACTUALSTOP;
				PWM_BANDA <= ACTUAL_PWM;
				ENABLE <= '1';
				
				
				
			
			when E4=>
				B1 <= ACTUALB1;
				B2 <= entrada8(1 downto 0);
				B3 <= ACTUALB3;
				STOP <= ACTUALSTOP;
				PWM_BANDA <= ACTUAL_PWM;
				ENABLE <= '1';
				
			when E5=>
				B1 <= ACTUALB1;
				B2 <= ACTUALB2;
				B3 <= entrada8(1 downto 0);
				STOP <= ACTUALSTOP;
				PWM_BANDA <= ACTUAL_PWM;
				ENABLE <= '1';
			
			when E6=>
				B1 <= ACTUALB1;
				B2 <= ACTUALB2;
				B3 <= ACTUALB3;
				STOP <= ACTUALSTOP;
				PWM_BANDA <= ACTUAL_PWM;
				ENABLE <= '0';
			
			when E7=>
				B1 <= ACTUALB1;
				B2 <= ACTUALB2;
				B3 <= ACTUALB3;
				STOP <= ACTUALSTOP;
				PWM_BANDA <= ACTUAL_PWM;
				ENABLE <= '0';
				
			
			when E8=>
				B1 <= ACTUALB1;
				B2 <= ACTUALB2;
				B3 <= ACTUALB3;
				STOP <= ACTUALSTOP;
				PWM_BANDA <= entrada8(2 downto 0);
				ENABLE <= '1';
			
			
			when E9=>
				B1 <= ACTUALB1;
				B2 <= ACTUALB2;
				B3 <= ACTUALB3;
				STOP <= ACTUALSTOP;
				PWM_BANDA <= ACTUAL_PWM;
				ENABLE <= '0';
			
			when E10=>
				B1 <= ACTUALB1;
				B2 <= ACTUALB2;
				B3 <= ACTUALB3;
				STOP <= '1';
				PWM_BANDA <= ACTUAL_PWM;
				ENABLE <= '1';
			
			
			when E12=>
				B1 <= ACTUALB1;
				B2 <= ACTUALB2;
				B3 <= ACTUALB3;
				STOP <= '0';
				PWM_BANDA <= ACTUAL_PWM;
				ENABLE <= '1';
		end case;		
	end process;
end architecture;