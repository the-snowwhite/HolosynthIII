module nco (
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
	assign phase_acc = reg_phase_acc;	
	reg [V_WIDTH-1:0] vx_dly[x_offset:0];
	reg [O_WIDTH-1:0] ox_dly[x_offset:0];
	reg					reg_reset[VOICES-1:0][V_OSC-1:0];
	reg signed [10:0] 	reg_phase_acc;   
	reg [23:0] 			reg_osc_pitch_val[VOICES-1:0][V_OSC-1:0];
	reg [35:0]			phase_accum[VOICES-1:0][V_OSC-1:0]; // 36 bits phase accumulator
	integer o1,d1;
	genvar vloop,oloop;
	generate 
		for(vloop=0;vloop<VOICES;vloop=vloop+1) begin : phase_gens_outer
			for(oloop=0;oloop<V_OSC;oloop=oloop+1) begin: phase_gens_inner
				always @(posedge OSC_CLK or posedge reg_reset[vloop][oloop]  or negedge iRST_N)begin
					if (reg_reset[vloop][oloop] || !iRST_N)  phase_accum[vloop][oloop] <= 36'h0000000;
					else  phase_accum[vloop][oloop] <= phase_accum[vloop][oloop] + reg_osc_pitch_val[vloop][oloop];
				end
			end
		end
	endgenerate
	always @(posedge sCLK_XVXOSC)begin
		vx_dly[0] <= vx; ox_dly[0] <= ox;
		for(d1=0;d1<x_offset;d1=d1+1) begin // all Voices 2 osc's
			vx_dly[d1+1] <= vx_dly[d1]; ox_dly[d1+1] <= ox_dly[d1];
		end
		reg_reset[vx_dly[0]][ox_dly[0]] <= osc_accum_zero[{ox_dly[0],1'b0}];
		reg_osc_pitch_val[vx][ox] <= osc_pitch_val;
		reg_phase_acc <= phase_accum[vx_dly[x_offset]][ox_dly[x_offset]][35:25];
	end
endmodule
