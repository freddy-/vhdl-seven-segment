--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:28:31 01/14/2018
-- Design Name:   
-- Module Name:   F:/DEV/FPGA/projetos/SegDisplay/counter_tb.vhd
-- Project Name:  SegDisplay
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: seven_segment_display_VHDL
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
library UNIMACRO;
use unimacro.Vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY counter_tb IS
END counter_tb;
 
ARCHITECTURE behavior OF counter_tb IS 

   --Inputs
   signal CLK : std_logic := '0';
 	--Outputs
   signal output : std_logic_vector(47 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN

  COUNTER_LOAD_MACRO_inst : COUNTER_LOAD_MACRO
    generic map (
      COUNT_BY => X"000000000001", -- Count by value
      DEVICE => "SPARTAN6", -- Target Device: "VIRTEX5", "VIRTEX6", "SPARTAN6"
      WIDTH_DATA => 48) -- Counter output bus width, 1-48
    port map (
      Q => output, -- Counter ouput, width determined by WIDTH_DATA generic
      CLK => CLK, -- 1-bit clock input
      CE => '1', -- 1-bit clock enable input
      DIRECTION => '1', -- 1-bit up/down count direction input, high is count up
      LOAD => '0', -- 1-bit active high load input
      LOAD_DATA => (others => '0'), -- Counter load data, width determined by WIDTH_DATA generic => (others => '0')
      RST => '0' -- 1-bit active high synchronous reset
    );
    
   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 
   stim_proc: process
   begin		
      wait for 1000 ms;	

      wait;
   end process;

END;
