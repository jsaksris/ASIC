LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY tb_top IS 
END tb_top;

ARCHITECTURE behavior OF tb_top IS

COMPONENT top
PORT(	rst : in std_logic;
	clk : in std_logic;
	data_in : in std_logic_vector(11 downto 0) :=(others=>'0');
	enable : in std_logic;
	dataout : out std_logic_vector (27 downto 0);
	dataval : out std_logic);
end component;

signal rst : std_logic:= '0';
signal clk : std_logic:= '0';
signal enable : std_logic:= '0';
signal data_in : std_logic_vector(11 downto 0):= (others => '0');

signal 	dataout : std_logic_vector(27 downto 0);
signal	dataval : std_logic;

BEGIN

	uut : top PORT MAP(
	rst => rst,
	clk => clk,
	data_in => data_in,
	enable => enable,
	dataout => dataout,
	dataval => dataval);

	p_clk : process
	begin 
            wait for 10 ns;
	    clk <= not clk;
        end process p_clk;

	p_rst : process
	begin 
	   rst <= '0';
           wait for 100 ns;
           rst <= '1';
           wait for 600 us;
    end process p_rst;

	stim_procces : process
        begin
           enable <= '0';
           --data_in <= (others => '0');

           wait for 30 us;
           for i in 0 to 3 loop
		if unsigned(data_in) > 30 then
			data_in <= (others=>'0');
		end if; 
              wait until clk='1' and clk'event;
	      data_in <= std_logic_vector(unsigned(data_in)+1);
	      enable <= '1';
           end loop;
           wait until clk='0' and clk'event;
	end process;
END behavior;
		
