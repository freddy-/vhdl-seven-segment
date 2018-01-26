--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:44:46 01/21/2018
-- Design Name:   
-- Module Name:   F:/DEV/FPGA/projetos/SegDisplay/clkDiv_tb.vhd
-- Project Name:  SegDisplay
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: clkDiv
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY clkDiv_tb IS
END clkDiv_tb;
 
ARCHITECTURE behavior OF clkDiv_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clkDiv
    PORT(
         i_clk : IN  std_logic;
         o_slowClk : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i_clk : std_logic := '0';

 	--Outputs
   signal o_slowClk : std_logic;

   -- Clock period definitions
   constant i_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: clkDiv PORT MAP (
          i_clk => i_clk,
          o_slowClk => o_slowClk
        );

   -- Clock process definitions
   i_clk_process :process
   begin
		i_clk <= '0';
		wait for i_clk_period/2;
		i_clk <= '1';
		wait for i_clk_period/2;
   end process;
  
   -- Stimulus process
   stim_proc: process
   begin
      wait;
   end process;

END;
