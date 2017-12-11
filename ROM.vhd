Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ROM is 
generic ( width_word : integer := 11;
	  nb_word : integer := 16;
	  nb_addr : integer := 4);
port (
	clk : in std_logic;
	rst : in std_logic;

	adresse_c  : in std_logic_vector(nb_addr-1 downto 0);

	dataout_c  : out std_logic_vector(width_word-1 downto 0);

	enable_c : in std_logic);

end ROM;

architecture archi_ROM of ROM is
type rom_type is array (0 to (nb_word-1)) of std_logic_vector(width_word-1 downto 0);
signal rom : rom_type;


begin

	process(clk,rst)
	begin
		if rst = '0' then 
			dataout_c <= ( others => '0');
		elsif clk'event and clk = '1' then
			if enable_c = '1' then 
				dataout_c <= rom(to_integer(unsigned(adresse_c)));
			else
				NULL;
			end if;
		end if;
	end process;

	rom(0) <= "11111101111";
	rom(1) <= "11111100011";
	rom(2) <= "11111100001";
	rom(3) <= "11111110111";
	rom(4) <= "00000100001";
	rom(5) <= "00001001010";
	rom(6) <= "00001001111";
	rom(7) <= "00000011001";
	rom(8) <= "11110110100";
	rom(9) <= "11101011000";
	rom(10) <= "11101010100";
	rom(11) <= "11111100100";
	rom(12) <= "00100000101";
	rom(13) <= "01001101001";
	rom(14) <= "01110001110";
	rom(15) <= "01111111111";

end archi_ROM;
