library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DISP_MUX is
port (i_A : in std_logic;
	  i_B : in std_logic;
	  i_sel: in std_logic;
	  o_out: out std_logic;
	  o_out_sync: out std_logic;
	  i_clk: in std_logic
	); end DISP_MUX;

architecture RTL of DISP_MUX is
begin
p_async: process(i_A, i_B, i_sel) is
begin
if(i_sel = '1') then
	o_out <= i_A;
else
o_out <= i_B;
end if;
end process p_async;

p_sync: process(i_clk) is
begin
	if rising_edge(i_clk) then
	if(i_sel = '1') then
		o_out_sync <= i_A;
		else
		o_out_sync <= i_B;
	end if;
	end if;
end process p_sync;

end RTL;