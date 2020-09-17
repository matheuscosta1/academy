library ieee ;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity contador is

generic (n: natural := 253 );
port (	
	clock:	in std_logic;
	clear:	in std_logic;
	count:	in std_logic;
	Q:	out std_logic_vector(n-1 downto 0)
     );
end contador;

architecture arq_contador of contador is		 	  
	
    signal Q_ant: std_logic_vector(n-1 downto 0);

begin

    process(clock, count, clear)
    begin
	if clear = '1' then
 	    Q_ant <= Q_ant - Q_ant;
	elsif (clock ='1' and clock'event) then
	    if count = '1' then
		Q_ant <= Q_ant + 1;
	    end if;
	end if;
    end process;	
	
    Q <= Q_ant;

end arq_contador;
