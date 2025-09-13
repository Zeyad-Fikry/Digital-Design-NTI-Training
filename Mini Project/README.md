# Mini Project - Sequence Detector (110101)

This directory contains Verilog implementations of sequence detectors for the pattern "110101" using both Mealy and Moore state machines, with overlapping and non-overlapping detection modes.

## Files Overview

### Design Files
- **mealy_SD_Nonoverlapping.v** - Mealy sequence detector (non-overlapping)
- **mealy_SD_overlapping.v** - Mealy sequence detector (overlapping)
- **moore_SD_Nonoverlapping.v** - Moore sequence detector (non-overlapping)
- **moore_SD_overlapping.v** - Moore sequence detector (overlapping)

### Testbench Files
- **mealy_SD_Nonoverlapping_tb.v** - Testbench for Mealy non-overlapping detector
- **mealy_SD_overlapping_tb.v** - Testbench for Mealy overlapping detector
- **moore_SD_Nonoverlapping_tb.v** - Testbench for Moore non-overlapping detector
- **moore_SD_overlapping_tb.v** - Testbench for Moore overlapping detector

## Sequence Detected
All detectors are designed to detect the sequence: **110101**

## State Machine Types

### Mealy Machines
- Output depends on both current state and input
- Output changes immediately when input changes
- More efficient in terms of number of states

### Moore Machines
- Output depends only on current state
- Output changes only on clock edge
- More predictable timing

## Detection Modes

### Non-Overlapping
- After detecting a sequence, the detector resets to the initial state
- Each detection is independent
- Example: "110101110101" → 2 detections

### Overlapping
- After detecting a sequence, the detector can continue from a partial match
- Allows overlapping detections
- Example: "1101011" → 2 detections (overlapping)

## Usage

### Simulation
To run any testbench in ModelSim or Quartus:

1. Compile the design file and corresponding testbench
2. Run the simulation
3. View the waveform to observe state transitions and outputs


## Test Cases

Each testbench includes comprehensive test cases:
- Exact sequence detection
- Overlapping/non-overlapping behavior
- No match scenarios
- Partial match recovery
- Multiple sequence detection

## State Encoding

All designs use one-hot encoding for states:
- **Mealy**: 6 states (A, B, C, D, E, F)
- **Moore**: 7 states (A, B, C, D, E, F, G)

## Output

- **y = 1**: Sequence "110101" detected
- **y = 0**: No detection

## Clock and Reset

- **clk**: Positive edge triggered clock
- **reset**: Active high reset (resets to state A)
- **x**: Serial input bit
- **y**: Detection output
