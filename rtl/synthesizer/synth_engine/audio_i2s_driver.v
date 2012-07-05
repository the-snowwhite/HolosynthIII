module audio_i2s_driver (
	input               iRST_N,
	input               iAUD_LRCK,
	input               iAUD_BCK,
	input [15:0]        i_lsound_out, // 16-bits
	input [15:0]        i_rsound_out, // 16-bits
	output              oAUD_DATA
);

	reg [3:0]         SEL_Cont;
	reg signed [15:0] sound_out; // 16-bits
	reg reg_edge_detected;
	reg reg_lrck_dly;

	wire edge_detected = reg_lrck_dly ^ iAUD_LRCK;
	
////////////        SoundOut        ///////////////
	always@(posedge iAUD_BCK)begin
		reg_edge_detected <= edge_detected;
	end

    always@(negedge iAUD_BCK or negedge iRST_N)begin
        if(!iRST_N)begin
            SEL_Cont    <=  4'h0;
        end
        else begin
            reg_lrck_dly <= iAUD_LRCK;

			if (reg_edge_detected) begin 	SEL_Cont <= 4'h1; 				end
			else begin 						SEL_Cont <= SEL_Cont + 4'h1;	end

            if (SEL_Cont == 4'hf) begin
                if (iAUD_LRCK) begin 	sound_out <= i_rsound_out; end
				else begin 				sound_out <= i_lsound_out; end
			end	
        end
    end

//    assign  oAUD_DATA   =  (SEL_Cont < 16) ? sound_out[SEL_Cont[3:0]] : 1'b0; // 16-bits
    assign  oAUD_DATA   =  sound_out[~SEL_Cont]; // 16-bits
//    assign  oAUD_DATA   =  (SEL_Cont < 24) ? sound_out[SEL_Cont] : 1'b0; // 24-bits


endmodule
