-- inputs:  clk reset switch key 
-- outputs: display
--if switch is pressed, toggle between exposure time and number of photos -- need debouncing circuit
--key is 3 bit word containing exposure time

-- signal is closer to reg?
-- variable is closer to wire?

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CAMERA_SM is
port (i_clk : in std_logic;
	  i_rst_n : in std_logic;
	  i_switch : in std_logic;
	  i_key : in std_logic_vector(2 downto 0);
	  o_data : out std_logic_vector(2 downto 0);
	  i_photo_taken : in std_logic
	); end entity CAMERA_SM;


architecture RTL of CAMERA_SM is

signal photo_cnt : std_logic_vector(2 downto 0) := '000';
signal debounce_cnt : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(0, debounce_cnt'length);
signal hold : std_logic := '0';
type t_SM is (zero, one, two, three);
signal SM : t_SM := zero;

begin
p_SM : process(i_clk) is
begin
if rising_edge(i_clk)then
if i_rst_n = '0' then
	--reset values here
else
case SM is
when zero =>
if i_switch = '0' then
	SM <= one;
	o_data <= i_key;
	hold <= '0';
else
	SM <= zero;
	o_data <= photo_cnt;
	hold <= '1';
end if;

when one => 
if debounce_cnt = std_logic_vector(to_unsigned(50000000, debounce_cnt'length)) then
debounce_cnt <= std_logic_vector(to_unsigned(0, debounce_cnt'length));
if hold = '0'
SM <= two;
else SM <= zero;
end if;
else debounce_cnt <= debounce_cnt + '1';
SM <= one;
end if;

when two =>
if i_switch = '0'
SM <= one;
o_data <= photo_cnt;
hold <= '1';
else 
SM <= two;
o_data <= i_key;
hold <= '0';
end if;
end case;
end if;
end if;
end process p_SM;

p_photo_counter : process(i_clk) is
begin
if rising_edge(i_clk)then
if i_rst_n = '0' then
	--reset values here
else
if i_photo_taken = '1' then
	photo_cnt <= photo_cnt + '1';
else phto_cnt <= photo_cnt;
end if;
end if;
end if;
end process p_photo_counter;

end RTL;