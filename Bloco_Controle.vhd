library ieee;

use ieee.std_logic_1164.all;



entity Bloco_Controle is

	port(

		clock: in std_logic;

		btn: in std_logic;

		recebeu : in std_logic;

		cont2seg: in std_logic;

		reset: in std_logic;

		envia_sinal: out std_logic;

		recebe_sinal: out std_logic;

		resetDoContador: out std_logic;

		estado_recebe: out std_logic;

		estado_envia: out std_logic;

		estado_espera: out std_logic

		);

end entity;



architecture ctrl of Bloco_Controle is

	type FSMstates is (INICIO, INSTRUCAO, ENVIA, RECEBE);
	signal actualState, nextState : FSMstates;

begin


	--next-state logic

	PROCESS (actualState, btn, cont2seg, recebeu)

	begin

	nextState <= actualState;

	case actualState is

		when INICIO =>

			if btn = '1' then

				nextState <= INSTRUCAO;

			end if;

		when INSTRUCAO =>

			if btn = '0' and cont2seg = '0' then

				nextState <= ENVIA;

			elsif cont2seg = '1' then

				nextState <= RECEBE;

			end if;

		when ENVIA =>

			if recebeu = '1' then

				nextState <= INICIO;

			end if;

		when RECEBE =>
			if recebeu = '1' then

				nextState <= INICIO;

			end if;

		end case;

	end process;


	
	--memory

	EM: process(clock, reset) is

	begin

		if reset='1' then

			actualState <= INICIO;

		elsif rising_edge(clock) then

			actualState <= nextState;

		end if;
	end process;


	
	--output logic

	envia_sinal <= '1' when actualState=ENVIA else '0';

	recebe_sinal <= '1' when actualState=RECEBE else '0';

	resetDoContador <= '1' when actualState=INICIO else '0';

	estado_envia <= '1' when actualState=ENVIA else '0';
	estado_recebe <= '1' when actualState=RECEBE else '0';
	estado_espera <= '1' when actualState=INICIO else '1' when actualState=INSTRUCAO else '0';	


end architecture;