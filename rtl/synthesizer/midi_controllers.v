module midi_controllers (
    input iRST_N,
    input CLOCK_25,
//    input [7:0]SW,
//@name from midi_decoder
//    input           ictrl_cmd,
//    input           prg_ch_cmd,
    input  [7:0]    ictrl,
    input  [7:0]    ictrl_data,
    input           pitch_cmd,
//    input  [7:0]    prg_ch_data,
//    input   [7:0]   cur_sysex_data
//@name controller & status signals //
//    output [3:0]hex_disp[8],
//    output [7:0]disp_data[94],
//    output [7:0] o_index,
//@name cpu signals //
//    input [2:0] N_adr_data_rdy, // 2'b01 = read from synth/save to disk; 2'b11 = write to synth/load from disk
//    input [8:0] N_adr,              // data addr.
//    output [7:0] N_synth_out_data,      // data byte from synth to nios
//    input [7:0] N_synth_in_data,        // data byte from nios to synth
//@name touch signals    //

//@name     Controller Values       //
//    output signed [7:0] env_buf[16][V_OSC],
//    output signed [7:0] osc_buf[16][V_OSC],
//    output signed [7:0] mat_buf1[16][V_OSC],
//    output signed [7:0] mat_buf2[16][V_OSC],
//    output signed [7:0] com_buf[16][2],
    output reg [13:0]pitch_val
//    output N_save_sig,
//    output N_load_sig
);

parameter   VOICES = 8;// Set in toplevel
parameter   V_OSC = 4; // oscs per Voice  // Set in toplevel
//parameter V_WIDTH = utils::clogb2(VOICES);
parameter V_WIDTH = 3;
//parameter O_WIDTH = utils::clogb2(V_OSC);
//parameter B_WIDTH = utils::clogb2(V_OSC)+3;
parameter O_WIDTH = 2;
parameter B_WIDTH = O_WIDTH+3;

//wire[7:0] midi_data[128];
//wire[7:0] touch_data[94];

//reg signed[7:0] synth_data[16][(4*V_OSC)+2];


