library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Maquina is

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
end entity;

architecture arq of Maquina is
type estado_maquina is (E1,E_INT,E2,PARA_BANDA,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E15);
signal CS,NS: estado_maquina;
--signal estado_actual: std_logic_vector(4 downto 0);

begin
	
	CS<=E1 when reset_n='0' else NS when rising_edge(clk_p);
	
	process(CS,s1,s2,s3,s5,x,cont,SC,B1,B2,B3)
	begin	
		case CS is
		
			when E1=>
				if (s1 and not(x))='1' then
			--	and not(s2) and not(s5) and s3)='1' then
					NS <= E_INT;
				else
					NS <= E1;
				end if;
			
			
			when E_INT=>
				if cont='1' then
					NS <= E2;
				else
					NS <= E_INT;
				end if;
				
				
			when E2 =>
				if x='1' then
					NS<=PARA_BANDA;
				elsif (s2 and not(x))='1' then
					NS <= E3;
				else
					NS <= E2;
				end if;
		
			when PARA_BANDA =>
				if x='0' then
					NS <= E2;
				else
					NS <= PARA_BANDA;
				end if;
			
			when E3 =>
				if (not(x) and s5)='1' then
					NS <= E4;
				else
					NS <= E3;
				end if;
			
			when E4 =>
				if (not(x) and cont)='1' then
					NS <= E5;
				else
					NS <= E4;
				end if;
				
			when E5 =>
				if (not(x) and s3)='1' and SC="00" then
					NS <= E6;
				elsif (not(x) and s3)='1' and SC="10" then
					NS <= E7;
				elsif (not(x) and s3)='1' and SC="11" then
					NS <= E8;
				elsif (not(x) and s3)='1' and SC="01" then --Unknown
					NS <= E12;
				else
					NS <= E5;
				end if;
			
			
				--00 Rojo
				--01 Azul
				--11 Verde
			when E6 =>
				if cont ='1' then
					NS <= E9;
				else
					NS <= E6;
				end if;
			
			when E9 => 
				if (cont and not(x))='1' then
					NS <= E15;
				else
					NS<=E9;
				end if;
				
			
			when E7 =>
				if cont='1' then
					NS <= E10;
				else
					NS <= E7;
				end if;
			
			when E10 => 
				if (cont and not(x))='1' then
					NS <= E15;
				else
					NS<=E10;
				end if;
				
			when E8 =>
				if cont='1' then
					NS <= E11;
				else
					NS <= E8;
				end if;
			
			when E11 => 
				if (cont and not(x))='1' then
					NS <= E15;
				else
					NS<=E11;
				end if;
			
		
			when E12 =>
				if cont ='1' then
					NS <= E13;
				else
					NS <= E12;
				end if;
			
			when E13 => 
				if (cont and not(x))='1' then
					NS <= E15;
				else
					NS<=E13;
				end if;
				
			
			when E15 =>				
				NS <= E1; -- Modificar
				
		end case;
			
	end process;

	
	process(CS,B1,B2,B3,B4,SC)
	begin
		case CS is
			when E1=>
				Mv <='0';
				Mbr<= std_logic_vector(to_unsigned(DEP,16));
				Mm <= std_logic_vector(to_unsigned(ABRIR,16));
				Mg <= std_logic_vector(to_unsigned(NORM,16));
				En_Cont <= '0';
				cuanto_cuenta <= std_logic_vector(to_unsigned(0,23));
				estado_actual <= std_logic_vector(to_unsigned(1,5));
				led_banda<='0';
				led_brazo<='0';
				enable_tx<='0';
				en_color<='0';
				Tx<=valor_num_caja;
				enable_num_caja <= '0';
				num_caja <= std_logic_vector(to_unsigned(0,8));
			
			when E_INT=>
				Mv <='0';
				Mbr<= std_logic_vector(to_unsigned(DEP,16));
				Mm <= std_logic_vector(to_unsigned(ABRIR,16));
				Mg <= std_logic_vector(to_unsigned(NORM,16));
				En_Cont <= '1';
				cuanto_cuenta <= std_logic_vector(to_unsigned(SEG2,23));
				estado_actual <= std_logic_vector(to_unsigned(20,5));
				led_banda<='0';
				led_brazo<='0';
				enable_tx<='0';
				en_color<='1';
				Tx<=std_logic_vector(to_unsigned(0,8));
				enable_num_caja <= '0';
				num_caja <= std_logic_vector(to_unsigned(0,8));
			
			when E2=>
				Mv <= '1';
				Mbr<= std_logic_vector(to_unsigned(DEP,16));
				Mm <= std_logic_vector(to_unsigned(ABRIR,16));
				Mg <= std_logic_vector(to_unsigned(NORM,16));
				En_Cont <= '0';
				cuanto_cuenta <= std_logic_vector(to_unsigned(0,23));
				estado_actual <= std_logic_vector(to_unsigned(2,5));
				led_banda<='1';
				led_brazo<='0';
				enable_tx<='0';
				en_color<='0';
				Tx<=std_logic_vector(to_unsigned(0,8));
				enable_num_caja <= '0';
				num_caja <= std_logic_vector(to_unsigned(0,8));
			
			when PARA_BANDA=>
				Mv <= '0';
				Mbr<= std_logic_vector(to_unsigned(DEP,16));
				Mm <= std_logic_vector(to_unsigned(ABRIR,16));
				Mg <= std_logic_vector(to_unsigned(NORM,16));
				En_Cont <= '0';
				cuanto_cuenta <= std_logic_vector(to_unsigned(0,23));	
				estado_actual <= std_logic_vector(to_unsigned(19,5));
				led_banda<='0';
				led_brazo<='0';
				enable_tx<='0';
				en_color<='0';
				Tx<=std_logic_vector(to_unsigned(0,8));
				enable_num_caja <= '0';
				num_caja <= std_logic_vector(to_unsigned(0,8));
			
			when E3=>
				Mv <= '0';
				Mbr<= std_logic_vector(to_unsigned(BAN,16));
				Mm <= std_logic_vector(to_unsigned(ABRIR,16));
				Mg <= std_logic_vector(to_unsigned(NORM,16));
				En_Cont <= '0';
				cuanto_cuenta <= std_logic_vector(to_unsigned(0,23));	
				estado_actual <= std_logic_vector(to_unsigned(3,5));
				led_banda<='0';
				led_brazo<='1';
				enable_tx<='0';
				en_color<='0';
				Tx<=std_logic_vector(to_unsigned(0,8));
				enable_num_caja <= '0';
				num_caja <= std_logic_vector(to_unsigned(0,8));
			
			when E4=>
				Mv <= '0';
				Mbr<= std_logic_vector(to_unsigned(BAN,16));
				Mm <= std_logic_vector(to_unsigned(CERRADO,16));
				Mg <= std_logic_vector(to_unsigned(NORM,16));
				En_Cont <= '1';
				cuanto_cuenta <= std_logic_vector(to_unsigned(SEG1,23));	
				estado_actual <= std_logic_vector(to_unsigned(4,5));
				led_banda<='0';
				led_brazo<='1';
				enable_tx<='0';
				en_color<='0';
				Tx<=std_logic_vector(to_unsigned(0,8));
				enable_num_caja <= '0';
				num_caja <= std_logic_vector(to_unsigned(0,8));
				
			when E5=>
				Mv <= '0';
				Mbr<= std_logic_vector(to_unsigned(DEP,16));
				Mm <= std_logic_vector(to_unsigned(CERRADO,16));
				Mg <= std_logic_vector(to_unsigned(NORM,16));
				En_Cont <= '0';
				cuanto_cuenta <= std_logic_vector(to_unsigned(0,23));	
				estado_actual <= std_logic_vector(to_unsigned(5,5));
				led_banda<='0';
				led_brazo<='1';
				enable_tx<='0';
				en_color<='0';
				Tx<=std_logic_vector(to_unsigned(0,8));
				enable_num_caja <= '0';
				num_caja <= std_logic_vector(to_unsigned(0,8));
			
			when E6=>
				Mv <= '0';
				Mbr<= std_logic_vector(to_unsigned(DEP,16));
				Mm <= std_logic_vector(to_unsigned(CERRADO,16));
				Mg <= B1;
				En_Cont <= '1';
				cuanto_cuenta <= std_logic_vector(to_unsigned(SEG2,23));	
				estado_actual <= std_logic_vector(to_unsigned(6,5));
				led_banda<='0';
				led_brazo<='1';
				enable_tx<='0';
				en_color<='0';
				Tx<=std_logic_vector(to_unsigned(0,8));
				enable_num_caja <= '1';
				num_caja <= std_logic_vector(unsigned(SC)+to_unsigned(48,8));
			
			when E9=>
				Mv <= '0';
				Mbr<= std_logic_vector(to_unsigned(DEP,16));
				Mm <= std_logic_vector(to_unsigned(ABRIR,16));
				Mg <= B1;
				En_Cont <= '1';
				cuanto_cuenta <= std_logic_vector(to_unsigned(SEG1,23));	
				estado_actual <= std_logic_vector(to_unsigned(9,5));
				led_banda<='0';
				led_brazo<='1';
				enable_tx<='0';
				en_color<='0';
				Tx<=std_logic_vector(to_unsigned(0,8));	
				enable_num_caja <= '0';
				num_caja <= std_logic_vector(to_unsigned(0,8));

			when E7=>
				Mv <= '0';
				Mbr<= std_logic_vector(to_unsigned(DEP,16));
				Mm <= std_logic_vector(to_unsigned(CERRADO,16));
				Mg <= B2;
				En_Cont <= '1';
				cuanto_cuenta <= std_logic_vector(to_unsigned(SEG2,23));	
				estado_actual <= std_logic_vector(to_unsigned(31,5));
				led_banda<='0';
				led_brazo<='1';
				enable_tx<='0';
				en_color<='0';
				Tx<=std_logic_vector(to_unsigned(0,8));
				enable_num_caja <= '1';
				num_caja <= std_logic_vector(unsigned(SC)+to_unsigned(48,8));
			
			when E10=>
				Mv <= '0';
				Mbr<= std_logic_vector(to_unsigned(DEP,16));
				Mm <= std_logic_vector(to_unsigned(ABRIR,16));
				Mg <= B2;
				En_Cont <= '1';
				cuanto_cuenta <= std_logic_vector(to_unsigned(SEG1,23));	
				estado_actual <= std_logic_vector(to_unsigned(10,5));
				led_banda<='0';
				led_brazo<='1';
				enable_tx<='0';
				en_color<='0';
				Tx<=std_logic_vector(to_unsigned(0,8));
				enable_num_caja <= '0';
				num_caja <= std_logic_vector(to_unsigned(0,8));	

			when E8=>
				Mv <= '0';
				Mbr<= std_logic_vector(to_unsigned(DEP,16));
				Mm <= std_logic_vector(to_unsigned(CERRADO,16));
				Mg <= B3;
				En_Cont <= '1';
				cuanto_cuenta <= std_logic_vector(to_unsigned(SEG2,23));	
				estado_actual <= std_logic_vector(to_unsigned(8,5));
				led_banda<='0';
				led_brazo<='1';
				enable_tx<='0';
				en_color<='0';
				Tx<=std_logic_vector(to_unsigned(0,8));
				enable_num_caja <= '1';
				num_caja <= std_logic_vector(unsigned(SC)+to_unsigned(48,8));
			
			when E11=>
				Mv <= '0';
				Mbr<= std_logic_vector(to_unsigned(DEP,16));
				Mm <= std_logic_vector(to_unsigned(ABRIR,16));
				Mg <= B3;
				En_Cont <= '1';
				cuanto_cuenta <= std_logic_vector(to_unsigned(SEG1,23));	
				estado_actual <= std_logic_vector(to_unsigned(11,5));
				led_banda<='0';
				led_brazo<='1';
				enable_tx<='0';
				en_color<='0';
				Tx<=std_logic_vector(to_unsigned(0,8));
				enable_num_caja <= '0';
				num_caja <= std_logic_vector(to_unsigned(0,8));
	
			when E12=>
				Mv <= '0';
				Mbr<= std_logic_vector(to_unsigned(DEP,16));
				Mm <= std_logic_vector(to_unsigned(CERRADO,16));
				Mg <= B4;
				En_Cont <= '1';
				cuanto_cuenta <= std_logic_vector(to_unsigned(SEG2,23));	
				estado_actual <= std_logic_vector(to_unsigned(12,5));
				led_banda<='0';
				led_brazo<='1';
				enable_tx<='0';
				en_color<='0';
				Tx<=std_logic_vector(to_unsigned(0,8));
				enable_num_caja <= '1';
				num_caja <= std_logic_vector(to_unsigned(52,8));
			
			when E13=>
				Mv <= '0';
				Mbr<= std_logic_vector(to_unsigned(DEP,16));
				Mm <= std_logic_vector(to_unsigned(ABRIR,16));
				Mg <= B4;
				En_Cont <= '1';
				cuanto_cuenta <= std_logic_vector(to_unsigned(SEG1,23));	
				estado_actual <= std_logic_vector(to_unsigned(13,5));
				led_banda<='0';
				led_brazo<='1';
				enable_tx<='0';
				en_color<='0';
				Tx<=std_logic_vector(to_unsigned(0,8));
				enable_num_caja <= '0';
				num_caja <= std_logic_vector(to_unsigned(0,8));
			
			when E15=>
				Mv <='0';
				Mbr<= std_logic_vector(to_unsigned(DEP,16));
				Mm <= std_logic_vector(to_unsigned(ABRIR,16));
				Mg <= std_logic_vector(to_unsigned(NORM,16));
				En_Cont <= '0';
				cuanto_cuenta <= std_logic_vector(to_unsigned(0,23));
				estado_actual <= std_logic_vector(to_unsigned(15,5));
				led_banda<='0';
				led_brazo<='0';
				enable_tx<='1';
				en_color<='0';
				Tx<=valor_num_caja;
				enable_num_caja <= '0';
				num_caja <= std_logic_vector(to_unsigned(0,8));
		end case;
		
	end process;

end architecture;