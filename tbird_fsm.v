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
	 input reset,					 // Reset everything to default
	 
    output right_led1,     // LED for right signal (LED 1)
	 output right_hex20,
	 output right_hex21,
	 output right_hex22,
	 output right_hex23,
	 output right_hex24,
	 output right_hex25,
	 
    output right_led2,     // LED for right signal (LED 2)
	 output right_hex10,
	 output right_hex11,
	 output right_hex12,
	 output right_hex13,
	 output right_hex14,
	 output right_hex15,
	 
    output right_led3,     // LED for right signal (LED 3)
	 output right_hex00,
	 output right_hex01,
	 output right_hex02,
	 output right_hex03,
	 output right_hex04,
	 output right_hex05,
	 
    output left_led1,      // LED for left signal (LED 1)
	 output left_hex30,
	 output left_hex31,
	 output left_hex32,
	 output left_hex33,
	 output left_hex34,
	 output left_hex35,
	 
    output left_led2,      // LED for left signal (LED 2)
	 output left_hex40,
	 output left_hex41,
	 output left_hex42,
	 output left_hex43,
	 output left_hex44,
	 output left_hex45,
	 
    output left_led3,      // LED for left signal (LED 3)
	 output left_hex50,
	 output left_hex51,
	 output left_hex52,
	 output left_hex53,
	 output left_hex54,
	 output left_hex55
);


// State Definitions:
parameter resting = 6'b000000;

parameter rightTurn10 = 6'b000001;
parameter rightTurn11 = 6'b000010;
parameter rightTurn12 = 6'b000011;
parameter rightTurn13 = 6'b000100;
parameter rightTurn14 = 6'b000101;
parameter rightTurn15 = 6'b000110;

parameter rightTurn20 = 6'b000111;
parameter rightTurn21 = 6'b001000;
parameter rightTurn22 = 6'b001001;
parameter rightTurn23 = 6'b001010;
parameter rightTurn24 = 6'b001011;
parameter rightTurn25 = 6'b001100;

parameter rightTurn30 = 6'b001101;
parameter rightTurn31 = 6'b001110;
parameter rightTurn32 = 6'b001111;
parameter rightTurn33 = 6'b010000;
parameter rightTurn34 = 6'b010001;
parameter rightTurn35 = 6'b010010;

parameter leftTurn10 = 6'b010011;
parameter leftTurn11 = 6'b010100;
parameter leftTurn12 = 6'b010101;
parameter leftTurn13 = 6'b010110;
parameter leftTurn14 = 6'b010111;
parameter leftTurn15 = 6'b011000;

parameter leftTurn20 = 6'b011001;
parameter leftTurn21 = 6'b011010;
parameter leftTurn22 = 6'b011011;
parameter leftTurn23 = 6'b011100;
parameter leftTurn24 = 6'b011101;
parameter leftTurn25 = 6'b011110;

parameter leftTurn30 = 6'b011111;
parameter leftTurn31 = 6'b100000;
parameter leftTurn32 = 6'b100001;
parameter leftTurn33 = 6'b100010;
parameter leftTurn34 = 6'b100011;
parameter leftTurn35 = 6'b100100;

parameter hazard = 6'b100101;

// Internal Variables
reg [5:0] current_state, next_state;  // Holds current and next FSM state
reg [25:0] counter;  // Counter for timing delay (assuming we divide the 50MHz clock)
reg enable = 0;
parameter max_count = 25000000;  // Adjust this based on your desired blinking frequency (for 0.5Hz)

// Initial setup for FSM
initial begin
    current_state = resting;  // Start in resting state
    next_state = resting;
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
                next_state = rightTurn10;  // Transition to right turn state
            end else if (!left_button) begin
                next_state = leftTurn10;  // Transition to left turn state
            end else if (!hazard_button) begin
                next_state = hazard;  // Hazard mode overrides all
            end else begin
                next_state = resting;  // Stay in resting state
            end
        end
///////////////////////////////*********************************HEX 2 LEFT TURN ***************START
        rightTurn10: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
            end else begin
					next_state = rightTurn11;
				end
			end
			
			rightTurn11: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
            end else begin
					next_state = rightTurn12;
				end
			end
			
			rightTurn12: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
            end else begin
					next_state = rightTurn13;
				end
			end
			
			rightTurn13: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
            end else begin
					next_state = rightTurn14;
				end
			end
			
			rightTurn14: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
            end else begin
					next_state = rightTurn15;
				end
			end
			
			rightTurn15: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
            end else begin
					next_state = rightTurn20;
				end
			end
