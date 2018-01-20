
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee.std_logic_unsigned.all;

ENTITY Binary_to_BCD_tb IS
END Binary_to_BCD_tb;

ARCHITECTURE behavior OF Binary_to_BCD_tb IS 
   
    COMPONENT Binary_to_BCD
	generic(
		g_INPUT_WIDTH    : in positive;
		g_DECIMAL_DIGITS : in positive
	);
    PORT(
		i_CLOCK  : in std_logic;
		i_START  : in std_logic;
		i_BINARY : in std_logic_vector(13 downto 0);
		
		o_BCD : out std_logic_vector(15 downto 0);
		o_DV : out std_logic
	);
    END COMPONENT;
	
   --Inputs
   signal CLOCK : std_logic := '0';
   signal START : std_logic := '0';
   signal b_INPUT : std_logic_vector(13 downto 0) := "00000000000001";
   
   -- Outputs   
   signal BCD : std_logic_vector(15 downto 0);
   signal DV : std_logic := '0';

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
          

BEGIN

  -- Component Instantiation
	uut: Binary_to_BCD 
	GENERIC MAP(
		g_INPUT_WIDTH => 14,
		g_DECIMAL_DIGITS => 4
	)
	PORT MAP(
		i_CLOCK => CLOCK,
		i_START => START,
		i_BINARY => b_INPUT,
		o_BCD => BCD,
		o_DV => DV
	);

   -- Clock process definitions
	CLK_process :process
	begin
		CLOCK <= '0';
		wait for CLK_period/2;
		CLOCK <= '1';
		wait for CLK_period/2;
	end process;
   
--	process(DV)
--	begin
--		if(rising_edge(DV)) then
--			b_INPUT <= b_INPUT + 1;
--		end if;
--	end process;
   
	--  Test Bench Statements
	tb : PROCESS
	BEGIN

		wait for 100 ns;
		
		START <= '1';
		
		b_INPUT <= "00000000000001";

		wait; -- will wait forever
	END PROCESS tb;
	--  End Test Bench 

END;
