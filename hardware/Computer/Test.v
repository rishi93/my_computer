module Computer_Test;
    reg reset, clk;

    initial clk = 0;

    always begin
        #1 clk = ~clk;
    end

    // Pass the ROM filepath into the Computer, which forwards it to ROM.
    // ROM_FILE must be defined via command line -D flag
    Computer #(.ROM_FILE(`ROM_FILE)) computer(
        .reset(reset),
        .clk(clk)
    );

    task print_ram0;
    begin
        $display("RAM[0] = %d", computer.ram.mem[0]);
    end
    endtask

    integer i;
    reg [15:0] prev_pc;
    reg [15:0] curr_pc;

    initial begin
        // Press the reset button
        // It goes to 1, then bounces back to 0
        $display("--------------------");
        $display("finger on the reset button");
        reset = 1;
        $display("reset = %b", reset);
        #1;
        $display("finger off the reset button");
        reset = 0;
        $display("reset = %b", reset);
        $display("--------------------");

        i = 0;
        prev_pc = 16'hFFFF; // Initialize to a value that won't match
        curr_pc = 0;
        
        // Run until PC stops incrementing
        forever begin
            #2;
            i = i + 1;
            curr_pc = computer.pc;
            $display("Clock cycle: %d, PC = %d", i, curr_pc);
            
            if (curr_pc == prev_pc) begin
                // PC stopped changing
                $display("--------------------");
                $display("PC stopped incrementing after %d clock cycles", i);
                print_ram0();
                $finish;
            end
            
            if (i >= 1000) begin
                $display("--------------------");
                $display("WARNING: Reached safety limit of 1000 cycles");
                print_ram0();
                $finish;
            end
            
            prev_pc = curr_pc;
        end
    end

endmodule;