///////////////////////////////*********************************HEX 2 LEFT TURN ***************END
///////////////////////////////*********************************HEX 1 LEFT TURN ***************START
			rightTurn20: begin
				if (!reset) begin
					next_state = resting;
				end
				if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
				end else begin
					next_state = rightTurn21;
				end
			end
			
			rightTurn21: begin
				if (!reset) begin
					next_state = resting;
				end
				if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
				end else begin
					next_state = rightTurn22;
				end
			end
			
			rightTurn22: begin
				if (!reset) begin
					next_state = resting;
				end
				if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
				end else begin
					next_state = rightTurn23;
				end
			end
			
			rightTurn23: begin
				if (!reset) begin
					next_state = resting;
				end
				if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
				end else begin
					next_state = rightTurn24;
				end
			end
			
			rightTurn24: begin
				if (!reset) begin
					next_state = resting;
				end
				if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
				end else begin
					next_state = rightTurn25;
				end
			end
			
			rightTurn25: begin
				if (!reset) begin
					next_state = resting;
				end
				if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
				end else begin
					next_state = rightTurn30;
				end
			end
///////////////////////////////*********************************HEX 1 LEFT TURN ***************END
///////////////////////////////*********************************HEX 0 LEFT TURN ***************START
			rightTurn30: begin
				if (!reset) begin
					next_state = resting;
				end
				if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
				end else begin
					next_state = rightTurn31;
				end
			end
			
			rightTurn31: begin
				if (!reset) begin
					next_state = resting;
				end
				if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
				end else begin
					next_state = rightTurn32;
				end
			end
			
			rightTurn32: begin
				if (!reset) begin
					next_state = resting;
				end
				if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
				end else begin
					next_state = rightTurn33;
				end
			end
			
			rightTurn33: begin
				if (!reset) begin
					next_state = resting;
				end
				if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
				end else begin
					next_state = rightTurn34;
				end
			end
			
			rightTurn34: begin
				if (!reset) begin
					next_state = resting;
				end
				if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
				end else begin
					next_state = rightTurn35;
				end
			end
			
			rightTurn35: begin
				if (!reset) begin
					next_state = resting;
				end
				if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides right turn
				end else begin
					next_state = resting;
				end
			end
			
///////////////////////////////*********************************HEX 0 LEFT TURN ***************END
///////////////////////////////*********************************HEX 3 LEFT TURN ***************START
        leftTurn10: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn11;
				end
        end
		  
		  leftTurn11: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn12;
				end
        end
		  
		  leftTurn12: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn13;
				end
        end
		  
		  leftTurn13: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn14;
				end
        end
		  
		  leftTurn14: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn15;
				end
        end
		  
		  leftTurn15: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn20;
				end
        end
///////////////////////////////*********************************HEX 3 LEFT TURN ***************END
///////////////////////////////*********************************HEX 4 LEFT TURN ***************START
		  leftTurn20: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn21;
				end
        end
		  
		  leftTurn21: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn22;
				end
        end
		  
		  leftTurn22: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn23;
				end
        end
		  
		  leftTurn23: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn24;
				end
        end
		  
		  leftTurn24: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn25;
				end
        end
		  
		  leftTurn25: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn30;
				end
        end
///////////////////////////////*********************************HEX 4 LEFT TURN ***************END
///////////////////////////////*********************************HEX 5 LEFT TURN ***************START
		  leftTurn30: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn31;
				end
        end
		  
		  leftTurn31: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn32;
				end
        end
		  
		  leftTurn32: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn33;
				end
        end
		  
		  leftTurn33: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn34;
				end
        end
		  
		  leftTurn34: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = leftTurn35;
				end
        end
		  
		  leftTurn35: begin
				if (!reset) begin
					next_state = resting;
				end
            if (!hazard_button) begin
                next_state = hazard;  // Hazard overrides left turn
            end else begin
					next_state = resting;
				end
        end
///////////////////////////////*********************************HEX 5 LEFT TURN ***************END
        hazard: begin
				if (!reset) begin
					next_state = resting;
				end else begin
					next_state = resting;  // Return to resting after hazard is released
				end
        end

        default: next_state = resting;  // Default to resting state
    endcase
end

