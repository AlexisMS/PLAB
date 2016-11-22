library ieee;
use ieee.std_logic_1164.all;

entity Wrapper is
	 port(
		KEY : in std_logic_vector(1 downto 0);
		CLOCK_50: in std_logic;
		SW : in std_logic_vector(0 downto 0);
		LEDR : out std_logic_vector(5 downto 0)
	 );
end entity;

architecture arch of Wrapper is
	
	component PLAB
		generic (
             data_width_write : positive := 1;
				 data_width_read: positive := 5;
             address_width : positive := 1
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
	end component;
	
	signal key0_sig, key1_sig : std_logic;
begin
	key0_sig <= not KEY(0);
	key1_sig <= not KEY(1);
	LEDR(5) <= '1';
	sistema: PLAB generic map(data_width_write => 1,
									  data_width_read  => 5,
									  address_width    => 1) 
						port map(CLOCK_50,
									key0_sig,
									key1_sig,
									"0",
									SW(0 downto 0),
									LEDR(4 downto 0));
end architecture;

--count+(adress*64) --calculo para endereco da ram apartir da entrada
--usar um divisor de frequencia para diminuir o CLOCK_50 para uma frequencia qualquer (generic)
--