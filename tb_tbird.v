`timescale 1ns / 1ps

module tb_tbird;

// Inputs
reg clock;
reg right_button;
reg left_button;
reg hazard_button;
reg reset;

// Outputs
wire right_led1;
wire right_led2;
wire right_led3;
wire left_led1;
wire left_led2;
wire left_led3;

// Instantiate the Unit Under Test (UUT)
tbird uut (
    .clock(clock), 
    .right_button(right_button), 
    .left_button(left_button), 
    .hazard_button(hazard_button),
    .reset(reset),
    .right_led1(right_led1), 
    .right_led2(right_led2), 
    .right_led3(right_led3),
    .left_led1(left_led1), 
    .left_led2(left_led2), 
    .left_led3(left_led3)
);

// Clock generation (50 MHz)
always begin
    #10 clock = ~clock; // 50MHz clock -> T = 20ns, so toggle every 10ns
end

// Simulation logic
initial begin
    // Initialize Inputs
    clock = 0;
    right_button = 1; // Buttons are active-low, so 1 means not pressed
    left_button = 1;
    hazard_button = 1;
    reset = 1; // Active-low reset, so 1 means not resetting

    // Hold in resting state for some time
    #100;
    
    // Test right turn sequence
    right_button = 0; // Press right button (active-low)
    #1000;            // Wait for some time
    right_button = 1; // Release button
    #1000;
    
    // Test left turn sequence
    left_button = 0;  // Press left button (active-low)
    #1000;            // Wait for some time
    left_button = 1;  // Release button
    #1000;
    
    // Test hazard signal
    hazard_button = 0; // Press hazard button (active-low)
    #1000;             // Wait for some time
    hazard_button = 1; // Release hazard button
    #1000;
    
    // Test reset functionality
    // Apply reset during right turn signal
    right_button = 0;  // Start right turn signal
    #500;
    reset = 0;         // Apply reset
    #500;
    reset = 1;         // Release reset
    #1000;
    
    // Apply reset during left turn signal
    left_button = 0;   // Start left turn signal
    #500;
    reset = 0;         // Apply reset
    #500;
    reset = 1;         // Release reset
    #1000;
    
    // Apply reset during hazard signal
    hazard_button = 0; // Start hazard signal
    #500;
    reset = 0;         // Apply reset
    #500;
    reset = 1;         // Release reset
    #1000;
    
    // End simulation
    $finish;
end

endmodule
