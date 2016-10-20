library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity contador is
    port(
			comecaContagem: in std_logic;
         CLOCK_50: in std_logic;
			CONTO2SEG: out std_logic := '0'
        );
end contador;

architecture cont_arch of contador is
signal contador: std_logic_vector(27 downto 0) := (others => '0');  
 
begin
    process(CLOCK_50)
    begin
		  if comecaContagem = '0' then
				contador <= x"0000000";
		
        elsif CLOCK_50'event and CLOCK_50 = '1' and comecaContagem = '1' then
			contador <= contador + 1;
            if contador > x"000000A" then
                CONTO2SEG <= '1';
            else
                CONTO2SEG <= '0';            
            end if;
			else
        end if;
    end process;
end cont_arch;