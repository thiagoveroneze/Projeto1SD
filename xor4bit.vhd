library ieee;
use ieee.std_logic_1164.all;

entity xor4bit is
    port (
        V_SW: in std_logic_vector(11 downto 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0)
    );
end xor4bit;

architecture xor_bh of xor4bit is

    signal i1 , i2 , o : std_logic_vector(3 downto 0);
    -- como temos uma função lógica, desabilitei as flags nesse módulo
    
begin

    --signals recebem os valores das inputs para podermos realizar em cimas deles a lógica
    i1 <=  (V_SW(6), V_SW(5),V_SW(4),V_SW(3));
    i2 <= (V_SW(11),V_SW(10),V_SW(9),V_SW(8)); 
    
    -- para esse módulo decidi deixar as entradas como hexadecimal logo dois visores nao serao utilizados
    HEX7 <= "1111111";
    HEX5 <= "1111111";
    
    
    process (i1, i2, o)
    begin
    
       for k in 0 to 3 loop -- testamos par a par a condição xor
           o(k) <= i1(k) xor i2(k);
           end loop;
           
        -- mostrando as entradas em hexadecimal
        
        case i1 is
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
            when "1010" => HEX6 <= "0001000";
            when "1011" => HEX6 <= "0000011";
            when "1100" => HEX6 <= "1000110";
            when "1101" => HEX6 <= "0100001";
            when "1110" => HEX6 <= "0000110";
            when "1111" => HEX6 <= "0001110";
        end case;
        
        case i2 is
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
            when "1010" => HEX4 <= "0001000";
            when "1011" => HEX4 <= "0000011";
            when "1100" => HEX4 <= "1000110";
            when "1101" => HEX4 <= "0100001";
            when "1110" => HEX4 <= "0000110";
            when "1111" => HEX4 <= "0001110";
        end case;
        
        -- mostrando os resultados
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
    
end xor_bh;