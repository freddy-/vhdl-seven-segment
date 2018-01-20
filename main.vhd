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
		seg: out std_logic_vector(7 downto 0) := "00000000";
		o_displayData: out std_logic_vector(15 downto 0) := "00000000"
	);
end seven_segment_display_VHDL;

architecture Behavioral of seven_segment_display_VHDL is
	signal r_one_second_prescaler : std_logic_vector(24 downto 0) := (others => '0');
	signal r_counter: std_logic_vector(13 downto 0) := (others => '0');  
	signal r_bcd: std_logic_vector(15 downto 0) := (others => '0');
	signal r_displayData: std_logic_vector(15 downto 0) := (others => '0');
	signal r_dv: std_logic := '0';
begin 

	-- 1110000100001101010010000

	LED_VERDE <= r_dv;
	LED_LARANJA <= '0';

	-- TODO criar componente para manipular o debounce dos botoes
	-- TODO criar um contador up/down com estes sinais
	
	process (CLK)
	begin
		if(rising_edge(CLK)) then
			if r_one_second_prescaler = "0011100001000011010100100" then
				r_one_second_prescaler <= (others => '0');
				r_counter <= r_counter + 1;
				r_displayData <= r_bcd;
			else
				r_one_second_prescaler <= r_one_second_prescaler + 1;
			end if;			
		end if;
	end process;
	

	-- COUNTER_LOAD_MACRO: Loadable variable counter implemented in a DSP48E
	-- Virtex-5, Virtex-6, Spartan-6
	-- Xilinx HDL Libraries Guide, version 11.2
--	COUNTER_LOAD_MACRO_inst : COUNTER_LOAD_MACRO
--	generic map (
--		COUNT_BY => X"000000000001", -- Count by value
--		DEVICE => "SPARTAN6", -- Target Device: "VIRTEX5", "VIRTEX6", "SPARTAN6"
--		WIDTH_DATA => 25) -- Counter output bus width, 1-48
--	port map (
--		Q => r_one_second_prescaler, -- Counter ouput, width determined by WIDTH_DATA generic
--		CLK => CLK, -- 1-bit clock input
--		CE => '1', -- 1-bit clock enable input
--		DIRECTION => '1', -- 1-bit up/down count direction input, high is count up
--		LOAD => '0', -- 1-bit active high load input
--		LOAD_DATA => (others => '0'), -- Counter load data, width determined by WIDTH_DATA generic => (others => '0')
--		RST => '0' -- 1-bit active high synchronous reset
--	);
	-- End of COUNTER_LOAD_MACRO_inst instantiation

	bcd_inst : entity work.Binary_to_BCD
	generic map (		
		g_INPUT_WIDTH => 14,
		g_DECIMAL_DIGITS => 4
	)
	port map(		
		i_CLOCK => CLK,
		i_START => '1',
		i_BINARY => r_counter,
		o_BCD => r_bcd,
		o_DV => r_dv
	);
	
	ssdc_inst : entity work.ssdc 
	port map (
		CLK,
		r_displayData,
		digit,
		seg
	);
	
	o_displayData <= r_displayData;

end Behavioral;