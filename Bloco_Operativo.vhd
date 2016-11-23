library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
--use ieee.std_logic_unsigned.all;

entity Bloco_Operativo is
	port(
		btn : in std_logic;
		reset_contador: in std_logic;
		CLK : in std_logic;
		recebe_sinal : in std_logic;
		envia_sinal : in std_logic;
		clk_ir : in std_logic;
		in_ir : in std_logic_vector(0 downto 0);
		out_ir : out std_logic;
		recebeu : out std_logic;
		cont2seg : out std_logic;
		adress_in : in std_logic_vector(1 downto 0)
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
signal address_sig, adress_final: std_logic_vector(5 downto 0);
signal adress_temp : std_logic_vector(5 downto 0) := (others => '0');
signal temp : std_logic_vector(11 downto 0);

begin
	
	adress_temp(1 downto 0) <= adress_in(1 downto 0);	
	
	cont1: cont_adress port map ( clk_ir, reset_contador, address_sig(5 downto 0), recebeu);
	
	--y <= "010000";
	--x <= std_logic_vector( signed(adress_temp) * signed(y) );
	temp <= std_logic_vector( signed(address_sig) + ( signed(adress_temp) * "010000"));	
	--adress_final <= address_sig + (adress_temp * x);
	adress_final <= temp(5 downto 0);
	
	cont2: Contador port map ( btn, CLK, cont2seg);

	RAM_inst: RAM_1 port map (adress_final(5 downto 0), clk_ir, in_ir(0 downto 0), recebe_sinal, ram_out(0 downto 0));
		
	out_ir <= (ram_out(0) and envia_sinal);


end architecture;