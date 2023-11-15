module clock_divider
#(
  parameter CLOCK_MHZ = 12,
  parameter FPS = 1,
  parameter MULTIPLIER = 1
)
(
  input   wire clk_in,
  output  reg clk_out
);

  localparam [31:0] MAX_COUNT = ((CLOCK_MHZ * MULTIPLIER) * 1000000) / FPS;

  reg [31:0] counter = 28'd0;

  always @(posedge clk_in) begin
    if(counter == MAX_COUNT) begin
      counter <= 32'b0;
      clk_out <= ~clk_out;
    end else begin
      counter <= counter + 1;
    end
  end
endmodule
