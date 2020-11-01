----------------------------------------------------------------
--| Design file name: ASCII_5x7_font.vhd
----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;

entity ASCII_5x7_font is 
        GENERIC (clk_divider1: INTEGER := 6000);    --12MHz to 500Hz     
        port ( but1, but2,clk :   in std_logic;
                an :   out bit_vector(7 downto 0);
                dot:   out bit_vector(7 downto 0)	);
end ASCII_5x7_font;

-------------------------------------------------------------------
ARCHITECTURE ASCII_5x7_font OF ASCII_5x7_font IS
       TYPE state IS (S0, S1, S2, S3, S4, S5, S6, S7);
       
       SIGNAL  pr_state, nx_state: state;
       signal   E: bit;
       signal  NUM: unsigned (6 DOWNTO 0) := "0011110";
       TYPE memory IS ARRAY (0 TO 7) of bit_vector (7 downto 0);   
       signal  rom: memory; 

BEGIN
       ----- Clock generator (E->500Hz): -------------
       PROCESS (clk)
              VARIABLE count: INTEGER RANGE 0 TO clk_divider1;
              VARIABLE count1: INTEGER RANGE 0 TO 10000000;
                                                
       BEGIN
              
              IF (clk'EVENT AND clk='1') THEN
                   count := count + 1;
                   count1 := count1 +1;
                   
                   IF (count=clk_divider1) THEN
                           E <= NOT E;
                           count := 0;
                    elsif(count1 = 10000000) THEN
                           NUM <=NUM + "1";
                           count1 := 0;
                                                                                                           
                  END IF;
              END IF;
       END PROCESS;

      ----- Lower section of FSM: --------------------
      PROCESS (E)
      BEGIN
             IF (E'EVENT AND E='1') THEN
                  IF (but1='1') THEN
  --                      NUM <= NUM + "1";
                       pr_state <= S0;
                  ELSIF  (but2='1') THEN
                        pr_state <= S0;
    --                    NUM <= NUM - "1";
                 ELSE
                        NUM <= NUM;
                        pr_state <= nx_state;
                 END IF;
             END IF;
       END PROCESS;
       
       PROCESS(NUM)
       BEGIN
           IF NUM = x"30" THEN
                rom<= (x"0e", x"11", x"13", x"15", x"19", x"11", x"0e",x"00");   -- x"30, 0
           ELSIF NUM = x"31" THEN          
                rom<= (x"04", x"0c", x"04", x"04", x"04", x"04", x"0e",x"00");   -- x"31 1
           ELSIF NUM = x"32" THEN
                rom<= (x"0e", x"11", x"01", x"02", x"04", x"08", x"1f",x"00");   -- x"32 2
           ELSIF NUM = x"33" THEN
                rom<= (x"0e", x"11", x"01", x"06", x"01", x"11", x"0e",x"00");   -- x"33 3
           ELSIF NUM = x"34" THEN
                rom<= (x"02", x"06", x"0a", x"12", x"1f", x"02", x"02",x"00");   -- x"34 4
           ELSIF NUM = x"35" THEN
                rom<= (x"1f", x"10", x"1e", x"01", x"01", x"11", x"0e",x"00");   -- x"35 5
           ELSIF NUM = x"36" THEN
                rom<= (x"06", x"08", x"10", x"1e", x"11", x"11", x"0e",x"00");   -- x"36 6
           ELSIF NUM = x"37" THEN
                rom<= (x"1f", x"01", x"02", x"04", x"08", x"08", x"08",x"00");   -- x"37 7
           ELSIF NUM = x"38" THEN
                rom<= (x"0e", x"11", x"11", x"0e", x"11", x"11", x"0e",x"00");   -- x"38 8
           ELSIF NUM = x"39" THEN
                rom<= (x"0e", x"11", x"11", x"0f", x"01", x"02", x"0c",x"00");   -- x"39 9
           ELSIF NUM = x"3A" THEN
                rom<= (x"00", x"0c", x"0c", x"00", x"0c", x"0c", x"00",x"00");   -- x"3a :
           ELSIF NUM = x"3B" THEN
                rom<= (x"00", x"0c", x"0c", x"00", x"0c", x"04", x"08",x"00");   -- x"3b ;
           ELSIF NUM = x"3C" THEN
                rom<= (x"02", x"04", x"08", x"10", x"08", x"04", x"02",x"00");   -- x"3c <
           ELSIF NUM = x"3D" THEN
                rom<= (x"00", x"00", x"1f", x"00", x"1f", x"00", x"00",x"00");   -- x"3d =
           ELSIF NUM = x"3E" THEN
                rom<= (x"08", x"04", x"02", x"01", x"02", x"04", x"08",x"00");   -- x"3e >
           ELSIF NUM = x"3F" THEN
                rom<= (x"0e", x"11", x"01", x"02", x"04", x"00", x"04",x"00");   -- x"3f ?                             
           ELSIF NUM = x"40" THEN
                rom<= (x"0e", x"11", x"01", x"0d", x"15", x"15", x"0e",x"00");   -- x"40 @
           ELSIF NUM = x"41" THEN
                rom<= (x"04", x"0a", x"11", x"11", x"1f", x"11", x"11",x"00");   -- x"41 A
           ELSIF NUM = x"42" THEN
                rom<= (x"1e", x"11", x"11", x"1e", x"11", x"11", x"1e",x"00");   -- x"42 B
           ELSIF NUM = x"43" THEN
                rom<= (x"0e", x"11", x"10", x"10", x"10", x"11", x"0e",x"00");   -- x"43 C
           ELSIF NUM = x"44" THEN
                rom<= (x"1e", x"09", x"09", x"09", x"09", x"09", x"1e",x"00");   -- x"44 D
           ELSIF NUM = x"45" THEN
                rom<= (x"1f", x"10", x"10", x"1c", x"10", x"10", x"1f",x"00");   -- x"45", E
           ELSIF NUM = x"46" THEN
                rom<= (x"1f", x"10", x"10", x"1f", x"10", x"10", x"10",x"00");   -- x"46 F
           ELSIF NUM = x"47" THEN
                rom<= (x"0e", x"11", x"10", x"10", x"13", x"11", x"0f",x"00");   -- x"37 G
           ELSIF NUM = x"48" THEN
                rom<= (x"11", x"11", x"11", x"1f", x"11", x"11", x"11",x"00");   -- x"48 H
           ELSIF NUM = x"49" THEN
                rom<= (x"0e", x"04", x"04", x"04", x"04", x"04", x"0e",x"00");   -- x"49 I
           ELSIF NUM = x"4A" THEN
                rom<= (x"1f", x"02", x"02", x"02", x"02", x"12", x"0c",x"00");   -- x"4a J
           ELSIF NUM = x"4B" THEN
                rom<= (x"11", x"12", x"14", x"18", x"14", x"12", x"11",x"00");   -- x"4b K
           ELSIF NUM = x"4C" THEN
                rom<= (x"10", x"10", x"10", x"10", x"10", x"10", x"1f",x"00");   -- x"4c L
           ELSIF NUM = x"4D" THEN
                rom<= (x"11", x"1b", x"15", x"11", x"11", x"11", x"11",x"00");   -- x"4d M
           ELSIF NUM = x"4E" THEN
                rom<= (x"11", x"11", x"19", x"15", x"13", x"11", x"11",x"00");   -- x"4e N
           ELSIF NUM = x"4F" THEN
                rom<= (x"0e", x"11", x"11", x"11", x"11", x"11", x"0e",x"00");   -- x"4f O
           ELSIF NUM = x"50" THEN
                rom<= (x"1e", x"11", x"11", x"1e", x"10", x"10", x"10",x"00");   -- x"50 P
           ELSIF NUM = x"51" THEN
                rom<= (x"0e", x"11", x"11", x"11", x"15", x"12", x"0d",x"00");   -- x"51 Q 
           ELSIF NUM = x"52" THEN
                rom<= (x"1e", x"11", x"11", x"1e", x"14", x"12", x"11",x"00");   -- x"52 R
           ELSIF NUM = x"53" THEN
                rom<= (x"0e", x"11", x"10", x"0e", x"01", x"11", x"0e",x"00");   -- x"53 S
           ELSIF NUM = x"54" THEN
                rom<= (x"1f", x"04", x"04", x"04", x"04", x"04", x"04",x"00");   -- x"54 T
           ELSIF NUM = x"55" THEN
                rom<= (x"11", x"11", x"11", x"11", x"11", x"11", x"0e",x"00");   -- x"55 U
           ELSIF NUM = x"56" THEN
                rom<= (x"11", x"11", x"11", x"11", x"11", x"0a", x"04",x"00");   -- x"56 V
           ELSIF NUM = x"57" THEN
                rom<= (x"11", x"11", x"11", x"15", x"15", x"1b", x"11",x"00");   -- x"57 W
           ELSIF NUM = x"58" THEN
                rom<= (x"11", x"11", x"0a", x"04", x"0a", x"11", x"11",x"00");   -- x"58 X
           ELSIF NUM = x"59" THEN
                rom<= (x"11", x"11", x"0a", x"04", x"04", x"04", x"04",x"00");   -- x"59 Y
           ELSIF NUM = x"5A" THEN
                rom<= (x"1f", x"01", x"02", x"04", x"08", x"10", x"1f",x"00");   -- x"5a Z
           ELSIF NUM = x"5B" THEN
                rom<= (x"0e", x"08", x"08", x"08", x"08", x"08", x"0e",x"00");   -- x"5b [
           ELSIF NUM = x"5C" THEN
                rom<= (x"00", x"10", x"08", x"04", x"02", x"01", x"00",x"00");   -- x"5c \
           ELSIF NUM = x"5D" THEN
                rom<= (x"0e", x"02", x"02", x"02", x"02", x"02", x"0e",x"00");   -- x"5d ]
           ELSIF NUM = x"5E" THEN
                rom<= (x"04", x"0a", x"11", x"00", x"00", x"00", x"00",x"00");   -- x"5e ^
           ELSIF NUM = x"5F" THEN
                rom<= (x"00", x"00", x"00", x"00", x"00", x"00", x"1f",x"00");   -- x"5f _          
           ELSIF NUM = x"60" THEN
                rom<= (x"08", x"04", x"02", x"00", x"00", x"00", x"00",x"00");   -- x"60 `
           ELSIF NUM = x"61" THEN
                rom<= (x"00", x"0e", x"01", x"0d", x"13", x"13", x"0d",x"00");   -- x"61 a
           ELSIF NUM = x"62" THEN
                rom<= (x"10", x"10", x"10", x"1c", x"12", x"12", x"1c",x"00");   -- x"62 b
           ELSIF NUM = x"63" THEN
                rom<= (x"00", x"00", x"00", x"0e", x"10", x"10", x"0e",x"00");   -- x"63 c
           ELSIF NUM =x"64" THEN
                rom<= (x"01", x"01", x"01", x"07", x"09", x"09", x"07",x"00");   -- x"64 d
           ELSIF NUM = x"65" THEN
                rom<= (x"00", x"00", x"0e", x"11", x"1f", x"10", x"0f",x"00");   -- x"65 e
           ELSIF NUM = x"66" THEN
                rom<= (x"06", x"09", x"08", x"1c", x"08", x"08", x"08",x"00");   -- x"66 f
           ELSIF NUM = x"67" THEN
                rom<= (x"0e", x"11", x"13", x"0d", x"01", x"01", x"0e",x"00");   -- x"67 g
           ELSIF NUM = x"68" THEN
                rom<= (x"10", x"10", x"10", x"16", x"19", x"11", x"11",x"00");   -- x"68 h
           ELSIF NUM = x"69" THEN
                rom<= (x"00", x"04", x"00", x"04", x"04", x"04", x"04",x"00");   -- x"69 i
           ELSIF NUM = x"6A" THEN
                rom<= (x"02", x"00", x"06", x"02", x"02", x"12", x"0c",x"00");   -- x"6a j
           ELSIF NUM = x"6B" THEN
                rom<= (x"10", x"10", x"12", x"14", x"18", x"14", x"12",x"00");   -- x"6b k
           ELSIF NUM = x"6C" THEN
                rom<= (x"0c", x"04", x"04", x"04", x"04", x"04", x"04",x"00");   -- x"6c l
           ELSIF NUM = x"6D" THEN 
                rom<= (x"00", x"00", x"0a", x"15", x"15", x"11", x"11",x"00");   -- x"6d m
           ELSIF NUM = x"6E" THEN
                rom<= (x"00", x"00", x"16", x"19", x"11", x"11", x"11",x"00");   -- x"6e n
           ELSIF NUM = x"6F" THEN          
                rom<= (x"00", x"00", x"0e", x"11", x"11", x"11", x"0e",x"00");   -- x"6f o
           ELSIF NUM = x"70" THEN       
                rom<= (x"00", x"1c", x"12", x"12", x"1c", x"10", x"10",x"00");   -- x"70 p
           ELSIF NUM = x"71" THEN     
                rom<= (x"00", x"07", x"09", x"09", x"07", x"01", x"01",x"00");   -- x"71 q
           ELSIF NUM = x"72" THEN       
                rom<= (x"00", x"00", x"16", x"19", x"10", x"10", x"10",x"00");   -- x"72 r
           ELSIF NUM = x"73" THEN        
                rom<= (x"00", x"00", x"0f", x"10", x"0e", x"01", x"1e",x"00");   -- x"73 s
           ELSIF NUM = x"74" THEN     
                rom<= (x"08", x"08", x"1c", x"08", x"08", x"09", x"06",x"00");   -- x"74 t
           ELSIF NUM = x"75" THEN        
                rom<= (x"00", x"00", x"11", x"11", x"11", x"13", x"0d",x"00");   -- x"75 u
           ELSIF NUM = x"76" THEN       
                rom<= (x"00", x"00", x"11", x"11", x"11", x"0a", x"04",x"00");   -- x"76 v
          ELSIF NUM = x"77" THEN       
                rom<= (x"00", x"00", x"11", x"11", x"15", x"15", x"0a",x"00");   -- x"77 w
          ELSIF NUM = x"78" THEN        
                rom<= (x"00", x"00", x"11", x"0a", x"04", x"0a", x"11",x"00");   -- x"78 x
          ELSIF NUM = x"79" THEN         
                rom<= (x"00", x"11", x"11", x"0f", x"01", x"11", x"0e",x"00");   -- x"79 y
          ELSIF NUM = x"7A" THEN       
                rom<= (x"00", x"00", x"1f", x"02", x"04", x"08", x"1f",x"00");   -- x"7a z
          ELSIF NUM = x"7B" THEN        
                rom<= (x"06", x"08", x"08", x"10", x"08", x"08", x"06",x"00");   -- x"7b {
          ELSIF NUM = x"7C" THEN       
                rom<= (x"04", x"04", x"04", x"04", x"04", x"04", x"04",x"00");   -- x"7c |
          ELSIF NUM = x"7D" THEN         
                rom<= (x"0c", x"02", x"02", x"01", x"02", x"02", x"0c",x"00");   -- x"7d }
          ELSIF NUM = x"7E" THEN        
                rom<= (x"00", x"04", x"02", x"1f", x"02", x"04", x"00",x"00");   -- x"7e ->
          ELSIF NUM = x"7F" THEN         
                rom<= (x"00", x"04", x"08", x"1f", x"08", x"04", x"00", x"00");   -- x"7f <- 
          ELSE 
                rom<= (x"00", x"00", x"00", x"00", x"00", x"00", x"00", x"00");     
                
       END IF;
       END PROCESS;
       
             ----- Upper section of FSM: --------------------
       PROCESS (pr_state)
       BEGIN
            CASE pr_state IS
                   WHEN S0 =>
                             dot<=rom(0);
                             an <= "01111111";
                             nx_state <= S1;
                   WHEN S1 =>
                             dot<=rom(1);
                             an <= "10111111";
                             nx_state <= S2;
                   WHEN S2 =>
                             dot<=rom(2);
                             an <= "11011111";
                             nx_state <= S3;
                   WHEN S3 =>
                             dot<=rom(3);
                             an <= "11101111";
                             nx_state <= S4;
                   WHEN S4 =>
                             dot<=rom(4);
                             an <= "11110111";
                             nx_state <= S5;
                   WHEN S5 =>
                             dot<=rom(5);
                             an <= "11111011";
                             nx_state <= S6;
                   WHEN S6 =>
                             dot<=rom(6);
                             an <= "11111101";
                             nx_state <= S7;
                   WHEN S7 =>
                             dot<=rom(7);
                              an <= "11111110";
                             nx_state <= S0;
              END CASE;
       END PROCESS;
END ASCII_5x7_font;

