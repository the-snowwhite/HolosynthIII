module osc (
    input         iRST_N,
    input         OSC_CLK,
    input         sCLK_XVXENVS,
    input         sCLK_XVXOSC,
    input         [7:0] data,
    input         [6:0] adr,
    input         write,
    input [V_WIDTH+E_WIDTH-1:0] xxxx,
    input         osc_sel,
    input         [23:0]osc_pitch_val,
    input         [10:0] modulation,
    input         [VOICES-1:0]voice_free,
    input         [V_ENVS-1:0]osc_accum_zero,
    output        [16:0] sine_lut_out
);

parameter VOICES = 8;
parameter V_OSC = 4;
parameter V_ENVS = 8;
parameter V_WIDTH = 3;
parameter O_WIDTH = 2;
parameter OE_WIDTH = 1;
parameter E_WIDTH = O_WIDTH + OE_WIDTH;

//parameter ox_offset = (V_OSC * (VOICES -1)) + 1;
//parameter ox_offset = 15; //(V_OSC * (VOICES -1)) + 1; 4x 4
parameter ox_offset = (V_OSC * VOICES ) - 1;

    wire [10:0]tablelookup;
    wire signed [10:0]phase_acc;
    wire signed [10:0] mod;

    wire         [O_WIDTH-1:0] ox;
    wire         [V_WIDTH-1:0] vx;
    assign ox = xxxx[E_WIDTH-1:OE_WIDTH];
    assign vx = xxxx[V_WIDTH+E_WIDTH-1:E_WIDTH];

//    input         [V_WIDTH-1:0]waveform,
    reg signed [7:0] o_offs [V_OSC-1:0];
//    reg [O_WIDTH-1:0] ox_dly[3:0]; // 2 Voices 2 osc's
    reg [O_WIDTH-1:0] ox_dly[ox_offset:0]; // All Voices 2 osc's ?

    assign mod = modulation;

    integer loop,o1,d1;

    always@(posedge sCLK_XVXOSC)begin
        ox_dly[0] <= ox;
//		  for(d1=0;d1<=2;d1=d1+1) // 2 Voices 2 osc's
		  for(d1=0;d1<ox_offset;d1=d1+1)
        ox_dly[d1+1] <= ox_dly[d1];
    end

    always@(negedge iRST_N or negedge write)begin
        if(!iRST_N) begin
            for (loop=0;loop<V_OSC;loop=loop+1)begin
                o_offs[loop] <= 8'h00;
            end
        end else begin
            if(osc_sel)begin
                for (o1=0;o1<V_OSC;o1=o1+1)begin
                    if (adr == (6+(o1<<4))) o_offs[o1] <= data;
                end
            end
        end
    end


    sine_lookup osc_sine(.clk( sCLK_XVXENVS ), .addr( tablelookup ), .sine_value( sine_lut_out ));

//    assign tablelookup = phase_acc + mod + (o_offs[ox_dly[3]] << 3); // 2 Voices 2 osc's
    assign tablelookup = phase_acc + mod + (o_offs[ox_dly[ox_offset]] << 3);


	nco #(.VOICES(VOICES),.V_OSC(V_OSC),.V_WIDTH(V_WIDTH),.V_ENVS(V_ENVS),.O_WIDTH(O_WIDTH))  nco_inst (
		.iRST_N(iRST_N) ,   // input  iRST_N_sig
		.OSC_CLK ( OSC_CLK ),
		.sCLK_XVXOSC (sCLK_XVXOSC ),
		.sCLK_XVXENVS (sCLK_XVXENVS ),
		.osc_pitch_val ( osc_pitch_val ),
//		.voice_free ( voice_free ),
		.osc_accum_zero ( osc_accum_zero ),
		.ox    ( ox ),
		.vx    ( vx ),
		.phase_acc ( phase_acc )
	);

endmodule
