LIBRARY ieee; 
USE ieee.std_logic_1164.ALL; 
USE ieee.std_logic_unsigned.ALL; 
ENTITY hex2ssd_tb IS 
END hex2ssd_tb; 
ARCHITECTURE behavior OF hex2ssd_tb IS 
COMPONENT HEX2SSD is 
port( 
        X :  in STD_LOGIC_VECTOR(3 downto 0); 
        F:   out STD_LOGIC_VECTOR(6 downto 0); 
        AN:  out STD_LOGIC_VECTOR(3 downto 0)  ); 
END COMPONENT;

    signal X : std_logic_vector(3 downto 0) := (others => '0'); 
    signal F : std_logic_vector(6 downto 0) := (others => '0'); 
    signal AN : std_logic_vector(3 downto 0 ) := "1111";

BEGIN
-- Instantiate the Unit Under Test (UUT) 
uut: HEX2SSD PORT MAP (     X => X,     F => F,   AN => AN   ); 

-- Stimulus process 
stim_proc: process 
    begin 
    for T in 0 to 15 loop 
        wait for 10 ns;  X <= X + '1'; 
    end loop; 
    wait; 
    end process;
     
END;