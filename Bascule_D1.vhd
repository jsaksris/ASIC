Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity Bascule_D1 is 

port (
	clk : in std_logic;
	rst : in std_logic;
	data  : in std_logic;
	q  : out std_logic);

end Bascule_D1;

architecture archi_Bascule_D1 of Bascule_D1 is
begin

	process(clk,rst)
	begin
		if rst = '0' then 
			q <= '0';
		elsif clk'event and clk = '1' then
			q <= data;
		end if;
	end process;

end archi_Bascule_D1;
