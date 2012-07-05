module audio_i2s_driver (
  //  input               mCLK,
    input               iRST_N,
    input [15:0]        i_lsound_out, // 16-bits
    input [15:0]        i_rsound_out, // 16-bits
//    input [23:0]        i_rsound_out, // 24-bits
     input               iAUD_LRCK,
    input               iAUD_BCK,
   output              oAUD_DATA
//    output [3:0]        s_cnt
);

    reg [4:0]         SEL_Cont;
    reg signed [15:0] sound_out; // 16-bits
//    reg signed [23:0] sound_out; // 24-bits

//    assign s_cnt = SEL_Cont[3:0];


    reg reset1,r_done;

////////////        SoundOut        ///////////////
    always@(posedge iAUD_LRCK or posedge r_done)begin
        if (r_done) reset1 <= 1'b0;
        else if(iAUD_LRCK) reset1 <= 1'b1;
    end

    always@(posedge reset1 or negedge iAUD_BCK or negedge iRST_N)begin
        if(!iRST_N)begin
            SEL_Cont    <=  0; r_done <= 1'b0;
        end
        else if(reset1) begin
            SEL_Cont <= 31; r_done <= 1'b1; // 16-bits
//            SEL_Cont <= 24; r_done <= 1'b1; // 24-bits
        end
        else begin
            SEL_Cont    <=  SEL_Cont-1;
            if(SEL_Cont == 5'h10) begin
                sound_out <= i_rsound_out;
            end
            if(SEL_Cont == 5'h00) begin
                sound_out <= i_lsound_out;
            end
            r_done <= 1'b0;
        end
    end

//    assign  oAUD_DATA   =  (SEL_Cont < 16) ? sound_out[SEL_Cont[3:0]] : 1'b0; // 16-bits
    assign  oAUD_DATA   =  sound_out[SEL_Cont[3:0]]; // 16-bits
//    assign  oAUD_DATA   =  (SEL_Cont < 24) ? sound_out[SEL_Cont] : 1'b0; // 24-bits


endmodule