////////    Ctrl registers  midi ctrl nr.   ////////
/*
assign disp_data[0] =  env_buf[4'h0][0] ;// r[0][0]
assign disp_data[1] =  env_buf[4'h4][0] ;// l[0][0]
assign disp_data[2] =  env_buf[4'h1][0] ;//r[0][1]
assign disp_data[3] =  env_buf[4'h5][0] ;//l[0][1]
assign disp_data[4] =  env_buf[4'h2][0] ;//r[0][2]
assign disp_data[5] =  env_buf[4'h6][0] ;//l[0][2]
assign disp_data[6] =  env_buf[4'h3][0] ;
assign disp_data[7] =  env_buf[4'h7][0] ;
// 1 -- b0001
assign disp_data[8] =  env_buf[4'h0][1] ;
assign disp_data[9] =  env_buf[4'h4][1] ;
assign disp_data[10] =  env_buf[4'h1][1] ;
assign disp_data[11] =  env_buf[4'h5][1] ;
assign disp_data[12] =  env_buf[4'h2][1] ;
assign disp_data[13] =  env_buf[4'h6][1] ;
assign disp_data[14] =  env_buf[4'h3][1] ;
assign disp_data[15] =  env_buf[4'h7][1] ;
// 2 -- b0010
assign disp_data[16] =  env_buf[4'h0][2] ;
assign disp_data[17] =  env_buf[4'h4][2] ;
assign disp_data[18] =  env_buf[4'h1][2] ;
assign disp_data[19] =  env_buf[4'h5][2] ;
assign disp_data[20] =  env_buf[4'h2][2] ;
assign disp_data[21] =  env_buf[4'h6][2] ;
assign disp_data[22] =  env_buf[4'h3][2] ;
assign disp_data[23] =  env_buf[4'h7][2] ;
// 3 -- b0011
assign disp_data[24] =  env_buf[4'h0][3] ;
assign disp_data[25] =  env_buf[4'h4][3] ;
assign disp_data[26] =  env_buf[4'h1][3] ;
assign disp_data[27] =  env_buf[4'h5][3] ;
assign disp_data[28] =  env_buf[4'h2][3] ;
assign disp_data[29] =  env_buf[4'h6][3] ;
assign disp_data[30] =  env_buf[7'h3][3] ;
assign disp_data[31] =  env_buf[4'h7][3] ;
// 4 -- b0100
assign disp_data[32] =  osc_buf[4'h0][0] ;
assign disp_data[33] =  osc_buf[4'h1][0] ;
assign disp_data[34] =  osc_buf[4'h2][0] ;
assign disp_data[35] =  osc_buf[4'h3][0] ;
assign disp_data[36] =  osc_buf[4'h4][0] ;
assign disp_data[37] =  osc_buf[4'h5][0] ;
assign disp_data[38] =  osc_buf[4'h6][0] ;
assign disp_data[39] =  osc_buf[4'h7][0] ;
// 5 -- b0101
assign disp_data[40] =  osc_buf[4'h8][0] ;
assign disp_data[41] =  osc_buf[4'h9][0] ;
assign disp_data[42] =  osc_buf[4'ha][0] ;
assign disp_data[43] =  osc_buf[4'hb][0] ;
// 6 -- b0110
assign disp_data[48] =  osc_buf[4'h0][1] ;
assign disp_data[49] =  osc_buf[4'h1][1] ;
assign disp_data[50] =  osc_buf[4'h2][1] ;
assign disp_data[51] =  osc_buf[4'h3][1] ;
assign disp_data[52] =  osc_buf[4'h4][1] ;
assign disp_data[53] =  osc_buf[4'h5][1] ;
assign disp_data[54] =  osc_buf[4'h6][1] ;
assign disp_data[55] =  osc_buf[4'h7][1] ;
// 7 -- b0111
assign disp_data[56] =  osc_buf[4'h8][1] ;
assign disp_data[57] =  osc_buf[4'h9][1] ;
assign disp_data[58] =  osc_buf[4'ha][1] ;
assign disp_data[59] =  osc_buf[4'hb][1] ;
// 8 -- b1000
assign disp_data[64] =  osc_buf[4'h0][2] ;
assign disp_data[65] =  osc_buf[4'h1][2] ;
assign disp_data[66] =  osc_buf[4'h2][2] ;
assign disp_data[67] =  osc_buf[4'h3][2] ;
assign disp_data[68] =  osc_buf[4'h4][2] ;
assign disp_data[69] =  osc_buf[4'h5][2] ;
assign disp_data[70] =  osc_buf[4'h6][2] ;
assign disp_data[71] =  osc_buf[4'h7][2] ;
// 9 -- b1001
assign disp_data[72] =  osc_buf[4'h8][2] ;
assign disp_data[73] =  osc_buf[4'h9][2] ;
assign disp_data[74] =  osc_buf[4'ha][2] ;
assign disp_data[75] =  osc_buf[4'hb][2] ;
// 10 -- b1010
assign disp_data[80] =  osc_buf[4'h0][3] ;
assign disp_data[81] =  osc_buf[4'h1][3] ;
assign disp_data[82] =  osc_buf[4'h2][3] ;
assign disp_data[83] =  osc_buf[4'h3][3] ;
assign disp_data[84] =  osc_buf[4'h4][3] ;
assign disp_data[85] =  osc_buf[4'h5][3] ;
assign disp_data[86] =  osc_buf[4'h6][3] ;
assign disp_data[87] =  osc_buf[4'h7][3] ;
// 11 -- b1011
assign disp_data[88] =  osc_buf[4'h8][3] ;
assign disp_data[89] =  osc_buf[4'h9][3] ;
assign disp_data[90] =  osc_buf[4'ha][3] ;
assign disp_data[91] =  osc_buf[4'hb][3] ;
assign disp_data[92] =  com_buf[4'h0][0] ;
assign disp_data[93] =  com_buf[4'h1][0] ;
// ----------            --------------------        //

    generate
    genvar a33,aa33,c33;
        for(a33=0;a33<V_OSC;a33++)begin : assign_envs
            for(aa33=0;aa33<16;aa33++)begin : assign_inner_envs
                assign env_buf[aa33][a33] = synth_data[aa33][a33];
                assign osc_buf[aa33][a33] = synth_data[aa33][a33+V_OSC];
                assign mat_buf1[aa33][a33] = synth_data[aa33][a33+(2*V_OSC)];
                assign mat_buf2[aa33][a33] = synth_data[aa33][a33+(3*V_OSC)];
            end
        end
        for(c33=0;c33<16;c33++)begin : assign_com
            assign com_buf[c33][0] = synth_data[c33][(4*V_OSC)];
            assign com_buf[c33][1] = synth_data[c33][(4*V_OSC)+1];
        end
    endgenerate
*/
// ----------            --------------------        //

