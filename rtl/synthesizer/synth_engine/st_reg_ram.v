module st_reg_ram(
    output reg [106:0] q, //level, oldlevel, distance, st --//
    input [106:0] d,
    input [V_WIDTH+E_WIDTH-1:0] write_address, read_address,
    input we, wclk, rclk
    );
parameter VOICES = 8;
parameter V_ENVS = 8;
parameter V_WIDTH = 3;
parameter E_WIDTH = 3;


    reg [V_WIDTH+E_WIDTH-1:0] read_address_reg,write_address_reg;
    reg [106:0] mem [(VOICES*V_ENVS)-1:0];
    always @ (posedge wclk) begin
        if (we)
        mem[write_address_reg] <= d;
        write_address_reg <= write_address;
    end
    always @ (posedge rclk) begin
        q <= mem[read_address_reg];
        read_address_reg <= read_address;
    end
endmodule
