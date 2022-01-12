library ieee;
use ieee.std_logic_1164.all;

entity inv4bit is
    port (
        V_SW: in std_logic_vector(7 downto 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0)
    );
end inv4bit;

architecture inv4bh of inv4bit is

    signal i, flags: std_logic_vector(3 downto 0);
    
begin

    i <= (V_SW(6), V_SW(5),V_SW(4),V_SW(3)); 
    flags(1) <= '0'; -- overflow
    
    -- visores não utilizados
    HEX5 <= "1111111";
    HEX4 <= "1111111";
    HEX1 <= "1111111";
    
    
    process (i, flags)
    begin
    -- definindo flags
       if (i = "0000") then -- zero
           flags(3) <= '1';
           else
           flags(3) <= '0';
       end if;
    
       if (i(3) = '0' and flags(3) = '0') then --se bit de sinal da entrada é 0, seu comp de 2 é negativo, menos se for zero
           flags(2) <= '1';
           else
           flags(2) <= '0';
       end if;
       if (flags(3) = '1') then
           flags(0) <= '1'; -- segundo a tabela verdade, na unica instancia onde temos carryout é em i = "0000"
           else
           flags(0) <= '0';
       end if; 
       
    -- mostrando as flags
	   if (flags(0) = '1') then -- carryout
	       if (flags(1) = '1') then -- overflow
	           HEX2 <= "1110110";
	       else
	           HEX2 <= "1110111";
	       end if;
	   else
	       HEX2 <= "1111111";
	   end if;
	   if (flags(2) = '1') then -- negativo
	       if (flags(3) = '1') then -- zero
	           HEX3 <= "1110110";
	       else
	           HEX3 <= "1110111";
	       end if;
	   else
	       HEX3 <= "1111111";
	   end if;
       
    -- controle dos display 7 seg 
    
        if (i(3) = '1') then -- apenas para ficar mais visual quando a input é um negativo em comp 2
            HEX7 <= "0111111";
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
           when "1001" => HEX6 <= "1111000";
           when "1010" => HEX6 <= "0000010";
           when "1011" => HEX6 <= "0010010";
           when "1100" => HEX6 <= "0011001";
           when "1101" => HEX6 <= "0110000";
           when "1110" => HEX6 <= "0100100";
           when "1111" => HEX6 <= "1111001";
        end case;
        
        case i is  -- HEX0 é unidade da primeira entrada, como apenas trocamos o sinal por comp 2, repeti o  codigo acima pro result
           when "0000" => HEX0 <= "1000000";
           when "0001" => HEX0 <= "1111001";
           when "0010" => HEX0 <= "0100100";
           when "0011" => HEX0 <= "0110000"; 
           when "0100" => HEX0 <= "0011001";
           when "0101" => HEX0 <= "0010010";
           when "0110" => HEX0 <= "0000010";
           when "0111" => HEX0 <= "1111000";
           when "1000" => HEX0 <= "0000000";
           when "1001" => HEX0 <= "1111000";
           when "1010" => HEX0 <= "0000010";
           when "1011" => HEX0 <= "0010010";
           when "1100" => HEX0 <= "0011001";
           when "1101" => HEX0 <= "0110000";
           when "1110" => HEX0 <= "0100100";
           when "1111" => HEX0 <= "1111001";
        end case;
        
    end process;
end inv4bh;