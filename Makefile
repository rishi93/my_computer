.PHONY: Computer clean

Computer:
	@if [ -z "$(ROM_FILE)" ]; then \
		echo "ERROR: ROM_FILE must be specified. Usage: make Computer ROM_FILE=yourfile.bin"; \
		exit 1; \
	fi

	# Load the ROM with the specified file and then run the entire computer
	iverilog -DROM_FILE=\"$(ROM_FILE)\" -o hardware/Computer/sim.out \
		hardware/Register/Register.v hardware/PC/PC.v \
		hardware/ALU/ALU.v \
	    hardware/CPU/CPU.v hardware/RAM/RAM.v hardware/ROM/ROM.v \
		hardware/Computer/Computer.v hardware/Computer/Test.v
	vvp hardware/Computer/sim.out

clean:
	rm -f hardware/*/*sim.out hardware/*/*Test.vcd
