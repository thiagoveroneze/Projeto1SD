library ieee;
use ieee.std_logic_1164.all;

entity fulladder2 is -- definindo estrutura de um fulladder
    port( a,b : in  std_logic;
	      cin : in  std_logic;
          s   : out std_logic;
          cout: out std_logic);
end fulladder2;

architecture fa2_behav of fulladder2 is
begin 
     s    <= (a xor b) xor cin;
     cout <= (a and b) or ((a xor b) and cin);
end fa2_behav;

library ieee;
use ieee.std_logic_1164.all;

entity sub4bit is -- definindo estrutura do subtrator
    port( V_SW  : in  std_logic_vector(11 downto 0);
	      HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0));
end sub4bit;

architecture sub4bit_behav of sub4bit is
    
    component fulladder2 port(
	       a,b : in  std_logic;
	       cin : in  std_logic;
	       s   : out std_logic;
	       cout: out std_logic);
	 end component;

    signal s : std_logic_vector(4 downto 1);
    signal i1, i2, flags : std_logic_vector(3 downto 0);
    signal o : std_logic_vector(3 downto 0);

    begin 
    
    --signals recebem os valores das inputs para poder mostrar no display
    i1 <=  (V_SW(6), V_SW(5),V_SW(4),V_SW(3));
    i2 <= (V_SW(11),V_SW(10),V_SW(9),V_SW(8));
    
    -- a estrutura abaixo simula um circuito somador-subtrator de 4 bits setado com carry in = 1 para subtração
    fa1: fulladder2 port map(V_SW(3), V_SW(8) xor '1', '1',o(0),     s(1));	 
	fa2: fulladder2 port map(V_SW(4), V_SW(9) xor '1',s(1),o(1),     s(2));
	fa3: fulladder2 port map(V_SW(5),V_SW(10) xor '1',s(2),o(2),     s(3));
	fa4: fulladder2 port map(V_SW(6),V_SW(11) xor '1',s(3),o(3),     s(4)); 
	
	flags(0) <= s(4); --carry out
	flags(1) <= s(4) xor s(3); --overflow
	
	HEX1 <= "1111111"; -- como as respostas em compl.2 e so representam o intervalo [-8, 7], é desnecessaria a dezena do result
	 
	process(i1, i2, o, flags)
	begin
	   -- DEFININDO AS FLAGS
	   
	   if (o = "0000" and flags(0) = '1') then
	       flags(3) <= '1'; --zero
	       else
	       flags(3) <= '0';
	   end if;
	   if (flags(0) = '0') then
	       flags(2) <= '1'; -- se cout for zero, temos um numero negativo
	       else 
	       flags(2) <= '0';
	   end if;
	   
	   -- Como de praxe descartamos o carry out na subtraçaõ em compl. 2, decidi omitir a flag
	   if (flags(1) = '1') then
	       HEX2 <= "1111110";
	   else
	       HEX2 <= "1111111";
	   end if;
	   
	   if (flags(2) = '1') then
	       if (flags(3) = '1') then
	           HEX3 <= "1110110";
	       else
	           HEX3 <= "1110111";
	       end if;
	   elsif (flags(2) = '0' and flags(3) = '1') then
	           HEX3 <= "1111110";
	   else
	       HEX3 <= "1111111";
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
       
       if (flags(0) = '0') then
       case o is  --HEX0 é a unidade da saída
           when "0000" => HEX0 <= "1111111";
           when "0001" => HEX0 <= "0001110";
           when "0010" => HEX0 <= "0000110";
           when "0011" => HEX0 <= "0100001"; 
           when "0100" => HEX0 <= "1000110";
           when "0101" => HEX0 <= "0000011";
           when "0110" => HEX0 <= "0001000";
           when "0111" => HEX0 <= "0010000";
           when "1000" => HEX0 <= "0000000";
           when "1001" => HEX0 <= "1111000";
           when "1010" => HEX0 <= "0000010";
           when "1011" => HEX0 <= "0010010";
           when "1100" => HEX0 <= "0011001";
           when "1101" => HEX0 <= "0110000";
           when "1110" => HEX0 <= "0100100";
           when "1111" => HEX0 <= "1111001";
       end case;
       else
       case o is  --HEX0 é a unidade da saída
           when "0000" => HEX0 <= "1000000";
           when "0001" => HEX0 <= "1111001";
           when "0010" => HEX0 <= "0100100";
           when "0011" => HEX0 <= "0110000"; 
           when "0100" => HEX0 <= "0011001";
           when "0101" => HEX0 <= "0010010";
           when "0110" => HEX0 <= "0000010";
           when "0111" => HEX0 <= "1111000";
           when "1000" => HEX0 <= "0000000";
           when "1001" => HEX0 <= "0010000";
           when "1010" => HEX0 <= "0001000";
           when "1011" => HEX0 <= "0000011";
           when "1100" => HEX0 <= "1000110";
           when "1101" => HEX0 <= "0100001";
           when "1110" => HEX0 <= "0000110";
           when "1111" => HEX0 <= "0001110";
       end case;
       end if;
    end process;
end sub4bit_behav;