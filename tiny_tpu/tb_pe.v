module tb_pe();

    reg clk, active, wwrite;
    reg [7:0] datain, w_in;
    reg [15:0] sum_in;

    wire [15:0] maccout;
    wire [7:0] dataout, wout;
    wire wwriteout, activeout;

    integer i;

    pe DUT(
        .clk(clk),
        .active(active),
        .datain(datain),
        .win(w_in),
        .sumin(sum_in),
        .wwrite(wwrite),
        .maccout(maccout),
        .dataout(dataout),
        .wout(wout),
        .wwriteout(wwriteout),
        .activeout(activeout)
    );

    always begin
        #5;
        clk = ~clk; // clock diversion per 5 time scale 
    end // always

    initial begin
        clk = 1'b0; 
        active = 1'b1; 
        wwrite = 1'b0;
        datain = 8'h00;
        w_in = 8'h00;
        sum_in = 16'h0000;

        #100;

        wwrite = 1'b1; 

        for (i = 0; i < 64; i = i + 1) begin
            #10;
            w_in = w_in + 8'h04; // w_in is changed but sustain mac_out = 0, because of data_in = 0, sum_in= 0 >> mult_result = data_in* w_in =  0
        end

        wwrite = 1'b0;

        for (i = 0; i < 64; i = i + 1) begin
            #10;
            w_in = w_in + 8'h02; // w_out = 8'hAA because of wwrite =0 
        end

    end // initial

endmodule // pe_tb
