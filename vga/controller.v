module draw_controller_pixel
(
  input wire clk,
  input wire sclk,
  input wire de,
  input wire [9:0] sx,
  input wire [9:0] sy,
  input wire up,
  output reg [5:0] rgb
);

  // reg [4:0] px;
  reg signed [10:0] px = 10'd800;
  reg signed [10:0] py = 10'd100;
  reg signed [9:0] dirx = 10;
  reg signed [9:0] diry = 10;


  always @(posedge sclk) begin
    if(up) begin
      py <= 200;
      diry <= 10;
      px <= 200;
      dirx <= 10;
    end

      if(py >= 450) begin
        diry <= -10;
        py <= 449;
      end else if(px >= 770) begin
        dirx <= -10;
        px <= 769;
      end else if(px <= 30) begin
        dirx <= 10;
        px <= 31;
      end else if(py <= 30) begin
        diry <= 10;
        py <= 31;
      end else begin
        py <= py + diry;
        px <= px + dirx;
      end
    // end
  end


  always @(posedge clk) begin
    if (de) begin
      if(sx < 10 || sx >= 790 || sy <=10 || sy >= 470) begin
        rgb <= 6'b001100;
      end else  if(sx > (px - 20) && sx < (px + 20) && sy > (py - 20) && sy < (py + 20)) begin
        rgb <= 6'b001100;
      end else begin
        rgb <= 6'b000000;
      end      
    end else begin
     rgb <=  6'b000000;
    end
  end
endmodule