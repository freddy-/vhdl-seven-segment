----------------------------------------------------------------------------------
-- Company: 
-- Engineer:       Frederico Souza Sant' ana
-- 
-- Create Date:    16:53:41 01/13/2018 
-- Design Name: 	 Seven Segment Display Controller
-- Module Name:    ssdc - Behavioral 
-- Project Name:   Seven Segment Display Controller
-- Target Devices: 
-- Tool versions: 
-- Description:    Control 4 digit 7(8 with dot) seven segment display in multiplexed mode.
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity ssdc is
	port(
		i_clk: in std_logic;
		i_data: in std_logic_vector(15 downto 0);
		o_digit: out std_logic_vector(3 downto 0) := "0000";
		o_seg: out std_logic_vector(7 downto 0) := "00000000"
	);
end ssdc;

architecture Behavioral of ssdc is
	signal r_refresh_counter: std_logic_vector(18 downto 0) := (others => '0');
	signal r_digit_activating_counter: std_logic_vector(1 downto 0) := (others => '0');	
	signal r_bcd: std_logic_vector(3 downto 0) := (others => '0');
begin

	-- refresh rate generator
	process(i_clk)
	begin
		if(rising_edge(i_clk)) then
			r_refresh_counter <= r_refresh_counter + 1;
		end if;
	end process;
		
	-- pega os 2 ultimos bits pra usar na seleçao do digito. ~200hz
	r_digit_activating_counter <= r_refresh_counter(18 downto 17);
		
	-- digit mux
	process(r_digit_activating_counter)
	begin
		case r_digit_activating_counter is
		when "00" =>
			o_digit <= "1110";
			r_bcd <= i_data(15 downto 12);
		when "01" =>
			o_digit <= "1101";
			r_bcd <= i_data(11 downto 8);
		when "10" =>
			o_digit <= "1011";
			r_bcd <= i_data(7 downto 4);
		when "11" =>
			o_digit <= "0111";
			r_bcd <= i_data(3 downto 0);
		when others => null; 
		end case;
	end process;
	
	-- DP A B C D E F G
	process(r_bcd)
	begin
		 case r_bcd is
		 when "0000" => o_seg <= "10000001"; -- 0     
		 when "0001" => o_seg <= "11001111"; -- 1 
		 when "0010" => o_seg <= "10010010"; -- 2 
		 when "0011" => o_seg <= "10000110"; -- 3 
		 when "0100" => o_seg <= "11001100"; -- 4 
		 when "0101" => o_seg <= "10100100"; -- 5 
		 when "0110" => o_seg <= "10100000"; -- 6 
		 when "0111" => o_seg <= "10001111"; -- 7 
		 when "1000" => o_seg <= "10000000"; -- 8     
		 when "1001" => o_seg <= "10000100"; -- 9
		 when "1010" => o_seg <= "10001000"; -- A
		 when "1011" => o_seg <= "11100000"; -- B
		 when "1100" => o_seg <= "10110001"; -- C
		 when "1101" => o_seg <= "11000010"; -- D
		 when "1110" => o_seg <= "10110000"; -- E
		 when "1111" => o_seg <= "10111000"; -- F
		 when others => null; 
		 end case;
	end process;

end Behavioral;