assign right_led1 =   (current_state == rightTurn10) || (current_state == rightTurn11) || (current_state == rightTurn12) || (current_state == rightTurn13) || (current_state == rightTurn14) || (current_state == rightTurn15) || 
                      (current_state == rightTurn20) || (current_state == rightTurn21) || (current_state == rightTurn22) || (current_state == rightTurn23) || (current_state == rightTurn24) || (current_state == rightTurn25) || 
						    (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard);
assign right_hex20 =!((current_state == rightTurn10) || (current_state == rightTurn11) || (current_state == rightTurn12) || (current_state == rightTurn13) || (current_state == rightTurn14) || (current_state == rightTurn15) || 
                      (current_state == rightTurn20) || (current_state == rightTurn21) || (current_state == rightTurn22) || (current_state == rightTurn23) || (current_state == rightTurn24) || (current_state == rightTurn25) || 
						    (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex21 =!(                                  (current_state == rightTurn11) || (current_state == rightTurn12) || (current_state == rightTurn13) || (current_state == rightTurn14) || (current_state == rightTurn15) || 
                      (current_state == rightTurn20) || (current_state == rightTurn21) || (current_state == rightTurn22) || (current_state == rightTurn23) || (current_state == rightTurn24) || (current_state == rightTurn25) || 
						    (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex22 =!(                                                                    (current_state == rightTurn12) || (current_state == rightTurn13) || (current_state == rightTurn14) || (current_state == rightTurn15) || 
                      (current_state == rightTurn20) || (current_state == rightTurn21) || (current_state == rightTurn22) || (current_state == rightTurn23) || (current_state == rightTurn24) || (current_state == rightTurn25) || 
						    (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex23 =!(                                                                                                      (current_state == rightTurn13) || (current_state == rightTurn14) || (current_state == rightTurn15) || 
                      (current_state == rightTurn20) || (current_state == rightTurn21) || (current_state == rightTurn22) || (current_state == rightTurn23) || (current_state == rightTurn24) || (current_state == rightTurn25) || 
						    (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex24 =!( 																																													  (current_state == rightTurn14) || (current_state == rightTurn15) || 
                      (current_state == rightTurn20) || (current_state == rightTurn21) || (current_state == rightTurn22) || (current_state == rightTurn23) || (current_state == rightTurn24) || (current_state == rightTurn25) || 
						    (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex25 =!( 																																																							     (current_state == rightTurn15) || 
                      (current_state == rightTurn20) || (current_state == rightTurn21) || (current_state == rightTurn22) || (current_state == rightTurn23) || (current_state == rightTurn24) || (current_state == rightTurn25) || 
						    (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));

assign right_led2 =   (current_state == rightTurn20) || (current_state == rightTurn21) || (current_state == rightTurn22) || (current_state == rightTurn23) || (current_state == rightTurn24) || (current_state == rightTurn25) || 
						    (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard);
assign right_hex10 =!((current_state == rightTurn20) || (current_state == rightTurn21) || (current_state == rightTurn22) || (current_state == rightTurn23) || (current_state == rightTurn24) || (current_state == rightTurn25) || 
						    (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex11 =!(										  	  (current_state == rightTurn21) || (current_state == rightTurn22) || (current_state == rightTurn23) || (current_state == rightTurn24) || (current_state == rightTurn25) || 
						    (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex12 =!(																						   (current_state == rightTurn22) || (current_state == rightTurn23) || (current_state == rightTurn24) || (current_state == rightTurn25) || 
						    (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex13 =!(																																       (current_state == rightTurn23) || (current_state == rightTurn24) || (current_state == rightTurn25) || 
						    (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex14 =!(																																													  (current_state == rightTurn24) || (current_state == rightTurn25) || 
						    (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex15 =!(																																																								   (current_state == rightTurn25) || 
						    (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));

assign right_led3 =   (current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard);
assign right_hex00 =!((current_state == rightTurn30) || (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex01 =!(											  (current_state == rightTurn31) || (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex02 =!(																						   (current_state == rightTurn32) || (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex03 =!(																																		 (current_state == rightTurn33) || (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex04 =!(																																													  (current_state == rightTurn34) || (current_state == rightTurn35) ||
						    (current_state == hazard));
assign right_hex05 =!(																																																									(current_state == rightTurn35) ||
						    (current_state == hazard));

assign left_led1 =   (current_state == leftTurn10) || (current_state == leftTurn11) || (current_state == leftTurn12) || (current_state == leftTurn13) || (current_state == leftTurn14) || (current_state == leftTurn15) ||
							(current_state == leftTurn20) || (current_state == leftTurn21) || (current_state == leftTurn22) || (current_state == leftTurn23) || (current_state == leftTurn24) || (current_state == leftTurn25) || 
							(current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard);
assign left_hex30 =!((current_state == leftTurn10) || (current_state == leftTurn11) || (current_state == leftTurn12) || (current_state == leftTurn13) || (current_state == leftTurn14) || (current_state == leftTurn15) ||
							(current_state == leftTurn20) || (current_state == leftTurn21) || (current_state == leftTurn22) || (current_state == leftTurn23) || (current_state == leftTurn24) || (current_state == leftTurn25) || 
							(current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex31 =!(											(current_state == leftTurn11) || (current_state == leftTurn12) || (current_state == leftTurn13) || (current_state == leftTurn14) || (current_state == leftTurn15) ||
							(current_state == leftTurn20) || (current_state == leftTurn21) || (current_state == leftTurn22) || (current_state == leftTurn23) || (current_state == leftTurn24) || (current_state == leftTurn25) || 
							(current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex32 =!(																						(current_state == leftTurn12) || (current_state == leftTurn13) || (current_state == leftTurn14) || (current_state == leftTurn15) ||
							(current_state == leftTurn20) || (current_state == leftTurn21) || (current_state == leftTurn22) || (current_state == leftTurn23) || (current_state == leftTurn24) || (current_state == leftTurn25) || 
							(current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex33 =!(																																	(current_state == leftTurn13) || (current_state == leftTurn14) || (current_state == leftTurn15) ||
							(current_state == leftTurn20) || (current_state == leftTurn21) || (current_state == leftTurn22) || (current_state == leftTurn23) || (current_state == leftTurn24) || (current_state == leftTurn25) || 
							(current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex34 =!(																																												(current_state == leftTurn14) || (current_state == leftTurn15) ||
							(current_state == leftTurn20) || (current_state == leftTurn21) || (current_state == leftTurn22) || (current_state == leftTurn23) || (current_state == leftTurn24) || (current_state == leftTurn25) || 
							(current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex35 =!(																																																							(current_state == leftTurn15) ||
							(current_state == leftTurn20) || (current_state == leftTurn21) || (current_state == leftTurn22) || (current_state == leftTurn23) || (current_state == leftTurn24) || (current_state == leftTurn25) || 
							(current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
							
assign left_led2 =   (current_state == leftTurn20) || (current_state == leftTurn21) || (current_state == leftTurn22) || (current_state == leftTurn23) || (current_state == leftTurn24) || (current_state == leftTurn25) || 
							(current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard);
assign left_hex40 =!((current_state == leftTurn20) || (current_state == leftTurn21) || (current_state == leftTurn22) || (current_state == leftTurn23) || (current_state == leftTurn24) || (current_state == leftTurn25) || 
							(current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex41 =!(											(current_state == leftTurn21) || (current_state == leftTurn22) || (current_state == leftTurn23) || (current_state == leftTurn24) || (current_state == leftTurn25) || 
							(current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex42 =!(																						(current_state == leftTurn22) || (current_state == leftTurn23) || (current_state == leftTurn24) || (current_state == leftTurn25) || 
							(current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex43 =!(																																	(current_state == leftTurn23) || (current_state == leftTurn24) || (current_state == leftTurn25) || 
							(current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex44 =!(																																												(current_state == leftTurn24) || (current_state == leftTurn25) || 
							(current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex45 =!(																																																							(current_state == leftTurn25) || 
							(current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
							
assign left_led3 =   (current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard);
assign left_hex50 =!((current_state == leftTurn30) || (current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex51 =!(											(current_state == leftTurn31) || (current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex52 =!(																						(current_state == leftTurn32) || (current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex53 =!(																																	(current_state == leftTurn33) || (current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex54 =!(																																												(current_state == leftTurn34) || (current_state == leftTurn35) || 
							(current_state == hazard));
assign left_hex55 =!(																																																							(current_state == leftTurn35) || 
							(current_state == hazard));
							
// Clock Divider Logic (for timing control)
// Divides the 50MHz clock to slower values for visible LED blinking
always @ (posedge clock) begin
    if (counter == max_count-1) begin
		counter <= 0;
		enable <= ~enable;
	 end
	 else begin
		counter <= counter + 1;
	 end
end

endmodule
