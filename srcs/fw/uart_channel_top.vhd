
library IEEE; 
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use work.uart_types_pkg.all;

entity uart_channel_top is
  generic(
    TOTAL_CHANNELS : integer := 32;
    TOTAL_TILES    : integer := 8
    );
   port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    MCLK : in STD_LOGIC;
    MRST : in STD_LOGIC;

--MAXIS interface
	 M_AXIS0_tkeep  : out std_logic_vector(15 downto 0);
	 M_AXIS0_tstrb  : out std_logic_vector(15 downto 0);
	 M_AXIS0_tdata  : out std_logic_vector (127 downto 0);
	 M_AXIS0_tvalid : out std_logic;
	 M_AXIS0_tready : in std_logic;
	 M_AXIS0_tlast  : out std_logic;


	 M_AXIS1_tkeep  : out std_logic_vector(15 downto 0);
	 M_AXIS1_tstrb  : out std_logic_vector(15 downto 0);
	 M_AXIS1_tdata  : out std_logic_vector (127 downto 0);
	 M_AXIS1_tvalid : out std_logic;
	 M_AXIS1_tready : in std_logic;
	 M_AXIS1_tlast  : out std_logic;


	 M_AXIS2_tkeep  : out std_logic_vector(15 downto 0);
	 M_AXIS2_tstrb  : out std_logic_vector(15 downto 0);
	 M_AXIS2_tdata  : out std_logic_vector (127 downto 0);
	 M_AXIS2_tvalid : out std_logic;
	 M_AXIS2_tready : in std_logic;
	 M_AXIS2_tlast  : out std_logic;


	 M_AXIS3_tkeep  : out std_logic_vector(15 downto 0);
	 M_AXIS3_tstrb  : out std_logic_vector(15 downto 0);
	 M_AXIS3_tdata  : out std_logic_vector (127 downto 0);
	 M_AXIS3_tvalid : out std_logic;
	 M_AXIS3_tready : in std_logic;
	 M_AXIS3_tlast  : out std_logic;


	 M_AXIS4_tkeep  : out std_logic_vector(15 downto 0);
	 M_AXIS4_tstrb  : out std_logic_vector(15 downto 0);
	 M_AXIS4_tdata  : out std_logic_vector (127 downto 0);
	 M_AXIS4_tvalid : out std_logic;
	 M_AXIS4_tready : in std_logic;
	 M_AXIS4_tlast  : out std_logic;


	 M_AXIS5_tkeep  : out std_logic_vector(15 downto 0);
	 M_AXIS5_tstrb  : out std_logic_vector(15 downto 0);
	 M_AXIS5_tdata  : out std_logic_vector (127 downto 0);
	 M_AXIS5_tvalid : out std_logic;
	 M_AXIS5_tready : in std_logic;
	 M_AXIS5_tlast  : out std_logic;


	 M_AXIS6_tkeep  : out std_logic_vector(15 downto 0);
	 M_AXIS6_tstrb  : out std_logic_vector(15 downto 0);
	 M_AXIS6_tdata  : out std_logic_vector (127 downto 0);
	 M_AXIS6_tvalid : out std_logic;
	 M_AXIS6_tready : in std_logic;
	 M_AXIS6_tlast  : out std_logic;


	 M_AXIS7_tkeep  : out std_logic_vector(15 downto 0);
	 M_AXIS7_tstrb  : out std_logic_vector(15 downto 0);
	 M_AXIS7_tdata  : out std_logic_vector (127 downto 0);
	 M_AXIS7_tvalid : out std_logic;
	 M_AXIS7_tready : in std_logic;
	 M_AXIS7_tlast  : out std_logic;


--SAXIS interface
	 S_AXIS0_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS0_tlast : in std_logic;
	 S_AXIS0_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS0_tvalid : in std_logic;
	 S_AXIS0_tready : out std_logic;
	 S_AXIS0_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS1_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS1_tlast : in std_logic;
	 S_AXIS1_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS1_tvalid : in std_logic;
	 S_AXIS1_tready : out std_logic;
	 S_AXIS1_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS2_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS2_tlast : in std_logic;
	 S_AXIS2_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS2_tvalid : in std_logic;
	 S_AXIS2_tready : out std_logic;
	 S_AXIS2_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS3_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS3_tlast : in std_logic;
	 S_AXIS3_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS3_tvalid : in std_logic;
	 S_AXIS3_tready : out std_logic;
	 S_AXIS3_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS4_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS4_tlast : in std_logic;
	 S_AXIS4_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS4_tvalid : in std_logic;
	 S_AXIS4_tready : out std_logic;
	 S_AXIS4_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS5_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS5_tlast : in std_logic;
	 S_AXIS5_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS5_tvalid : in std_logic;
	 S_AXIS5_tready : out std_logic;
	 S_AXIS5_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS6_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS6_tlast : in std_logic;
	 S_AXIS6_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS6_tvalid : in std_logic;
	 S_AXIS6_tready : out std_logic;
	 S_AXIS6_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS7_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS7_tlast : in std_logic;
	 S_AXIS7_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS7_tvalid : in std_logic;
	 S_AXIS7_tready : out std_logic;
	 S_AXIS7_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS8_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS8_tlast : in std_logic;
	 S_AXIS8_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS8_tvalid : in std_logic;
	 S_AXIS8_tready : out std_logic;
	 S_AXIS8_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS9_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS9_tlast : in std_logic;
	 S_AXIS9_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS9_tvalid : in std_logic;
	 S_AXIS9_tready : out std_logic;
	 S_AXIS9_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS10_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS10_tlast : in std_logic;
	 S_AXIS10_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS10_tvalid : in std_logic;
	 S_AXIS10_tready : out std_logic;
	 S_AXIS10_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS11_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS11_tlast : in std_logic;
	 S_AXIS11_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS11_tvalid : in std_logic;
	 S_AXIS11_tready : out std_logic;
	 S_AXIS11_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS12_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS12_tlast : in std_logic;
	 S_AXIS12_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS12_tvalid : in std_logic;
	 S_AXIS12_tready : out std_logic;
	 S_AXIS12_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS13_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS13_tlast : in std_logic;
	 S_AXIS13_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS13_tvalid : in std_logic;
	 S_AXIS13_tready : out std_logic;
	 S_AXIS13_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS14_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS14_tlast : in std_logic;
	 S_AXIS14_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS14_tvalid : in std_logic;
	 S_AXIS14_tready : out std_logic;
	 S_AXIS14_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS15_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS15_tlast : in std_logic;
	 S_AXIS15_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS15_tvalid : in std_logic;
	 S_AXIS15_tready : out std_logic;
	 S_AXIS15_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS16_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS16_tlast : in std_logic;
	 S_AXIS16_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS16_tvalid : in std_logic;
	 S_AXIS16_tready : out std_logic;
	 S_AXIS16_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS17_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS17_tlast : in std_logic;
	 S_AXIS17_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS17_tvalid : in std_logic;
	 S_AXIS17_tready : out std_logic;
	 S_AXIS17_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS18_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS18_tlast : in std_logic;
	 S_AXIS18_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS18_tvalid : in std_logic;
	 S_AXIS18_tready : out std_logic;
	 S_AXIS18_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS19_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS19_tlast : in std_logic;
	 S_AXIS19_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS19_tvalid : in std_logic;
	 S_AXIS19_tready : out std_logic;
	 S_AXIS19_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS20_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS20_tlast : in std_logic;
	 S_AXIS20_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS20_tvalid : in std_logic;
	 S_AXIS20_tready : out std_logic;
	 S_AXIS20_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS21_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS21_tlast : in std_logic;
	 S_AXIS21_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS21_tvalid : in std_logic;
	 S_AXIS21_tready : out std_logic;
	 S_AXIS21_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS22_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS22_tlast : in std_logic;
	 S_AXIS22_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS22_tvalid : in std_logic;
	 S_AXIS22_tready : out std_logic;
	 S_AXIS22_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS23_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS23_tlast : in std_logic;
	 S_AXIS23_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS23_tvalid : in std_logic;
	 S_AXIS23_tready : out std_logic;
	 S_AXIS23_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS24_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS24_tlast : in std_logic;
	 S_AXIS24_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS24_tvalid : in std_logic;
	 S_AXIS24_tready : out std_logic;
	 S_AXIS24_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS25_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS25_tlast : in std_logic;
	 S_AXIS25_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS25_tvalid : in std_logic;
	 S_AXIS25_tready : out std_logic;
	 S_AXIS25_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS26_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS26_tlast : in std_logic;
	 S_AXIS26_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS26_tvalid : in std_logic;
	 S_AXIS26_tready : out std_logic;
	 S_AXIS26_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS27_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS27_tlast : in std_logic;
	 S_AXIS27_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS27_tvalid : in std_logic;
	 S_AXIS27_tready : out std_logic;
	 S_AXIS27_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS28_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS28_tlast : in std_logic;
	 S_AXIS28_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS28_tvalid : in std_logic;
	 S_AXIS28_tready : out std_logic;
	 S_AXIS28_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS29_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS29_tlast : in std_logic;
	 S_AXIS29_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS29_tvalid : in std_logic;
	 S_AXIS29_tready : out std_logic;
	 S_AXIS29_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS30_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS30_tlast : in std_logic;
	 S_AXIS30_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS30_tvalid : in std_logic;
	 S_AXIS30_tready : out std_logic;
	 S_AXIS30_tdata : in std_logic_vector(127 downto 0);


	 S_AXIS31_tkeep : in std_logic_vector(15 downto 0);
	 S_AXIS31_tlast : in std_logic;
	 S_AXIS31_tstrb : in std_logic_vector(15 downto 0);
	 S_AXIS31_tvalid : in std_logic;
	 S_AXIS31_tready : out std_logic;
	 S_AXIS31_tdata : in std_logic_vector(127 downto 0);


