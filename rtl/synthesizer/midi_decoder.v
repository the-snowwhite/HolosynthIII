module midi_decoder(
    input                    CLOCK_25,
//    input                    sys_clk,
    input                    iRST_N,
// from uart
    input                    byteready,
    input [7:0]              cur_status,
    input [7:0]              midibyte_nr,
    input [7:0]              midibyte,
// inputs from synth engine
    input [VOICES-1:0]       voice_free,
    input [3:0]              midi_ch,
// outputs to synth_engine
    output [VOICES-1:0]      keys_on,
// note events
    output reg               note_on,
    output reg [V_WIDTH-1:0] cur_key_adr,
    output reg [7:0]         cur_key_val,
    output reg [7:0]         cur_vel_on,
    output reg [7:0]         cur_vel_off,
// controller data
    output reg               octrl_cmd,
    output reg               prg_ch_cmd,
    output reg               pitch_cmd,
    output reg [7:0]         octrl,
    output reg [7:0]         octrl_data,
    output reg [7:0]         prg_ch_data,
// memory controller
    output                   write ,
    output reg [6:0]         adr,
    output reg [7:0]         data,
    output                   env_sel,
    output                   osc_sel,
    output                   m1_sel,
    output                   m2_sel,
    output                   com_sel,
// status data
    output reg [V_WIDTH:0]   active_keys,
    output reg               off_note_error

);

parameter VOICES = 8;
parameter V_WIDTH = 3; 

//parameter V_WIDTH = utils::clogb2(VOICES);

// ----- Pack / Unpack macros   ---- //


`define PACK_BIT_ARRAY(PK_LEN,PK_SRC,PK_DEST) generate genvar pk_idx; for(pk_idx=0;pk_idx<(PK_LEN);pk_idx = pk_idx+1)begin : pack_bit_array assign keys_on[pk_idx] = key_on[pk_idx]; end endgenerate
 // -----        End Macros Def     ---- //
 `PACK_BIT_ARRAY(VOICES,key_on,keys_on)

// -----        End Macros     ---- //


reg   key_on[VOICES-1:0];

reg   [7:0]key_val[VOICES-1:0];

//////////////key1 & key2 Assign///////////
reg [3:0] cur_midi_ch;
reg byteready_r, is_data_byte_r, syx_cmd, syx_cmd_r[1:0];
reg [7:0]cur_status_r;
reg [7:0]midi_bytes;
reg signed[7:0]databyte;
reg voice_free_r[VOICES-1:0];
reg [V_WIDTH:0]cur_slot;

    reg [V_WIDTH-1:0]first_free_voice;
    reg [V_WIDTH-1:0]first_on;
    reg [V_WIDTH-1:0] on_slot[VOICES-1:0];
    reg [V_WIDTH-1:0] off_slot[VOICES-1:0];
    reg free_voice_found;
    reg [7:0]vel_off;
    reg [7:0]cur_note;
    reg [V_WIDTH-1:0]slot_off;
    reg off_note_error_flag;

    reg               data_ready;
    reg [2:0]         bank_adr;

    integer free_voices_found;
    integer note_found;
    integer i0;
    integer i1;
    integer i2;
    integer i3;
    integer i4;
    integer i5;
    integer i6;
    integer i7;
    integer i8;

wire is_cur_midi_ch=(
    (cur_status_r[3:0]==cur_midi_ch)?1'b1:1'b0);

