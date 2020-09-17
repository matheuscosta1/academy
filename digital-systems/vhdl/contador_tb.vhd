library ieee;
use ieee.std_logic_1164.all;			 
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity contador_tb is		
end contador_tb;

architecture arq_tb of contador_tb is

    component contador
    port 
	(   
	    clock:	in std_logic;
	    clear:	in std_logic;
	    count:	in std_logic;
	    Q:		out std_logic_vector(253 downto 0)
	);
    end component;

    signal T_clock:     std_logic;
    signal T_clear:     std_logic;
    signal T_count:     std_logic;
    signal T_Q:         std_logic_vector(253 downto 0);

begin
    
    U_counter: counter port map (T_clock, T_clear, T_count, T_Q);
	
    process				 
    begin
	T_clock <= '0';	
	wait for 5 ns;
	T_clock <= '1';
	wait for 5 ns;
    end process;
	
    process

	variable err_cnt: integer := 0;

    begin		

									
	T_clear <= '1';			
	T_count <= '1';
	wait for 20 ns;	
		
	T_clear <= '0';			
		
	-- test case 1
	wait for 10 ns;
	assert (T_Q=1) report "Failed case 1" severity error;
	if (T_Q/=1) then
	    err_cnt := err_cnt+1;
	end if;
			
	-- test case 2
	wait for 10 ns;
	assert (T_Q=2) report "Failed case 2" severity error;	
	if (T_Q/=2) then
	    err_cnt := err_cnt+1;
	end if;
			
	-- test case 3
	wait for 10 ns;
	assert (T_Q=3) report "Failed case 3" severity error;
	if (T_Q/=3) then
	    err_cnt := err_cnt+1;
	end if;
	
	-- test case 4
	wait for 10 ns;
	assert (T_Q=4) report "Failed case 4" severity error;
	if (T_Q/=4) then
	    err_cnt := err_cnt+1;
	end if;
			
	-- test case 5
	wait for 10 ns;
	assert (T_Q=5) report "Failed case 5" severity error;
	if (T_Q/=5) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 6
	wait for 10 ns;
	assert (T_Q=6) report "Failed case 6" severity error;
	if (T_Q/=6) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 7
	wait for 10 ns;
	assert (T_Q=7) report "Failed case 7" severity error;
	if (T_Q/=7) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 8
	wait for 10 ns;
	assert (T_Q=8) report "Failed case 8" severity error;
	if (T_Q/=8) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 9
	wait for 10 ns;
	assert (T_Q=9) report "Failed case 9" severity error;
	if (T_Q/=9) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 10
	wait for 10 ns;
	assert (T_Q=10) report "Failed case " severity error;
	if (T_Q/=10) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 11
	wait for 10 ns;
	assert (T_Q=11) report "Failed case 11" severity error;
	if (T_Q/=11) then
	    err_cnt := err_cnt+1;
	end if;


	-- test case 12
	wait for 10 ns;
	assert (T_Q=12) report "Failed case 12" severity error;
	if (T_Q/=12) then
	    err_cnt := err_cnt+1;
	end if;


	-- test case 13
	wait for 10 ns;
	assert (T_Q=13) report "Failed case 13" severity error;
	if (T_Q/=13) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 14
	wait for 10 ns;
	assert (T_Q=14) report "Failed case 14" severity error;
	if (T_Q/=14) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 15
	wait for 10 ns;
	assert (T_Q=15) report "Failed case 15" severity error;
	if (T_Q/=15) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 16
	wait for 10 ns;
	assert (T_Q=16) report "Failed case 16" severity error;
	if (T_Q/=16) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 17
	wait for 10 ns;
	assert (T_Q=17) report "Failed case 17" severity error;
	if (T_Q/=17) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 18
	wait for 10 ns;
	assert (T_Q=18) report "Failed case 18" severity error;
	if (T_Q/=18) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 19
	wait for 10 ns;
	assert (T_Q=19) report "Failed case 19" severity error;
	if (T_Q/=19) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 20
	wait for 10 ns;
	assert (T_Q=20) report "Failed case 20" severity error;
	if (T_Q/2) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 21
	wait for 10 ns;
	assert (T_Q=21) report "Failed case 21" severity error;
	if (T_Q/=21) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 22
	wait for 10 ns;
	assert (T_Q=22) report "Failed case 22" severity error;
	if (T_Q/=22) then
	    err_cnt := err_cnt+1;
	end if;
	-- test case 23
	wait for 10 ns;
	assert (T_Q=23) report "Failed case 23" severity error;
	if (T_Q/=23) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 24
	wait for 10 ns;
	assert (T_Q=24) report "Failed case 24" severity error;
	if (T_Q/=24) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 25
	wait for 10 ns;
	assert (T_Q=25) report "Failed case 25" severity error;
	if (T_Q/=25) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 26
	wait for 10 ns;
	assert (T_Q=26) report "Failed case 26" severity error;
	if (T_Q/=26) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 27
	wait for 10 ns;
	assert (T_Q=27) report "Failed case 27" severity error;
	if (T_Q/=27) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 28
	wait for 10 ns;
	assert (T_Q=28) report "Failed case 28" severity error;
	if (T_Q/=28) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 29
	wait for 10 ns;
	assert (T_Q=29) report "Failed case 29" severity error;
	if (T_Q/=29) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 30
	wait for 10 ns;
	assert (T_Q=30) report "Failed case 30" severity error;
	if (T_Q/=26) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 31
	wait for 10 ns;
	assert (T_Q=31) report "Failed case 31" severity error;
	if (T_Q/=31) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 32
	wait for 10 ns;
	assert (T_Q=32) report "Failed case 32" severity error;
	if (T_Q/=32) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 33
	wait for 10 ns;
	assert (T_Q=33) report "Failed case 33" severity error;
	if (T_Q/=33) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 34
	wait for 10 ns;
	assert (T_Q=34) report "Failed case 34" severity error;
	if (T_Q/=34) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 35
	wait for 10 ns;
	assert (T_Q=35) report "Failed case 35" severity error;
	if (T_Q/=35) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 36
	wait for 10 ns;
	assert (T_Q=36) report "Failed case 36" severity error;
	if (T_Q/=36) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 37
	wait for 10 ns;
	assert (T_Q=37) report "Failed case 37" severity error;
	if (T_Q/=37) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 38
	wait for 10 ns;
	assert (T_Q=38) report "Failed case 38" severity error;
	if (T_Q/=38) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 39
	wait for 10 ns;
	assert (T_Q=39) report "Failed case 39" severity error;
	if (T_Q/=39) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 40
	wait for 10 ns;
	assert (T_Q=40) report "Failed case 40" severity error;
	if (T_Q/=40) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 41
	wait for 10 ns;
	assert (T_Q=41) report "Failed case 41" severity error;
	if (T_Q/=41) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 42
	wait for 10 ns;
	assert (T_Q=42) report "Failed case 42" severity error;
	if (T_Q/=42) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 43
	wait for 10 ns;
	assert (T_Q=43) report "Failed case 43" severity error;
	if (T_Q/=43) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 44
	wait for 10 ns;
	assert (T_Q=44) report "Failed case 44" severity error;
	if (T_Q/=44) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 45
	wait for 10 ns;
	assert (T_Q=45) report "Failed case 45" severity error;
	if (T_Q/=45) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 46
	wait for 10 ns;
	assert (T_Q=46) report "Failed case 46" severity error;
	if (T_Q/=46) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 47
	wait for 10 ns;
	assert (T_Q=47) report "Failed case 47" severity error;
	if (T_Q/=47) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 48
	wait for 10 ns;
	assert (T_Q=48) report "Failed case 48" severity error;
	if (T_Q/=48) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 49
	wait for 10 ns;
	assert (T_Q=49) report "Failed case 49" severity error;
	if (T_Q/=49) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 50
	wait for 10 ns;
	assert (T_Q=50) report "Failed case 50" severity error;
	if (T_Q/=50) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 51
	wait for 10 ns;
	assert (T_Q=51) report "Failed case 51" severity error;
	if (T_Q/=51) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 52
	wait for 10 ns;
	assert (T_Q=52) report "Failed case 52" severity error;
	if (T_Q/=52) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 53
	wait for 10 ns;
	assert (T_Q=53) report "Failed case 53" severity error;
	if (T_Q/=53) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 54
	wait for 10 ns;
	assert (T_Q=54) report "Failed case 54" severity error;
	if (T_Q/=54) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 55
	wait for 10 ns;
	assert (T_Q=55) report "Failed case 55" severity error;
	if (T_Q/=55) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 56
	wait for 10 ns;
	assert (T_Q=56) report "Failed case 56" severity error;
	if (T_Q/=56) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 57
	wait for 10 ns;
	assert (T_Q=57) report "Failed case 57" severity error;
	if (T_Q/=57) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 58
	wait for 10 ns;
	assert (T_Q=58) report "Failed case 58" severity error;
	if (T_Q/=58) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 59
	wait for 10 ns;
	assert (T_Q=59) report "Failed case 59" severity error;
	if (T_Q/=59) then
	    err_cnt := err_cnt+1;
	end if;	

	-- test case 60
	wait for 10 ns;
	assert (T_Q=60) report "Failed case 60" severity error;
	if (T_Q/=60) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 61
	wait for 10 ns;
	assert (T_Q=61) report "Failed case 61" severity error;
	if (T_Q/=61) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 62
	wait for 10 ns;
	assert (T_Q=62) report "Failed case 62" severity error;
	if (T_Q/=62) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 63
	wait for 10 ns;
	assert (T_Q=63) report "Failed case 63" severity error;
	if (T_Q/=63) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 64
	wait for 10 ns;
	assert (T_Q=64) report "Failed case 64" severity error;
	if (T_Q/=64) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 65
	wait for 10 ns;
	assert (T_Q=65) report "Failed case 65" severity error;
	if (T_Q/=65) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 66
	wait for 10 ns;
	assert (T_Q=66) report "Failed case 66" severity error;
	if (T_Q/=66) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 67
	wait for 10 ns;
	assert (T_Q=67) report "Failed case 67" severity error;
	if (T_Q/=67) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 68
	wait for 10 ns;
	assert (T_Q=68) report "Failed case 68" severity error;
	if (T_Q/=68) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 69
	wait for 10 ns;
	assert (T_Q=69) report "Failed case 69" severity error;
	if (T_Q/=69) then
	    err_cnt := err_cnt+1;
	end if;		

	-- test case 70
	wait for 10 ns;
	assert (T_Q=70) report "Failed case 70" severity error;
	if (T_Q/=70) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 71
	wait for 10 ns;
	assert (T_Q=71) report "Failed case 71" severity error;
	if (T_Q/=71) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 72
	wait for 10 ns;
	assert (T_Q=72) report "Failed case 72" severity error;
	if (T_Q/=72) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 73
	wait for 10 ns;
	assert (T_Q=73) report "Failed case 73" severity error;
	if (T_Q/=73) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 74
	wait for 10 ns;
	assert (T_Q=74) report "Failed case 74" severity error;
	if (T_Q/=74) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 75
	wait for 10 ns;
	assert (T_Q=75) report "Failed case 75" severity error;
	if (T_Q/=75) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 76
	wait for 10 ns;
	assert (T_Q=76) report "Failed case 76" severity error;
	if (T_Q/=76) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 77
	wait for 10 ns;
	assert (T_Q=77) report "Failed case 77" severity error;
	if (T_Q/=77) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 78
	wait for 10 ns;
	assert (T_Q=78) report "Failed case 78" severity error;
	if (T_Q/=78) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 79
	wait for 10 ns;
	assert (T_Q=79) report "Failed case 79" severity error;
	if (T_Q/=79) then
	    err_cnt := err_cnt+1;
	end if;		
	
	-- test case 80
	wait for 10 ns;
	assert (T_Q=80) report "Failed case 80" severity error;
	if (T_Q/=80) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 81
	wait for 10 ns;
	assert (T_Q=81) report "Failed case 81" severity error;
	if (T_Q/=81) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 82
	wait for 10 ns;
	assert (T_Q=82) report "Failed case 82" severity error;
	if (T_Q/=82) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 83
	wait for 10 ns;
	assert (T_Q=83) report "Failed case 83" severity error;
	if (T_Q/=83) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 84
	wait for 10 ns;
	assert (T_Q=84) report "Failed case 84" severity error;
	if (T_Q/=84) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 85
	wait for 10 ns;
	assert (T_Q=85) report "Failed case 85" severity error;
	if (T_Q/=85) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 86
	wait for 10 ns;
	assert (T_Q=86) report "Failed case 86" severity error;
	if (T_Q/=86) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 87
	wait for 10 ns;
	assert (T_Q=87) report "Failed case 87" severity error;
	if (T_Q/=87) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 88
	wait for 10 ns;
	assert (T_Q=88) report "Failed case 88" severity error;
	if (T_Q/=88) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 89
	wait for 10 ns;
	assert (T_Q=89) report "Failed case 89" severity error;
	if (T_Q/=89) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 90
	wait for 10 ns;
	assert (T_Q=90) report "Failed case 90" severity error;
	if (T_Q/=90) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 91
	wait for 10 ns;
	assert (T_Q=91) report "Failed case 91" severity error;
	if (T_Q/=91) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 92
	wait for 10 ns;
	assert (T_Q=92) report "Failed case 92" severity error;
	if (T_Q/=92) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 93
	wait for 10 ns;
	assert (T_Q=93) report "Failed case 93" severity error;
	if (T_Q/=93) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 94
	wait for 10 ns;
	assert (T_Q=94) report "Failed case 94" severity error;
	if (T_Q/=94) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 95
	wait for 10 ns;
	assert (T_Q=95) report "Failed case 95" severity error;
	if (T_Q/=95) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 96
	wait for 10 ns;
	assert (T_Q=96) report "Failed case 96" severity error;
	if (T_Q/=96) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 97
	wait for 10 ns;
	assert (T_Q=97) report "Failed case 97" severity error;
	if (T_Q/=97) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 98
	wait for 10 ns;
	assert (T_Q=98) report "Failed case 98" severity error;
	if (T_Q/=98) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 99
	wait for 10 ns;
	assert (T_Q=99) report "Failed case 99" severity error;
	if (T_Q/=99) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 100
	wait for 10 ns;
	assert (T_Q=100) report "Failed case 100" severity error;
	if (T_Q/=100) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 101
	wait for 10 ns;
	assert (T_Q=101) report "Failed case 101" severity error;
	if (T_Q/=101) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 102
	wait for 10 ns;
	assert (T_Q=102) report "Failed case 102" severity error;
	if (T_Q/=102) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 103
	wait for 10 ns;
	assert (T_Q=103) report "Failed case 103" severity error;
	if (T_Q/=103) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 104
	wait for 10 ns;
	assert (T_Q=104) report "Failed case 104" severity error;
	if (T_Q/=104) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 105
	wait for 10 ns;
	assert (T_Q=105) report "Failed case 105" severity error;
	if (T_Q/=105) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 106
	wait for 10 ns;
	assert (T_Q=106) report "Failed case 106" severity error;
	if (T_Q/=106) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 107
	wait for 10 ns;
	assert (T_Q=107) report "Failed case 107" severity error;
	if (T_Q/=107) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 108
	wait for 10 ns;
	assert (T_Q=108) report "Failed case 108" severity error;
	if (T_Q/=108) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 109
	wait for 10 ns;
	assert (T_Q=109) report "Failed case 109" severity error;
	if (T_Q/=109) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 110
	wait for 10 ns;
	assert (T_Q=110) report "Failed case 110" severity error;
	if (T_Q/=110) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 111
	wait for 10 ns;
	assert (T_Q=111) report "Failed case 100" severity error;
	if (T_Q/=111) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 112
	wait for 10 ns;
	assert (T_Q=112) report "Failed case 112" severity error;
	if (T_Q/=112) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 113
	wait for 10 ns;
	assert (T_Q=113) report "Failed case 113" severity error;
	if (T_Q/=113) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 114
	wait for 10 ns;
	assert (T_Q=114) report "Failed case 114" severity error;
	if (T_Q/=114) then
	    err_cnt := err_cnt+1;
	end if;

	-- test case 115
	wait for 10 ns;
	assert (T_Q=115) report "Failed case 115" severity error;
	if (T_Q/=115) then
	    err_cnt := err_cnt+1;
	end if;
	
       	-- summary of all the tests
	if (err_cnt=0) then 			
	    assert false 
	    report "Testbench of Adder completed successfully!" 
	    severity note; 
	else 
	    assert true 
	    report "Something wrong, try again" 
	    severity error; 
	end if; 
		
	wait;
		
    end process;

end arq_tb;

configuration CFG_TB of counter_TB is
	for TB
	end for;
end CFG_TB;
