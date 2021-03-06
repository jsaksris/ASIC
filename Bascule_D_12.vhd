Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Bascule_D_12 is 

port (
	clk : in std_logic;
	rst : in std_logic;
	data  : in std_logic_vector(11 downto 0);
	q  : out std_logic_vector(11 downto 0));

end Bascule_D_12;

architecture archi_Bascule_D_12 of Bascule_D_12 is
begin

	process(clk,rst)
	begin
		if rst = '0' then 
			q <= ( others => '0');
		elsif clk'event and clk = '1' then
			q <= data;
		end if;
	end process;

end archi_Bascule_D_12;
