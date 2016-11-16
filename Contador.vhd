library ieee;

use ieee.std_logic_1164.all;

use IEEE.std_logic_unsigned.all;



entity contador is
 
   port(

	CLOCK_50: in std_logic;
	comecaContagem: in std_logic;

        CONTO2SEG: out std_logic := '0'

   	);

end entity;



architecture cont_arch of contador is

	type FSMstates is (PARADO, CONTANDO, CONTOU2SEGUNDOS);
	signal actualState, nextState : FSMstates;
	signal contador: std_logic_vector(27 downto 0) := (others => '0');
begin

	--next-state logic    
PROCESS (actualState, contador, clock)

    	begin

	nextState <= actualState;
	case actualState is
		when PARADO =>
			if comecaContagem = '1' then
				nextState <= CONTANDO;
			end if;
		when CONTANDO =>
			if contador > x"5F5E0FF" then
				nextState <= CONTOU2SEGUNDOS;
			end if;
		when CONTOU2SEGUNDOS =>
			nextState <= PARADO;
	end case;
end process;
	--memory
EM: PROCESS (CLOCK_50)	is
	begin
		if rising_edge(CLOCK_50) then
			actualState <= nextState;
		end if;
end PROCESS;
	--output logic
	contador <= x"0000000" when actualState=PARADO else contador+1 when actualState=CONTANDO else contador;
	CONTO2SEG <= '1' when actualState=CONTOU2SEGUNDOS else '0';
end architecture;