/////////////   Fetch Controllers           /////////////
//      Internal             //
    reg  pitch_cmd_r;
    reg [6:0]pitch_lsb;

/*    reg [7:0]ctrl_r;
    reg [7:0]ctrl_data_r;
    reg pitch_cmd_, ctrl_cmd_r, ctrl_cmd_r2, sysex_cmd_r, sysex_cmd_r2, data_ready, prg_ch_cmd_r, prg_ch_cmd_r2;

    reg [7:0] pb_value;
    reg [7:0]r[2*V_OSC][3:0];//  2 extra values for feedback + ?
    reg signed [7:0]l[(2*V_OSC)-1:0][3:0];// 2 extra values for feedback + ?
    reg[7:0]osc_ct[V_OSC-1:0];
    reg[7:0]osc_ft[V_OSC-1:0];
    reg[7:0]base_ct[V_OSC-1:0]; // base freq coarse
    reg[7:0]base_ft[V_OSC-1:0]; // base freq fine
    reg[7:0]k_scale[V_OSC-1:0];
    reg[7:0]o_offs[V_OSC-1:0];
    reg signed[7:0]osc_lvl[V_OSC-1:0];
    reg signed[7:0]osc_mod[V_OSC-1:0];
    reg signed[7:0]m_vol;
    reg signed[7:0]osc_feedb[V_OSC-1:0];

    assign o_index = com_buf[4][0];
    reg col_inx,cc_col_inx;
    reg [2:0]bnk_inx, col_adr_low;
    reg [O_WIDTH-1:0]row_adr_1;


    reg load_data;

    reg N_adr_data_rdy_r,N_adr_data_rdy_w, N_save_sig_r, N_load_sig_r, write_slide_r;
    reg [7:0] s_adr_1, s_adr_0, s_dat_val, slide_val_r, data;//N_synth_in_data_r,
    reg [7:0] c_adr_1_r, c_adr_0_r;
//  reg [8:0] N_adr_r;
    reg [7:0] disp_val_r;
    wire [O_WIDTH:0]a1;
*/

    always @(posedge CLOCK_25)begin
  /*      load_data <= (sysex_cmd & !sysex_cmd_r2) | (ictrl_cmd & !ctrl_cmd_r2) ;
        ctrl_cmd_r <= ictrl_cmd;
        ctrl_cmd_r2 <= ctrl_cmd_r;
        ctrl_data_r <= ictrl_data;
        sysex_cmd_r2 <= sysex_cmd_r;
        data_ready <= (ictrl_cmd & !ctrl_cmd_r2) | (sysex_cmd & !sysex_cmd_r2) |
                    (N_adr_data_rdy[1] & !N_adr_data_rdy_w);
*/
        pitch_cmd_r <= pitch_cmd;
 /*       N_adr_data_rdy_r <= N_adr_data_rdy[0];
        N_adr_data_rdy_w <= N_adr_data_rdy[1];// 1'b1 = write to synth
//      N_synth_in_data_r <= N_synth_in_data;
//      N_adr_r <= N_adr;
//      N_load_sig_r <= N_load_sig;
//      N_save_sig_r <= N_save_sig;
//      write_slide_r <= write_slide;
//      slide_val_r <= slide_val;
//      disp_val_r <= disp_val;
        prg_ch_cmd_r <= prg_ch_cmd;
        prg_ch_cmd_r2 <= prg_ch_cmd_r;
        N_save_sig <= 1'b0;
*/    end

    always @(posedge pitch_cmd_r)   pitch_lsb <= ictrl[6:0];

    always @(negedge iRST_N or negedge pitch_cmd_r)begin
        if (!iRST_N)
            pitch_val <= 8191;
        else if(!pitch_cmd_r)
            pitch_val <= {ictrl_data[6:0],pitch_lsb};
    end

 /*
    always @(negedge iRST_n or posedge CLOCK_25) begin
        if (!iRST_n)begin
            N_load_sig <= 1'b0;
        end
        else if(!prg_ch_cmd && prg_ch_cmd_r)begin N_load_sig <= 1'b1;end
        else N_load_sig <= 1'b0;
    end

    always @(posedge ictrl_cmd) ctrl_r <= ictrl;

    always @(posedge load_data)begin
        if(sysex_cmd) begin : sysex_mappings;
            data <= sysex_data[2]; row_adr_1 <= o_index[O_WIDTH-1:0];
            bnk_inx <= sysex_data[0][2:0]; col_adr_low <= sysex_data[1][2:0];
            col_inx <= sysex_data[1][3];
        end
        else if(ictrl_cmd) begin : CC_mappings; // @brief CC mappings (Korg Kronos)

            if(ctrl_r >= 8'd22 && ctrl_r <= 8'd29) begin // @brief Buttons Upper
                data <= ictrl - 8'd22;
                bnk_inx <= 3'd5; row_adr_1 <= 4'd0; col_adr_low <= 4'd6;
                cc_col_inx <= (ictrl_data & 8'h01);
            end

            else if(ictrl == 8'd39) begin // @brief Volume (Master fader)
                data <= ictrl_data; col_inx <= 1'b0;
                bnk_inx <= 3'd4; row_adr_1 <= 4'd0; col_adr_low <= 1'b1;
            end

            else if(ictrl >= 8'd48 && ictrl <= 8'd55) begin// @brief Faders
                data <= ictrl_data; col_inx <= cc_col_inx;
                bnk_inx <= 3'd0; row_adr_1 <= o_index[O_WIDTH-1:0]; col_adr_low <= ictrl - 8'd48;
            end

            else if(ictrl >= 8'd56 && ictrl <= 8'd63)begin // @brief Buttons Lower
                data <= ictrl - 8'd56;
                bnk_inx <= 3'd4; row_adr_1 <= 4'd0; col_adr_low <= 4'd4;
            end

            else if(ictrl >= 8'd76 && ictrl <= 8'd83)begin // @brief Knobs
                data <= ictrl_data; col_inx <= cc_col_inx;
                bnk_inx <= 3'd1; row_adr_1 <= o_index[O_WIDTH-1:0]; col_adr_low <= ictrl - 8'd76;
            end
            else if (ictrl <= 8'd21)begin
                data <= 8'd0;   col_inx <= 0;
                bnk_inx <= 3'd7; row_adr_1 <= 4'd0;col_adr_low <= ictrl - 8'd0;
            end
        end
    end

    always @(negedge iRST_n or negedge data_ready ) begin
        if (!iRST_n) begin
            for(a1=0;a1 <V_OSC;a1++)begin
                synth_data[4'h0][a1] <= 8'h00;
                synth_data[4'h1][a1] <= 8'h00;
                synth_data[4'h2][a1] <= 8'h00;
                synth_data[4'h3][a1] <= 8'h00;
                synth_data[4'h4][a1] <= 8'h00;
                synth_data[4'h5][a1] <= 8'h00;
                synth_data[4'h6][a1] <= 8'h7f;
                synth_data[4'h7][a1] <= 8'h00;
                synth_data[4'h8][a1] <= 8'h00;
                synth_data[4'h9][a1] <= 8'h00;
                synth_data[4'hA][a1] <= 8'h00;
                synth_data[4'hB][a1] <= 8'h00;
                synth_data[4'hC][a1] <= 8'h00;
                synth_data[4'hD][a1] <= 8'h00;
                synth_data[4'hE][a1] <= 8'h7f;
                synth_data[4'hF][a1] <= 8'h00;

                synth_data[4'h0][a1+V_OSC] <= 8'h40;
                synth_data[4'h1][a1+V_OSC] <= 8'h40;
                synth_data[4'h2][a1+V_OSC] <= 8'h7f;
                synth_data[4'h3][a1+V_OSC] <= 8'h00;
                synth_data[4'h4][a1+V_OSC] <= 8'h00;
                synth_data[4'h5][a1+V_OSC] <= 8'h00;
                synth_data[4'h6][a1+V_OSC] <= 8'h00;
                synth_data[4'h7][a1+V_OSC] <= 8'h00;
                synth_data[4'h8][a1+V_OSC] <= 8'h40;
                synth_data[4'h9][a1+V_OSC] <= 8'h40;
                synth_data[4'ha][a1+V_OSC] <= 8'h00;
                synth_data[4'hb][a1+V_OSC] <= 8'h00;
                synth_data[4'hc][a1+V_OSC] <= 8'h00;
                synth_data[4'hd][a1+V_OSC] <= 8'h00;
                synth_data[4'he][a1+V_OSC] <= 8'h00;
                synth_data[4'hf][a1+V_OSC] <= 8'h00;

                synth_data[4'h0][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'h1][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'h2][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'h3][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'h4][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'h5][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'h6][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'h7][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'h8][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'h9][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'ha][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'hb][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'hc][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'hd][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'he][a1+(2*V_OSC)] <= 8'h00;
                synth_data[4'hf][a1+(2*V_OSC)] <= 8'h00;

                synth_data[4'h0][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'h1][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'h2][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'h3][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'h4][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'h5][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'h6][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'h7][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'h8][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'h9][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'ha][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'hb][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'hc][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'hd][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'he][a1+(3*V_OSC)] <= 8'h00;
                synth_data[4'hf][a1+(3*V_OSC)] <= 8'h00;

            end
            synth_data[4'h0][(4*V_OSC)] <= 8'h02;
            synth_data[4'h1][(4*V_OSC)] <= 8'd60;
            synth_data[4'h2][(4*V_OSC)] <= 8'h00;
            synth_data[4'h3][(4*V_OSC)] <= 8'h00;
            synth_data[4'h4][(4*V_OSC)] <= 8'h00;
            synth_data[4'h5][(4*V_OSC)] <= 8'h00;
            synth_data[4'h6][(4*V_OSC)] <= 8'h00;
            synth_data[4'h7][(4*V_OSC)] <= 8'h00;
            synth_data[4'h8][(4*V_OSC)] <= 8'h00;
            synth_data[4'h9][(4*V_OSC)] <= 8'h00;
            synth_data[4'hA][(4*V_OSC)] <= 8'h00;
            synth_data[4'hB][(4*V_OSC)] <= 8'h00;
            synth_data[4'hC][(4*V_OSC)] <= 8'h00;
            synth_data[4'hD][(4*V_OSC)] <= 8'h00;
            synth_data[4'hE][(4*V_OSC)] <= 8'h00;
            synth_data[4'hF][(4*V_OSC)] <= 8'h00;
            synth_data[4'h0][(4*V_OSC)+1] <= 8'h00;
            synth_data[4'h1][(4*V_OSC)+1] <= 8'd00;
            synth_data[4'h2][(4*V_OSC)+1] <= 8'h00;
            synth_data[4'h3][(4*V_OSC)+1] <= 8'h00;
            synth_data[4'h4][(4*V_OSC)+1] <= 8'h00;
            synth_data[4'h5][(4*V_OSC)+1] <= 8'h00;
            synth_data[4'h6][(4*V_OSC)+1] <= 8'h00;
            synth_data[4'h7][(4*V_OSC)+1] <= 8'h00;
            synth_data[4'h8][(4*V_OSC)+1] <= 8'h00;
            synth_data[4'h9][(4*V_OSC)+1] <= 8'h00;
            synth_data[4'hA][(4*V_OSC)+1] <= 8'h00;
            synth_data[4'hB][(4*V_OSC)+1] <= 8'h00;
            synth_data[4'hC][(4*V_OSC)+1] <= 8'h00;
            synth_data[4'hD][(4*V_OSC)+1] <= 8'h00;
            synth_data[4'hE][(4*V_OSC)+1] <= 8'h00;
            synth_data[4'hF][(4*V_OSC)+1] <= 8'h00;
        end else begin
            if (!data_ready) begin
                if( N_adr_data_rdy_w) synth_data[N_adr[3:0]][N_adr[8:4]] <= N_synth_in_data;
                else begin
                    if(bnk_inx >= 4) synth_data[{col_inx,col_adr_low[2:0]}][{bnk_inx,2'b00}] <= data;
                    else if(bnk_inx <= 3) synth_data[{col_inx,col_adr_low[2:0]}][{bnk_inx,row_adr_1}] <= data;
                end
            end
        end
    end

    always @(posedge N_load_sig or posedge N_adr_data_rdy_r)begin
        if(N_load_sig )N_synth_out_data <= prg_ch_data;
        else if(N_adr_data_rdy_w == 1'b0)begin
            N_synth_out_data <= synth_data[N_adr[3:0]][N_adr[8:4]];
        end
    end


*/

endmodule
