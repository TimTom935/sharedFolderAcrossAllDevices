// FSM for Car Turn Signal and Hazard Lights
// Implemented on DE1-SoC FPGA Board
// Designed for control of LEDs based on pushbutton inputs for LEFT, RIGHT, and HAZARD signals

// Inputs:
// - right_button (active-low): Indicates right turn signal.
// - left_button (active-low): Indicates left turn signal.
// - hazard_button (active-low): Indicates hazard signal.
// - clock: System clock (50MHz).

// Outputs:
// - LEDs for right and left turn signals.
// - Sequence control for turn signals.

module tbird(
    input clock,               // System clock (50MHz)
    input right_button,        // Right turn signal button (active-low)
    input left_button,         // Left turn signal button (active-low)
    input hazard_button,       // Hazard signal button (active-low)
    output reg right_led1,     // LED for right signal (LED 1)
    output reg right_led2,     // LED for right signal (LED 2)
    output reg right_led3,     // LED for right signal (LED 3)
    output reg left_led1,      // LED for left signal (LED 1)
    output reg left_led2,      // LED for left signal (LED 2)
    output reg left_led3,      // LED for left signal (LED 3)
    output reg all_leds_on     // All LEDs on for hazard signal
);


// State Definitions:
parameter resting = 2'b00;
parameter rightTurn = 2'b01;
parameter leftTurn = 2'b10;
parameter hazard = 2'b11;

// Timing intervals for LED sequences
parameter t1 = 25000000;  // Adjust these values to suit your timing requirements
parameter t2 = 50000000;
parameter t3 = 75000000;
parameter t4 = 100000000;

// Internal Variables
reg [1:0] current_state, next_state;  // Holds current and next FSM state
reg [23:0] counter;  // Counter for timing delay (assuming we divide the 50MHz clock)
reg [23:0] clk_divider;  // Clock divider counter
reg sequence_completed;  // Signal indicating when a turn sequence is complete
reg slow_enable;  // Slower clock enable for timing control
parameter max_count = 25000000;  // Adjust this based on your desired blinking frequency (for 0.5Hz)

// Initial setup for FSM
initial begin
    current_state = resting;  // Start in resting state
    next_state = resting;
    counter = 0;
    clk_divider = 0;
    all_leds_on = 0;
    sequence_completed = 0;
end

// State Register Logic
// This block updates the current state on every clock cycle
always @ (posedge clock) begin
    current_state = next_state;  // Update the state to the next state
end

// Next State Logic
always @ (*) begin
    case (current_state)
        resting: begin
            if (!right_button) begin
                next_state = rightTurn;  // Transition to right turn state
            end else if (!left_button) begin
                next_state = leftTurn;  // Transition to left turn state
            end else if (!hazard_button) begin
                next_state = hazard;  // Hazard mode overrides all
            end else begin
                next_state = resting;  // Stay in resting state
            end
        end

        rightTurn: begin
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
            end else if (sequence_completed) begin
                next_state = resting;  // Return to resting after turn sequence
            end else begin
                next_state = rightTurn;  // Stay in right turn state until complete
            end
        end

        leftTurn: begin
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else if (sequence_completed) begin
                next_state = resting;  // Return to resting after turn sequence
            end else begin
                next_state = leftTurn;  // Stay in left turn state until complete
            end
        end

        hazard: begin
            if (hazard_button) begin
                next_state = resting;  // Return to resting after hazard is released
            end else begin
                next_state = hazard;  // Stay in hazard state as long as hazard button is pressed
            end
        end

        default: next_state = resting;  // Default to resting state
    endcase
end

// Output Logic: Hazard, Right Turn, Left Turn
// This block controls the actual LED outputs based on the current state

// Hazard method: Blink all LEDs until the hazard button is released
always @ (posedge clock) begin
    if (current_state == hazard && slow_enable) begin
        all_leds_on = ~all_leds_on;  // Toggle LEDs on/off
    end else begin
        all_leds_on = 0;  // Ensure LEDs are off when not in hazard state
    end
end

// Right turn method: Light up LEDs in sequence, then go to resting state
always @ (posedge clock) begin
    if (current_state == rightTurn && slow_enable) begin
        case (counter)
            t1: right_led1 = 1;  // Light up the first right LED
            t2: right_led2 = 1;  // Light up the second right LED
            t3: right_led3 = 1;  // Light up the third right LED
            t4: begin
                right_led1 = 0;
                right_led2 = 0;
                right_led3 = 0;  // Turn off all right LEDs
                sequence_completed = 1;  // Signal that the sequence is done
            end
        endcase
        counter = counter + 1;  // Increment timing counter
    end else begin
        counter = 0;  // Reset the counter when not in rightTurn state
    end
end

// Left turn method: Light up LEDs in sequence, then go to resting state
always @ (posedge clock) begin
    if (current_state == leftTurn && slow_enable) begin
        case (counter)
            t1: left_led1 = 1;  // Light up the first left LED
            t2: left_led2 = 1;  // Light up the second left LED
            t3: left_led3 = 1;  // Light up the third left LED
            t4: begin
                left_led1 = 0;
                left_led2 = 0;
                left_led3 = 0;  // Turn off all left LEDs
                sequence_completed = 1;  // Signal that the sequence is done
            end
        endcase
        counter = counter + 1;  // Increment timing counter
    end else begin
        counter = 0;  // Reset the counter when not in leftTurn state
    end
end

// Clock Divider Logic (for timing control)
// Divides the 50MHz clock to slower values for visible LED blinking
always @ (posedge clock) begin
    if (clk_divider == max_count) begin
        slow_enable = 1;  // Generate slow enable pulse
        clk_divider = 0;
    end else begin
        slow_enable = 0;
        clk_divider = clk_divider + 1;
    end
end

endmodule
