module draw_colors
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

  localparam SIZE = H_RES / 7;
  localparam SIZE_2 = H_RES / 14;

  always @(posedge clk) begin
    if (de) begin
      if(sy < V_RES - 75) begin 
        if(sx < SIZE) begin
          rgb <= 6'b111111;
        end else if(sx < SIZE * 2) begin
          rgb <= 6'b111100;
        end else if(sx < SIZE * 3) begin
          rgb <= 6'b001111;
        end else if(sx < SIZE * 4) begin
          rgb <= 6'b001100;
        end else if(sx < SIZE * 5) begin
          rgb <= 6'b110011;
        end else if(sx < SIZE * 6) begin
          rgb <= 6'b110000;
        end else if(sx < SIZE * 7) begin
          rgb <= 6'b000011;
        end
      end else begin
        if(sx >= SIZE_2 * 3 && sx < SIZE_2 * 5) begin
          rgb <= 6'b111111;
        end else begin
          rgb <= 6'b000000;
        end
      end
    end else begin
     rgb <=  6'b000000;
    end
  end
endmodule