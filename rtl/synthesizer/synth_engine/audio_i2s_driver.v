module audio_i2s_driver (
	input               reset_reg_N,
	input               iAUD_LRCK,
	input               iAUD_BCK,
`ifdef	_24BitAudio
	input [23:0]        i_lsound_out, // 24-bits
	input [23:0]        i_rsound_out, // 24-bits
`else
	input [15:0]        i_lsound_out, // 16-bits
	input [15:0]        i_rsound_out, // 16-bits
`endif 
	output              oAUD_DATA
);

	reg [4:0]         SEL_Cont;
`ifdef	_24BitAudio
	reg signed [23:0] sound_out; // 24-bits
`else
	reg signed [15:0] sound_out; // 16-bits
`endif 
	reg reg_edge_detected;
	reg reg_lrck_dly;

	wire edge_detected = reg_lrck_dly ^ iAUD_LRCK;
	
////////////        SoundOut        ///////////////
	always@(posedge iAUD_BCK)begin
		reg_edge_detected <= edge_detected;
	end

    always@(negedge iAUD_BCK or negedge reset_reg_N)begin
        if(!reset_reg_N)begin
            SEL_Cont    <=  5'h0;
        end
        else begin
            reg_lrck_dly <= iAUD_LRCK;

			if (reg_edge_detected) begin 	SEL_Cont <= 5'h0; 				end // i2s mode 1 bclk delay
			else begin 						SEL_Cont <= SEL_Cont + 1'b1;	end

            if (SEL_Cont == 5'h1f) begin
                if (iAUD_LRCK) begin 	sound_out <= i_rsound_out; end
				else begin 				sound_out <= i_lsound_out; end
			end	
        end
    end

`ifdef _24BitAudio
    assign  oAUD_DATA   =  (SEL_Cont <= 23) ? sound_out[(~SEL_Cont)-5'd8] : 1'b0; // 24-bits
`else
    assign  oAUD_DATA   =  (SEL_Cont <= 15 ) ? sound_out[~SEL_Cont[4:0]] : 1'b0; // 16-bits
`endif

endmodule
