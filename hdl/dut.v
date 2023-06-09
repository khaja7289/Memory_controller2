module memory_controller (
  input wire clk,
  input wire reset,
  input wire [31:0] address,
  input wire [31:0] write_data,
  input wire write_enable,
  input wire read_enable,
  output wire [31:0] read_data
);

  reg [31:0] memory [0:1023]; // Assuming 1024 memory locations, each 32 bits wide

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      memory <= 0; // Reset memory contents to 0
    end else begin
      if (write_enable) begin
        memory[address] <= write_data; // Write data to the specified memory address
      end
      
      if (read_enable) begin
        read_data <= memory[address]; // Read data from the specified memory address
      end
    end
  end

endmodule
