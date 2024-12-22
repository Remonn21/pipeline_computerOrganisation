# VHDL Pipeline Processor

## Team Number: 1 
**Course**: Computer Organization  
**Instructor**: Dr. Hatem Zakria

**Team Members**:  
- Remon Ehab  
- Adham Ashraf 
- Ebrahim Amin
- Ibrahim Saeed
- Hazem Mohammed
- Basel Ahmed
## Overview

This project is a VHDL implementation of a pipeline processor, designed as part of a Computer Organization course under the guidance of Dr. Hatem Zakri. The processor utilizes a pipelined architecture, allowing for efficient instruction execution and increased throughput. This project demonstrates the fundamental concepts of pipelining and parallelism in digital systems, which are crucial for modern computer architectures.

## Project Details

### Objectives

- To design and implement a basic pipelined processor using VHDL.
- To understand the principles of instruction-level parallelism.
- To explore different stages of a pipeline, such as fetch, decode, execute, memory access, and write-back.
- To test the design for correct functionality and performance.

### Features

- 5-stage pipeline architecture:
  - **IF**: Instruction Fetch
  - **ID**: Instruction Decode
  - **EX**: Execute
  - **MEM**: Memory Access
  - **WB**: Write-back
- Hazard detection and forwarding mechanisms.
- Basic arithmetic and logical operations.
- Support for a simple instruction set architecture (ISA).

### Tools & Technologies

- **Hardware Description Language**: VHDL
- **Simulation Software**: ModelSim, Xilinx Vivado
- **Target Hardware**: FPGA (Optional for future implementation)

### Project Structure

```
├── README.md                 # Project documentation
# VHDL source files
├── alu.vhd               # ALU unit
├── alu_control.vhd       # ALU control logic
├── Branch_Adder.vhd      # Branch address calculation
├── data_mem.vhd          # Data memory module
├── ex_mem_reg.vhd        # EX/MEM pipeline register
├── forwarding_unit.vhd   # Forwarding unit to handle data hazards
├── forward_a_mux.vhd     # Multiplexer for forwarding A
├── forward_b_mux.vhd     # Multiplexer for forwarding B
├── f_id_reg.vhd          # IF/ID pipeline register
├── hazzard_unit.vhd      # Hazard detection unit
├── id_ex_reg.vhd         # ID/EX pipeline register
├── instructionmemory.vhd # Instruction memory
├── jump_sh.vhd           # Jump signal handling
├── main_control_unit.vhd # Main control logic for instruction decoding
├── mux_32.vhd            # 32-bit multiplexer
├── mux_32_m.vhd          # 32-bit multiplexer (memory stage)
├── mux_32_mem.vhd        # Multiplexer for memory
├── mux_control_haz.vhd   # Control hazard multiplexer
├── pc.vhd                # Program Counter module
├── pc_adder.vhd          # Program Counter adder
├── pipeline.vhd          # Main pipeline processor file
├── rd_rt_mux.vhd         # Multiplexer for read/write registers
├── reg_file.vhd          # Register file
├── shift.vhd             # Shifting operation (for shifts and jumps)
├── sign_extend.vhd       # Sign extend unit
├── wb.vhd                # Write-back logic


```

## How to Use

1. Clone the repository to your local machine.
   ```bash
   git clone https://github.com/Remonn21/pipeline_computerOrganisation.git
   cd pipeline-processor
   ```

2. Open the project in your preferred VHDL simulator (e.g., ModelSim, Aldec or Xilinx Vivado).

3. Compile the VHDL files, starting with the main processor file (`pipeline.vhd`), followed by the other components (register file, ALU, control unit).

4. Run the simulation to test the functionality of the processor.


## Example Usage

Once the design is compiled and the simulation is running, the processor will execute a series of instructions in the pipeline. For example, it will fetch an instruction, decode it, execute it, access memory if necessary, and write the result back to the register file.

The testbench includes scenarios such as arithmetic operations, load/store operations, and branch instructions. You can extend the test cases to include additional instructions or edge cases as needed.

Here's the instructions in the instruction memory

| **Hex Code**  | **Address** | **Instruction**                                          | **Description**                                             |
|---------------|-------------|----------------------------------------------------------|-------------------------------------------------------------|
| `x"8CE20005"` | 0x0000 0014 | `LW REG(2), 5(R7)`                                       | Load word from memory address 5 + contents of R7 into R2.   |
| `x"01024824"` | 0x0000 0000 | `AND REG(9), REG(8), REG(2)`                             | AND operation between REG8 and REG7, result stored in REG9. |
| `x"12110003"` | 0x0000 0014 | `BEQ REG(16), REG(17), $L1`                              | Branch to label `$L1` if REG16 equals REG17.                 |
| `x"01285024"` | 0x0000 0018 | `AND REG(10), REG(9), REG(8)`                             | AND operation between REG9 and REG8, result stored in REG10. |
| `x"01896825"` | 0x0000 0004 | `OR REG(13), REG(12), REG(9)`                             | OR operation between REG12 and REG9, result stored in REG13. |
| `x"01285024"` | 0x0000 0018 | `AND REG(10), REG(9), REG(8)`                             | AND operation between REG9 and REG8, result stored in REG10. |
| `x"01285020"` | 0x0000 0008 | `ADD REG(10), REG(9), REG(8)`                             | ADD operation between REG9 and REG8, result stored in REG10. |
| `x"0800000B"` | 0x0000 002C | `JUMP to 0x00000000`                                     | Jump to address 0x00400000.                                  |
| `x"01285022"` | 0x0000 000C | `SUB REG(13), REG(9), REG(8)`                             | SUB operation between REG9 and REG8, result stored in REG13. |
| `x"0149402A"` | 0x0000 0010 | `SLT REG(8), REG(10), REG(9)`                             | Set REG8 to 1 if REG10 is less than REG9, else set to 0.      |
| `x"01285024"` | 0x0000 0018 | `AND REG(10), REG(9), REG(8)`                             | AND operation between REG9 and REG8, result stored in REG10. |
| `x"018B6825"` | 0x0000 001C | `OR REG(13), REG(12), REG(11)`                            | OR operation between REG12 and REG11, result stored in REG13. |





## Contributing

If you would like to contribute to this project, feel free to fork the repository, make your changes, and submit a pull request. Make sure to follow the VHDL coding standards and include appropriate test cases.



## Acknowledgments

- Dr. Hatem Zakria for his guidance and support throughout the project.
- The concepts of pipelining and computer organization studied in the course.
- Open-source communities and online resources for VHDL tutorials and examples.

