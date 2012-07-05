module address_decoder (
    input           CLOCK_25,
    input           iRST_N,
    input           data_ready,
    input   [2:0]   bank_adr,

    output   reg    write ,
    output   reg    env_sel,
    output   reg    osc_sel,
    output   reg    m1_sel,
    output   reg    m2_sel,
    output   reg    com_sel
//@name cpu signals //
//    input [2:0] N_adr_data_rdy, // 2'b01 = read from synth/save to disk; 2'b11 = write to synth/load from disk
//    input [8:0] N_adr,              // data addr.
//@name touch signals    //
//    output N_save_sig,
//    output N_load_sig
);

    reg syx_data_rdy_r[3:0];
    reg [2:0] syx_bank_adr_r;


    always @(posedge CLOCK_25)begin
        syx_bank_adr_r <= bank_adr;
        syx_data_rdy_r[0] <= data_ready;
        syx_data_rdy_r[1] <= syx_data_rdy_r[0];
        syx_data_rdy_r[2] <= syx_data_rdy_r[1];
        syx_data_rdy_r[3] <= syx_data_rdy_r[2];
        write  <= syx_data_rdy_r[3];
    end
    always @(negedge iRST_N or posedge syx_data_rdy_r[1]) begin
        if (!iRST_N)begin
            env_sel <= 0;
            osc_sel <= 0;
            m1_sel <= 0;
            m2_sel <= 0;
            com_sel <= 0;
        end
        else begin
            case (syx_bank_adr_r)
                0: begin env_sel<=1'b1;osc_sel<=1'b0;m1_sel<=1'b0;m2_sel<=1'b0;com_sel<=1'b0;end
                1: begin env_sel<=1'b0;osc_sel<=1'b1;m1_sel<=1'b0;m2_sel<=1'b0;com_sel<=1'b0;end
                2: begin env_sel<=1'b0;osc_sel<=1'b0;m1_sel<=1'b1;m2_sel<=1'b0;com_sel<=1'b0;end
                3: begin env_sel<=1'b0;osc_sel<=1'b0;m1_sel<=1'b0;m2_sel<=1'b1;com_sel<=1'b0;end
                4: begin env_sel<=1'b0;osc_sel<=1'b0;m1_sel<=1'b0;m2_sel<=1'b0;com_sel<=1'b1;end
                default: begin env_sel <= 0; osc_sel <= 0; m1_sel <= 0; m2_sel <= 0; com_sel <= 0; end
            endcase
        end
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


    always @(posedge N_load_sig or posedge N_adr_data_rdy_r)begin
        if(N_load_sig )N_synth_out_data <= prg_ch_data;
        else if(N_adr_data_rdy_w == 1'b0)begin
            N_synth_out_data <= synth_data[N_adr[3:0]][N_adr[8:4]];
        end
    end


*/

endmodule
