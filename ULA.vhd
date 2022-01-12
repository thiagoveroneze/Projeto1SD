library ieee;
use ieee.std_logic_1164.all;
library work;

entity ULA is
    port (
        V_SW: in std_logic_vector(11 downto 0);
        HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7: out std_logic_vector(6 downto 0)
    );
end ULA;

architecture ULA_bh of ULA is

begin
    
    test1: entity work.adder4bit port map(
    V_SW => V_SW,
    HEX0 => HEX0,
    HEX1 => HEX1,
    HEX2 => HEX2,
    HEX3 => HEX3,
    HEX4 => HEX4,
    HEX5 => HEX5,
    HEX6 => HEX6,
    HEX7 => HEX7
    );
    
end ULA_bh;