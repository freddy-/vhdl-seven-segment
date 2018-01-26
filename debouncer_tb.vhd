--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:50:01 01/21/2018
-- Design Name:   
-- Module Name:   F:/DEV/FPGA/projetos/SegDisplay/debouncer_tb.vhd
-- Project Name:  SegDisplay
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: debouncer
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
 
ENTITY debouncer_tb IS
END debouncer_tb;
 
ARCHITECTURE behavior OF debouncer_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT debouncer
    PORT(
         i_clk : IN  std_logic;
         i_raw : IN  std_logic;
         o_clean : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal i_clk : std_logic := '0';
   signal i_raw : std_logic := '0';

 	--Outputs
   signal o_clean : std_logic;

   -- Clock period definitions
   constant i_clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: debouncer PORT MAP (
          i_clk => i_clk,
          i_raw => i_raw,
          o_clean => o_clean
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

      -- levará 9 clks pra decidir o estado do botao
      i_raw <= '1'; -- 0 = pressionado, 1 = solto

      wait for i_clk_period*100;

      i_raw <= '0';
      wait for i_clk_period*9;

      i_raw <= '1';
      wait for i_clk_period*9;

      i_raw <= '0';
      wait for i_clk_period*9;




      wait;
   end process;

END;
