Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity top is

generic ( width_word_dpram : integer := 12;
	  nb_word_dpram : integer := 31;
	  nb_addr_dpram : integer := 5;
	  width_word_rom : integer :=11 ;
	  nb_word_rom : integer :=16 ;
	  nb_addr_rom : integer :=4;
	  width_total :integer:=23 ;
	  width_end : integer :=28);

PORT ( 	rst : in std_logic;
	clk : in std_logic;
	data_in : in std_logic_vector(width_word_dpram-1 downto 0);
	enable : in std_logic;
	dataout : out std_logic_vector (27 downto 0);
	dataval : out std_logic);
end entity;

architecture behavioral of top is

signal e1,e2,e3,e4,e5,out6 : std_logic;
signal add,add1 : std_logic_vector(nb_addr_dpram-1 downto 0);
signal add2 : std_logic_vector(nb_addr_rom-1 downto 0);
signal out1,out2,q2 : std_logic_vector(width_word_dpram-1 downto 0);
signal out3,q3 : std_logic_vector(width_word_rom-1 downto 0);
signal q4,out4 : std_logic_vector(width_total-1 downto 0);
signal out5 : std_logic_vector(width_end-1 downto 0);



component sequencer is
port (
	clk : in std_logic;
	rst : in std_logic;
	adresse_PRAM_ecriture  : out std_logic_vector(nb_addr_dpram-1 downto 0);
	adresse_PRAM_lecture  : out std_logic_vector(nb_addr_dpram-1 downto 0);
	adresse_ROM  : out std_logic_vector(nb_addr_rom-1 downto 0);
	enable_ecriture : out std_logic;
	enable_lecture : out std_logic;
	enable_ROM : out std_logic;
	enable_Mul : out std_logic;
	enable_Accu : out std_logic;
	data_val : out std_logic;
	enable : in std_logic);
end component;

component DPRAM is
port (
	clk : in std_logic;
	rst : in std_logic;
	adresse_a  : in std_logic_vector(nb_addr_dpram-1 downto 0);
	adresse_b  : in std_logic_vector(nb_addr_dpram-1 downto 0);
	datain_b  : in std_logic_vector(width_word_dpram-1 downto 0);
	datain_a  : in std_logic_vector(width_word_dpram-1 downto 0);
	dataout_a  : out std_logic_vector(width_word_dpram-1 downto 0);
	dataout_b  : out std_logic_vector(width_word_dpram-1 downto 0);
	enable_a : in std_logic;
	enable_b : in std_logic);
end component;

component ROM is
port (
	clk : in std_logic;
	rst : in std_logic;
	adresse_c  : in std_logic_vector(nb_addr_rom-1 downto 0);
	dataout_c  : out std_logic_vector(width_word_rom-1 downto 0);
	enable_c : in std_logic);
end component;

component Mul is
port (
	clk : in std_logic;
	rst : in std_logic;
	datain_dpram  : in std_logic_vector(width_word_dpram-1 downto 0);
	datain_rom  : in std_logic_vector(width_word_rom-1 downto 0);
	en_mul : in std_logic;
	dataout_mul  : out std_logic_vector(width_total-1 downto 0));
end component;

component Accu is
port (
	clk : in std_logic;
	rst : in std_logic;
	datain_acc  : in std_logic_vector(width_total-1 downto 0);
	dataout  : out std_logic_vector(width_end-1 downto 0);
	en_in : in std_logic);
end component;

component Bascule_D1 is 

port (
	clk : in std_logic;
	rst : in std_logic;
	data  : in std_logic;
	q  : out std_logic);

end component;

component Bascule_D_11 is 

port (
	clk : in std_logic;
	rst : in std_logic;
	data  : in std_logic_vector(10 downto 0);
	q  : out std_logic_vector(10 downto 0));

end component;

component Bascule_D_12 is 

port (
	clk : in std_logic;
	rst : in std_logic;
	data  : in std_logic_vector(11 downto 0);
	q  : out std_logic_vector(11 downto 0));

end component;

component Bascule_D_23 is 

port (
	clk : in std_logic;
	rst : in std_logic;
	data  : in std_logic_vector(22 downto 0);
	q  : out std_logic_vector(22 downto 0));

end component;

component Bascule_D_28 is 

port (
	clk : in std_logic;
	rst : in std_logic;
	data  : in std_logic_vector(27 downto 0);
	q  : out std_logic_vector(27 downto 0));

end component;

begin
uut1: sequencer port map (rst=>rst,clk=>clk,enable=>enable,adresse_PRAM_ecriture=>add,adresse_PRAM_lecture=>add1,adresse_ROM=>add2,
enable_ecriture=>e1,enable_lecture=>e2,enable_ROM=>e3,enable_Mul=>e4,enable_Accu=>e5,data_val=>out6);
uut2: DPRAM port map (rst=>rst,clk=>clk,adresse_a=>add,adresse_b=>add1 ,datain_b=>data_in,datain_a=>data_in,dataout_a=>out1 ,dataout_b=>out2 ,enable_a=>e1,enable_b=>e2);
uut3: ROM port map (rst=>rst,clk=>clk,adresse_c=>add2,dataout_c=>out3 ,enable_c=>e3);
uut4: Bascule_D_11 port map (rst=>rst,clk=>clk,data=>out3 ,q=>q3 );
uut5: Bascule_D_12 port map (rst=>rst,clk=>clk,data=>out2 ,q=>q2 );
uut6: Mul port map (rst=>rst,clk=>clk,datain_dpram=>q2 ,datain_rom=>q3 ,en_mul=> e4,dataout_mul=>out4 );
uut7: Bascule_D_23 port map (rst=>rst,clk=>clk,data=> 	out4 ,q=>q4 );
uut8: Accu port map (rst=>rst,clk=>clk,datain_acc=>q4 ,dataout=>out5 ,en_in=>e5);
uut9: Bascule_D_28 port map (rst=>rst,clk=>clk,data=>out5 ,q=>dataout );
uut10: Bascule_D1 port map (rst=>rst,clk=>clk,data=>out6 ,q=>dataval ); 

end behavioral;
