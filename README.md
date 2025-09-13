# Final Project: UART TX and RX Design - Verilog Implementation

A comprehensive Universal Asynchronous Receiver-Transmitter (UART) design featuring detailed transmitter (TX) and receiver (RX) modules implemented in Verilog HDL. The project includes individual module testbenches, architectural diagrams, simulation results, and a complete system testbench (`UART.v` and `UART_tb.v`) that validates both TX and RX functionality working together.

## 📋 Table of Contents

- [Overview](#overview)
- [Project Structure](#project-structure)
- [TX Design](#tx-design)
- [RX Design](#rx-design)
- [System Integration](#system-integration)
- [Architecture Diagrams](#architecture-diagrams)
- [Testing Strategy](#testing-strategy)
- [Simulation Results](#simulation-results)
- [Getting Started](#getting-started)
- [Technical Specifications](#technical-specifications)

## 🔍 Overview

This project focuses on the detailed design and implementation of UART transmitter and receiver modules in Verilog. The TX and RX modules are designed as independent, reusable components that can be integrated into larger systems. The main `UART.v` module serves as a top-level wrapper that instantiates both TX and RX modules, while `UART_tb.v` provides comprehensive testing to verify that both modules work correctly together in a complete communication system.

## 📁 Project Structure

All project files are organized within the **Final Project** folder:

```
Final Project/
├── UART/                           # Complete UART System
│   ├── UART.v                      # Top-level UART integration module
│   ├── UART_tb.v                   # Complete system testbench
│   ├── UART Architecture .dio      # System architecture diagram
│   ├── UART State Diagram.png      # Overall system state diagram
│   ├── UART_tb result.png          # System test simulation results
│   ├── Uart_tb Result.mp4          # Video demonstration of system test
│   └── Transcript.png              # System test transcript
├── TX/                             # Transmitter Module
│   ├── UART_TX.v                   # TX top-level module
│   ├── UART_TX_tb.v                # TX testbench
│   ├── UART_TX Arch.png            # TX architecture diagram
│   ├── frame.v                     # Frame formatting module
│   ├── baud_counter_TX.v           # TX baud rate counter
│   ├── bit_select.v                # Bit selection logic
│   ├── multiplexer.v               # Output multiplexer
│   └── result.png                  # TX simulation results
└── RX/                             # Receiver Module
    ├── UART_RX.v                   # RX top-level module
    ├── UART_RX_tb.v                # RX testbench
    ├── UART_RX Arch.png            # RX architecture diagram
    ├── FSM State Diagram .png      # RX state machine diagram
    ├── FSM.v                       # State machine controller
    ├── edge_detector.v             # Start bit detection
    ├── Edge Detector Diagram.png   # Edge detector diagram
    ├── baud_counter.v              # RX baud rate counter
    ├── Baud Counter Diagram.png    # Baud counter diagram
    ├── SIPO_shift_register.v       # Serial-in parallel-out register
    ├── result when stop bit 0.png  # RX result with stop bit 0
    ├── result when stop bit 1.png  # RX result with stop bit 1
    └── RX transcript.png           # RX simulation transcript
```

## 📡 TX Design (Transmitter)

The UART Transmitter is designed with a modular approach for reliable serial data transmission:

### TX Architecture
```
UART_TX.v (Top Level)
├── frame.v              # Frame formatting (start + data + stop)
├── baud_counter_TX.v    # TX baud rate timing control
├── bit_select.v         # Bit position counter and selection
└── multiplexer.v        # Serial output bit selection
```

### TX Design Details
- **Frame Formatting**: Creates standard UART frame with start bit (0), 8 data bits, and stop bit (1)
- **Baud Rate Control**: Configurable timing for bit transmission intervals
- **Bit Sequencing**: Sequential transmission of start bit, data bits (LSB first), and stop bit
- **Output Control**: Clean serial output with proper idle state (high)

### TX Key Features
- **Synchronous Design**: All operations synchronized to system clock
- **Busy/Done Signals**: Status indicators for external control
- **Configurable Data Width**: Parameterized for different data sizes
- **Clean State Machine**: Simple, reliable transmission control

### TX Visual Documentation
- **`UART_TX Arch.png`**: Complete TX module architecture diagram
- **`result.png`**: TX simulation waveform showing frame transmission

## 📥 RX Design (Receiver)

The UART Receiver implements a sophisticated state machine-based design for robust data reception:

### RX Architecture
```
UART_RX.v (Top Level)
├── edge_detector.v       # Start bit detection (falling edge)
├── FSM.v                 # Main state machine controller
├── baud_counter.v        # RX baud rate synchronization
└── SIPO_shift_register.v # Serial-to-parallel data conversion
```

### RX State Machine
The receiver uses a 6-state FSM for reliable data reception:
- **IDLE**: Waiting for start bit (falling edge detection)
- **START**: Validating start bit and initializing reception
- **DATA**: Receiving 8 data bits with proper timing
- **STOP**: Validating stop bit
- **DONE**: Data reception complete, data valid
- **ERR**: Error state for invalid stop bit

### RX Design Details
- **Edge Detection**: Reliable start bit detection using falling edge detector
- **Baud Synchronization**: Self-synchronizing baud rate counter
- **Data Sampling**: Mid-bit sampling for maximum noise immunity
- **Error Handling**: Stop bit validation and error state management
- **SIPO Conversion**: Serial-in parallel-out shift register for data assembly

### RX Visual Documentation
- **`UART_RX Arch.png`**: Complete RX module architecture diagram
- **`FSM State Diagram .png`**: Detailed state machine flow diagram
- **`Edge Detector Diagram.png`**: Edge detection circuit diagram
- **`Baud Counter Diagram.png`**: Baud rate counter implementation
- **`result when stop bit 0.png`**: Simulation with invalid stop bit (error case)
- **`result when stop bit 1.png`**: Simulation with valid stop bit (success case)
- **`RX transcript.png`**: Detailed RX simulation transcript

## 🔗 System Integration

### UART.v - Top-Level Integration
The `UART.v` module serves as the system integrator that:
- Instantiates both TX and RX modules
- Provides unified interface for external systems
- Handles parameter passing between modules
- Manages clock and reset distribution

### UART_tb.v - Complete System Testing
The `UART_tb.v` testbench validates the entire system by:
- **Loopback Testing**: Connecting TX output to RX input
- **Data Verification**: Transmitting known data and verifying reception
- **Timing Validation**: Ensuring proper timing relationships
- **State Monitoring**: Tracking both TX and RX states during operation
- **Error Detection**: Verifying error handling and recovery

### System Visual Documentation
- **`UART Architecture .dio`**: Complete system architecture diagram
- **`UART State Diagram.png`**: Overall system state flow
- **`UART_tb result.png`**: Complete system test simulation results
- **`Uart_tb Result.mp4`**: Video demonstration of the complete system test
- **`Transcript.png`**: Detailed system test transcript

## 🧪 Testing Strategy

### Individual Module Testing
Each TX and RX module has its own dedicated testbench:
- **`UART_TX_tb.v`**: Tests transmitter functionality in isolation
- **`UART_RX_tb.v`**: Tests receiver functionality with controlled input

### Integrated System Testing
The main `UART_tb.v` testbench performs comprehensive system validation:
- **Loopback Configuration**: TX output directly connected to RX input
- **Data Integrity Testing**: Verifies transmitted data matches received data
- **Timing Analysis**: Ensures proper synchronization between TX and RX
- **State Verification**: Monitors both modules' internal states
- **Error Scenarios**: Tests error handling and recovery mechanisms

### Test Results Validation
The testbench includes:
- Console output showing data flow
- Timing verification for all signals
- State transition monitoring
- Success/failure reporting
- Waveform generation for detailed analysis

## 📊 Simulation Results

The project includes comprehensive simulation results demonstrating:

### TX Module Results
- **Frame Generation**: Proper start bit, data bits, and stop bit formatting
- **Timing Control**: Accurate baud rate timing and bit transmission
- **State Transitions**: Clean state machine operation
- **Output Waveforms**: Clear serial output with proper idle state

### RX Module Results
- **Start Bit Detection**: Reliable falling edge detection
- **Data Sampling**: Accurate mid-bit sampling of incoming data
- **State Machine Operation**: Proper transitions through IDLE, START, DATA, STOP, DONE states
- **Error Handling**: Correct behavior for invalid stop bits
- **Data Assembly**: Successful serial-to-parallel conversion

### System Integration Results
- **Loopback Communication**: Successful TX→RX data transmission
- **Data Integrity**: Transmitted data matches received data
- **Timing Synchronization**: Proper coordination between TX and RX modules
- **Error Recovery**: System handles error conditions gracefully

### Visual Documentation
- **Static Images**: PNG files showing detailed simulation waveforms
- **Video Demonstration**: MP4 file showing real-time system operation
- **Architecture Diagrams**: Visual representation of module interconnections
- **State Diagrams**: Flow charts showing state machine operations

## 🚀 Getting Started

### Prerequisites
- Verilog simulator (ModelSim, QuestaSim, or similar)
- Quartus Prime (for FPGA synthesis)

### Running the Complete System Test
1. Compile all Verilog files in your simulator
2. Run the main system testbench: `UART/UART_tb.v`
3. Observe the loopback test where TX output feeds into RX input
4. Verify that transmitted data matches received data in console output
5. View the video demonstration: `UART/Uart_tb Result.mp4`

### Running Individual Module Tests
1. **TX Module Testing**: Run `TX/UART_TX_tb.v` to test transmitter in isolation
2. **RX Module Testing**: Run `RX/UART_RX_tb.v` to test receiver with controlled input
3. Compare individual results with integrated system test

### Viewing Documentation
1. **Architecture Diagrams**: Open PNG files to understand module structure
2. **State Diagrams**: Review FSM flow charts for design understanding
3. **Simulation Results**: Analyze waveform images for timing verification
4. **Video Demonstrations**: Watch MP4 files for real-time operation

### System Integration Example
```verilog
// The UART.v module integrates both TX and RX for complete communication
UART #(.WIDTH(8)) uart_system (
    .clk(clk),
    .reset(reset),
    .rx(external_rx),           // External RX input
    .tx(external_tx),           // External TX output
    .tx_data(data_to_send),     // Data to transmit
    .tx_en(transmit_enable),    // Start transmission
    .tx_busy(transmit_busy),    // TX busy indicator
    .tx_done(transmit_done),    // TX completion signal
    .rx_data(received_data),    // Received data output
    .rx_data_valid(data_valid), // Data valid indicator
    .rx_busy(receive_busy)      // RX busy indicator
);
```

## ⚙️ Technical Specifications

- **Data Width**: 8 bits (configurable)
- **Frame Format**: 1 start bit + 8 data bits + 1 stop bit
- **Clock Frequency**: 100 MHz system clock
- **Baud Rate**: 9600 bps (designed for 100MHz clock)
- **Clock Domain**: Single clock domain design
- **Reset**: Asynchronous active-high reset
- **Protocol**: Standard UART (no parity, 1 stop bit)
- **Error Handling**: Stop bit validation and error state management
- **Visual Documentation**: Comprehensive diagrams and simulation results

## 📂 File Structure

### Complete UART System (`UART/`)
- `UART.v` - Top-level integration module
- `UART_tb.v` - Complete system testbench
- `UART Architecture .dio` - System architecture diagram
- `UART State Diagram.png` - Overall system state diagram
- `UART_tb result.png` - System test simulation results
- `Uart_tb Result.mp4` - Video demonstration of system test
- `Transcript.png` - System test transcript

### Transmitter Module (`TX/`)
- `UART_TX.v` - TX controller
- `UART_TX_tb.v` - TX testbench
- `UART_TX Arch.png` - TX architecture diagram
- `frame.v` - Frame formatting
- `baud_counter_TX.v` - TX timing
- `bit_select.v` - Bit selection
- `multiplexer.v` - Output control
- `result.png` - TX simulation results

### Receiver Module (`RX/`)
- `UART_RX.v` - RX controller
- `UART_RX_tb.v` - RX testbench
- `UART_RX Arch.png` - RX architecture diagram
- `FSM State Diagram .png` - State machine diagram
- `FSM.v` - State machine
- `edge_detector.v` - Edge detection
- `Edge Detector Diagram.png` - Edge detector diagram
- `baud_counter.v` - RX timing
- `Baud Counter Diagram.png` - Baud counter diagram
- `SIPO_shift_register.v` - Data conversion
- `result when stop bit 0.png` - Error case simulation
- `result when stop bit 1.png` - Success case simulation
- `RX transcript.png` - RX simulation transcript

## 🤝 Contributing

This project was developed as part of a digital design course. Contributions and improvements are welcome! Please feel free to:
- Report bugs or issues
- Suggest enhancements
- Submit pull requests
- Improve documentation

## 📝 License

This project is part of an educational portfolio. Please respect academic integrity guidelines when using this code.

---

**Note**: This implementation is designed for educational purposes and demonstrates fundamental digital design concepts including state machines, counters, shift registers, modular design principles, and comprehensive documentation practices.
