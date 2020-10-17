-----------------------------
--Rotating square circuit
-----------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;

entity Rotating_square_circuit is port(
    clk: in std_logic;
    AN: out std_logic_vector(3 downto 0); -- Digits
    F: out std_logic_vector(6 downto 0) );
end Rotating_square_circuit;

architecture arch of Rotating_square_circuit is
    signal sel: std_logic_vector(2 downto 0);
    constant N: integer :=24; 
    signal step : unsigned(N downto 0);
    begin
        process(clk)
        begin
            if(rising_edge (clk)) then
            step <= step + 1;
            end if;
    end process;
sel <= std_logic_vector(step(N downto N-2));

process(sel) 
begin
    if (sel= "000" OR sel = "111") then
        an <= "1000";
   
    elsif(sel = "001" OR sel = "110") then
        an <= "0100";
    
    elsif(sel = "010" OR sel = "101") then
        an <= "0010";
    
    elsif(sel = "011" OR sel = "100") then
        an <= "0001";

    end if;
end process;

--7-segment led decoding
F(6 downto 0) <= "0011100" when sel(2 downto 2)="0" else --top line
                 "1100010";                              --bottem line
end arch;