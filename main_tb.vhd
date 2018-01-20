--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:53:40 01/18/2018
-- Design Name:   
-- Module Name:   F:/DEV/FPGA/projetos/SegDisplay/main_tb.vhd
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY main_tb IS
END main_tb;
 
ARCHITECTURE behavior OF main_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT seven_segment_display_VHDL
    PORT(
         CLK : IN  std_logic;
         button : IN  std_logic_vector(1 downto 0);
         LED_VERDE : OUT  std_logic;
         LED_LARANJA : OUT  std_logic;
         digit : OUT  std_logic_vector(3 downto 0);
         seg : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal button : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal LED_VERDE : std_logic;
   signal LED_LARANJA : std_logic;
   signal digit : std_logic_vector(3 downto 0);
   signal seg : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN

 
	-- Instantiate the Unit Under Test (UUT)
   uut: seven_segment_display_VHDL PORT MAP (
          CLK => CLK,
          button => button,
          LED_VERDE => LED_VERDE,
          LED_LARANJA => LED_LARANJA,
          digit => digit,
          seg => seg
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
