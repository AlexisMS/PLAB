library ieee;
use ieee.std_logic_1164.all;

--Estudantes: Alexis Mendes Sequeira e Guilherme Faria

entity PLAB is
	 port(
		KEY : in std_logic_vector(2 downto 0);
		CLOCK_50: in std_logic;
		SW : in std_logic_vector(0 downto 0);
		LEDR : out std_logic_vector(3 downto 0)
	 );
end entity;

architecture arch of PLAB is

component Bloco_Operativo
	port (
		btn : in std_logic;
		reset_contador: in std_logic;
		CLK : in std_logic;
		recebe_sinal : in std_logic;
		envia_sinal : in std_logic;
		clk_ir : in std_logic;
		in_ir : in std_logic_vector(0 downto 0);
		out_ir : out std_logic;
		recebeu : out std_logic;
		cont2seg : out std_logic
	);
end component;

component Bloco_Controle
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
end component;

	signal key0_sig, key1_sig, key2_sig, recebe_sig, recebeu_sig, envia_sig, cont2seg_sig, reset_cont_sig : std_logic;
	
begin
	key0_sig <= not(KEY(0));
	key1_sig <= not(KEY(1));
	key2_sig <= not(KEY(2));
	
	operativo: Bloco_Operativo port map(key0_sig,reset_cont_sig,CLOCK_50,recebe_sig,envia_sig,key1_sig,SW(0 downto 0),LEDR(0),recebeu_sig,cont2seg_sig);
	
	controle: bloco_Controle port map(CLOCK_50,key0_sig,recebeu_sig,cont2seg_sig,key2_sig,envia_sig,recebe_sig,reset_cont_sig,LEDR(2),LEDR(1),LEDR(3));

end architecture;