library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity freq_div is
	generic (
				max_count : unsigned(23 downto 0) := X"BEBC20" -- 12 500 000 in hex, 2Hz
				);
	port (
    clk_50Mhz : in  std_logic;
    rst       : in  std_logic;
    clk_out   : out std_logic);
end freq_div;

architecture Behavioral of freq_div is

  signal prescaler : unsigned(23 downto 0);
  signal clk_out_i : std_logic;
begin

  gen_clk : process (clk_50Mhz, rst)
  begin
    if rst = '1' then
      clk_out_i   <= '0';
      prescaler   <= (others => '0');
    elsif rising_edge(clk_50Mhz) then   -- rising clock edge
      if prescaler = max_count then     
        prescaler   <= (others => '0');
        clk_out_i   <= not clk_out_i;
      else
        prescaler <= prescaler + "1";
      end if;
    end if;
  end process gen_clk;

clk_out <= clk_out_i;

end Behavioral;