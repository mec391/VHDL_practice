library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity TB_DISP_MUX is
end TB_DISP_MUX;


architecture behave of TB_DISP_MUX is
constant c_CLOCK_PERIOD: time := 40 ns;

	signal i_A : std_logic := '0';
	signal i_B : std_logic := '0';
	signal i_sel : std_logic := '0';
    signal o_out: std_logic;
    signal o_out_sync : std_logic;
    signal i_clk : std_logic := '0';

component DISP_MUX is
	port (	  
		i_A : in std_logic;
		i_B : in std_logic;
	  i_sel: in std_logic;
	  o_out: out std_logic;
	  o_out_sync: out std_logic;
	  i_clk: in std_logic);
	end component DISP_MUX;

begin
DUT : DISP_MUX
port map (
i_A => i_A,
i_B => i_B,
i_sel => i_sel,
o_out => o_out,
o_out_sync => o_out_sync,
i_clk => i_clk);

p_CLK_GEN : process is
begin
	wait for c_CLOCK_PERIOD/2;
	i_clk <= not i_clk;
end process p_CLK_GEN;

process
begin
i_A <= '1';
i_B <= '0';
i_sel <= '1';
wait for 200 ns;
i_sel <= '0';
wait for 200 ns;
end process;
end behave;
