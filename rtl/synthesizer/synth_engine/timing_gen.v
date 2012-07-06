module timing_gen (
	input sCLK_XVXENVS, // clk
	input   iRST_N,    // reset
	output reg [V_WIDTH+E_WIDTH-1:0]xxxx,  // index counter 
	output   n_xxxx_zero
);

parameter VOICES = 8;
parameter V_ENVS = 8;
parameter V_WIDTH = 3;
parameter E_WIDTH = 3;

	reg r_xxxx_max;

	wire xxxx_max = (xxxx == (VOICES*V_ENVS)-1) ? 1'b1:1'b0;
	assign n_xxxx_zero = r_xxxx_max;
	
	always @(negedge sCLK_XVXENVS)begin r_xxxx_max <= xxxx_max; end

	always @(posedge sCLK_XVXENVS or negedge iRST_N)begin
		if(!iRST_N) begin xxxx <= 0; end
		else begin
			if(xxxx_max ) begin xxxx <= 0; end
			else begin xxxx <= xxxx + 1'b1; end
		end
	end

endmodule
