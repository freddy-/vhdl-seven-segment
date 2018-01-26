----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:27:04 01/06/2018 
-- Design Name: 
-- Module Name:    main - Behavioral 
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
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

library UNIMACRO;
use unimacro.Vcomponents.all;

entity seven_segment_display_VHDL is
	port(
		CLK: in std_logic; -- 29.498MHZ
		button: in std_logic_vector(1 downto 0);
		LED_VERDE: out std_logic := '1';
		LED_LARANJA: out std_logic := '1';
		digit: out std_logic_vector(3 downto 0) := "0000";
		seg: out std_logic_vector(7 downto 0) := "00000000"
	);
end seven_segment_display_VHDL;

architecture Behavioral of seven_segment_display_VHDL is
	signal r_counter: std_logic_vector(13 downto 0) := (others => '0');  
	signal r_bcd: std_logic_vector(15 downto 0) := (others => '0');
	signal r_dv: std_logic := '0';
	signal r_slowClk: std_logic := '0';
	signal w_buttonUp: std_logic := '1';
	signal w_buttonDown: std_logic := '1';

begin 

	LED_VERDE <= r_dv;
	LED_LARANJA <= button(0);
	
	-- Controle dos botões

	clkDiv_inst: entity work.clkDiv
	PORT MAP(
		i_clk => CLK,
		o_slowClk => r_slowClk
	);

	debouncer_up_ins: entity work.debouncer
	PORT MAP(
		i_clk => r_slowClk,
		i_raw => button(0),
		o_clean => w_buttonUp
	);

	debouncer_down_ins: entity work.debouncer
	PORT MAP(
		i_clk => r_slowClk,
		i_raw => button(1),
		o_clean => w_buttonDown
	);


	-- Processo para incrementar e decrementar

	up_down_inst : entity work.up_down_counter
	GENERIC MAP (
		g_OUTPUT_WIDTH => 14
	)
	PORT MAP (
		i_CLK => CLK,
		i_UP => w_buttonUp,
		i_DOWN => w_buttonDown,
		o_VALUE => r_counter
	);


	-- Controle do display 7 segmentos

	bcd_inst : entity work.Binary_to_BCD
	GENERIC MAP (		
		g_INPUT_WIDTH => 14,
		g_DECIMAL_DIGITS => 4
	)
	PORT MAP (		
		i_CLOCK => CLK,
		i_START => '1',
		i_BINARY => r_counter,
		o_BCD => r_bcd,
		o_DV => r_dv
	);
	
	ssdc_inst : entity work.ssdc 
	PORT MAP (
		CLK,
		r_bcd,
		digit,
		seg
	);
	
end Behavioral;