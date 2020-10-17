library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;

entity Heartbeat_circuit is port(
    clk: in std_logic;
    AN: out std_logic_vector(3 downto 0); -- Digits
    F: out std_logic_vector(6 downto 0) );
end Heartbeat_circuit;

architecture arch of Heartbeat_circuit is
    signal sel: std_logic_vector(1 downto 0);
    signal up_down:  std_logic; -- up or down    
   constant N: integer := 24; 
   signal counter_updown: unsigned (N downto 0);
   
begin
process(clk)
begin
    if(rising_edge(clk)) then
        if(up_down='1') then
        counter_updown <= counter_updown - 1; -- count down
        
        elsif(up_down='0') then
        counter_updown <= counter_updown + 1; -- count up
        
        end if;
    end if;
    
    if(counter_updown(N-1 downto N-2) ="11" and up_down ='0') then  --to down
        counter_updown<="1111111111111111111111111";
        up_down <='1';
    elsif(counter_updown(N-1 downto N-2) ="00" and up_down = '1') then  --to up
        counter_updown<="0000000000000000000000000";
        up_down <='0';
    end if;
end process;

sel <= std_logic_vector (counter_updown(N-1 downto N-2));

process(sel) 
    begin     
        if (sel = "00") then       -- 1
           if(counter_updown(1 downto 1)="0") then
               an <= "0100";F(6 downto 0) <= "1001111" ;
           elsif(counter_updown(1 downto 1)="1") then
               an <= "0010";F(6 downto 0) <= "1111001" ;
           end if;
                               
        elsif (sel = "01") then    --2
            if(counter_updown(1 downto 1)="0") then
                an <= "0100";F(6 downto 0) <= "1111001";
            elsif(counter_updown(1 downto 1)="1") then
                an <= "0010";F(6 downto 0) <= "1001111";   
            end if;
                                       
        elsif (sel = "10") then    --3
            if(counter_updown(1 downto 1)="0") then 
                an <= "1000";F(6 downto 0) <= "1001111";
            elsif(counter_updown(1 downto 1)="1") then
                an <= "0001";F(6 downto 0) <= "1111001";
            end if;
               
        elsif (sel = "11" ) then   -- 4
            if(counter_updown(1 downto 1)="0") then    
                an <= "1000"; F(6 downto 0) <= "1111001" ;
            elsif(counter_updown(1 downto 1)="1") then
                an <= "0001"; F(6 downto 0) <= "1001111" ;
            end if;
      
        end if;    
    end process;
end arch;