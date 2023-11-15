module vga 
#(
  // horizontal resolution and timing
  parameter H_RES     = 640,
  parameter H_FP      = 16,   // horizontal front porch
  parameter H_BP      = 48,   // horizontal back porch
  parameter H_S       = 96,   // horizontal sync

  // vertical resolution and timing
  parameter V_RES     = 480,
  parameter V_FP      = 10,   // vertical front porch
  parameter V_BP      = 33,   // vertical back porch
  parameter V_S       = 2     // vertical sync
)
(
  input   wire        clk,        // pixel clock, should be 25.175hz for VGA 640x480
  output  wire        hsync,      // hsync output signal
  output  wire        vsync,      // vsync output signal
  output  wire        de,         // data enable (can write to video)
  output  reg [9:0]   sx,         // horizontal count
  output  reg [9:0]   sy          // vertical count
);
  // calculated parameters
  localparam HA_END   = H_RES - 1;
  localparam HS_START = HA_END + H_FP;
  localparam HS_END   = HS_START + H_S;
  localparam LINE_END = HS_END + H_BP;

  localparam VA_END   = V_RES - 1;
  localparam VS_START = VA_END + V_FP;
  localparam VS_END   = VS_START + V_S;
  localparam SCREEN_END = VS_END + V_BP;

  // pixel coordinates
  always @(posedge clk) begin
    if (sx == LINE_END) begin // last pixel
      sx <= 0;
      sy <= (sy == SCREEN_END) ? 0 : sy + 1;  // last line
    end else begin
      sx <= sx + 1;
    end
  end

  assign hsync = ~(sx >= HS_START && sx < HS_END);
  assign vsync = ~(sy >= VS_START && sy < VS_END);
  assign de = (sx <= HA_END && sy <= VA_END);
endmodule