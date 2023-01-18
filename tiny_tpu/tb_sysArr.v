`timescale 1 ps / 1 ps

module tb_sysArr();
    parameter width_height = 4;
    localparam weight_width = 8 * width_height * width_height;
    localparam sum_width = 16 * width_height;
    localparam data_width = 8 * width_height;

    // inputs to DUT
    reg clock;
    reg active;
    reg [data_width-1:0] datain;
    reg [weight_width-1:0] win;
    reg [sum_width-1:0] sumin;
    reg wwrite;

    // outputs from DUT
    wire [sum_width-1:0] maccout;
    //wire [weight_width-1:0] wout;
    //wire [width_height-1:0] wwriteout;
    wire [width_height-1:0] activeout;
    wire [data_width-1:0] dataout;

    // instantiation of DUT
    sysArr DUT (
        .clock      (clock),
        .active   (active),
        .datain   (datain),
        .win      (win),
        .sumin    (sumin),
        .wwrite   (wwrite),
        .maccout  (maccout),
        //.wout     (wout),
        //.wwriteout(wwriteout),
        .activeout(activeout),
        .dataout  (dataout)
    );

    defparam DUT.width_height = width_height;

    always begin
        #5;
        clock = ~clock;
    end // always

    initial begin
        clock = 1'b0;
        active = 1'b0;
        datain = 32'h0000_0000;
        win = 128'h0100_0000_0001_0000_0000_0100_0000_0001;
        sumin = 64'h0000_0000_0000_0000;
        wwrite = 1'b1;

        #10;

        //win = 32'h0404_0404;
       
        wwrite = 1'b0;
        win = 32'h0403_0201;

        #10;
        active = 1'b1;
        datain = 32'h0x0x_0x01;
        //win = 32'h0303_0303;
        

        #10;
        active = 1'b1;
        datain = 32'h0x0x_0000;
        
        #10;
        active = 1'b1;
        datain = 32'h0x00_0100;

        #10;
        active = 1'b1;
        datain = 32'h0000_0000;
        
        #10;
        active = 1'b1;
        datain = 32'h0001_000x;
        
        #10;
        active = 1'b1;
        datain = 32'h0000_0x0x;
        
        #10;
        active = 1'b1;
        datain = 32'h010x_0x0x;
        

        #50;

        $stop;
    end // initial
endmodule // tb_sysArr
