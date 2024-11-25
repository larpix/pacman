library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package uart_types_pkg is  
  type t_uart_array_1 is array(natural range <>) of std_logic;
  type t_uart_array_2 is array(natural range <>) of std_logic_vector(1 downto 0);
  type t_uart_array_3 is array(natural range <>) of std_logic_vector(2 downto 0);
  type t_uart_array_4 is array(natural range <>) of std_logic_vector(3 downto 0);
    type t_uart_array_8 is array(natural range <>) of std_logic_vector(7 downto 0);
   type t_uart_array_9 is array(natural range <>) of std_logic_vector(8 downto 0);
  type t_uart_array_16 is array(natural range <>) of std_logic_vector(15 downto 0);
  type t_uart_array_32 is array(natural range <>) of std_logic_vector(31 downto 0);
  type t_uart_array_128 is array(natural range <>) of std_logic_vector(127 downto 0);
  type t_uart_array_64 is array(natural range <>) of std_logic_vector(63 downto 0);
              
end package;
