module draw_border
#(
  parameter H_RES = 640,
  parameter V_RES = 480,
  parameter OUTER_WIDTH = 20,
  parameter INNER_WIDTH = 10,
  parameter OUTLINE_WIDTH = 5,
  parameter LINE_PADDING = 5
)
(
  input wire clk,
  input wire de,
  input wire [9:0] sx,
  input wire [9:0] sy,
  output reg [5:0] rgb
);
  localparam cx = (H_RES / 2) - 1;
  localparam cy = (V_RES / 2) - 1;

  always @(posedge clk) begin
    if (de) begin
      // offsets x is 1,-1, y is 4, -1
      if(sx < OUTLINE_WIDTH || sx > H_RES - OUTLINE_WIDTH - 1 || sy < OUTLINE_WIDTH || sy > V_RES - OUTLINE_WIDTH -1)  begin
        rgb <= 6'b001100;
      end else if(sx < OUTER_WIDTH || sx > H_RES - OUTER_WIDTH - 1 || sy < OUTER_WIDTH || sy > V_RES - OUTER_WIDTH - 1) begin
        rgb <= 6'b110000;
      end else if(sx < INNER_WIDTH  || sx > H_RES - INNER_WIDTH - 1 || sy < INNER_WIDTH || sy > V_RES - INNER_WIDTH - 1) begin
        rgb <= 6'b111111;
      end else begin
        if((sx > (cx - LINE_PADDING) && sx < (cx + LINE_PADDING)) || (sy > (cy - LINE_PADDING) && sy < (cy + LINE_PADDING))) begin
          rgb <= 6'b111111;
        end else begin
          rgb <= 6'b000011;
        end
      end
    end else begin
     rgb <=  6'b000000;
    end
  end
endmodule