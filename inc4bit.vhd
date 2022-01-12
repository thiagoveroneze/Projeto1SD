library ieee;
use ieee.std_logic_1164.all;

entity inc4bit is
    port (
        V_SW: in std_logic_vector(7 downto 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0)
    );
end inc4bit;

architecture inc_bh of inc4bit is

    signal i, flags  : std_logic_vector(3 downto 0);
    
begin

    i <= (V_SW(6), V_SW(5),V_SW(4),V_SW(3)); --sinal i recebe os valores de entrada
    
    -- visores não utilizados
    HEX5 <= "1111111";
    HEX4 <= "1111111";
    HEX3 <= "1111111"; -- onde teriamos flags Z e N , mas como explicado abaixo, essa função nao permite essas flags
    
    flags(3) <= '0'; -- nao tem como o resultado ser zero aqui, logo flag zero sempre inativa
    flags(2) <= '0'; -- mesma coisa pra flag negativo
    flags(1) <= '0'; -- e também para overflow
    
    process (i, flags)
    begin
       
       if (i = "1111") then -- só ocorre cout se a entrada for "1111"
           flags(0) <= '1';
           else 
           flags(0) <= '0';
       end if;
       
       if (flags(0) = '1') then -- carryout
	           HEX2 <= "1110111";
	       else
	           HEX2 <= "1111111";
	       end if;
       
       
       if (i > "1001") then 
           HEX7 <= "1111001"; -- HEX7 é a dezena da primeira entrada
           else
           HEX7 <= "1111111";
       end if;
       case i is  -- HEX6 é unidade da primeira entrada
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
       
       if (i > "1000") then --HEX1 é a dezena da saída
           HEX1 <= "1111001";
       else
           HEX1 <= "1111111";
       end if; 
       case i is  --HEX0 é a unidade da saída
           when "0000" => HEX0 <= "1111001";
           when "0001" => HEX0 <= "0100100";
           when "0010" => HEX0 <= "0110000";
           when "0011" => HEX0 <= "0011001"; 
           when "0100" => HEX0 <= "0010010";
           when "0101" => HEX0 <= "0000010";
           when "0110" => HEX0 <= "1111000";
           when "0111" => HEX0 <= "0000000";
           when "1000" => HEX0 <= "0010000";
           when "1001" => HEX0 <= "1000000";
           when "1010" => HEX0 <= "1111001";
           when "1011" => HEX0 <= "0100100";
           when "1100" => HEX0 <= "0110000";
           when "1101" => HEX0 <= "0011001";
           when "1110" => HEX0 <= "0010010";
           when "1111" => HEX0 <= "0000010";
        end case;
          
    end process;
    
end inc_bh;