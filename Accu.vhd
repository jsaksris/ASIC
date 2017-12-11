Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Accu is 
generic ( 	width_word : integer := 23;
		width_end : integer := 28);

port (
	clk : in std_logic;
	rst : in std_logic;

	datain_acc  : in std_logic_vector(width_word-1 downto 0);

	dataout  : out std_logic_vector(width_end-1 downto 0);
	en_in : in std_logic);
	
end Accu;

architecture archi_Accu of Accu is
signal somme : std_logic_vector (width_end-1 downto 0):=(others=>'0');
begin

	process(clk,rst)
	begin
		if rst = '0' then 
			--dataout <= ( others => '0');
			somme <= (others => '0');
		elsif clk'event and clk = '1' then
			if (en_in = '1') then
				somme <= somme + datain_acc;
				dataout <= somme;
			end if;
		end if;
	end process;

end archi_Accu;