--A_AXI_LITE interface
	 S_AXI_LITE0_wready : out std_logic;
	 S_AXI_LITE0_arready : out std_logic;
	 S_AXI_LITE0_rready : in std_logic;
	 S_AXI_LITE0_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE0_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE0_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE0_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE0_awready : out std_logic;
	 S_AXI_LITE0_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE0_awvalid : in  std_logic;
	 S_AXI_LITE0_arvalid : in std_logic;
	 S_AXI_LITE0_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE0_rvalid : out std_logic;
	 S_AXI_LITE0_wvalid : in std_logic;
	 S_AXI_LITE0_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE0_bvalid : out std_logic;
	 S_AXI_LITE0_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE0_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE0_bready : in std_logic;


	 S_AXI_LITE1_wready : out std_logic;
	 S_AXI_LITE1_arready : out std_logic;
	 S_AXI_LITE1_rready : in std_logic;
	 S_AXI_LITE1_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE1_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE1_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE1_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE1_awready : out std_logic;
	 S_AXI_LITE1_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE1_awvalid : in  std_logic;
	 S_AXI_LITE1_arvalid : in std_logic;
	 S_AXI_LITE1_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE1_rvalid : out std_logic;
	 S_AXI_LITE1_wvalid : in std_logic;
	 S_AXI_LITE1_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE1_bvalid : out std_logic;
	 S_AXI_LITE1_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE1_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE1_bready : in std_logic;


	 S_AXI_LITE2_wready : out std_logic;
	 S_AXI_LITE2_arready : out std_logic;
	 S_AXI_LITE2_rready : in std_logic;
	 S_AXI_LITE2_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE2_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE2_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE2_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE2_awready : out std_logic;
	 S_AXI_LITE2_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE2_awvalid : in  std_logic;
	 S_AXI_LITE2_arvalid : in std_logic;
	 S_AXI_LITE2_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE2_rvalid : out std_logic;
	 S_AXI_LITE2_wvalid : in std_logic;
	 S_AXI_LITE2_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE2_bvalid : out std_logic;
	 S_AXI_LITE2_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE2_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE2_bready : in std_logic;


	 S_AXI_LITE3_wready : out std_logic;
	 S_AXI_LITE3_arready : out std_logic;
	 S_AXI_LITE3_rready : in std_logic;
	 S_AXI_LITE3_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE3_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE3_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE3_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE3_awready : out std_logic;
	 S_AXI_LITE3_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE3_awvalid : in  std_logic;
	 S_AXI_LITE3_arvalid : in std_logic;
	 S_AXI_LITE3_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE3_rvalid : out std_logic;
	 S_AXI_LITE3_wvalid : in std_logic;
	 S_AXI_LITE3_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE3_bvalid : out std_logic;
	 S_AXI_LITE3_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE3_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE3_bready : in std_logic;


	 S_AXI_LITE4_wready : out std_logic;
	 S_AXI_LITE4_arready : out std_logic;
	 S_AXI_LITE4_rready : in std_logic;
	 S_AXI_LITE4_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE4_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE4_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE4_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE4_awready : out std_logic;
	 S_AXI_LITE4_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE4_awvalid : in  std_logic;
	 S_AXI_LITE4_arvalid : in std_logic;
	 S_AXI_LITE4_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE4_rvalid : out std_logic;
	 S_AXI_LITE4_wvalid : in std_logic;
	 S_AXI_LITE4_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE4_bvalid : out std_logic;
	 S_AXI_LITE4_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE4_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE4_bready : in std_logic;


	 S_AXI_LITE5_wready : out std_logic;
	 S_AXI_LITE5_arready : out std_logic;
	 S_AXI_LITE5_rready : in std_logic;
	 S_AXI_LITE5_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE5_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE5_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE5_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE5_awready : out std_logic;
	 S_AXI_LITE5_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE5_awvalid : in  std_logic;
	 S_AXI_LITE5_arvalid : in std_logic;
	 S_AXI_LITE5_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE5_rvalid : out std_logic;
	 S_AXI_LITE5_wvalid : in std_logic;
	 S_AXI_LITE5_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE5_bvalid : out std_logic;
	 S_AXI_LITE5_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE5_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE5_bready : in std_logic;


	 S_AXI_LITE6_wready : out std_logic;
	 S_AXI_LITE6_arready : out std_logic;
	 S_AXI_LITE6_rready : in std_logic;
	 S_AXI_LITE6_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE6_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE6_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE6_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE6_awready : out std_logic;
	 S_AXI_LITE6_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE6_awvalid : in  std_logic;
	 S_AXI_LITE6_arvalid : in std_logic;
	 S_AXI_LITE6_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE6_rvalid : out std_logic;
	 S_AXI_LITE6_wvalid : in std_logic;
	 S_AXI_LITE6_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE6_bvalid : out std_logic;
	 S_AXI_LITE6_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE6_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE6_bready : in std_logic;


	 S_AXI_LITE7_wready : out std_logic;
	 S_AXI_LITE7_arready : out std_logic;
	 S_AXI_LITE7_rready : in std_logic;
	 S_AXI_LITE7_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE7_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE7_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE7_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE7_awready : out std_logic;
	 S_AXI_LITE7_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE7_awvalid : in  std_logic;
	 S_AXI_LITE7_arvalid : in std_logic;
	 S_AXI_LITE7_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE7_rvalid : out std_logic;
	 S_AXI_LITE7_wvalid : in std_logic;
	 S_AXI_LITE7_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE7_bvalid : out std_logic;
	 S_AXI_LITE7_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE7_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE7_bready : in std_logic;


	 S_AXI_LITE8_wready : out std_logic;
	 S_AXI_LITE8_arready : out std_logic;
	 S_AXI_LITE8_rready : in std_logic;
	 S_AXI_LITE8_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE8_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE8_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE8_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE8_awready : out std_logic;
	 S_AXI_LITE8_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE8_awvalid : in  std_logic;
	 S_AXI_LITE8_arvalid : in std_logic;
	 S_AXI_LITE8_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE8_rvalid : out std_logic;
	 S_AXI_LITE8_wvalid : in std_logic;
	 S_AXI_LITE8_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE8_bvalid : out std_logic;
	 S_AXI_LITE8_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE8_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE8_bready : in std_logic;


	 S_AXI_LITE9_wready : out std_logic;
	 S_AXI_LITE9_arready : out std_logic;
	 S_AXI_LITE9_rready : in std_logic;
	 S_AXI_LITE9_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE9_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE9_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE9_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE9_awready : out std_logic;
	 S_AXI_LITE9_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE9_awvalid : in  std_logic;
	 S_AXI_LITE9_arvalid : in std_logic;
	 S_AXI_LITE9_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE9_rvalid : out std_logic;
	 S_AXI_LITE9_wvalid : in std_logic;
	 S_AXI_LITE9_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE9_bvalid : out std_logic;
	 S_AXI_LITE9_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE9_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE9_bready : in std_logic;


	 S_AXI_LITE10_wready : out std_logic;
	 S_AXI_LITE10_arready : out std_logic;
	 S_AXI_LITE10_rready : in std_logic;
	 S_AXI_LITE10_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE10_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE10_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE10_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE10_awready : out std_logic;
	 S_AXI_LITE10_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE10_awvalid : in  std_logic;
	 S_AXI_LITE10_arvalid : in std_logic;
	 S_AXI_LITE10_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE10_rvalid : out std_logic;
	 S_AXI_LITE10_wvalid : in std_logic;
	 S_AXI_LITE10_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE10_bvalid : out std_logic;
	 S_AXI_LITE10_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE10_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE10_bready : in std_logic;


	 S_AXI_LITE11_wready : out std_logic;
	 S_AXI_LITE11_arready : out std_logic;
	 S_AXI_LITE11_rready : in std_logic;
	 S_AXI_LITE11_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE11_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE11_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE11_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE11_awready : out std_logic;
	 S_AXI_LITE11_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE11_awvalid : in  std_logic;
	 S_AXI_LITE11_arvalid : in std_logic;
	 S_AXI_LITE11_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE11_rvalid : out std_logic;
	 S_AXI_LITE11_wvalid : in std_logic;
	 S_AXI_LITE11_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE11_bvalid : out std_logic;
	 S_AXI_LITE11_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE11_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE11_bready : in std_logic;


	 S_AXI_LITE12_wready : out std_logic;
	 S_AXI_LITE12_arready : out std_logic;
	 S_AXI_LITE12_rready : in std_logic;
	 S_AXI_LITE12_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE12_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE12_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE12_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE12_awready : out std_logic;
	 S_AXI_LITE12_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE12_awvalid : in  std_logic;
	 S_AXI_LITE12_arvalid : in std_logic;
	 S_AXI_LITE12_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE12_rvalid : out std_logic;
	 S_AXI_LITE12_wvalid : in std_logic;
	 S_AXI_LITE12_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE12_bvalid : out std_logic;
	 S_AXI_LITE12_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE12_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE12_bready : in std_logic;


	 S_AXI_LITE13_wready : out std_logic;
	 S_AXI_LITE13_arready : out std_logic;
	 S_AXI_LITE13_rready : in std_logic;
	 S_AXI_LITE13_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE13_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE13_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE13_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE13_awready : out std_logic;
	 S_AXI_LITE13_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE13_awvalid : in  std_logic;
	 S_AXI_LITE13_arvalid : in std_logic;
	 S_AXI_LITE13_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE13_rvalid : out std_logic;
	 S_AXI_LITE13_wvalid : in std_logic;
	 S_AXI_LITE13_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE13_bvalid : out std_logic;
	 S_AXI_LITE13_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE13_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE13_bready : in std_logic;


	 S_AXI_LITE14_wready : out std_logic;
	 S_AXI_LITE14_arready : out std_logic;
	 S_AXI_LITE14_rready : in std_logic;
	 S_AXI_LITE14_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE14_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE14_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE14_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE14_awready : out std_logic;
	 S_AXI_LITE14_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE14_awvalid : in  std_logic;
	 S_AXI_LITE14_arvalid : in std_logic;
	 S_AXI_LITE14_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE14_rvalid : out std_logic;
	 S_AXI_LITE14_wvalid : in std_logic;
	 S_AXI_LITE14_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE14_bvalid : out std_logic;
	 S_AXI_LITE14_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE14_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE14_bready : in std_logic;


	 S_AXI_LITE15_wready : out std_logic;
	 S_AXI_LITE15_arready : out std_logic;
	 S_AXI_LITE15_rready : in std_logic;
	 S_AXI_LITE15_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE15_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE15_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE15_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE15_awready : out std_logic;
	 S_AXI_LITE15_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE15_awvalid : in  std_logic;
	 S_AXI_LITE15_arvalid : in std_logic;
	 S_AXI_LITE15_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE15_rvalid : out std_logic;
	 S_AXI_LITE15_wvalid : in std_logic;
	 S_AXI_LITE15_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE15_bvalid : out std_logic;
	 S_AXI_LITE15_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE15_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE15_bready : in std_logic;


	 S_AXI_LITE16_wready : out std_logic;
	 S_AXI_LITE16_arready : out std_logic;
	 S_AXI_LITE16_rready : in std_logic;
	 S_AXI_LITE16_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE16_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE16_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE16_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE16_awready : out std_logic;
	 S_AXI_LITE16_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE16_awvalid : in  std_logic;
	 S_AXI_LITE16_arvalid : in std_logic;
	 S_AXI_LITE16_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE16_rvalid : out std_logic;
	 S_AXI_LITE16_wvalid : in std_logic;
	 S_AXI_LITE16_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE16_bvalid : out std_logic;
	 S_AXI_LITE16_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE16_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE16_bready : in std_logic;


	 S_AXI_LITE17_wready : out std_logic;
	 S_AXI_LITE17_arready : out std_logic;
	 S_AXI_LITE17_rready : in std_logic;
	 S_AXI_LITE17_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE17_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE17_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE17_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE17_awready : out std_logic;
	 S_AXI_LITE17_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE17_awvalid : in  std_logic;
	 S_AXI_LITE17_arvalid : in std_logic;
	 S_AXI_LITE17_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE17_rvalid : out std_logic;
	 S_AXI_LITE17_wvalid : in std_logic;
	 S_AXI_LITE17_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE17_bvalid : out std_logic;
	 S_AXI_LITE17_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE17_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE17_bready : in std_logic;


	 S_AXI_LITE18_wready : out std_logic;
	 S_AXI_LITE18_arready : out std_logic;
	 S_AXI_LITE18_rready : in std_logic;
	 S_AXI_LITE18_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE18_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE18_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE18_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE18_awready : out std_logic;
	 S_AXI_LITE18_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE18_awvalid : in  std_logic;
	 S_AXI_LITE18_arvalid : in std_logic;
	 S_AXI_LITE18_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE18_rvalid : out std_logic;
	 S_AXI_LITE18_wvalid : in std_logic;
	 S_AXI_LITE18_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE18_bvalid : out std_logic;
	 S_AXI_LITE18_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE18_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE18_bready : in std_logic;


	 S_AXI_LITE19_wready : out std_logic;
	 S_AXI_LITE19_arready : out std_logic;
	 S_AXI_LITE19_rready : in std_logic;
	 S_AXI_LITE19_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE19_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE19_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE19_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE19_awready : out std_logic;
	 S_AXI_LITE19_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE19_awvalid : in  std_logic;
	 S_AXI_LITE19_arvalid : in std_logic;
	 S_AXI_LITE19_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE19_rvalid : out std_logic;
	 S_AXI_LITE19_wvalid : in std_logic;
	 S_AXI_LITE19_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE19_bvalid : out std_logic;
	 S_AXI_LITE19_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE19_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE19_bready : in std_logic;


	 S_AXI_LITE20_wready : out std_logic;
	 S_AXI_LITE20_arready : out std_logic;
	 S_AXI_LITE20_rready : in std_logic;
	 S_AXI_LITE20_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE20_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE20_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE20_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE20_awready : out std_logic;
	 S_AXI_LITE20_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE20_awvalid : in  std_logic;
	 S_AXI_LITE20_arvalid : in std_logic;
	 S_AXI_LITE20_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE20_rvalid : out std_logic;
	 S_AXI_LITE20_wvalid : in std_logic;
	 S_AXI_LITE20_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE20_bvalid : out std_logic;
	 S_AXI_LITE20_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE20_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE20_bready : in std_logic;


	 S_AXI_LITE21_wready : out std_logic;
	 S_AXI_LITE21_arready : out std_logic;
	 S_AXI_LITE21_rready : in std_logic;
	 S_AXI_LITE21_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE21_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE21_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE21_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE21_awready : out std_logic;
	 S_AXI_LITE21_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE21_awvalid : in  std_logic;
	 S_AXI_LITE21_arvalid : in std_logic;
	 S_AXI_LITE21_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE21_rvalid : out std_logic;
	 S_AXI_LITE21_wvalid : in std_logic;
	 S_AXI_LITE21_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE21_bvalid : out std_logic;
	 S_AXI_LITE21_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE21_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE21_bready : in std_logic;


	 S_AXI_LITE22_wready : out std_logic;
	 S_AXI_LITE22_arready : out std_logic;
	 S_AXI_LITE22_rready : in std_logic;
	 S_AXI_LITE22_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE22_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE22_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE22_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE22_awready : out std_logic;
	 S_AXI_LITE22_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE22_awvalid : in  std_logic;
	 S_AXI_LITE22_arvalid : in std_logic;
	 S_AXI_LITE22_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE22_rvalid : out std_logic;
	 S_AXI_LITE22_wvalid : in std_logic;
	 S_AXI_LITE22_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE22_bvalid : out std_logic;
	 S_AXI_LITE22_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE22_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE22_bready : in std_logic;


	 S_AXI_LITE23_wready : out std_logic;
	 S_AXI_LITE23_arready : out std_logic;
	 S_AXI_LITE23_rready : in std_logic;
	 S_AXI_LITE23_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE23_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE23_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE23_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE23_awready : out std_logic;
	 S_AXI_LITE23_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE23_awvalid : in  std_logic;
	 S_AXI_LITE23_arvalid : in std_logic;
	 S_AXI_LITE23_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE23_rvalid : out std_logic;
	 S_AXI_LITE23_wvalid : in std_logic;
	 S_AXI_LITE23_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE23_bvalid : out std_logic;
	 S_AXI_LITE23_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE23_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE23_bready : in std_logic;


	 S_AXI_LITE24_wready : out std_logic;
	 S_AXI_LITE24_arready : out std_logic;
	 S_AXI_LITE24_rready : in std_logic;
	 S_AXI_LITE24_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE24_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE24_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE24_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE24_awready : out std_logic;
	 S_AXI_LITE24_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE24_awvalid : in  std_logic;
	 S_AXI_LITE24_arvalid : in std_logic;
	 S_AXI_LITE24_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE24_rvalid : out std_logic;
	 S_AXI_LITE24_wvalid : in std_logic;
	 S_AXI_LITE24_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE24_bvalid : out std_logic;
	 S_AXI_LITE24_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE24_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE24_bready : in std_logic;


	 S_AXI_LITE25_wready : out std_logic;
	 S_AXI_LITE25_arready : out std_logic;
	 S_AXI_LITE25_rready : in std_logic;
	 S_AXI_LITE25_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE25_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE25_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE25_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE25_awready : out std_logic;
	 S_AXI_LITE25_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE25_awvalid : in  std_logic;
	 S_AXI_LITE25_arvalid : in std_logic;
	 S_AXI_LITE25_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE25_rvalid : out std_logic;
	 S_AXI_LITE25_wvalid : in std_logic;
	 S_AXI_LITE25_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE25_bvalid : out std_logic;
	 S_AXI_LITE25_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE25_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE25_bready : in std_logic;


	 S_AXI_LITE26_wready : out std_logic;
	 S_AXI_LITE26_arready : out std_logic;
	 S_AXI_LITE26_rready : in std_logic;
	 S_AXI_LITE26_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE26_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE26_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE26_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE26_awready : out std_logic;
	 S_AXI_LITE26_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE26_awvalid : in  std_logic;
	 S_AXI_LITE26_arvalid : in std_logic;
	 S_AXI_LITE26_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE26_rvalid : out std_logic;
	 S_AXI_LITE26_wvalid : in std_logic;
	 S_AXI_LITE26_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE26_bvalid : out std_logic;
	 S_AXI_LITE26_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE26_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE26_bready : in std_logic;


	 S_AXI_LITE27_wready : out std_logic;
	 S_AXI_LITE27_arready : out std_logic;
	 S_AXI_LITE27_rready : in std_logic;
	 S_AXI_LITE27_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE27_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE27_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE27_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE27_awready : out std_logic;
	 S_AXI_LITE27_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE27_awvalid : in  std_logic;
	 S_AXI_LITE27_arvalid : in std_logic;
	 S_AXI_LITE27_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE27_rvalid : out std_logic;
	 S_AXI_LITE27_wvalid : in std_logic;
	 S_AXI_LITE27_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE27_bvalid : out std_logic;
	 S_AXI_LITE27_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE27_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE27_bready : in std_logic;


	 S_AXI_LITE28_wready : out std_logic;
	 S_AXI_LITE28_arready : out std_logic;
	 S_AXI_LITE28_rready : in std_logic;
	 S_AXI_LITE28_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE28_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE28_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE28_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE28_awready : out std_logic;
	 S_AXI_LITE28_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE28_awvalid : in  std_logic;
	 S_AXI_LITE28_arvalid : in std_logic;
	 S_AXI_LITE28_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE28_rvalid : out std_logic;
	 S_AXI_LITE28_wvalid : in std_logic;
	 S_AXI_LITE28_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE28_bvalid : out std_logic;
	 S_AXI_LITE28_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE28_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE28_bready : in std_logic;


	 S_AXI_LITE29_wready : out std_logic;
	 S_AXI_LITE29_arready : out std_logic;
	 S_AXI_LITE29_rready : in std_logic;
	 S_AXI_LITE29_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE29_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE29_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE29_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE29_awready : out std_logic;
	 S_AXI_LITE29_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE29_awvalid : in  std_logic;
	 S_AXI_LITE29_arvalid : in std_logic;
	 S_AXI_LITE29_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE29_rvalid : out std_logic;
	 S_AXI_LITE29_wvalid : in std_logic;
	 S_AXI_LITE29_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE29_bvalid : out std_logic;
	 S_AXI_LITE29_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE29_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE29_bready : in std_logic;


	 S_AXI_LITE30_wready : out std_logic;
	 S_AXI_LITE30_arready : out std_logic;
	 S_AXI_LITE30_rready : in std_logic;
	 S_AXI_LITE30_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE30_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE30_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE30_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE30_awready : out std_logic;
	 S_AXI_LITE30_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE30_awvalid : in  std_logic;
	 S_AXI_LITE30_arvalid : in std_logic;
	 S_AXI_LITE30_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE30_rvalid : out std_logic;
	 S_AXI_LITE30_wvalid : in std_logic;
	 S_AXI_LITE30_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE30_bvalid : out std_logic;
	 S_AXI_LITE30_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE30_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE30_bready : in std_logic;


	 S_AXI_LITE31_wready : out std_logic;
	 S_AXI_LITE31_arready : out std_logic;
	 S_AXI_LITE31_rready : in std_logic;
	 S_AXI_LITE31_wstrb : in std_logic_vector(3 downto 0);
	 S_AXI_LITE31_bresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE31_awprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE31_awaddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE31_awready : out std_logic;
	 S_AXI_LITE31_arprot : in std_logic_vector(2 downto 0);
	 S_AXI_LITE31_awvalid : in  std_logic;
	 S_AXI_LITE31_arvalid : in std_logic;
	 S_AXI_LITE31_rresp : out std_logic_vector(1 downto 0);
	 S_AXI_LITE31_rvalid : out std_logic;
	 S_AXI_LITE31_wvalid : in std_logic;
	 S_AXI_LITE31_wdata : in std_logic_vector (31 downto 0);
	 S_AXI_LITE31_bvalid : out std_logic;
	 S_AXI_LITE31_rdata : out std_logic_vector(31 downto 0);
	 S_AXI_LITE31_araddr : in std_logic_vector(31 downto 0);
	 S_AXI_LITE31_bready : in std_logic;


   
    PACMAN_TS : in UNSIGNED ( 63 downto 0 );
    MISO : in std_logic_vector(TOTAL_CHANNELS-1 downto 0);   
    UART_RX_BUSY : out std_logic;
    UART_TX_BUSY : out std_logic;
    TILE_EN      : in  std_logic_vector(0 to TOTAL_TILES-1);
    MOSI         : out std_logic_vector ( TOTAL_CHANNELS-1 downto 0) 
  );
