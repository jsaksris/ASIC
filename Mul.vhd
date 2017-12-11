Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Mul is 
generic ( width_word_dpram : integer := 12;
	  width_word_rom : integer := 11;
	  width_total : integer := 23);
port (
	clk : in std_logic;
	rst : in std_logic;

	datain_dpram  : in std_logic_vector(width_word_dpram-1 downto 0);
	datain_rom  : in std_logic_vector(width_word_rom-1 downto 0);

	en_mul : in std_logic;

	dataout_mul  : out std_logic_vector(width_total-1 downto 0));
end Mul;

architecture archi_Mul of Mul is

begin

	process(clk,rst)
	begin
		if rst = '0' then 
			dataout_mul <= ( others => '0');
		elsif clk'event and clk = '1' then
			if (en_mul = '0') then
			dataout_mul <= datain_dpram * datain_rom;
			end if;
		end if;
	end process;

end archi_Mul;
