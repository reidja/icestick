module draw_gradient
#(
  parameter H_RES = 640,
  parameter V_RES = 480
)
(
  input wire clk,
  input wire de,
  input wire [9:0] sx,
  input wire [9:0] sy,
  output reg [5:0] rgb
);

  localparam SIZE_X = H_RES / 8;
  localparam SIZE_Y = V_RES / 8;

  reg [3:0] cell_x = 0;
  reg [3:0] cell_y = 0;

  reg [5:0] value = 0;

  always @(posedge clk) begin
    if(de) begin
      cell_x = sx / SIZE_X;
      cell_y = sy / SIZE_Y;
    end
  end

  always @(posedge clk) begin
    if(de) begin
      rgb <= (cell_y *  8) + cell_x;
    end else begin
      rgb <= 6'b000000;
    end
  end
endmodule