end uart_channel_top;


architecture arch_imp of uart_channel_top is
   component uart_channel_array is
       generic(
    TOTAL_CHANNELS : integer := 32;
    TOTAL_TILES    : integer := 8
    );
   port (
    ACLK : in STD_LOGIC;
    ARESETN : in STD_LOGIC;
    MCLK : in STD_LOGIC;
    MRST : in STD_LOGIC;
    M_AXIS_tdata : out t_uart_array_128 (0 to TOTAL_TILES-1);
    M_AXIS_tkeep : out t_uart_array_16(0 to TOTAL_TILES-1);
    M_AXIS_tlast : out std_logic_vector(0 to TOTAL_TILES-1);
    M_AXIS_tready : in std_logic_vector(0 to TOTAL_TILES-1);
    M_AXIS_tstrb : out t_uart_array_16(0 to TOTAL_TILES-1);
    M_AXIS_tvalid : out std_logic_vector(0 to TOTAL_TILES-1);
    PACMAN_TS : in UNSIGNED ( 63 downto 0 );
    S_AXIS_tdata : in t_uart_array_128 (0 to TOTAL_CHANNELS-1);
    S_AXIS_tkeep : in t_uart_array_16(0 to TOTAL_CHANNELS-1);
    S_AXIS_tlast : in std_logic_vector(0 to TOTAL_CHANNELS-1);
    S_AXIS_tready : out std_logic_vector(0 to TOTAL_CHANNELS-1);
    S_AXIS_tstrb : in t_uart_array_16(0 to TOTAL_CHANNELS-1);
    S_AXIS_tvalid : in std_logic_vector(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_araddr : in t_uart_array_32(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_arprot : in t_uart_array_3(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_arready : out std_logic_vector(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_arvalid : in std_logic_vector(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_awaddr : in t_uart_array_32(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_awprot : in t_uart_array_3(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_awready : out std_logic_vector(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_awvalid : in  std_logic_vector(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_bready : in std_logic_vector(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_bresp : out t_uart_array_2(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_bvalid : out std_logic_vector(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_rdata : out t_uart_array_32(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_rready : in std_logic_vector(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_rresp : out t_uart_array_2(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_rvalid : out std_logic_vector(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_wdata : in t_uart_array_32(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_wready : out std_logic_vector(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_wstrb : in t_uart_array_4(0 to TOTAL_CHANNELS-1);
    S_AXI_LITE_wvalid : in std_logic_vector(0 to TOTAL_CHANNELS-1);
    MISO : in std_logic_vector(TOTAL_CHANNELS-1 downto 0);   
    UART_RX_BUSY : out std_logic;
    UART_TX_BUSY : out std_logic;
    TILE_EN      : in  std_logic_vector(0 to TOTAL_TILES-1);
    MOSI         : out std_logic_vector ( TOTAL_CHANNELS-1 downto 0) 
  );
  end component;

  signal M_AXIS_tdata : t_uart_array_128 (0 to TOTAL_TILES-1);
  signal M_AXIS_tkeep : t_uart_array_16(0 to TOTAL_TILES-1);
  signal M_AXIS_tlast : std_logic_vector(0 to TOTAL_TILES-1);
  signal M_AXIS_tready : std_logic_vector(0 to TOTAL_TILES-1);
  signal M_AXIS_tstrb : t_uart_array_16(0 to TOTAL_TILES-1);
  signal M_AXIS_tvalid: std_logic_vector(0 to TOTAL_TILES-1);

  signal S_AXIS_tdata : t_uart_array_128 (0 to TOTAL_CHANNELS-1);
  signal S_AXIS_tkeep : t_uart_array_16(0 to TOTAL_CHANNELS-1);
  signal S_AXIS_tlast : std_logic_vector(0 to TOTAL_CHANNELS-1);
  signal S_AXIS_tready :std_logic_vector(0 to TOTAL_CHANNELS-1);
  signal S_AXIS_tstrb  :t_uart_array_16(0 to TOTAL_CHANNELS-1);
  signal S_AXIS_tvalid :std_logic_vector(0 to TOTAL_CHANNELS-1);
 
  signal S_AXI_LITE_araddr :t_uart_array_32(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_arprot :t_uart_array_3(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_arready :std_logic_vector(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_arvalid :std_logic_vector(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_awaddr :t_uart_array_32(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_awprot :t_uart_array_3(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_awready :std_logic_vector(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_awvalid : std_logic_vector(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_bready :std_logic_vector(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_bresp :t_uart_array_2(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_bvalid :std_logic_vector(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_rdata :t_uart_array_32(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_rready :std_logic_vector(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_rresp :t_uart_array_2(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_rvalid :std_logic_vector(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_wdata :t_uart_array_32(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_wready :std_logic_vector(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_wstrb :t_uart_array_4(0 to TOTAL_CHANNELS-1);
  signal S_AXI_LITE_wvalid :std_logic_vector(0 to TOTAL_CHANNELS-1);
begin

	 M_AXIS0_tkeep   <= M_AXIS_tkeep  (0);
	 M_AXIS0_tstrb   <= M_AXIS_tstrb  (0);
	 M_AXIS0_tdata   <= M_AXIS_tdata  (0);
	 M_AXIS0_tvalid  <= M_AXIS_tvalid (0);
	 M_AXIS_tready (0) <= M_AXIS0_tready ;
	 M_AXIS0_tlast   <= M_AXIS_tlast  (0);
	 M_AXIS1_tkeep   <= M_AXIS_tkeep  (1);
	 M_AXIS1_tstrb   <= M_AXIS_tstrb  (1);
	 M_AXIS1_tdata   <= M_AXIS_tdata  (1);
	 M_AXIS1_tvalid  <= M_AXIS_tvalid (1);
	 M_AXIS_tready (1) <= M_AXIS1_tready ;
	 M_AXIS1_tlast   <= M_AXIS_tlast  (1);
	 M_AXIS2_tkeep   <= M_AXIS_tkeep  (2);
	 M_AXIS2_tstrb   <= M_AXIS_tstrb  (2);
	 M_AXIS2_tdata   <= M_AXIS_tdata  (2);
	 M_AXIS2_tvalid  <= M_AXIS_tvalid (2);
	 M_AXIS_tready (2) <= M_AXIS2_tready ;
	 M_AXIS2_tlast   <= M_AXIS_tlast  (2);
	 M_AXIS3_tkeep   <= M_AXIS_tkeep  (3);
	 M_AXIS3_tstrb   <= M_AXIS_tstrb  (3);
	 M_AXIS3_tdata   <= M_AXIS_tdata  (3);
	 M_AXIS3_tvalid  <= M_AXIS_tvalid (3);
	 M_AXIS_tready (3) <= M_AXIS3_tready ;
	 M_AXIS3_tlast   <= M_AXIS_tlast  (3);
	 M_AXIS4_tkeep   <= M_AXIS_tkeep  (4);
	 M_AXIS4_tstrb   <= M_AXIS_tstrb  (4);
	 M_AXIS4_tdata   <= M_AXIS_tdata  (4);
	 M_AXIS4_tvalid  <= M_AXIS_tvalid (4);
	 M_AXIS_tready (4) <= M_AXIS4_tready ;
	 M_AXIS4_tlast   <= M_AXIS_tlast  (4);
	 M_AXIS5_tkeep   <= M_AXIS_tkeep  (5);
	 M_AXIS5_tstrb   <= M_AXIS_tstrb  (5);
	 M_AXIS5_tdata   <= M_AXIS_tdata  (5);
	 M_AXIS5_tvalid  <= M_AXIS_tvalid (5);
	 M_AXIS_tready (5) <= M_AXIS5_tready ;
	 M_AXIS5_tlast   <= M_AXIS_tlast  (5);
	 M_AXIS6_tkeep   <= M_AXIS_tkeep  (6);
	 M_AXIS6_tstrb   <= M_AXIS_tstrb  (6);
	 M_AXIS6_tdata   <= M_AXIS_tdata  (6);
	 M_AXIS6_tvalid  <= M_AXIS_tvalid (6);
	 M_AXIS_tready (6) <= M_AXIS6_tready ;
	 M_AXIS6_tlast   <= M_AXIS_tlast  (6);
	 M_AXIS7_tkeep   <= M_AXIS_tkeep  (7);
	 M_AXIS7_tstrb   <= M_AXIS_tstrb  (7);
	 M_AXIS7_tdata   <= M_AXIS_tdata  (7);
	 M_AXIS7_tvalid  <= M_AXIS_tvalid (7);
	 M_AXIS_tready (7) <= M_AXIS7_tready ;
	 M_AXIS7_tlast   <= M_AXIS_tlast  (7);
	 S_AXIS_tkeep (0) <= S_AXIS0_tkeep ;
	 S_AXIS_tlast (0) <= S_AXIS0_tlast ;
	 S_AXIS_tstrb (0) <= S_AXIS0_tstrb ;
	 S_AXIS_tvalid (0) <= S_AXIS0_tvalid ;
	 S_AXIS0_tready  <= S_AXIS_tready (0);
	 S_AXIS_tdata (0) <= S_AXIS0_tdata ;
	 S_AXIS_tkeep (1) <= S_AXIS1_tkeep ;
	 S_AXIS_tlast (1) <= S_AXIS1_tlast ;
	 S_AXIS_tstrb (1) <= S_AXIS1_tstrb ;
	 S_AXIS_tvalid (1) <= S_AXIS1_tvalid ;
	 S_AXIS1_tready  <= S_AXIS_tready (1);
	 S_AXIS_tdata (1) <= S_AXIS1_tdata ;
	 S_AXIS_tkeep (2) <= S_AXIS2_tkeep ;
	 S_AXIS_tlast (2) <= S_AXIS2_tlast ;
	 S_AXIS_tstrb (2) <= S_AXIS2_tstrb ;
	 S_AXIS_tvalid (2) <= S_AXIS2_tvalid ;
	 S_AXIS2_tready  <= S_AXIS_tready (2);
	 S_AXIS_tdata (2) <= S_AXIS2_tdata ;
	 S_AXIS_tkeep (3) <= S_AXIS3_tkeep ;
	 S_AXIS_tlast (3) <= S_AXIS3_tlast ;
	 S_AXIS_tstrb (3) <= S_AXIS3_tstrb ;
	 S_AXIS_tvalid (3) <= S_AXIS3_tvalid ;
	 S_AXIS3_tready  <= S_AXIS_tready (3);
	 S_AXIS_tdata (3) <= S_AXIS3_tdata ;
	 S_AXIS_tkeep (4) <= S_AXIS4_tkeep ;
	 S_AXIS_tlast (4) <= S_AXIS4_tlast ;
	 S_AXIS_tstrb (4) <= S_AXIS4_tstrb ;
	 S_AXIS_tvalid (4) <= S_AXIS4_tvalid ;
	 S_AXIS4_tready  <= S_AXIS_tready (4);
	 S_AXIS_tdata (4) <= S_AXIS4_tdata ;
	 S_AXIS_tkeep (5) <= S_AXIS5_tkeep ;
	 S_AXIS_tlast (5) <= S_AXIS5_tlast ;
	 S_AXIS_tstrb (5) <= S_AXIS5_tstrb ;
	 S_AXIS_tvalid (5) <= S_AXIS5_tvalid ;
	 S_AXIS5_tready  <= S_AXIS_tready (5);
	 S_AXIS_tdata (5) <= S_AXIS5_tdata ;
	 S_AXIS_tkeep (6) <= S_AXIS6_tkeep ;
	 S_AXIS_tlast (6) <= S_AXIS6_tlast ;
	 S_AXIS_tstrb (6) <= S_AXIS6_tstrb ;
	 S_AXIS_tvalid (6) <= S_AXIS6_tvalid ;
	 S_AXIS6_tready  <= S_AXIS_tready (6);
	 S_AXIS_tdata (6) <= S_AXIS6_tdata ;
	 S_AXIS_tkeep (7) <= S_AXIS7_tkeep ;
	 S_AXIS_tlast (7) <= S_AXIS7_tlast ;
	 S_AXIS_tstrb (7) <= S_AXIS7_tstrb ;
	 S_AXIS_tvalid (7) <= S_AXIS7_tvalid ;
	 S_AXIS7_tready  <= S_AXIS_tready (7);
	 S_AXIS_tdata (7) <= S_AXIS7_tdata ;
	 S_AXIS_tkeep (8) <= S_AXIS8_tkeep ;
	 S_AXIS_tlast (8) <= S_AXIS8_tlast ;
	 S_AXIS_tstrb (8) <= S_AXIS8_tstrb ;
	 S_AXIS_tvalid (8) <= S_AXIS8_tvalid ;
	 S_AXIS8_tready  <= S_AXIS_tready (8);
	 S_AXIS_tdata (8) <= S_AXIS8_tdata ;
	 S_AXIS_tkeep (9) <= S_AXIS9_tkeep ;
	 S_AXIS_tlast (9) <= S_AXIS9_tlast ;
	 S_AXIS_tstrb (9) <= S_AXIS9_tstrb ;
	 S_AXIS_tvalid (9) <= S_AXIS9_tvalid ;
	 S_AXIS9_tready  <= S_AXIS_tready (9);
	 S_AXIS_tdata (9) <= S_AXIS9_tdata ;
	 S_AXIS_tkeep (10) <= S_AXIS10_tkeep ;
	 S_AXIS_tlast (10) <= S_AXIS10_tlast ;
	 S_AXIS_tstrb (10) <= S_AXIS10_tstrb ;
	 S_AXIS_tvalid (10) <= S_AXIS10_tvalid ;
	 S_AXIS10_tready  <= S_AXIS_tready (10);
	 S_AXIS_tdata (10) <= S_AXIS10_tdata ;
	 S_AXIS_tkeep (11) <= S_AXIS11_tkeep ;
	 S_AXIS_tlast (11) <= S_AXIS11_tlast ;
	 S_AXIS_tstrb (11) <= S_AXIS11_tstrb ;
	 S_AXIS_tvalid (11) <= S_AXIS11_tvalid ;
	 S_AXIS11_tready  <= S_AXIS_tready (11);
	 S_AXIS_tdata (11) <= S_AXIS11_tdata ;
	 S_AXIS_tkeep (12) <= S_AXIS12_tkeep ;
	 S_AXIS_tlast (12) <= S_AXIS12_tlast ;
	 S_AXIS_tstrb (12) <= S_AXIS12_tstrb ;
	 S_AXIS_tvalid (12) <= S_AXIS12_tvalid ;
	 S_AXIS12_tready  <= S_AXIS_tready (12);
	 S_AXIS_tdata (12) <= S_AXIS12_tdata ;
	 S_AXIS_tkeep (13) <= S_AXIS13_tkeep ;
	 S_AXIS_tlast (13) <= S_AXIS13_tlast ;
	 S_AXIS_tstrb (13) <= S_AXIS13_tstrb ;
	 S_AXIS_tvalid (13) <= S_AXIS13_tvalid ;
	 S_AXIS13_tready  <= S_AXIS_tready (13);
	 S_AXIS_tdata (13) <= S_AXIS13_tdata ;
	 S_AXIS_tkeep (14) <= S_AXIS14_tkeep ;
	 S_AXIS_tlast (14) <= S_AXIS14_tlast ;
	 S_AXIS_tstrb (14) <= S_AXIS14_tstrb ;
	 S_AXIS_tvalid (14) <= S_AXIS14_tvalid ;
	 S_AXIS14_tready  <= S_AXIS_tready (14);
	 S_AXIS_tdata (14) <= S_AXIS14_tdata ;
	 S_AXIS_tkeep (15) <= S_AXIS15_tkeep ;
	 S_AXIS_tlast (15) <= S_AXIS15_tlast ;
	 S_AXIS_tstrb (15) <= S_AXIS15_tstrb ;
	 S_AXIS_tvalid (15) <= S_AXIS15_tvalid ;
	 S_AXIS15_tready  <= S_AXIS_tready (15);
	 S_AXIS_tdata (15) <= S_AXIS15_tdata ;
	 S_AXIS_tkeep (16) <= S_AXIS16_tkeep ;
	 S_AXIS_tlast (16) <= S_AXIS16_tlast ;
	 S_AXIS_tstrb (16) <= S_AXIS16_tstrb ;
	 S_AXIS_tvalid (16) <= S_AXIS16_tvalid ;
	 S_AXIS16_tready  <= S_AXIS_tready (16);
	 S_AXIS_tdata (16) <= S_AXIS16_tdata ;
	 S_AXIS_tkeep (17) <= S_AXIS17_tkeep ;
	 S_AXIS_tlast (17) <= S_AXIS17_tlast ;
	 S_AXIS_tstrb (17) <= S_AXIS17_tstrb ;
	 S_AXIS_tvalid (17) <= S_AXIS17_tvalid ;
	 S_AXIS17_tready  <= S_AXIS_tready (17);
	 S_AXIS_tdata (17) <= S_AXIS17_tdata ;
	 S_AXIS_tkeep (18) <= S_AXIS18_tkeep ;
	 S_AXIS_tlast (18) <= S_AXIS18_tlast ;
	 S_AXIS_tstrb (18) <= S_AXIS18_tstrb ;
	 S_AXIS_tvalid (18) <= S_AXIS18_tvalid ;
	 S_AXIS18_tready  <= S_AXIS_tready (18);
	 S_AXIS_tdata (18) <= S_AXIS18_tdata ;
	 S_AXIS_tkeep (19) <= S_AXIS19_tkeep ;
	 S_AXIS_tlast (19) <= S_AXIS19_tlast ;
	 S_AXIS_tstrb (19) <= S_AXIS19_tstrb ;
	 S_AXIS_tvalid (19) <= S_AXIS19_tvalid ;
	 S_AXIS19_tready  <= S_AXIS_tready (19);
	 S_AXIS_tdata (19) <= S_AXIS19_tdata ;
	 S_AXIS_tkeep (20) <= S_AXIS20_tkeep ;
	 S_AXIS_tlast (20) <= S_AXIS20_tlast ;
	 S_AXIS_tstrb (20) <= S_AXIS20_tstrb ;
	 S_AXIS_tvalid (20) <= S_AXIS20_tvalid ;
	 S_AXIS20_tready  <= S_AXIS_tready (20);
	 S_AXIS_tdata (20) <= S_AXIS20_tdata ;
	 S_AXIS_tkeep (21) <= S_AXIS21_tkeep ;
	 S_AXIS_tlast (21) <= S_AXIS21_tlast ;
	 S_AXIS_tstrb (21) <= S_AXIS21_tstrb ;
	 S_AXIS_tvalid (21) <= S_AXIS21_tvalid ;
	 S_AXIS21_tready  <= S_AXIS_tready (21);
	 S_AXIS_tdata (21) <= S_AXIS21_tdata ;
	 S_AXIS_tkeep (22) <= S_AXIS22_tkeep ;
	 S_AXIS_tlast (22) <= S_AXIS22_tlast ;
	 S_AXIS_tstrb (22) <= S_AXIS22_tstrb ;
	 S_AXIS_tvalid (22) <= S_AXIS22_tvalid ;
	 S_AXIS22_tready  <= S_AXIS_tready (22);
	 S_AXIS_tdata (22) <= S_AXIS22_tdata ;
	 S_AXIS_tkeep (23) <= S_AXIS23_tkeep ;
	 S_AXIS_tlast (23) <= S_AXIS23_tlast ;
	 S_AXIS_tstrb (23) <= S_AXIS23_tstrb ;
	 S_AXIS_tvalid (23) <= S_AXIS23_tvalid ;
	 S_AXIS23_tready  <= S_AXIS_tready (23);
	 S_AXIS_tdata (23) <= S_AXIS23_tdata ;
	 S_AXIS_tkeep (24) <= S_AXIS24_tkeep ;
	 S_AXIS_tlast (24) <= S_AXIS24_tlast ;
	 S_AXIS_tstrb (24) <= S_AXIS24_tstrb ;
	 S_AXIS_tvalid (24) <= S_AXIS24_tvalid ;
	 S_AXIS24_tready  <= S_AXIS_tready (24);
	 S_AXIS_tdata (24) <= S_AXIS24_tdata ;
	 S_AXIS_tkeep (25) <= S_AXIS25_tkeep ;
	 S_AXIS_tlast (25) <= S_AXIS25_tlast ;
	 S_AXIS_tstrb (25) <= S_AXIS25_tstrb ;
	 S_AXIS_tvalid (25) <= S_AXIS25_tvalid ;
	 S_AXIS25_tready  <= S_AXIS_tready (25);
	 S_AXIS_tdata (25) <= S_AXIS25_tdata ;
	 S_AXIS_tkeep (26) <= S_AXIS26_tkeep ;
	 S_AXIS_tlast (26) <= S_AXIS26_tlast ;
	 S_AXIS_tstrb (26) <= S_AXIS26_tstrb ;
	 S_AXIS_tvalid (26) <= S_AXIS26_tvalid ;
	 S_AXIS26_tready  <= S_AXIS_tready (26);
	 S_AXIS_tdata (26) <= S_AXIS26_tdata ;
	 S_AXIS_tkeep (27) <= S_AXIS27_tkeep ;
	 S_AXIS_tlast (27) <= S_AXIS27_tlast ;
	 S_AXIS_tstrb (27) <= S_AXIS27_tstrb ;
	 S_AXIS_tvalid (27) <= S_AXIS27_tvalid ;
	 S_AXIS27_tready  <= S_AXIS_tready (27);
	 S_AXIS_tdata (27) <= S_AXIS27_tdata ;
	 S_AXIS_tkeep (28) <= S_AXIS28_tkeep ;
	 S_AXIS_tlast (28) <= S_AXIS28_tlast ;
	 S_AXIS_tstrb (28) <= S_AXIS28_tstrb ;
	 S_AXIS_tvalid (28) <= S_AXIS28_tvalid ;
	 S_AXIS28_tready  <= S_AXIS_tready (28);
	 S_AXIS_tdata (28) <= S_AXIS28_tdata ;
	 S_AXIS_tkeep (29) <= S_AXIS29_tkeep ;
	 S_AXIS_tlast (29) <= S_AXIS29_tlast ;
	 S_AXIS_tstrb (29) <= S_AXIS29_tstrb ;
	 S_AXIS_tvalid (29) <= S_AXIS29_tvalid ;
	 S_AXIS29_tready  <= S_AXIS_tready (29);
	 S_AXIS_tdata (29) <= S_AXIS29_tdata ;
	 S_AXIS_tkeep (30) <= S_AXIS30_tkeep ;
	 S_AXIS_tlast (30) <= S_AXIS30_tlast ;
	 S_AXIS_tstrb (30) <= S_AXIS30_tstrb ;
	 S_AXIS_tvalid (30) <= S_AXIS30_tvalid ;
	 S_AXIS30_tready  <= S_AXIS_tready (30);
	 S_AXIS_tdata (30) <= S_AXIS30_tdata ;
	 S_AXIS_tkeep (31) <= S_AXIS31_tkeep ;
	 S_AXIS_tlast (31) <= S_AXIS31_tlast ;
	 S_AXIS_tstrb (31) <= S_AXIS31_tstrb ;
	 S_AXIS_tvalid (31) <= S_AXIS31_tvalid ;
	 S_AXIS31_tready  <= S_AXIS_tready (31);
	 S_AXIS_tdata (31) <= S_AXIS31_tdata ;
	 S_AXI_LITE0_wready  <= S_AXI_LITE_wready (0);
	 S_AXI_LITE0_arready  <= S_AXI_LITE_arready (0);
	 S_AXI_LITE_rready (0) <= S_AXI_LITE0_rready ;
	 S_AXI_LITE_wstrb (0) <= S_AXI_LITE0_wstrb ;
	 S_AXI_LITE0_bresp  <= S_AXI_LITE_bresp (0);
	 S_AXI_LITE_awprot (0) <= S_AXI_LITE0_awprot ;
	 S_AXI_LITE_awaddr (0) <= S_AXI_LITE0_awaddr ;
	 S_AXI_LITE0_awready  <= S_AXI_LITE_awready (0);
	 S_AXI_LITE_arprot (0) <= S_AXI_LITE0_arprot ;
	 S_AXI_LITE_awvalid (0) <= S_AXI_LITE0_awvalid ;
	 S_AXI_LITE_arvalid (0) <= S_AXI_LITE0_arvalid ;
	 S_AXI_LITE0_rresp  <= S_AXI_LITE_rresp (0);
	 S_AXI_LITE0_rvalid  <= S_AXI_LITE_rvalid (0);
	 S_AXI_LITE_wvalid (0) <= S_AXI_LITE0_wvalid ;
	 S_AXI_LITE_wdata (0) <= S_AXI_LITE0_wdata ;
	 S_AXI_LITE0_bvalid  <= S_AXI_LITE_bvalid (0);
	 S_AXI_LITE0_rdata  <= S_AXI_LITE_rdata (0);
	 S_AXI_LITE_araddr (0) <= S_AXI_LITE0_araddr ;
	 S_AXI_LITE_bready (0) <= S_AXI_LITE0_bready ;
	 S_AXI_LITE1_wready  <= S_AXI_LITE_wready (1);
	 S_AXI_LITE1_arready  <= S_AXI_LITE_arready (1);
	 S_AXI_LITE_rready (1) <= S_AXI_LITE1_rready ;
	 S_AXI_LITE_wstrb (1) <= S_AXI_LITE1_wstrb ;
	 S_AXI_LITE1_bresp  <= S_AXI_LITE_bresp (1);
	 S_AXI_LITE_awprot (1) <= S_AXI_LITE1_awprot ;
	 S_AXI_LITE_awaddr (1) <= S_AXI_LITE1_awaddr ;
	 S_AXI_LITE1_awready  <= S_AXI_LITE_awready (1);
	 S_AXI_LITE_arprot (1) <= S_AXI_LITE1_arprot ;
	 S_AXI_LITE_awvalid (1) <= S_AXI_LITE1_awvalid ;
	 S_AXI_LITE_arvalid (1) <= S_AXI_LITE1_arvalid ;
	 S_AXI_LITE1_rresp  <= S_AXI_LITE_rresp (1);
	 S_AXI_LITE1_rvalid  <= S_AXI_LITE_rvalid (1);
	 S_AXI_LITE_wvalid (1) <= S_AXI_LITE1_wvalid ;
	 S_AXI_LITE_wdata (1) <= S_AXI_LITE1_wdata ;
	 S_AXI_LITE1_bvalid  <= S_AXI_LITE_bvalid (1);
	 S_AXI_LITE1_rdata  <= S_AXI_LITE_rdata (1);
	 S_AXI_LITE_araddr (1) <= S_AXI_LITE1_araddr ;
	 S_AXI_LITE_bready (1) <= S_AXI_LITE1_bready ;
	 S_AXI_LITE2_wready  <= S_AXI_LITE_wready (2);
	 S_AXI_LITE2_arready  <= S_AXI_LITE_arready (2);
	 S_AXI_LITE_rready (2) <= S_AXI_LITE2_rready ;
	 S_AXI_LITE_wstrb (2) <= S_AXI_LITE2_wstrb ;
	 S_AXI_LITE2_bresp  <= S_AXI_LITE_bresp (2);
	 S_AXI_LITE_awprot (2) <= S_AXI_LITE2_awprot ;
	 S_AXI_LITE_awaddr (2) <= S_AXI_LITE2_awaddr ;
	 S_AXI_LITE2_awready  <= S_AXI_LITE_awready (2);
	 S_AXI_LITE_arprot (2) <= S_AXI_LITE2_arprot ;
	 S_AXI_LITE_awvalid (2) <= S_AXI_LITE2_awvalid ;
	 S_AXI_LITE_arvalid (2) <= S_AXI_LITE2_arvalid ;
	 S_AXI_LITE2_rresp  <= S_AXI_LITE_rresp (2);
	 S_AXI_LITE2_rvalid  <= S_AXI_LITE_rvalid (2);
	 S_AXI_LITE_wvalid (2) <= S_AXI_LITE2_wvalid ;
	 S_AXI_LITE_wdata (2) <= S_AXI_LITE2_wdata ;
	 S_AXI_LITE2_bvalid  <= S_AXI_LITE_bvalid (2);
	 S_AXI_LITE2_rdata  <= S_AXI_LITE_rdata (2);
	 S_AXI_LITE_araddr (2) <= S_AXI_LITE2_araddr ;
	 S_AXI_LITE_bready (2) <= S_AXI_LITE2_bready ;
	 S_AXI_LITE3_wready  <= S_AXI_LITE_wready (3);
	 S_AXI_LITE3_arready  <= S_AXI_LITE_arready (3);
	 S_AXI_LITE_rready (3) <= S_AXI_LITE3_rready ;
	 S_AXI_LITE_wstrb (3) <= S_AXI_LITE3_wstrb ;
	 S_AXI_LITE3_bresp  <= S_AXI_LITE_bresp (3);
	 S_AXI_LITE_awprot (3) <= S_AXI_LITE3_awprot ;
	 S_AXI_LITE_awaddr (3) <= S_AXI_LITE3_awaddr ;
	 S_AXI_LITE3_awready  <= S_AXI_LITE_awready (3);
	 S_AXI_LITE_arprot (3) <= S_AXI_LITE3_arprot ;
	 S_AXI_LITE_awvalid (3) <= S_AXI_LITE3_awvalid ;
	 S_AXI_LITE_arvalid (3) <= S_AXI_LITE3_arvalid ;
	 S_AXI_LITE3_rresp  <= S_AXI_LITE_rresp (3);
	 S_AXI_LITE3_rvalid  <= S_AXI_LITE_rvalid (3);
	 S_AXI_LITE_wvalid (3) <= S_AXI_LITE3_wvalid ;
	 S_AXI_LITE_wdata (3) <= S_AXI_LITE3_wdata ;
	 S_AXI_LITE3_bvalid  <= S_AXI_LITE_bvalid (3);
	 S_AXI_LITE3_rdata  <= S_AXI_LITE_rdata (3);
	 S_AXI_LITE_araddr (3) <= S_AXI_LITE3_araddr ;
	 S_AXI_LITE_bready (3) <= S_AXI_LITE3_bready ;
	 S_AXI_LITE4_wready  <= S_AXI_LITE_wready (4);
	 S_AXI_LITE4_arready  <= S_AXI_LITE_arready (4);
	 S_AXI_LITE_rready (4) <= S_AXI_LITE4_rready ;
	 S_AXI_LITE_wstrb (4) <= S_AXI_LITE4_wstrb ;
	 S_AXI_LITE4_bresp  <= S_AXI_LITE_bresp (4);
	 S_AXI_LITE_awprot (4) <= S_AXI_LITE4_awprot ;
	 S_AXI_LITE_awaddr (4) <= S_AXI_LITE4_awaddr ;
	 S_AXI_LITE4_awready  <= S_AXI_LITE_awready (4);
	 S_AXI_LITE_arprot (4) <= S_AXI_LITE4_arprot ;
	 S_AXI_LITE_awvalid (4) <= S_AXI_LITE4_awvalid ;
	 S_AXI_LITE_arvalid (4) <= S_AXI_LITE4_arvalid ;
	 S_AXI_LITE4_rresp  <= S_AXI_LITE_rresp (4);
	 S_AXI_LITE4_rvalid  <= S_AXI_LITE_rvalid (4);
	 S_AXI_LITE_wvalid (4) <= S_AXI_LITE4_wvalid ;
	 S_AXI_LITE_wdata (4) <= S_AXI_LITE4_wdata ;
	 S_AXI_LITE4_bvalid  <= S_AXI_LITE_bvalid (4);
	 S_AXI_LITE4_rdata  <= S_AXI_LITE_rdata (4);
	 S_AXI_LITE_araddr (4) <= S_AXI_LITE4_araddr ;
	 S_AXI_LITE_bready (4) <= S_AXI_LITE4_bready ;
	 S_AXI_LITE5_wready  <= S_AXI_LITE_wready (5);
	 S_AXI_LITE5_arready  <= S_AXI_LITE_arready (5);
	 S_AXI_LITE_rready (5) <= S_AXI_LITE5_rready ;
	 S_AXI_LITE_wstrb (5) <= S_AXI_LITE5_wstrb ;
	 S_AXI_LITE5_bresp  <= S_AXI_LITE_bresp (5);
	 S_AXI_LITE_awprot (5) <= S_AXI_LITE5_awprot ;
	 S_AXI_LITE_awaddr (5) <= S_AXI_LITE5_awaddr ;
	 S_AXI_LITE5_awready  <= S_AXI_LITE_awready (5);
	 S_AXI_LITE_arprot (5) <= S_AXI_LITE5_arprot ;
	 S_AXI_LITE_awvalid (5) <= S_AXI_LITE5_awvalid ;
	 S_AXI_LITE_arvalid (5) <= S_AXI_LITE5_arvalid ;
	 S_AXI_LITE5_rresp  <= S_AXI_LITE_rresp (5);
	 S_AXI_LITE5_rvalid  <= S_AXI_LITE_rvalid (5);
	 S_AXI_LITE_wvalid (5) <= S_AXI_LITE5_wvalid ;
	 S_AXI_LITE_wdata (5) <= S_AXI_LITE5_wdata ;
	 S_AXI_LITE5_bvalid  <= S_AXI_LITE_bvalid (5);
	 S_AXI_LITE5_rdata  <= S_AXI_LITE_rdata (5);
	 S_AXI_LITE_araddr (5) <= S_AXI_LITE5_araddr ;
	 S_AXI_LITE_bready (5) <= S_AXI_LITE5_bready ;
	 S_AXI_LITE6_wready  <= S_AXI_LITE_wready (6);
	 S_AXI_LITE6_arready  <= S_AXI_LITE_arready (6);
	 S_AXI_LITE_rready (6) <= S_AXI_LITE6_rready ;
	 S_AXI_LITE_wstrb (6) <= S_AXI_LITE6_wstrb ;
	 S_AXI_LITE6_bresp  <= S_AXI_LITE_bresp (6);
	 S_AXI_LITE_awprot (6) <= S_AXI_LITE6_awprot ;
	 S_AXI_LITE_awaddr (6) <= S_AXI_LITE6_awaddr ;
	 S_AXI_LITE6_awready  <= S_AXI_LITE_awready (6);
	 S_AXI_LITE_arprot (6) <= S_AXI_LITE6_arprot ;
	 S_AXI_LITE_awvalid (6) <= S_AXI_LITE6_awvalid ;
	 S_AXI_LITE_arvalid (6) <= S_AXI_LITE6_arvalid ;
	 S_AXI_LITE6_rresp  <= S_AXI_LITE_rresp (6);
	 S_AXI_LITE6_rvalid  <= S_AXI_LITE_rvalid (6);
	 S_AXI_LITE_wvalid (6) <= S_AXI_LITE6_wvalid ;
	 S_AXI_LITE_wdata (6) <= S_AXI_LITE6_wdata ;
	 S_AXI_LITE6_bvalid  <= S_AXI_LITE_bvalid (6);
	 S_AXI_LITE6_rdata  <= S_AXI_LITE_rdata (6);
	 S_AXI_LITE_araddr (6) <= S_AXI_LITE6_araddr ;
	 S_AXI_LITE_bready (6) <= S_AXI_LITE6_bready ;
	 S_AXI_LITE7_wready  <= S_AXI_LITE_wready (7);
	 S_AXI_LITE7_arready  <= S_AXI_LITE_arready (7);
	 S_AXI_LITE_rready (7) <= S_AXI_LITE7_rready ;
	 S_AXI_LITE_wstrb (7) <= S_AXI_LITE7_wstrb ;
	 S_AXI_LITE7_bresp  <= S_AXI_LITE_bresp (7);
	 S_AXI_LITE_awprot (7) <= S_AXI_LITE7_awprot ;
	 S_AXI_LITE_awaddr (7) <= S_AXI_LITE7_awaddr ;
	 S_AXI_LITE7_awready  <= S_AXI_LITE_awready (7);
	 S_AXI_LITE_arprot (7) <= S_AXI_LITE7_arprot ;
	 S_AXI_LITE_awvalid (7) <= S_AXI_LITE7_awvalid ;
	 S_AXI_LITE_arvalid (7) <= S_AXI_LITE7_arvalid ;
	 S_AXI_LITE7_rresp  <= S_AXI_LITE_rresp (7);
	 S_AXI_LITE7_rvalid  <= S_AXI_LITE_rvalid (7);
	 S_AXI_LITE_wvalid (7) <= S_AXI_LITE7_wvalid ;
	 S_AXI_LITE_wdata (7) <= S_AXI_LITE7_wdata ;
	 S_AXI_LITE7_bvalid  <= S_AXI_LITE_bvalid (7);
	 S_AXI_LITE7_rdata  <= S_AXI_LITE_rdata (7);
	 S_AXI_LITE_araddr (7) <= S_AXI_LITE7_araddr ;
	 S_AXI_LITE_bready (7) <= S_AXI_LITE7_bready ;
	 S_AXI_LITE8_wready  <= S_AXI_LITE_wready (8);
	 S_AXI_LITE8_arready  <= S_AXI_LITE_arready (8);
	 S_AXI_LITE_rready (8) <= S_AXI_LITE8_rready ;
	 S_AXI_LITE_wstrb (8) <= S_AXI_LITE8_wstrb ;
	 S_AXI_LITE8_bresp  <= S_AXI_LITE_bresp (8);
	 S_AXI_LITE_awprot (8) <= S_AXI_LITE8_awprot ;
	 S_AXI_LITE_awaddr (8) <= S_AXI_LITE8_awaddr ;
	 S_AXI_LITE8_awready  <= S_AXI_LITE_awready (8);
	 S_AXI_LITE_arprot (8) <= S_AXI_LITE8_arprot ;
	 S_AXI_LITE_awvalid (8) <= S_AXI_LITE8_awvalid ;
	 S_AXI_LITE_arvalid (8) <= S_AXI_LITE8_arvalid ;
	 S_AXI_LITE8_rresp  <= S_AXI_LITE_rresp (8);
	 S_AXI_LITE8_rvalid  <= S_AXI_LITE_rvalid (8);
	 S_AXI_LITE_wvalid (8) <= S_AXI_LITE8_wvalid ;
	 S_AXI_LITE_wdata (8) <= S_AXI_LITE8_wdata ;
	 S_AXI_LITE8_bvalid  <= S_AXI_LITE_bvalid (8);
	 S_AXI_LITE8_rdata  <= S_AXI_LITE_rdata (8);
	 S_AXI_LITE_araddr (8) <= S_AXI_LITE8_araddr ;
	 S_AXI_LITE_bready (8) <= S_AXI_LITE8_bready ;
	 S_AXI_LITE9_wready  <= S_AXI_LITE_wready (9);
	 S_AXI_LITE9_arready  <= S_AXI_LITE_arready (9);
	 S_AXI_LITE_rready (9) <= S_AXI_LITE9_rready ;
	 S_AXI_LITE_wstrb (9) <= S_AXI_LITE9_wstrb ;
	 S_AXI_LITE9_bresp  <= S_AXI_LITE_bresp (9);
	 S_AXI_LITE_awprot (9) <= S_AXI_LITE9_awprot ;
	 S_AXI_LITE_awaddr (9) <= S_AXI_LITE9_awaddr ;
	 S_AXI_LITE9_awready  <= S_AXI_LITE_awready (9);
	 S_AXI_LITE_arprot (9) <= S_AXI_LITE9_arprot ;
	 S_AXI_LITE_awvalid (9) <= S_AXI_LITE9_awvalid ;
	 S_AXI_LITE_arvalid (9) <= S_AXI_LITE9_arvalid ;
	 S_AXI_LITE9_rresp  <= S_AXI_LITE_rresp (9);
	 S_AXI_LITE9_rvalid  <= S_AXI_LITE_rvalid (9);
	 S_AXI_LITE_wvalid (9) <= S_AXI_LITE9_wvalid ;
	 S_AXI_LITE_wdata (9) <= S_AXI_LITE9_wdata ;
	 S_AXI_LITE9_bvalid  <= S_AXI_LITE_bvalid (9);
	 S_AXI_LITE9_rdata  <= S_AXI_LITE_rdata (9);
	 S_AXI_LITE_araddr (9) <= S_AXI_LITE9_araddr ;
	 S_AXI_LITE_bready (9) <= S_AXI_LITE9_bready ;
	 S_AXI_LITE10_wready  <= S_AXI_LITE_wready (10);
	 S_AXI_LITE10_arready  <= S_AXI_LITE_arready (10);
	 S_AXI_LITE_rready (10) <= S_AXI_LITE10_rready ;
	 S_AXI_LITE_wstrb (10) <= S_AXI_LITE10_wstrb ;
	 S_AXI_LITE10_bresp  <= S_AXI_LITE_bresp (10);
	 S_AXI_LITE_awprot (10) <= S_AXI_LITE10_awprot ;
	 S_AXI_LITE_awaddr (10) <= S_AXI_LITE10_awaddr ;
	 S_AXI_LITE10_awready  <= S_AXI_LITE_awready (10);
	 S_AXI_LITE_arprot (10) <= S_AXI_LITE10_arprot ;
	 S_AXI_LITE_awvalid (10) <= S_AXI_LITE10_awvalid ;
	 S_AXI_LITE_arvalid (10) <= S_AXI_LITE10_arvalid ;
	 S_AXI_LITE10_rresp  <= S_AXI_LITE_rresp (10);
	 S_AXI_LITE10_rvalid  <= S_AXI_LITE_rvalid (10);
	 S_AXI_LITE_wvalid (10) <= S_AXI_LITE10_wvalid ;
	 S_AXI_LITE_wdata (10) <= S_AXI_LITE10_wdata ;
	 S_AXI_LITE10_bvalid  <= S_AXI_LITE_bvalid (10);
	 S_AXI_LITE10_rdata  <= S_AXI_LITE_rdata (10);
	 S_AXI_LITE_araddr (10) <= S_AXI_LITE10_araddr ;
	 S_AXI_LITE_bready (10) <= S_AXI_LITE10_bready ;
	 S_AXI_LITE11_wready  <= S_AXI_LITE_wready (11);
	 S_AXI_LITE11_arready  <= S_AXI_LITE_arready (11);
	 S_AXI_LITE_rready (11) <= S_AXI_LITE11_rready ;
	 S_AXI_LITE_wstrb (11) <= S_AXI_LITE11_wstrb ;
	 S_AXI_LITE11_bresp  <= S_AXI_LITE_bresp (11);
	 S_AXI_LITE_awprot (11) <= S_AXI_LITE11_awprot ;
	 S_AXI_LITE_awaddr (11) <= S_AXI_LITE11_awaddr ;
	 S_AXI_LITE11_awready  <= S_AXI_LITE_awready (11);
	 S_AXI_LITE_arprot (11) <= S_AXI_LITE11_arprot ;
	 S_AXI_LITE_awvalid (11) <= S_AXI_LITE11_awvalid ;
	 S_AXI_LITE_arvalid (11) <= S_AXI_LITE11_arvalid ;
	 S_AXI_LITE11_rresp  <= S_AXI_LITE_rresp (11);
	 S_AXI_LITE11_rvalid  <= S_AXI_LITE_rvalid (11);
	 S_AXI_LITE_wvalid (11) <= S_AXI_LITE11_wvalid ;
	 S_AXI_LITE_wdata (11) <= S_AXI_LITE11_wdata ;
	 S_AXI_LITE11_bvalid  <= S_AXI_LITE_bvalid (11);
	 S_AXI_LITE11_rdata  <= S_AXI_LITE_rdata (11);
	 S_AXI_LITE_araddr (11) <= S_AXI_LITE11_araddr ;
	 S_AXI_LITE_bready (11) <= S_AXI_LITE11_bready ;
	 S_AXI_LITE12_wready  <= S_AXI_LITE_wready (12);
	 S_AXI_LITE12_arready  <= S_AXI_LITE_arready (12);
	 S_AXI_LITE_rready (12) <= S_AXI_LITE12_rready ;
	 S_AXI_LITE_wstrb (12) <= S_AXI_LITE12_wstrb ;
	 S_AXI_LITE12_bresp  <= S_AXI_LITE_bresp (12);
	 S_AXI_LITE_awprot (12) <= S_AXI_LITE12_awprot ;
	 S_AXI_LITE_awaddr (12) <= S_AXI_LITE12_awaddr ;
	 S_AXI_LITE12_awready  <= S_AXI_LITE_awready (12);
	 S_AXI_LITE_arprot (12) <= S_AXI_LITE12_arprot ;
	 S_AXI_LITE_awvalid (12) <= S_AXI_LITE12_awvalid ;
	 S_AXI_LITE_arvalid (12) <= S_AXI_LITE12_arvalid ;
	 S_AXI_LITE12_rresp  <= S_AXI_LITE_rresp (12);
	 S_AXI_LITE12_rvalid  <= S_AXI_LITE_rvalid (12);
	 S_AXI_LITE_wvalid (12) <= S_AXI_LITE12_wvalid ;
	 S_AXI_LITE_wdata (12) <= S_AXI_LITE12_wdata ;
	 S_AXI_LITE12_bvalid  <= S_AXI_LITE_bvalid (12);
	 S_AXI_LITE12_rdata  <= S_AXI_LITE_rdata (12);
	 S_AXI_LITE_araddr (12) <= S_AXI_LITE12_araddr ;
	 S_AXI_LITE_bready (12) <= S_AXI_LITE12_bready ;
	 S_AXI_LITE13_wready  <= S_AXI_LITE_wready (13);
	 S_AXI_LITE13_arready  <= S_AXI_LITE_arready (13);
	 S_AXI_LITE_rready (13) <= S_AXI_LITE13_rready ;
	 S_AXI_LITE_wstrb (13) <= S_AXI_LITE13_wstrb ;
	 S_AXI_LITE13_bresp  <= S_AXI_LITE_bresp (13);
	 S_AXI_LITE_awprot (13) <= S_AXI_LITE13_awprot ;
	 S_AXI_LITE_awaddr (13) <= S_AXI_LITE13_awaddr ;
	 S_AXI_LITE13_awready  <= S_AXI_LITE_awready (13);
	 S_AXI_LITE_arprot (13) <= S_AXI_LITE13_arprot ;
	 S_AXI_LITE_awvalid (13) <= S_AXI_LITE13_awvalid ;
	 S_AXI_LITE_arvalid (13) <= S_AXI_LITE13_arvalid ;
	 S_AXI_LITE13_rresp  <= S_AXI_LITE_rresp (13);
	 S_AXI_LITE13_rvalid  <= S_AXI_LITE_rvalid (13);
	 S_AXI_LITE_wvalid (13) <= S_AXI_LITE13_wvalid ;
	 S_AXI_LITE_wdata (13) <= S_AXI_LITE13_wdata ;
	 S_AXI_LITE13_bvalid  <= S_AXI_LITE_bvalid (13);
	 S_AXI_LITE13_rdata  <= S_AXI_LITE_rdata (13);
	 S_AXI_LITE_araddr (13) <= S_AXI_LITE13_araddr ;
	 S_AXI_LITE_bready (13) <= S_AXI_LITE13_bready ;
	 S_AXI_LITE14_wready  <= S_AXI_LITE_wready (14);
	 S_AXI_LITE14_arready  <= S_AXI_LITE_arready (14);
	 S_AXI_LITE_rready (14) <= S_AXI_LITE14_rready ;
	 S_AXI_LITE_wstrb (14) <= S_AXI_LITE14_wstrb ;
	 S_AXI_LITE14_bresp  <= S_AXI_LITE_bresp (14);
	 S_AXI_LITE_awprot (14) <= S_AXI_LITE14_awprot ;
	 S_AXI_LITE_awaddr (14) <= S_AXI_LITE14_awaddr ;
	 S_AXI_LITE14_awready  <= S_AXI_LITE_awready (14);
	 S_AXI_LITE_arprot (14) <= S_AXI_LITE14_arprot ;
	 S_AXI_LITE_awvalid (14) <= S_AXI_LITE14_awvalid ;
	 S_AXI_LITE_arvalid (14) <= S_AXI_LITE14_arvalid ;
	 S_AXI_LITE14_rresp  <= S_AXI_LITE_rresp (14);
	 S_AXI_LITE14_rvalid  <= S_AXI_LITE_rvalid (14);
	 S_AXI_LITE_wvalid (14) <= S_AXI_LITE14_wvalid ;
	 S_AXI_LITE_wdata (14) <= S_AXI_LITE14_wdata ;
	 S_AXI_LITE14_bvalid  <= S_AXI_LITE_bvalid (14);
	 S_AXI_LITE14_rdata  <= S_AXI_LITE_rdata (14);
	 S_AXI_LITE_araddr (14) <= S_AXI_LITE14_araddr ;
	 S_AXI_LITE_bready (14) <= S_AXI_LITE14_bready ;
	 S_AXI_LITE15_wready  <= S_AXI_LITE_wready (15);
	 S_AXI_LITE15_arready  <= S_AXI_LITE_arready (15);
	 S_AXI_LITE_rready (15) <= S_AXI_LITE15_rready ;
	 S_AXI_LITE_wstrb (15) <= S_AXI_LITE15_wstrb ;
	 S_AXI_LITE15_bresp  <= S_AXI_LITE_bresp (15);
	 S_AXI_LITE_awprot (15) <= S_AXI_LITE15_awprot ;
	 S_AXI_LITE_awaddr (15) <= S_AXI_LITE15_awaddr ;
	 S_AXI_LITE15_awready  <= S_AXI_LITE_awready (15);
	 S_AXI_LITE_arprot (15) <= S_AXI_LITE15_arprot ;
	 S_AXI_LITE_awvalid (15) <= S_AXI_LITE15_awvalid ;
	 S_AXI_LITE_arvalid (15) <= S_AXI_LITE15_arvalid ;
	 S_AXI_LITE15_rresp  <= S_AXI_LITE_rresp (15);
	 S_AXI_LITE15_rvalid  <= S_AXI_LITE_rvalid (15);
	 S_AXI_LITE_wvalid (15) <= S_AXI_LITE15_wvalid ;
	 S_AXI_LITE_wdata (15) <= S_AXI_LITE15_wdata ;
	 S_AXI_LITE15_bvalid  <= S_AXI_LITE_bvalid (15);
	 S_AXI_LITE15_rdata  <= S_AXI_LITE_rdata (15);
	 S_AXI_LITE_araddr (15) <= S_AXI_LITE15_araddr ;
	 S_AXI_LITE_bready (15) <= S_AXI_LITE15_bready ;
	 S_AXI_LITE16_wready  <= S_AXI_LITE_wready (16);
	 S_AXI_LITE16_arready  <= S_AXI_LITE_arready (16);
	 S_AXI_LITE_rready (16) <= S_AXI_LITE16_rready ;
	 S_AXI_LITE_wstrb (16) <= S_AXI_LITE16_wstrb ;
	 S_AXI_LITE16_bresp  <= S_AXI_LITE_bresp (16);
	 S_AXI_LITE_awprot (16) <= S_AXI_LITE16_awprot ;
	 S_AXI_LITE_awaddr (16) <= S_AXI_LITE16_awaddr ;
	 S_AXI_LITE16_awready  <= S_AXI_LITE_awready (16);
	 S_AXI_LITE_arprot (16) <= S_AXI_LITE16_arprot ;
	 S_AXI_LITE_awvalid (16) <= S_AXI_LITE16_awvalid ;
	 S_AXI_LITE_arvalid (16) <= S_AXI_LITE16_arvalid ;
	 S_AXI_LITE16_rresp  <= S_AXI_LITE_rresp (16);
	 S_AXI_LITE16_rvalid  <= S_AXI_LITE_rvalid (16);
	 S_AXI_LITE_wvalid (16) <= S_AXI_LITE16_wvalid ;
	 S_AXI_LITE_wdata (16) <= S_AXI_LITE16_wdata ;
	 S_AXI_LITE16_bvalid  <= S_AXI_LITE_bvalid (16);
	 S_AXI_LITE16_rdata  <= S_AXI_LITE_rdata (16);
	 S_AXI_LITE_araddr (16) <= S_AXI_LITE16_araddr ;
	 S_AXI_LITE_bready (16) <= S_AXI_LITE16_bready ;
	 S_AXI_LITE17_wready  <= S_AXI_LITE_wready (17);
	 S_AXI_LITE17_arready  <= S_AXI_LITE_arready (17);
	 S_AXI_LITE_rready (17) <= S_AXI_LITE17_rready ;
	 S_AXI_LITE_wstrb (17) <= S_AXI_LITE17_wstrb ;
	 S_AXI_LITE17_bresp  <= S_AXI_LITE_bresp (17);
	 S_AXI_LITE_awprot (17) <= S_AXI_LITE17_awprot ;
	 S_AXI_LITE_awaddr (17) <= S_AXI_LITE17_awaddr ;
	 S_AXI_LITE17_awready  <= S_AXI_LITE_awready (17);
	 S_AXI_LITE_arprot (17) <= S_AXI_LITE17_arprot ;
	 S_AXI_LITE_awvalid (17) <= S_AXI_LITE17_awvalid ;
	 S_AXI_LITE_arvalid (17) <= S_AXI_LITE17_arvalid ;
	 S_AXI_LITE17_rresp  <= S_AXI_LITE_rresp (17);
	 S_AXI_LITE17_rvalid  <= S_AXI_LITE_rvalid (17);
	 S_AXI_LITE_wvalid (17) <= S_AXI_LITE17_wvalid ;
	 S_AXI_LITE_wdata (17) <= S_AXI_LITE17_wdata ;
	 S_AXI_LITE17_bvalid  <= S_AXI_LITE_bvalid (17);
	 S_AXI_LITE17_rdata  <= S_AXI_LITE_rdata (17);
	 S_AXI_LITE_araddr (17) <= S_AXI_LITE17_araddr ;
	 S_AXI_LITE_bready (17) <= S_AXI_LITE17_bready ;
	 S_AXI_LITE18_wready  <= S_AXI_LITE_wready (18);
	 S_AXI_LITE18_arready  <= S_AXI_LITE_arready (18);
	 S_AXI_LITE_rready (18) <= S_AXI_LITE18_rready ;
	 S_AXI_LITE_wstrb (18) <= S_AXI_LITE18_wstrb ;
	 S_AXI_LITE18_bresp  <= S_AXI_LITE_bresp (18);
	 S_AXI_LITE_awprot (18) <= S_AXI_LITE18_awprot ;
	 S_AXI_LITE_awaddr (18) <= S_AXI_LITE18_awaddr ;
	 S_AXI_LITE18_awready  <= S_AXI_LITE_awready (18);
	 S_AXI_LITE_arprot (18) <= S_AXI_LITE18_arprot ;
	 S_AXI_LITE_awvalid (18) <= S_AXI_LITE18_awvalid ;
	 S_AXI_LITE_arvalid (18) <= S_AXI_LITE18_arvalid ;
	 S_AXI_LITE18_rresp  <= S_AXI_LITE_rresp (18);
	 S_AXI_LITE18_rvalid  <= S_AXI_LITE_rvalid (18);
	 S_AXI_LITE_wvalid (18) <= S_AXI_LITE18_wvalid ;
	 S_AXI_LITE_wdata (18) <= S_AXI_LITE18_wdata ;
	 S_AXI_LITE18_bvalid  <= S_AXI_LITE_bvalid (18);
	 S_AXI_LITE18_rdata  <= S_AXI_LITE_rdata (18);
	 S_AXI_LITE_araddr (18) <= S_AXI_LITE18_araddr ;
	 S_AXI_LITE_bready (18) <= S_AXI_LITE18_bready ;
	 S_AXI_LITE19_wready  <= S_AXI_LITE_wready (19);
	 S_AXI_LITE19_arready  <= S_AXI_LITE_arready (19);
	 S_AXI_LITE_rready (19) <= S_AXI_LITE19_rready ;
	 S_AXI_LITE_wstrb (19) <= S_AXI_LITE19_wstrb ;
	 S_AXI_LITE19_bresp  <= S_AXI_LITE_bresp (19);
	 S_AXI_LITE_awprot (19) <= S_AXI_LITE19_awprot ;
	 S_AXI_LITE_awaddr (19) <= S_AXI_LITE19_awaddr ;
	 S_AXI_LITE19_awready  <= S_AXI_LITE_awready (19);
	 S_AXI_LITE_arprot (19) <= S_AXI_LITE19_arprot ;
	 S_AXI_LITE_awvalid (19) <= S_AXI_LITE19_awvalid ;
	 S_AXI_LITE_arvalid (19) <= S_AXI_LITE19_arvalid ;
	 S_AXI_LITE19_rresp  <= S_AXI_LITE_rresp (19);
	 S_AXI_LITE19_rvalid  <= S_AXI_LITE_rvalid (19);
	 S_AXI_LITE_wvalid (19) <= S_AXI_LITE19_wvalid ;
	 S_AXI_LITE_wdata (19) <= S_AXI_LITE19_wdata ;
	 S_AXI_LITE19_bvalid  <= S_AXI_LITE_bvalid (19);
	 S_AXI_LITE19_rdata  <= S_AXI_LITE_rdata (19);
	 S_AXI_LITE_araddr (19) <= S_AXI_LITE19_araddr ;
	 S_AXI_LITE_bready (19) <= S_AXI_LITE19_bready ;
	 S_AXI_LITE20_wready  <= S_AXI_LITE_wready (20);
	 S_AXI_LITE20_arready  <= S_AXI_LITE_arready (20);
	 S_AXI_LITE_rready (20) <= S_AXI_LITE20_rready ;
	 S_AXI_LITE_wstrb (20) <= S_AXI_LITE20_wstrb ;
	 S_AXI_LITE20_bresp  <= S_AXI_LITE_bresp (20);
	 S_AXI_LITE_awprot (20) <= S_AXI_LITE20_awprot ;
	 S_AXI_LITE_awaddr (20) <= S_AXI_LITE20_awaddr ;
	 S_AXI_LITE20_awready  <= S_AXI_LITE_awready (20);
	 S_AXI_LITE_arprot (20) <= S_AXI_LITE20_arprot ;
	 S_AXI_LITE_awvalid (20) <= S_AXI_LITE20_awvalid ;
	 S_AXI_LITE_arvalid (20) <= S_AXI_LITE20_arvalid ;
	 S_AXI_LITE20_rresp  <= S_AXI_LITE_rresp (20);
	 S_AXI_LITE20_rvalid  <= S_AXI_LITE_rvalid (20);
	 S_AXI_LITE_wvalid (20) <= S_AXI_LITE20_wvalid ;
	 S_AXI_LITE_wdata (20) <= S_AXI_LITE20_wdata ;
	 S_AXI_LITE20_bvalid  <= S_AXI_LITE_bvalid (20);
	 S_AXI_LITE20_rdata  <= S_AXI_LITE_rdata (20);
	 S_AXI_LITE_araddr (20) <= S_AXI_LITE20_araddr ;
	 S_AXI_LITE_bready (20) <= S_AXI_LITE20_bready ;
	 S_AXI_LITE21_wready  <= S_AXI_LITE_wready (21);
	 S_AXI_LITE21_arready  <= S_AXI_LITE_arready (21);
	 S_AXI_LITE_rready (21) <= S_AXI_LITE21_rready ;
	 S_AXI_LITE_wstrb (21) <= S_AXI_LITE21_wstrb ;
	 S_AXI_LITE21_bresp  <= S_AXI_LITE_bresp (21);
	 S_AXI_LITE_awprot (21) <= S_AXI_LITE21_awprot ;
	 S_AXI_LITE_awaddr (21) <= S_AXI_LITE21_awaddr ;
	 S_AXI_LITE21_awready  <= S_AXI_LITE_awready (21);
	 S_AXI_LITE_arprot (21) <= S_AXI_LITE21_arprot ;
	 S_AXI_LITE_awvalid (21) <= S_AXI_LITE21_awvalid ;
	 S_AXI_LITE_arvalid (21) <= S_AXI_LITE21_arvalid ;
	 S_AXI_LITE21_rresp  <= S_AXI_LITE_rresp (21);
	 S_AXI_LITE21_rvalid  <= S_AXI_LITE_rvalid (21);
	 S_AXI_LITE_wvalid (21) <= S_AXI_LITE21_wvalid ;
	 S_AXI_LITE_wdata (21) <= S_AXI_LITE21_wdata ;
	 S_AXI_LITE21_bvalid  <= S_AXI_LITE_bvalid (21);
	 S_AXI_LITE21_rdata  <= S_AXI_LITE_rdata (21);
	 S_AXI_LITE_araddr (21) <= S_AXI_LITE21_araddr ;
	 S_AXI_LITE_bready (21) <= S_AXI_LITE21_bready ;
	 S_AXI_LITE22_wready  <= S_AXI_LITE_wready (22);
	 S_AXI_LITE22_arready  <= S_AXI_LITE_arready (22);
	 S_AXI_LITE_rready (22) <= S_AXI_LITE22_rready ;
	 S_AXI_LITE_wstrb (22) <= S_AXI_LITE22_wstrb ;
	 S_AXI_LITE22_bresp  <= S_AXI_LITE_bresp (22);
	 S_AXI_LITE_awprot (22) <= S_AXI_LITE22_awprot ;
	 S_AXI_LITE_awaddr (22) <= S_AXI_LITE22_awaddr ;
	 S_AXI_LITE22_awready  <= S_AXI_LITE_awready (22);
	 S_AXI_LITE_arprot (22) <= S_AXI_LITE22_arprot ;
	 S_AXI_LITE_awvalid (22) <= S_AXI_LITE22_awvalid ;
	 S_AXI_LITE_arvalid (22) <= S_AXI_LITE22_arvalid ;
	 S_AXI_LITE22_rresp  <= S_AXI_LITE_rresp (22);
	 S_AXI_LITE22_rvalid  <= S_AXI_LITE_rvalid (22);
	 S_AXI_LITE_wvalid (22) <= S_AXI_LITE22_wvalid ;
	 S_AXI_LITE_wdata (22) <= S_AXI_LITE22_wdata ;
	 S_AXI_LITE22_bvalid  <= S_AXI_LITE_bvalid (22);
	 S_AXI_LITE22_rdata  <= S_AXI_LITE_rdata (22);
	 S_AXI_LITE_araddr (22) <= S_AXI_LITE22_araddr ;
	 S_AXI_LITE_bready (22) <= S_AXI_LITE22_bready ;
	 S_AXI_LITE23_wready  <= S_AXI_LITE_wready (23);
	 S_AXI_LITE23_arready  <= S_AXI_LITE_arready (23);
	 S_AXI_LITE_rready (23) <= S_AXI_LITE23_rready ;
	 S_AXI_LITE_wstrb (23) <= S_AXI_LITE23_wstrb ;
	 S_AXI_LITE23_bresp  <= S_AXI_LITE_bresp (23);
	 S_AXI_LITE_awprot (23) <= S_AXI_LITE23_awprot ;
	 S_AXI_LITE_awaddr (23) <= S_AXI_LITE23_awaddr ;
	 S_AXI_LITE23_awready  <= S_AXI_LITE_awready (23);
	 S_AXI_LITE_arprot (23) <= S_AXI_LITE23_arprot ;
	 S_AXI_LITE_awvalid (23) <= S_AXI_LITE23_awvalid ;
	 S_AXI_LITE_arvalid (23) <= S_AXI_LITE23_arvalid ;
	 S_AXI_LITE23_rresp  <= S_AXI_LITE_rresp (23);
	 S_AXI_LITE23_rvalid  <= S_AXI_LITE_rvalid (23);
	 S_AXI_LITE_wvalid (23) <= S_AXI_LITE23_wvalid ;
	 S_AXI_LITE_wdata (23) <= S_AXI_LITE23_wdata ;
	 S_AXI_LITE23_bvalid  <= S_AXI_LITE_bvalid (23);
	 S_AXI_LITE23_rdata  <= S_AXI_LITE_rdata (23);
	 S_AXI_LITE_araddr (23) <= S_AXI_LITE23_araddr ;
	 S_AXI_LITE_bready (23) <= S_AXI_LITE23_bready ;
	 S_AXI_LITE24_wready  <= S_AXI_LITE_wready (24);
	 S_AXI_LITE24_arready  <= S_AXI_LITE_arready (24);
	 S_AXI_LITE_rready (24) <= S_AXI_LITE24_rready ;
	 S_AXI_LITE_wstrb (24) <= S_AXI_LITE24_wstrb ;
	 S_AXI_LITE24_bresp  <= S_AXI_LITE_bresp (24);
	 S_AXI_LITE_awprot (24) <= S_AXI_LITE24_awprot ;
	 S_AXI_LITE_awaddr (24) <= S_AXI_LITE24_awaddr ;
	 S_AXI_LITE24_awready  <= S_AXI_LITE_awready (24);
	 S_AXI_LITE_arprot (24) <= S_AXI_LITE24_arprot ;
	 S_AXI_LITE_awvalid (24) <= S_AXI_LITE24_awvalid ;
	 S_AXI_LITE_arvalid (24) <= S_AXI_LITE24_arvalid ;
	 S_AXI_LITE24_rresp  <= S_AXI_LITE_rresp (24);
	 S_AXI_LITE24_rvalid  <= S_AXI_LITE_rvalid (24);
	 S_AXI_LITE_wvalid (24) <= S_AXI_LITE24_wvalid ;
	 S_AXI_LITE_wdata (24) <= S_AXI_LITE24_wdata ;
	 S_AXI_LITE24_bvalid  <= S_AXI_LITE_bvalid (24);
	 S_AXI_LITE24_rdata  <= S_AXI_LITE_rdata (24);
	 S_AXI_LITE_araddr (24) <= S_AXI_LITE24_araddr ;
	 S_AXI_LITE_bready (24) <= S_AXI_LITE24_bready ;
	 S_AXI_LITE25_wready  <= S_AXI_LITE_wready (25);
	 S_AXI_LITE25_arready  <= S_AXI_LITE_arready (25);
	 S_AXI_LITE_rready (25) <= S_AXI_LITE25_rready ;
	 S_AXI_LITE_wstrb (25) <= S_AXI_LITE25_wstrb ;
	 S_AXI_LITE25_bresp  <= S_AXI_LITE_bresp (25);
	 S_AXI_LITE_awprot (25) <= S_AXI_LITE25_awprot ;
	 S_AXI_LITE_awaddr (25) <= S_AXI_LITE25_awaddr ;
	 S_AXI_LITE25_awready  <= S_AXI_LITE_awready (25);
	 S_AXI_LITE_arprot (25) <= S_AXI_LITE25_arprot ;
	 S_AXI_LITE_awvalid (25) <= S_AXI_LITE25_awvalid ;
	 S_AXI_LITE_arvalid (25) <= S_AXI_LITE25_arvalid ;
	 S_AXI_LITE25_rresp  <= S_AXI_LITE_rresp (25);
	 S_AXI_LITE25_rvalid  <= S_AXI_LITE_rvalid (25);
	 S_AXI_LITE_wvalid (25) <= S_AXI_LITE25_wvalid ;
	 S_AXI_LITE_wdata (25) <= S_AXI_LITE25_wdata ;
	 S_AXI_LITE25_bvalid  <= S_AXI_LITE_bvalid (25);
	 S_AXI_LITE25_rdata  <= S_AXI_LITE_rdata (25);
	 S_AXI_LITE_araddr (25) <= S_AXI_LITE25_araddr ;
	 S_AXI_LITE_bready (25) <= S_AXI_LITE25_bready ;
	 S_AXI_LITE26_wready  <= S_AXI_LITE_wready (26);
	 S_AXI_LITE26_arready  <= S_AXI_LITE_arready (26);
	 S_AXI_LITE_rready (26) <= S_AXI_LITE26_rready ;
	 S_AXI_LITE_wstrb (26) <= S_AXI_LITE26_wstrb ;
	 S_AXI_LITE26_bresp  <= S_AXI_LITE_bresp (26);
	 S_AXI_LITE_awprot (26) <= S_AXI_LITE26_awprot ;
	 S_AXI_LITE_awaddr (26) <= S_AXI_LITE26_awaddr ;
	 S_AXI_LITE26_awready  <= S_AXI_LITE_awready (26);
	 S_AXI_LITE_arprot (26) <= S_AXI_LITE26_arprot ;
	 S_AXI_LITE_awvalid (26) <= S_AXI_LITE26_awvalid ;
	 S_AXI_LITE_arvalid (26) <= S_AXI_LITE26_arvalid ;
	 S_AXI_LITE26_rresp  <= S_AXI_LITE_rresp (26);
	 S_AXI_LITE26_rvalid  <= S_AXI_LITE_rvalid (26);
	 S_AXI_LITE_wvalid (26) <= S_AXI_LITE26_wvalid ;
	 S_AXI_LITE_wdata (26) <= S_AXI_LITE26_wdata ;
	 S_AXI_LITE26_bvalid  <= S_AXI_LITE_bvalid (26);
	 S_AXI_LITE26_rdata  <= S_AXI_LITE_rdata (26);
	 S_AXI_LITE_araddr (26) <= S_AXI_LITE26_araddr ;
	 S_AXI_LITE_bready (26) <= S_AXI_LITE26_bready ;
	 S_AXI_LITE27_wready  <= S_AXI_LITE_wready (27);
	 S_AXI_LITE27_arready  <= S_AXI_LITE_arready (27);
	 S_AXI_LITE_rready (27) <= S_AXI_LITE27_rready ;
	 S_AXI_LITE_wstrb (27) <= S_AXI_LITE27_wstrb ;
	 S_AXI_LITE27_bresp  <= S_AXI_LITE_bresp (27);
	 S_AXI_LITE_awprot (27) <= S_AXI_LITE27_awprot ;
	 S_AXI_LITE_awaddr (27) <= S_AXI_LITE27_awaddr ;
	 S_AXI_LITE27_awready  <= S_AXI_LITE_awready (27);
	 S_AXI_LITE_arprot (27) <= S_AXI_LITE27_arprot ;
	 S_AXI_LITE_awvalid (27) <= S_AXI_LITE27_awvalid ;
	 S_AXI_LITE_arvalid (27) <= S_AXI_LITE27_arvalid ;
	 S_AXI_LITE27_rresp  <= S_AXI_LITE_rresp (27);
	 S_AXI_LITE27_rvalid  <= S_AXI_LITE_rvalid (27);
	 S_AXI_LITE_wvalid (27) <= S_AXI_LITE27_wvalid ;
	 S_AXI_LITE_wdata (27) <= S_AXI_LITE27_wdata ;
	 S_AXI_LITE27_bvalid  <= S_AXI_LITE_bvalid (27);
	 S_AXI_LITE27_rdata  <= S_AXI_LITE_rdata (27);
	 S_AXI_LITE_araddr (27) <= S_AXI_LITE27_araddr ;
	 S_AXI_LITE_bready (27) <= S_AXI_LITE27_bready ;
	 S_AXI_LITE28_wready  <= S_AXI_LITE_wready (28);
	 S_AXI_LITE28_arready  <= S_AXI_LITE_arready (28);
	 S_AXI_LITE_rready (28) <= S_AXI_LITE28_rready ;
	 S_AXI_LITE_wstrb (28) <= S_AXI_LITE28_wstrb ;
	 S_AXI_LITE28_bresp  <= S_AXI_LITE_bresp (28);
	 S_AXI_LITE_awprot (28) <= S_AXI_LITE28_awprot ;
	 S_AXI_LITE_awaddr (28) <= S_AXI_LITE28_awaddr ;
	 S_AXI_LITE28_awready  <= S_AXI_LITE_awready (28);
	 S_AXI_LITE_arprot (28) <= S_AXI_LITE28_arprot ;
	 S_AXI_LITE_awvalid (28) <= S_AXI_LITE28_awvalid ;
	 S_AXI_LITE_arvalid (28) <= S_AXI_LITE28_arvalid ;
	 S_AXI_LITE28_rresp  <= S_AXI_LITE_rresp (28);
	 S_AXI_LITE28_rvalid  <= S_AXI_LITE_rvalid (28);
	 S_AXI_LITE_wvalid (28) <= S_AXI_LITE28_wvalid ;
	 S_AXI_LITE_wdata (28) <= S_AXI_LITE28_wdata ;
	 S_AXI_LITE28_bvalid  <= S_AXI_LITE_bvalid (28);
	 S_AXI_LITE28_rdata  <= S_AXI_LITE_rdata (28);
	 S_AXI_LITE_araddr (28) <= S_AXI_LITE28_araddr ;
	 S_AXI_LITE_bready (28) <= S_AXI_LITE28_bready ;
	 S_AXI_LITE29_wready  <= S_AXI_LITE_wready (29);
	 S_AXI_LITE29_arready  <= S_AXI_LITE_arready (29);
	 S_AXI_LITE_rready (29) <= S_AXI_LITE29_rready ;
	 S_AXI_LITE_wstrb (29) <= S_AXI_LITE29_wstrb ;
	 S_AXI_LITE29_bresp  <= S_AXI_LITE_bresp (29);
	 S_AXI_LITE_awprot (29) <= S_AXI_LITE29_awprot ;
	 S_AXI_LITE_awaddr (29) <= S_AXI_LITE29_awaddr ;
	 S_AXI_LITE29_awready  <= S_AXI_LITE_awready (29);
	 S_AXI_LITE_arprot (29) <= S_AXI_LITE29_arprot ;
	 S_AXI_LITE_awvalid (29) <= S_AXI_LITE29_awvalid ;
	 S_AXI_LITE_arvalid (29) <= S_AXI_LITE29_arvalid ;
	 S_AXI_LITE29_rresp  <= S_AXI_LITE_rresp (29);
	 S_AXI_LITE29_rvalid  <= S_AXI_LITE_rvalid (29);
	 S_AXI_LITE_wvalid (29) <= S_AXI_LITE29_wvalid ;
	 S_AXI_LITE_wdata (29) <= S_AXI_LITE29_wdata ;
	 S_AXI_LITE29_bvalid  <= S_AXI_LITE_bvalid (29);
	 S_AXI_LITE29_rdata  <= S_AXI_LITE_rdata (29);
	 S_AXI_LITE_araddr (29) <= S_AXI_LITE29_araddr ;
	 S_AXI_LITE_bready (29) <= S_AXI_LITE29_bready ;
	 S_AXI_LITE30_wready  <= S_AXI_LITE_wready (30);
	 S_AXI_LITE30_arready  <= S_AXI_LITE_arready (30);
	 S_AXI_LITE_rready (30) <= S_AXI_LITE30_rready ;
	 S_AXI_LITE_wstrb (30) <= S_AXI_LITE30_wstrb ;
	 S_AXI_LITE30_bresp  <= S_AXI_LITE_bresp (30);
	 S_AXI_LITE_awprot (30) <= S_AXI_LITE30_awprot ;
	 S_AXI_LITE_awaddr (30) <= S_AXI_LITE30_awaddr ;
	 S_AXI_LITE30_awready  <= S_AXI_LITE_awready (30);
	 S_AXI_LITE_arprot (30) <= S_AXI_LITE30_arprot ;
	 S_AXI_LITE_awvalid (30) <= S_AXI_LITE30_awvalid ;
	 S_AXI_LITE_arvalid (30) <= S_AXI_LITE30_arvalid ;
	 S_AXI_LITE30_rresp  <= S_AXI_LITE_rresp (30);
	 S_AXI_LITE30_rvalid  <= S_AXI_LITE_rvalid (30);
	 S_AXI_LITE_wvalid (30) <= S_AXI_LITE30_wvalid ;
	 S_AXI_LITE_wdata (30) <= S_AXI_LITE30_wdata ;
	 S_AXI_LITE30_bvalid  <= S_AXI_LITE_bvalid (30);
	 S_AXI_LITE30_rdata  <= S_AXI_LITE_rdata (30);
	 S_AXI_LITE_araddr (30) <= S_AXI_LITE30_araddr ;
	 S_AXI_LITE_bready (30) <= S_AXI_LITE30_bready ;
	 S_AXI_LITE31_wready  <= S_AXI_LITE_wready (31);
	 S_AXI_LITE31_arready  <= S_AXI_LITE_arready (31);
	 S_AXI_LITE_rready (31) <= S_AXI_LITE31_rready ;
	 S_AXI_LITE_wstrb (31) <= S_AXI_LITE31_wstrb ;
	 S_AXI_LITE31_bresp  <= S_AXI_LITE_bresp (31);
	 S_AXI_LITE_awprot (31) <= S_AXI_LITE31_awprot ;
	 S_AXI_LITE_awaddr (31) <= S_AXI_LITE31_awaddr ;
	 S_AXI_LITE31_awready  <= S_AXI_LITE_awready (31);
	 S_AXI_LITE_arprot (31) <= S_AXI_LITE31_arprot ;
	 S_AXI_LITE_awvalid (31) <= S_AXI_LITE31_awvalid ;
	 S_AXI_LITE_arvalid (31) <= S_AXI_LITE31_arvalid ;
	 S_AXI_LITE31_rresp  <= S_AXI_LITE_rresp (31);
	 S_AXI_LITE31_rvalid  <= S_AXI_LITE_rvalid (31);
	 S_AXI_LITE_wvalid (31) <= S_AXI_LITE31_wvalid ;
	 S_AXI_LITE_wdata (31) <= S_AXI_LITE31_wdata ;
	 S_AXI_LITE31_bvalid  <= S_AXI_LITE_bvalid (31);
	 S_AXI_LITE31_rdata  <= S_AXI_LITE_rdata (31);
	 S_AXI_LITE_araddr (31) <= S_AXI_LITE31_araddr ;
	 S_AXI_LITE_bready (31) <= S_AXI_LITE31_bready ;

uart_channel_array_inst : component uart_channel_array
  generic map(
    TOTAL_TILES => 8 ,
    TOTAL_CHANNELS =>  32 
  )
  port map(
   ACLK => ACLK,
   ARESETN => ARESETN,
   MCLK    => MCLK,
   MRST    => MRST,
   M_AXIS_tdata => M_AXIS_tdata,
    M_AXIS_tkeep => M_AXIS_tkeep ,
    M_AXIS_tlast => M_AXIS_tlast,
    M_AXIS_tready => M_AXIS_tready,
    M_AXIS_tstrb  => M_AXIS_tstrb,
    M_AXIS_tvalid => M_AXIS_tvalid,
    PACMAN_TS     => PACMAN_TS,
    S_AXIS_tdata  => S_AXIS_tdata,
    S_AXIS_tkeep  => S_AXIS_tkeep,
    S_AXIS_tlast  => S_AXIS_tlast,
    S_AXIS_tready => S_AXIS_tready,
    S_AXIS_tstrb  => S_AXIS_tstrb,
    S_AXIS_tvalid => S_AXIS_tvalid,
    S_AXI_LITE_araddr => S_AXI_LITE_araddr,
    S_AXI_LITE_arprot => S_AXI_LITE_arprot,
    S_AXI_LITE_arready => S_AXI_LITE_arready,
    S_AXI_LITE_arvalid => S_AXI_LITE_arvalid,
    S_AXI_LITE_awaddr  => S_AXI_LITE_awaddr,
    S_AXI_LITE_awprot  => S_AXI_LITE_awprot,
    S_AXI_LITE_awready => S_AXI_LITE_awready,
    S_AXI_LITE_awvalid => S_AXI_LITE_awvalid,
    S_AXI_LITE_bready  => S_AXI_LITE_bready,
    S_AXI_LITE_bresp   => S_AXI_LITE_bresp,
    S_AXI_LITE_bvalid  => S_AXI_LITE_bvalid,
    S_AXI_LITE_rdata   => S_AXI_LITE_rdata,
    S_AXI_LITE_rready  => S_AXI_LITE_rready,
    S_AXI_LITE_rresp   => S_AXI_LITE_rresp,
    S_AXI_LITE_rvalid  => S_AXI_LITE_rvalid,
    S_AXI_LITE_wdata   =>  S_AXI_LITE_wdata,
    S_AXI_LITE_wready  => S_AXI_LITE_wready,
    S_AXI_LITE_wstrb   => S_AXI_LITE_wstrb,
    S_AXI_LITE_wvalid  => S_AXI_LITE_wvalid,
    MISO               => MISO,
    UART_RX_BUSY       => UART_RX_BUSY,
    UART_TX_BUSY       => UART_TX_BUSY,
    TILE_EN            => TILE_EN,
    MOSI               => MOSI 
  );
end arch_imp;

