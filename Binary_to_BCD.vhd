----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:02:58 01/16/2018 
-- Design Name: 
-- Module Name:    Binary_to_BCD - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--	http://www.nandland.com
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity Binary_to_BCD is
	generic(
		g_INPUT_WIDTH    : in positive;
		g_DECIMAL_DIGITS : in positive
	);
	
	port(
		i_CLOCK  : in std_logic;
		i_START  : in std_logic;
		i_BINARY : in std_logic_vector(g_INPUT_WIDTH - 1 downto 0);
		
		o_BCD : out std_logic_vector(g_DECIMAL_DIGITS * 4 - 1 downto 0);
		o_DV : out std_logic
	);

end Binary_to_BCD;

architecture Behavioral of Binary_to_BCD is
	type t_BCD_STATE is (s_IDLE, s_SHIFT, s_CHECK_SHIFT_INDEX, s_ADD, s_CHECK_DIGIT_INDEX, s_BCD_DONE); -- estados da Finite State Machine
	signal r_FSM_STATE : t_BCD_STATE := s_IDLE; -- Seta estado inicial
	
	-- registrador que conterá o resultado durante a conversão
	signal r_BCD : std_logic_vector(g_DECIMAL_DIGITS * 4 - 1 downto 0) := (others => '0');
	
	-- registrador que armazenará o ultimo valor convertido
	signal r_BCD_FINAL : std_logic_vector(g_DECIMAL_DIGITS * 4 - 1 downto 0) := (others => '0');
	
	-- registrador que conterá os dados de entrada que serão deslocados
	signal r_BINARY : std_logic_vector(g_INPUT_WIDTH - 1 downto 0) := (others => '0');
	
	-- armazena qual digito está sendo processado
	signal r_DIGIT_INDEX : natural range 0 to g_DECIMAL_DIGITS - 1 := 0;
	
	-- armazena qual o indice do bit que está sendo deslocado
	signal r_LOOP_COUNTER : natural range 0 to g_INPUT_WIDTH - 1 := 0;
begin

	DB : process(i_CLOCK)
		variable v_UPPER : natural;
		variable v_LOWER : natural;
		variable v_BCD_DIGIT : std_logic_vector(3 downto 0);
	begin
		
		if (rising_edge(i_CLOCK)) then		
			case r_FSM_STATE is			
				when s_IDLE =>
					if (i_START = '1') then
						r_BCD <= (others => '0');
						r_BINARY <= i_BINARY;
						r_FSM_STATE <= s_SHIFT;
					else
						r_FSM_STATE <= s_IDLE;
					end if;
				
				--desloca os bits de r_binary para r_BCD
				when s_SHIFT =>
					r_BCD <= r_BCD(r_BCD'left - 1 downto 0) & r_BINARY(r_BINARY'left);
					r_BINARY <= r_BINARY(r_BINARY'left - 1 downto 0) & '0';
					r_FSM_STATE <= s_CHECK_SHIFT_INDEX;
				
				-- verifica o indice dos bits
				when s_CHECK_SHIFT_INDEX =>
					if (r_LOOP_COUNTER = g_INPUT_WIDTH - 1) then
						-- se processou todos os bits, acabou
						r_LOOP_COUNTER <= 0;
						r_FSM_STATE <= s_BCD_DONE;
					else
						r_LOOP_COUNTER <= r_LOOP_COUNTER + 1;
						r_FSM_STATE <= s_ADD;
					end if;
					
				when s_ADD =>
					-- obtem o indice superior
					v_UPPER := r_DIGIT_INDEX * 4 + 3;
					-- obtem o indice inferior
					v_LOWER := r_DIGIT_INDEX * 4;
					-- extrai os 4 bits referente ao digito
					v_BCD_DIGIT := r_BCD(v_UPPER downto v_LOWER);
					
					if (v_BCD_DIGIT > 4) then
						v_BCD_DIGIT := v_BCD_DIGIT + 3;
					end if;
					
					-- atualiza o registrador dos digitos com o novo valor do digito selecionado
					r_BCD(v_UPPER downto v_LOWER) <= std_logic_vector(v_BCD_DIGIT);
					r_FSM_STATE <= s_CHECK_DIGIT_INDEX;
					
				-- verifica se todos os digitos BCD foram verificados e/ou incrementados
				when s_CHECK_DIGIT_INDEX =>
					if (r_DIGIT_INDEX = g_DECIMAL_DIGITS - 1) then
						r_DIGIT_INDEX <= 0;
						r_FSM_STATE <= s_SHIFT;
					else
						r_DIGIT_INDEX <= r_DIGIT_INDEX + 1;
						r_FSM_STATE <= s_ADD;
					end if;
					
				when s_BCD_DONE =>
					r_FSM_STATE <= s_IDLE;
					r_BCD_FINAL <= r_BCD;
					
				when others =>
					r_FSM_STATE <= s_IDLE;
					
			end case;
		end if;
		
	end process;
	
	o_DV <= '1' when r_FSM_STATE = s_BCD_DONE else '0';
	o_BCD <= r_BCD_FINAL;
end Behavioral;

