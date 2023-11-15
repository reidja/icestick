module main (
  // Inputs
  input clk,                      // 12Mhz clock

  input ctrl_up,                  // Up button

  // Outputs (VGA)
  output reg [5:0]    rgb,        // RGB pins (6-bit currently)
  output wire         hsync_out,  // hsync signal
  output wire         vsync_out,  // vsync signal

  // Outputs (LED)
	output wire [2:0]   led,        // LEDs
  output wire         led_1,
	output wire         lock_led    // Green LED used for PLL
);
  // Resolution

  localparam H_RES = 800;
  localparam V_RES = 480;

  assign led = 3'b111;           // turn on the leds

  wire clk_slow;

  assign led_1 = ~ctrl_up;
  clock_divider #(
    .MULTIPLIER(1),
    .FPS(60)
  )divider(
    .clk_in(clk),
    .clk_out(clk_slow)
  );

  // Pixel clock
  wire pclk;                      // 25.125Mhz pixel clock
  clock_32 clock(
    .clk(clk),
    .clk_out(pclk),
    .lock(lock_led)               // turn on led during PLL
  );

  // VGA driver
  wire [9:0] sx;                  // screen x coordinate
  wire [9:0] sy;                  // screen y coordinate
  wire de;                        // active display signal
  vga #(
    .H_RES(H_RES),
    .V_RES(V_RES),
    .H_FP(32),
    .H_BP(90),
    .V_BP(34),
    .V_FP(8),
    .H_S(96), // 96
    .V_S(2),
  ) vga (
    .clk(pclk),
    .hsync(hsync_out),  
    .vsync(vsync_out),
    .sx(sx),   
    .sy(sy),
    .de(de)
  );

  // wire [5:0] rgb1;

  // Renderer
  // draw_colors #(
  //   .H_RES(H_RES),
  //   .V_RES(V_RES)
  // ) render1 (
  //   .clk(pclk),
  //   .de(de),
  //   .sx(sx),
  //   .sy(sy),
  //   .rgb(rgb)
  // );

  // wire [5:0] rgb2;

  draw_controller_pixel render (
    .sclk(clk_slow),
    .clk(pclk),
    .de(de),
    .sx(sx),
    .sy(sy),
    .rgb(rgb),
    .up(~ctrl_up)
  );
  

  // Renderer
  // draw_border #(
  //   .H_RES(H_RES),
  //   .V_RES(V_RES),
  //   .OUTER_WIDTH(20),
  //   .INNER_WIDTH(30),
  //   .OUTLINE_WIDTH(10),
  // ) render2 (
  //   .clk(pclk),
  //   .de(de),
  //   .sx(sx),
  //   .sy(sy),
  //   .rgb(rgb)
  // );

  // draw_gradient #(
  //   .H_RES(H_RES),
  //   .V_RES(V_RES),
  // ) render2 (
  //   .clk(pclk),
  //   .de(de),
  //   .sx(sx),
  //   .sy(sy),
  //   .rgb(rgb2)
  // );


  // always @(posedge pclk) begin
  //   if(clk_slow) begin
  //     rgb <= rgb1;
  //   end else begin
  //     rgb <= rgb2;
  //   end
  // end
 
endmodule