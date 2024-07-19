library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity obuft_out_array is
  generic (
    I_ARRAY_LENGTH  : integer := 32;
    EN_ARRAY_LENGTH : integer := 8
    );
  port
    (
      i_a  : in    std_logic_vector(I_ARRAY_LENGTH-1 downto 0);
      en_a : in    std_logic_vector(EN_ARRAY_LENGTH-1 downto 0);
      o_a  : out  std_logic_vector(I_ARRAY_LENGTH-1 downto 0)
);
end obuft_out_array;

architecture arch_obuft_out_array of obuft_out_array is
  component obuft_out is
    port (
       i  : in    std_logic;
       en : in    std_logic;
       o  : out  std_logic
      );
  end component;
  signal tile_en_i: integer := TOTAL_CHANNELS/TOTAL_TILES;      
begin
  obuft_array_gen : for I in 0 to I_ARRAY_LENGTH-1 generate
    obuft_out_inst : component obuft_out
      port map(
      i  =>i_a(I),
      en =>en_a(I/tile_en_i),
      o  =>o_a(I)
      );
    end generate;
end arch_obuft_out_array; 
