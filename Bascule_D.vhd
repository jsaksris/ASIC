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

	datain_c  : in std_logic_vector(width_word-1 downto 0);

	dataout_c  : out std_logic_vector(width_word-1 downto 0);

	enable_c : in std_logic);

end ROM;

architecture archi_ROM of ROM is
type rom_type is array (0 to (nb_word-1)) of std_logic_vector(width_word-1 downto 0);
signal rom : rom_type;


begin

	process(clk,rst)
	begin
		if rst = '1' then 
			dataout_c <= ( others => '0');
		elsif clk'event and clk = '1' then
			if enable_c = '1' then 
				dataout_c <= rom(to_integer(unsigned(adresse_c)));
			else
				NULL;
			end if;
		end if;
	end process;

	rom(0) <= "00000000000";
	rom(1) <= "00000000001";
	rom(2) <= "00000000010";
	rom(3) <= "00000000011";
	rom(4) <= "00000000100";
	rom(5) <= "00000000101";
	rom(6) <= "00000000110";
	rom(7) <= "00000000111";
	rom(8) <= "00000001000";
	rom(9) <= "00000001001";
	rom(10) <= "00000001010";
	rom(11) <= "00000001011";
	rom(12) <= "00000001100";
	rom(13) <= "00000001101";
	rom(14) <= "00000001110";
	rom(15) <= "00000001111";

end archi_ROM;
