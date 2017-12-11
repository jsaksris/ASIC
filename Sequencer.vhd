Library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

entity Sequencer is 
generic ( width_word : integer := 12;
	  nb_word : integer := 31;
	  nb_addr_pram : integer := 5;
	  nb_addr_rom : integer := 4);

port (
	clk : in std_logic;
	rst : in std_logic;

	adresse_PRAM_ecriture  : out std_logic_vector(nb_addr_pram-1 downto 0);
	adresse_PRAM_lecture  : out std_logic_vector(nb_addr_pram-1 downto 0);
	adresse_ROM  : out std_logic_vector(nb_addr_rom-1 downto 0);

	enable_ecriture : out std_logic;
	enable_lecture : out std_logic;
	enable_ROM : out std_logic;
	enable_Mul : out std_logic;
	enable_Accu : out std_logic;

	data_val : out std_logic;

	enable : in std_logic);
	
end Sequencer;

architecture archi_Sequencer of Sequencer is
type etat is (reset,attente,etat_write,wait_write,calcul);
signal etatp,etatf : etat;
signal enable_ecriture_save : std_logic;
signal  i : std_logic_vector(4 downto 0);
signal  k : std_logic_vector(4 downto 0);
signal  l : std_logic_vector(3 downto 0);
signal up : std_logic := '1';
--signal i_save, k_save : integer range 0 to 31;
--signal l_save : integer range 0 to 16;
--signal mem_ecriture_save : std_logic :='0';

-- h address
-- x address



begin

	BlocM : process(rst,clk)
	begin
		if rst = '0' then
			etatp <= reset;
			enable_ecriture_save <= '0';
			--mem_ecriture_save <= '0'; 
		elsif clk'event and clk = '1' then
			etatp <= etatf;
			enable_ecriture_save <= enable;
			--i <= i_save;
			--l <= l_save;
			--k <= k_save;
		end if;
	end process;

	BlocF : process(etatp,etatf,enable,enable_ecriture_save,i,k)
	begin
		case etatp is 
			when reset => etatf <= attente;

			when attente =>
				if enable = '1' and enable_ecriture_save = '0' then
					etatf <= etat_write;
				else 
					etatf <= attente;
				end if;

			when etat_write =>
				if enable  = '0' and enable_ecriture_save = '1' then
					etatf <= calcul;
				elsif (i < 30) then
					etatf <= etat_write;
				else
					etatf <= wait_write;
				end if;

			when wait_write =>
				
				if enable  = '0' and enable_ecriture_save = '1' then
					etatf <= calcul;
				else
					etatf <= wait_write;
				end if;

			when calcul =>
				
				if enable  = '1' and enable_ecriture_save = '0' then
					etatf <= etat_write;
				elsif k < 30 then 
					etatf <= calcul;
				else
					etatf <= attente;
				end if;
			when others => etatf <= reset;
		end case;
	end process;

	BlocG : process(etatp,clk)
	begin
	if (clk'event and clk = '1') then
		case etatp is
			when reset =>
				enable_ecriture <= '0';
				enable_lecture <= '0';
				enable_ROM <= '0';
				enable_Mul <= '0';
				enable_Accu <= '0';
				adresse_PRAM_ecriture <= (others => '0');
				adresse_PRAM_lecture <= (others => '0');
				adresse_ROM <= (others => '0');
				data_val <= '0';


			when attente =>
				k <= (others=>'0');
				i <= (others=>'0');
				l <= (others=>'0');
				enable_ecriture <= '0';
				enable_lecture <= '0';
				enable_ROM <= '0';
				enable_Mul <= '0';
				enable_Accu <= '0';
				adresse_PRAM_ecriture <= (others => '0');
				adresse_PRAM_lecture <= (others => '0');
				adresse_ROM <= (others => '0');

			when etat_write =>
				enable_ecriture <= '1';
				enable_lecture <= '0';
				enable_ROM <= '0';
				enable_Mul <= '0';
				enable_Accu <= '0';
				adresse_PRAM_ecriture <= std_logic_vector(i);
				adresse_PRAM_lecture <= (others => '0');
				adresse_ROM <= (others => '0');
				i <= std_logic_vector(unsigned(i)+ 1);
				data_val <= '0';
				--mem_ecriture_save <= enable_ecriture_save;

			when wait_write =>
				enable_ecriture <= '0';
				enable_lecture <= '0';
				enable_ROM <= '0';
				enable_Mul <= '0';
				enable_Accu <= '0';
				adresse_PRAM_ecriture <= (others => '0');
				adresse_PRAM_lecture <= (others => '0');
				adresse_ROM <= (others => '0');
				i <= (others => '0');
				data_val <= '0';

			when calcul =>
				enable_ecriture <= '0';
				enable_lecture <= '0';
				enable_ROM <= '1';
				enable_Mul <= '1';
				enable_Accu <= '1';
				k <= std_logic_vector(unsigned(k) + 1);
				adresse_PRAM_lecture <= std_logic_vector(k);
				adresse_ROM <= std_logic_vector(l);
				if (unsigned(l) = 15 and up = '1') then
						up <= '0';
						l <= std_logic_vector(unsigned(l) - 1);
				elsif (unsigned(l) = 0 and up = '0') then
						up <= '1';
				elsif (up = '1') then
						l <= std_logic_vector(unsigned(l) + 1);
				else 
						l <= std_logic_vector(unsigned(l) - 1);
				end if;
				
				if (unsigned(k) = 30) then
					data_val <= '1';
					k <= (others=>'0');
				else data_val <= '0';
				end if;
			when others =>
				enable_ecriture <= '0';
				enable_lecture <= '0';
				enable_ROM <= '0';
				enable_Mul <= '0';
				enable_Accu <= '0';
				data_val <= '0';
				adresse_PRAM_ecriture <= (others => '0');
				adresse_PRAM_lecture <= (others => '0');
				adresse_ROM <= (others => '0');

		end case;
	end if;
	end process;


end archi_Sequencer;
