
module nco2 (
    input	iRST_N,
    input	OSC_CLK,
    input	sCLK_XVXOSC,
    input	sCLK_XVXENVS,
    input	[23:0]osc_pitch_val,
    input	[V_ENVS-1:0]osc_accum_zero,
    input	[O_WIDTH-1:0] ox,
    input	[V_WIDTH-1:0] vx,
    output	[10:0]phase_acc
);

parameter VOICES = 8;
parameter V_OSC = 4;
parameter V_ENVS = 8;
parameter V_WIDTH = 3;
parameter O_WIDTH = 2;
parameter x_offset = (V_OSC * VOICES ) - 2;

//	assign phase_acc = reg_phase_accum[25:15];
	assign phase_acc = phase_accum_b[24:14];
	assign reset = osc_accum_zero[{ox,1'b0}];
//	assign reset = osc_accum_zero[ox_dly[0]];
	
	reg [V_WIDTH-1:0] vx_dly[x_offset:0];
	reg [O_WIDTH-1:0] ox_dly[x_offset:0];
	reg					reg_reset[VOICES-1:0][V_OSC-1:0];
	wire				reset;
	wire				reset_a;
	wire				reset_b;
	reg signed [10:0] 	reg_phase_acc;   
	reg [23:0] 			reg_osc_pitch_val;
	wire [23:0] 		osc_pitch_val_a;
	wire [23:0] 		osc_pitch_val_b;
	wire [25:0]			phase_accum_a; // 36 bits phase accumulator
	wire [25:0]			phase_accum_b; // 36 bits phase accumulator
	reg [24:0]			reg_phase_accum; // 36 bits phase accumulator
	integer o1,d1;
    nco_ram #(.VOICES(VOICES),.V_OSC(V_OSC),.V_WIDTH(V_WIDTH),.O_WIDTH(O_WIDTH))nco_ram_inst
	(
		.qa({reset_a,phase_accum_a,osc_pitch_val_a}) ,  // output [16+37+37+8+21+9-1:0] q_sig
		.qb({reset_b,phase_accum_b,osc_pitch_val_b}) ,  // output [16+37+37+8+21+9-1:0] q_sig
		.d({reset,reg_phase_accum,reg_osc_pitch_val}) ,    // input [15+36+36+7+20+8:0] d_sig
//		.d({reset,reg_phase_accum,osc_pitch_val}) ,    // input [15+36+36+7+20+8:0] d_sig
		.write_address({vx_dly[0],ox_dly[0]}) ,   // input  write_address_sig
		.reada_address({vx,ox}) ,    // input  read_address_sig
		.readb_address({vx_dly[x_offset],ox_dly[x_offset]}) ,    // input  read_address_sig
		.we(1'b1) , // input  we_sig
//		.wclk(~sCLK_XVXOSC  ),     // input  clk_sig
		.wclk(~sCLK_XVXENVS  ),     // input  clk_sig
		.raclk(~sCLK_XVXOSC  ),     // input  clk_sig
		.rbclk(sCLK_XVXOSC )     // input  clk_sig
//		.rbclk(~sCLK_XVXENVS )     // input  clk_sig
	);

//				always @(posedge sCLK_XVXOSC or negedge iRST_N)begin
				always @(posedge sCLK_XVXENVS or negedge iRST_N)begin
					if ( !iRST_N)  reg_phase_accum <= 25'b0;
//					else  begin reg_phase_accum <= reset_a ? 26'b0 : (phase_accum_a + osc_pitch_val_a); end
					else  begin reg_phase_accum <= reg_reset[vx][ox] ? 25'b0 : (phase_accum_a + osc_pitch_val_a); end
//					else  begin reg_phase_accum <= reg_reset ? 26'b0 : (phase_accum_a + osc_pitch_val_a); end
//					else  reg_phase_accum <= phase_accum_a + osc_pitch_val_a;
				end
/*	
	genvar vloop,oloop;
	generate 
		for(vloop=0;vloop<VOICES;vloop=vloop+1) begin : phase_gens_outer
			for(oloop=0;oloop<V_OSC;oloop=oloop+1) begin: phase_gens_inner
				always @(posedge sCLK_XVXOSC or posedge reg_reset[vloop][oloop]  or negedge iRST_N)begin
					if (reg_reset[vloop][oloop] || !iRST_N)  phase_accum[vloop][oloop] <= 26'h0000000;
					else  phase_accum[vloop][oloop] <= phase_accum[vloop][oloop] + reg_osc_pitch_val[vloop][oloop];
				end
			end
		end
	endgenerate
*/
	always @(posedge sCLK_XVXOSC)begin
//	always @(posedge sCLK_XVXENVS)begin
		vx_dly[0] <= vx; ox_dly[0] <= ox;
		for(d1=0;d1<x_offset;d1=d1+1) begin // all Voices 2 osc's
			vx_dly[d1+1] <= vx_dly[d1]; ox_dly[d1+1] <= ox_dly[d1];
		end
//		reg_reset <= osc_accum_zero[{ox_dly[0],1'b0}];
//		reg_reset <= osc_accum_zero[{ox,1'b0}];
		reg_osc_pitch_val <= osc_pitch_val;
		reg_reset[vx_dly[0]][ox_dly[0]] <= osc_accum_zero[{ox_dly[0],1'b0}];
//		reg_phase_acc <= phase_accum_b[25:15];
//		vx_dly[0] <= vx; ox_dly[0] <= ox;
//		for(d1=0;d1<x_offset;d1=d1+1) begin // all Voices 2 osc's
//			vx_dly[d1+1] <= vx_dly[d1]; ox_dly[d1+1] <= ox_dly[d1];
//		end
//		reg_reset <= osc_accum_zero[{ox_dly[0],1'b0}];
//		reg_reset <= osc_accum_zero[{ox_dly[1],1'b0}];
//		reg_osc_pitch_val <= osc_pitch_val;
//		reg_phase_acc <= phase_accum_b[25:15];
	end
	 
endmodule