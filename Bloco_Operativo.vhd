library ieee;
use ieee.std_logic_1164.all;

entity Bloco_Operativo is
	port(
		btn : in std_logic;
		reset_contador: in std_logic;
		CLK : in std_logic;
		recebe_sinal : in std_logic;
		envia_sinal : in std_logic;
		clk_ir : in std_logic; --to do
		in_ir : in std_logic_vector(0 downto 0);
		out_ir : out std_logic;
		recebeu : out std_logic;
		cont2seg : out std_logic
	);
end entity;

architecture estrutural of Bloco_Operativo is

component RAM_1
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (5 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (0 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (0 DOWNTO 0)
	);
end component;

component Contador
	port(
         comecaContagem: in std_logic;
         CLOCK_50: in std_logic;
			CONTO2SEG: out std_logic
        );
end component;

component cont_adress
	port(
			entrada: in std_logic;
			RST: in std_logic;
			saidaContador: out std_logic_vector(5 downto 0);
			saidaPronto: out std_logic
		);
end component;

signal ram_out : std_logic_vector(0 downto 0);
signal address_sig : std_logic_vector(5 downto 0);

begin
	
	cont1: cont_adress port map ( clk_ir, reset_contador, address_sig(5 downto 0), recebeu);
	
	cont2: Contador port map ( btn, CLK, cont2seg);

	RAM_inst: RAM_1 port map (address_sig(5 downto 0), clk_ir, in_ir(0 downto 0), recebe_sinal, ram_out(0 downto 0));
		
	out_ir <= (ram_out(0) and envia_sinal);


end architecture;