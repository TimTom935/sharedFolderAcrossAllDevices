 module mips #(parameter DATA_WIDTH=8, ADDR_WIDTH=8)
   (
    input clk,                // Clock signal
    input reset,              // Reset signal (active-low)
    input [DATA_WIDTH-1:0] switches, // Input from switches (for I/O read)
    output wire [DATA_WIDTH-1:0] leds     // Output to LEDs (for I/O write)
	 
   );

   // Signals to connect mipscpu and exmem
   wire [DATA_WIDTH-1:0] cpu_data;   // Data from CPU to memory or I/O
   wire [DATA_WIDTH-1:0] mem_data;   // Data from memory or I/O to CPU
	wire [DATA_WIDTH-1:0] mem_data_1;
   wire [ADDR_WIDTH-1:0] cpu_addr;   // Address from CPU to memory or I/O
   wire cpu_memwrite;                // Write enable signal from CPU to memory or I/O
	wire IOCONTROL;
	wire ledEN;

   // Instantiate the mipscpu (mini-MIPS processor)
   miniMIPS #(DATA_WIDTH, ADDR_WIDTH) cpu (
      .clk(clk),
      .reset(reset),
      .memdata(mem_data_1),         // Data read from memory or I/O
      .memwrite(cpu_memwrite),    // Write enable to memory or I/O
      .adr(cpu_addr),             // Address to memory or I/O
      .writedata(cpu_data)        // Data to write to memory or I/O
   );

   // Instantiate the exmem (external memory module)
   exmem #(DATA_WIDTH, ADDR_WIDTH) mem (
      .data(cpu_data),            // Data to write from CPU
      .addr(cpu_addr),            // Address from CPU
      .we(cpu_memwrite),          // Write enable from CPU
      .clk(~clk),
      .q(mem_data),               // Data to CPU (either from memory or I/O)		
   );
	assign IOCONTROL = cpu_addr[6] & cpu_addr[7];
	mux2 #(8) regmux(mem_data, switches, IOCONTROL, mem_data_1);
	
	assign ledEN = cpu_memwrite & IOCONTROL;
	flopenr flop(~clk,reset, ledEN, writedata, leds);

endmodule
