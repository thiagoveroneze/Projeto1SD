library ieee;
use ieee.std_logic_1164.all;

entity not4bit is
    port (
        V_SW: in std_logic_vector(7 downto 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0)
    );
end not4bit;

architecture not_bh of not4bit is

    signal i, o : std_logic_vector(3 downto 0);
    
begin

    i <= (V_SW(6), V_SW(5),V_SW(4),V_SW(3)); --sinal i recebe os valores de entrada
    
    process (i, o)
    begin
       for k in 0 to 3 loop -- fazemos o not de cada elemento de i
           o(k) <= not i(k);
           end loop;
        
        -- mostrando a entrada
        
        if (i(0) = '1') then
            HEX4 <= "1111001";
            else
            HEX4 <= "1000000";
        end if;
        if (i(1) = '1') then
            HEX5 <= "1111001";
            else
            HEX5 <= "1000000";
        end if;
        if (i(2) = '1') then
            HEX6 <= "1111001";
            else
            HEX6 <= "1000000";
        end if;
        if (i(3) = '1') then
            HEX7 <= "1111001";
            else
            HEX7 <= "1000000";
        end if;
        
        -- mostrando o resultado
        if (o(0) = '1') then
            HEX0 <= "1111001";
            else
            HEX0 <= "1000000";
        end if;
        if (o(1) = '1') then
            HEX1 <= "1111001";
            else
            HEX1 <= "1000000";
        end if;
        if (o(2) = '1') then
            HEX2 <= "1111001";
            else
            HEX2 <= "1000000";
        end if;
        if (o(3) = '1') then
            HEX3 <= "1111001";
            else
            HEX3 <= "1000000";
        end if;
       
       
    end process;
    
end not_bh;