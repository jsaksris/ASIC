Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity DPRAM is 
generic ( width_word : integer := 12;
	  nb_word : integer := 31;
	  nb_addr : integer := 5);
port (
	clk : in std_logic;
	rst : in std_logic;

	adresse_a  : in std_logic_vector(nb_addr-1 downto 0);
	adresse_b  : in std_logic_vector(nb_addr-1 downto 0);

	datain_b  : in std_logic_vector(width_word-1 downto 0);
	datain_a  : in std_logic_vector(width_word-1 downto 0);

	dataout_a  : out std_logic_vector(width_word-1 downto 0);
	dataout_b  : out std_logic_vector(width_word-1 downto 0);

	enable_a : in std_logic;
	enable_b : in std_logic);

end DPRAM;

architecture archi_DPRAM of DPRAM is
type ram_type is array (0 to (nb_word-1)) of std_logic_vector(width_word-1 downto 0);
signal ram : ram_type;

begin

	process(clk,rst)
	begin
		if rst = '0' then 
			dataout_a <= ( others => '0');
			dataout_b <= ( others => '0');
			ram <= ((others=> (others=>'0')));
		elsif clk'event and clk = '1' then
			if enable_a = '0' then 
				dataout_a <= ram(to_integer(unsigned(adresse_a)));
			else
				ram(to_integer(unsigned(adresse_a))) <= datain_a;
			end if;
			
			if enable_b = '0' then
				dataout_b <= ram(to_integer(unsigned(adresse_b)));
			else
				ram(to_integer(unsigned(adresse_b))) <= datain_b;
			end if;
		end if;
	end process;

end archi_DPRAM;
