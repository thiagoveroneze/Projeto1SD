library ieee;
use ieee.std_logic_1164.all;

entity fulladder1 is -- definindo estrutura de um fulladder
    port( a,b : in  std_logic;
	      cin : in  std_logic;
		  s   : out std_logic;
		  cout: out std_logic);
end fulladder1;

architecture fa1_behav of fulladder1 is
begin 
     s    <= (a xor b) xor cin;
	 cout <= (a and b) or ((a xor b) and cin);
end fa1_behav;

library ieee;
use ieee.std_logic_1164.all;


entity adder4bit is -- definindo estrutura do adder
    port( 
          V_SW  : in  std_logic_vector(11 downto 0);
	      HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0)
	    );
end adder4bit;

architecture adder_behav of adder4bit is
    
    component fulladder1 port(
	       a,b : in  std_logic;
	       cin : in  std_logic;
	       s   : out std_logic;
	       cout: out std_logic);
	 end component;

    signal s : std_logic_vector(3 downto 1);
    signal i1, i2 : std_logic_vector(3 downto 0);
    signal o : std_logic_vector(4 downto 0);

    begin 
    
    --signals recebem os valores das inputs para poder mostrar no display
    i1 <=  (V_SW(6), V_SW(5),V_SW(4),V_SW(3));
    i2 <= (V_SW(11),V_SW(10),V_SW(9),V_SW(8));
    
    -- a estrutura abaixo simula um circuito somador-subtrator de 4 bits setado com carry in = 0 para adição
    fa1: fulladder1 port map(V_SW(3), V_SW(8), '0',o(0),     s(1));	 
	fa2: fulladder1 port map(V_SW(4), V_SW(9),s(1),o(1),     s(2));
	fa3: fulladder1 port map(V_SW(5),V_SW(10),s(2),o(2),     s(3));
	fa4: fulladder1 port map(V_SW(6),V_SW(11),s(3),o(3),     o(4)); 
	
	-- processo que determina o que aparece nos displays 7 seg e as flags
		process (i1, i2, o)
    begin
    
       --flags 
       
       if (o = "00000") then -- se resultado é zero, ativa flag zero
           HEX3 <= "1111110";
           else 
           HEX3 <= "1111111";
       end if;
       
       if (o(4) = '1') then -- se tem carry out, ativa a flag carry
           HEX2 <= "1110111";
           else 
           HEX2 <= "1111111";
       end if;
       
       -- controle dos display 7 seg 
       if (i1 > "1001") then 
           HEX7 <= "1111001"; -- HEX7 é a dezena da primeira entrada
           else
           HEX7 <= "1111111";
       end if;
       case i1 is  -- HEX6 é unidade da primeira entrada
           when "0000" => HEX6 <= "1000000";
           when "0001" => HEX6 <= "1111001";
           when "0010" => HEX6 <= "0100100";
           when "0011" => HEX6 <= "0110000"; 
           when "0100" => HEX6 <= "0011001";
           when "0101" => HEX6 <= "0010010";
           when "0110" => HEX6 <= "0000010";
           when "0111" => HEX6 <= "1111000";
           when "1000" => HEX6 <= "0000000";
           when "1001" => HEX6 <= "0010000";
           when "1010" => HEX6 <= "1000000";
           when "1011" => HEX6 <= "1111001";
           when "1100" => HEX6 <= "0100100";
           when "1101" => HEX6 <= "0110000";
           when "1110" => HEX6 <= "0011001";
           when "1111" => HEX6 <= "0010010";
       end case;
       if (i2 > "1001") then  -- HEX5 é a dezena da segunda entrada
           HEX5 <= "1111001";
           else
           HEX5 <= "1111111";
       end if;
        case i2 is -- HEX4 é unidade da segunda entrada
           when "0000" => HEX4 <= "1000000";
           when "0001" => HEX4 <= "1111001";
           when "0010" => HEX4 <= "0100100";
           when "0011" => HEX4 <= "0110000"; 
           when "0100" => HEX4 <= "0011001";
           when "0101" => HEX4 <= "0010010";
           when "0110" => HEX4 <= "0000010";
           when "0111" => HEX4 <= "1111000";
           when "1000" => HEX4 <= "0000000";
           when "1001" => HEX4 <= "0010000";
           when "1010" => HEX4 <= "1000000";
           when "1011" => HEX4 <= "1111001";
           when "1100" => HEX4 <= "0100100";
           when "1101" => HEX4 <= "0110000";
           when "1110" => HEX4 <= "0011001";
           when "1111" => HEX4 <= "0010010";
       end case;
       if (o > "01001" and o < "10100") then --HEX1 é a dezena da saída
           HEX1 <= "1111001";
       elsif ( o > "10011" and o < "11110") then
           HEX1 <= "0100100";
       elsif ( o > "11101") then
           HEX1 <= "0110000";
       else
           HEX1 <= "1111111";
       end if; 
       case o is  --HEX0 é a unidade da saída
           when "00000" => HEX0 <= "1000000";
           when "00001" => HEX0 <= "1111001";
           when "00010" => HEX0 <= "0100100";
           when "00011" => HEX0 <= "0110000"; 
           when "00100" => HEX0 <= "0011001";
           when "00101" => HEX0 <= "0010010";
           when "00110" => HEX0 <= "0000010";
           when "00111" => HEX0 <= "1111000";
           when "01000" => HEX0 <= "0000000";
           when "01001" => HEX0 <= "0010000";
           when "01010" => HEX0 <= "1000000";
           when "01011" => HEX0 <= "1111001";
           when "01100" => HEX0 <= "0100100";
           when "01101" => HEX0 <= "0110000";
           when "01110" => HEX0 <= "0011001";
           when "01111" => HEX0 <= "0010010";
           when "10000" => HEX0 <= "0000010";
           when "10001" => HEX0 <= "1111000";
           when "10010" => HEX0 <= "0000000";
           when "10011" => HEX0 <= "0010000";
           when "10100" => HEX0 <= "1000000";
           when "10101" => HEX0 <= "1111001";
           when "10110" => HEX0 <= "0100100";
           when "10111" => HEX0 <= "0110000";
           when "11000" => HEX0 <= "0011001";
           when "11001" => HEX0 <= "0010010";
           when "11010" => HEX0 <= "0000010"; 
           when "11011" => HEX0 <= "1111000";
           when "11100" => HEX0 <= "0000000";
           when "11101" => HEX0 <= "0010000";
           when "11110" => HEX0 <= "1000000";
           when "11111" => HEX0 <= "1111001";
       end case;
    end process;
end adder_behav;