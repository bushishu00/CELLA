//Verilog HDL for "CIM_macro", "verilog_dummy_cell_stimulus" "functional"


module dummy_cell_stimulus (
	output reg wl, preb
 );
	initial begin
	// reset
	wl=0;
	preb=0;
	
	// start
	#10
	wl=1;
	preb=1;

	#10
	wl=0;
	preb=0;

	#10
	wl=1;
	preb=1;

	#10
	wl=0;
	preb=0;

	#10
	wl=1;
	preb=0;

	#10
	wl=0;
	preb=0;

	
	end
endmodule
