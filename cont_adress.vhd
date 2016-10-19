library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity cont_adress is
	port(
	entrada: in std_logic;
	RST: in std_logic;
	saidaContador: out std_logic_vector(5 downto 0);
	saidaPronto: out std_logic
);
end entity;

architecture cont_arch of cont_adress is
signal contador: std_logic_vector(5 downto 0);
signal pronto : std_logic;

begin


	
	process(entrada,RST,contador,pronto)
	begin
		if RST = '1' then
			contador <= "000000";
			pronto <= '0';
		elsif entrada = '1' and contador < "000111" then
			contador <= contador + 1;
			pronto <= '0';
		elsif contador = "000111"then
			contador <= contador;
			pronto <= '1';
		else
			contador <= contador;
		end if;
	end process;
	
	saidaContador <= contador;
	saidaPronto <= pronto;
end architecture;