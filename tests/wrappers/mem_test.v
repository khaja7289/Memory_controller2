module TopLevelModule (
  input wire clk,
  input wire reset,
  input wire write_enable,
  input wire [31:0] write_address,
  input wire [31:0] write_data,
  output wire read_enable,
  input wire [31:0] read_address,
  output wire [31:0] read_data
);

  // Memory Controller Instance
  MemoryController dut (
    .clk(clk),
    .reset(reset),
    .write_enable(write_enable),
    .write_address(write_address),
    .write_data(write_data),
    .read_enable(read_enable),
    .read_address(read_address),
    .read_data(read_data)
  );

  initial begin
	$dumpfile("waves.vcd");
	$dumpvars;
  end

endmodule
