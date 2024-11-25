module bufgmux_utility(
		       input wire I0,
		       input wire I1,
		       input wire S,
		       output wire O
  );
   
BUFGMUX #(
   .CLK_SEL_TYPE("ASYNC")  // ASYNC, SYNC
)
BUFGMUX_inst (
   .O(O),   // 1-bit output: Clock output
   .I0(I0), // 1-bit input: Clock input (S=0)
   .I1(I1), // 1-bit input: Clock input (S=1)
   .S(S)    // 1-bit input: Clock select
);

endmodule // bufgmux_utility
