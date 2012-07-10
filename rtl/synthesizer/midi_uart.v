module MIDI_UART(
    input                   CLOCK_25,
//    input                   sys_clk,
    input                   iRST_N,
    input                   midi_rxd,
//    input                   initial_reset,
    output  reg     byteready,
    output   reg        sys_real,
    output  reg[7:0]    sys_real_dat,
    output  reg[7:0]    cur_status,
    output  reg[7:0]    midibyte_nr,
    output  reg[7:0]    midibyte
// for debugging
/*
    output  reg startbit_d,
    output  reg [4:0]revcnt,
    output  reg [7:0] counter,
    output  reg midi_clk,
    output  reg reset_mod_cnt
*/
);
    reg midi_dat,md_1;
    wire md_ok = md_1 & midi_rxd;

    always @(posedge CLOCK_25)begin
        md_1 <= midi_rxd;
        midi_dat <= md_ok;
    end
// comment out for debug
    reg startbit_d;
    reg [4:0]revcnt;
    reg [7:0] counter;
    reg midi_clk;
    reg reset_mod_cnt;

//// Clock gen ////
//wire mgen_c;
//wire [7:0]m_cnt_bits;

      reg carry;
    reg [2:0]reset_cnt;
    reg [7:0]samplebyte;
    wire byte_end = (revcnt[4:0]==18)? 1'b1 : 1'b0;

    always @(negedge iRST_N or posedge CLOCK_25)begin //! divide clock by 200
        if(!iRST_N)begin counter <= 8'h00; carry <=1'b0; end
        else if (CLOCK_25)
            if(reset_mod_cnt)begin carry <= 1'b0; counter <= 8'h00;end
            else if(counter == 8'd200)begin carry <= 1'b1; counter <= 8'h00;end
            else begin counter <= counter + 8'h1;carry <= 1'b0;end
    end
    always @(negedge iRST_N or posedge CLOCK_25)begin//! divide by 2 more so we get 62500 hz midi clock
        if(!iRST_N) midi_clk <= 1'b0;
        else if (reset_mod_cnt) midi_clk <= 1'b0;
        else if(carry)midi_clk <= ~(midi_clk);
    end


always @(posedge CLOCK_25 or negedge iRST_N)begin
    if (!iRST_N)begin startbit_d <= 0;end
    else begin
        if(revcnt>=18) startbit_d <= 0;
        else if (!startbit_d)begin
            if(midi_dat) startbit_d <= 0;
            else startbit_d <= 1;
        end
    end
end

// Clk gen reset circuit /////
always @(negedge CLOCK_25 or negedge iRST_N)begin
    if(!iRST_N)begin reset_cnt <= 0;reset_mod_cnt <= 0;end
    else begin
        if (!startbit_d)
            reset_cnt <= 0;
        else if(reset_cnt <= 1 && startbit_d)begin
            reset_cnt <= reset_cnt+1'b1;
            reset_mod_cnt <= 1;
        end
        else reset_mod_cnt <= 0;
    end
end

///// sequence generator /////

    always @(posedge midi_clk or negedge iRST_N)begin
        if(!iRST_N) revcnt <= 0;
        else begin
            if (!startbit_d) revcnt <= 0;
            else if (revcnt >= 18) revcnt <= 0;
            else revcnt <= revcnt+1'b1;
        end
    end

// Serial data in

    always @(negedge midi_clk or negedge iRST_N) begin
        if(!iRST_N)begin samplebyte <= 0; midibyte <= 0;end
        else begin
            case (revcnt[4:0])
            5'd3:samplebyte[0] <= midi_dat;
            5'd5:samplebyte[1] <= midi_dat;
            5'd7:samplebyte[2] <= midi_dat;
            5'd9:samplebyte[3] <= midi_dat;
            5'd11:samplebyte[4] <= midi_dat;
            5'd13:samplebyte[5] <= midi_dat;
            5'd15:samplebyte[6] <= midi_dat;
            5'd17:samplebyte[7] <= midi_dat;
            5'd18:midibyte <= samplebyte;
            default:;
            endcase
        end
    end

    always @(negedge midi_clk or negedge iRST_N) begin
        if(!iRST_N) byteready <= 0;
        else begin
//            if (initial_reset) byteready<=0;
            if ( byte_end && (sys_real == 1'b0)) byteready <= 1;
            else byteready <= 0;
        end
    end

// DataByte counter -- Status byte logger //
    always @(negedge startbit_d or negedge iRST_N)begin
        if(!iRST_N)begin midibyte_nr <= 0; cur_status <= 0;sys_real_dat <= 0;end
        else begin
            if(samplebyte[7:4] == 4'hf && samplebyte[3:0] & 4'h8)begin
                sys_real_dat <= samplebyte;
                sys_real <= 1'b1;
            end
            else begin
                sys_real <= 1'b0;
                if((samplebyte & 8'h80) && (samplebyte != 8'hf7))begin
                    midibyte_nr <= 0;
                    cur_status <= samplebyte;
                end
                else midibyte_nr <= midibyte_nr+1'b1;
            end
        end
    end

endmodule
