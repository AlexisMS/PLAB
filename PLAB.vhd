library ieee;
use ieee.std_logic_1164.all;

--Estudantes: Alexis Mendes Sequeira e Guilherme Faria

entity PLAB is
	generic (
             data_width_write : positive := 1;
				 data_width_read: positive := 5;
             address_width : positive := 2
             --<any other parameter needed>
     );
     port(
            clock : in std_logic;
            resetn : in std_logic;
            reade: in std_logic;   -- active if reading from an address of the component
--				write : in std_logic;   -- active if writing into an address of the component
            address : in std_logic_vector(address_width-1 downto 0);   -- the address from it's reading or to were it's writing
            writedata : in std_logic_vector(data_width_write-1 downto 0);  -- the data to be written
            readdata : out std_logic_vector(data_width_read-1 downto 0)  -- the data readed
            --<any other inputs or outputs that will not be connected to the bus>
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

	signal recebe_sig, recebeu_sig, envia_sig, cont2seg_sig, reset_cont_sig : std_logic;
	signal adress_sig: std_logic_vector(1 downto 0);
begin
	writedata(1) <= '0';
	
	operativo: Bloco_Operativo port map(reade,
													reset_cont_sig,
													clock,
													recebe_sig,
													envia_sig,
													--out_cont_freq_ir, --definir depois
													writedata(0 downto 0),
													readdata(0),
													recebeu_sig,
													cont2seg_sig);
	
	controle: bloco_Controle port map(clock,
												reade,
												recebeu_sig,
												cont2seg_sig,
												resetn,
												envia_sig,
												recebe_sig,
												reset_cont_sig,
												writedata(3),
												writedata(2),
												writedata(4));

end architecture;