`timescale 1ns/1ps

module tbird_tb;

// Testbench Signals
reg clock;
reg right_button;
reg left_button;
reg hazard_button;

wire right_led1;
wire right_led2;
wire right_led3;
wire left_led1;
wire left_led2;
wire left_led3;
wire all_leds_on;

// Instantiate the DUT (Device Under Test)
tbird uut (
    .clock(clock),
    .right_button(right_button),
    .left_button(left_button),
    .hazard_button(hazard_button),
    .right_led1(right_led1),
    .right_led2(right_led2),
    .right_led3(right_led3),
    .left_led1(left_led1),
    .left_led2(left_led2),
    .left_led3(left_led3),
    .all_leds_on(all_leds_on)
);

// Clock Generation (50MHz clock period = 20ns)
always begin
    #10 clock = ~clock; // Toggle clock every 10ns
end

// Test Procedure
initial begin
    // Initialize Inputs
    clock = 0;
    right_button = 1;
    left_button = 1;
    hazard_button = 1;

    // Test right turn signal
    $display("Testing right turn signal");
    right_button = 0;  // Press right turn button
    #200000;  // Wait for the sequence to complete
    right_button = 1;  // Release right turn button
    #200000;

    // Test left turn signal
    $display("Testing left turn signal");
    left_button = 0;  // Press left turn button
    #200000;  // Wait for the sequence to complete
    left_button = 1;  // Release left turn button
    #200000;

    // Test hazard signal
    $display("Testing hazard signal");
    hazard_button = 0;  // Press hazard button
    #200000;  // Let the hazard blink for some time
    hazard_button = 1;  // Release hazard button
    #200000;

    // End simulation
    $display("Testbench complete");
end

endmodule