wire is_st_note_on=(
    (cur_status_r[7:4]==4'h9)?1'b1:1'b0);

    wire is_st_note_off=(
        (cur_status_r[7:4]==4'h8)?1'b1:1'b0);

    wire is_st_ctrl=(
        (cur_status_r[7:4]==4'hb)?1'b1:1'b0);

    wire is_st_prg_change=(
        (cur_status_r[7:4]==4'hc)?1'b1:1'b0);

    wire is_st_pitch=(
        (cur_status_r[7:4]==4'he)?1'b1:1'b0);

    wire is_st_sysex=(
        (cur_status_r[7:4]==4'hf)?1'b1:1'b0);

    wire is_data_byte=(
     (midi_bytes[0]==1'b1)?1'b1:1'b0);

    wire is_velocity=(
     (midi_bytes[0]==1'b0 && midi_bytes != 8'h0)?1'b1:1'b0);

     wire is_allnotesoff=(
     (databyte==8'h7b)?1'b1:1'b0);

     address_decoder adr_dec_inst (
         .CLOCK_25 ( CLOCK_25 ),
         .iRST_N ( iRST_N ),
         .data_ready ( data_ready ),
         .bank_adr ( bank_adr ),

         .write  ( write  ),
         .env_sel ( env_sel ),
         .osc_sel ( osc_sel ),
         .m1_sel ( m1_sel ),
         .m2_sel ( m2_sel ),
         .com_sel ( com_sel )
     );


    always @(posedge CLOCK_25)begin
       for(i0=0; i0 < VOICES ; i0=i0+1) begin
           voice_free_r[i0] <= voice_free[i0];
        end
    end

    always @(posedge CLOCK_25)begin
        syx_cmd_r[0] <= syx_cmd;
        syx_cmd_r[1] <= syx_cmd_r[0];
        data_ready   <= syx_cmd_r[0] & ~syx_cmd_r[1];
    end

    always @(negedge iRST_N or posedge CLOCK_25)begin
        if (!iRST_N) begin
        end
        else begin
            is_data_byte_r <= is_data_byte;
            cur_midi_ch <= midi_ch;
            byteready_r <= (is_cur_midi_ch | is_st_sysex) ? byteready : 1'b0 ;
            cur_status_r <= cur_status;
            midi_bytes <= (is_cur_midi_ch | is_st_sysex) ? midibyte_nr : 8'h00;
            databyte <= (is_cur_midi_ch | is_st_sysex) ? midibyte : 8'h00;
       end
    end

    always @(negedge iRST_N or posedge is_data_byte_r)begin
        if (!iRST_N) begin
            free_voice_found <= 1'b1;
            first_free_voice<=0;
        end
        else begin
            for(i3=VOICES-1,free_voices_found=0; i3 >= 0 ; i3=i3-1) begin
                free_voice_found <= 1'b0;
                if(voice_free_r[i3])begin
                    free_voices_found = free_voices_found +1;
                    first_free_voice <= i3;
                end
                if (free_voices_found > 0) free_voice_found <= 1'b1;
            end
        end
    end
    
    always @(negedge iRST_N or negedge byteready_r) begin
        if (!iRST_N) begin // init values 
            active_keys <= 0;
            off_note_error <= 1'b0;
            cur_key_val <= 8'hff;
            cur_vel_on <= 0;
            cur_vel_off <= 0;
           for(i5=0;i5<VOICES-1;i5=i5+1)begin
                key_on[i5] <= 1'b0;
                cur_key_adr <= i5;
                key_val[i5] <= 8'hff;
                on_slot[i5] <= 0;
                off_slot[i5] <= 0;
            end
            slot_off<=0;
            cur_note<=0;
            cur_slot<=0;
            active_keys<=0;
            off_note_error<=1'b0;
            off_note_error_flag<=0;
            octrl_cmd <= 1'b0;prg_ch_cmd <=1'b0;syx_cmd <= 1'b0;pitch_cmd <= 1'b0;
        end
        else begin
            octrl_cmd <= 1'b0;prg_ch_cmd <=1'b0;syx_cmd <= 1'b0;pitch_cmd <= 1'b0;note_on <= 1'b0;
            if(is_st_note_on)begin // Note on omni
                if(is_data_byte)begin
                    if(active_keys >= VOICES) begin
                        active_keys <= active_keys-1'b1;
                        key_on[on_slot[0]]<=1'b0;
                        cur_key_adr <= on_slot[0];
                        cur_key_val <=8'hff;
                        key_val[on_slot[0]]<=8'hff;
                        slot_off<=on_slot[0];
                        cur_slot<=on_slot[0];
                    end else if(free_voice_found  == 1'b0)begin
                        cur_slot <= off_slot[active_keys];
                    end
                    else begin
                        cur_slot<=first_free_voice;
                    end
                    for(i6=VOICES-1;i6>0;i6=i6-1)begin
                        on_slot[i6-1]<=on_slot[i6];
                    end
                    cur_note<=databyte;
                end else if(is_velocity)begin
                    active_keys <= active_keys+1'b1;
                    key_on[cur_slot]<=1'b1;
                    cur_key_adr <= cur_slot;
                    cur_key_val <= cur_note;
                    cur_vel_on <= databyte;
                    note_on <= 1'b1;
                    key_val[cur_slot]<=cur_note;
                    on_slot[VOICES-1] <= cur_slot;
                end
            end else if(is_st_ctrl)begin // Control Change omni
                if(is_data_byte)begin
                    octrl<=databyte;
                    if(is_allnotesoff)begin
                        for(i4=0;i4<VOICES;i4=i4+1)begin
                            key_on[i4]<=1'b0;
                            cur_key_adr <= i4;
                            key_val[i4]<=8'hff;
                            cur_key_val<=8'hff;
                        end
                        slot_off <= 0;
                        cur_note <= 0;
                        active_keys <= 0;
                        off_note_error <= 1'b0;
                    end
                end else if(is_velocity)begin
                    octrl_data<=databyte;
                    octrl_cmd<=1'b1;
                end
            end else if(is_st_prg_change)begin // Control Change omni
                    prg_ch_cmd <= 1'b1;
                if(is_data_byte)begin
                    prg_ch_data<=databyte;
                    prg_ch_cmd <= 1'b0;
                end
            end else if(is_st_sysex)begin // Sysex
                case (midi_bytes)
                    8'd3:bank_adr  <=databyte[2:0];
                    8'd4:adr  <=databyte[6:0];
                    8'd5:data  <=databyte;
                    8'd6:if (midi_bytes == 6 && databyte == 8'hf7)syx_cmd <= 1'b1;
                    default:;
                endcase
            end else if(is_st_pitch)begin // Control Change omni
                if(is_data_byte)begin
                    octrl<=databyte;
                    pitch_cmd<=1'b1;
                end else if(is_velocity)begin
                    octrl_data<=databyte;
                    pitch_cmd<=1'b0;
                end
            end else if (is_st_note_off) begin// Note off omni
                if(is_data_byte)begin
                    for(i2=0,note_found=0;i2<VOICES;i2=i2+1)begin
                        off_note_error_flag <= 1'b1;
                        if(databyte==key_val[i2])begin
                            active_keys <= active_keys-1'b1;
                            slot_off<=i2;
                            key_on[i2]<=1'b0;
                            cur_key_adr <= i2;
                            cur_key_val <= 8'hff;
                            key_val[i2] <= 8'hff;
                            note_found = 1;
                        end
                        if(note_found == 1) off_note_error_flag <= 1'b0;
                    end
                end else if(is_velocity )begin
                    if(off_note_error_flag)begin
                        off_note_error <= 1'b1;
                    end
                    if(key_val[slot_off] == 8'hff)begin
                       cur_vel_off<=databyte;
                        off_slot[VOICES-1]<=slot_off;
                        for(i7=VOICES-1;i7>0;i7=i7-1)begin
                            if(i7>active_keys)begin
                                off_slot[i7-1] <= off_slot[i7];
                            end
                        end
                    end
                    if(active_keys == 0)begin
                        for(i8=0;i8<VOICES;i8=i8+1)begin
                            key_on[i8]<=1'b0;
                            cur_key_adr <= i8;
                            cur_key_val <= 8'hff;
                            cur_vel_on <= 8'd0;
                            cur_vel_off <= 8'd0;
                            key_val[i8] <= 8'hff;
                        end
                        cur_note <= 8'd0;
                        slot_off <= 0;
                        cur_slot <= 0;
                    end
                end
            end
        end
    end

endmodule
