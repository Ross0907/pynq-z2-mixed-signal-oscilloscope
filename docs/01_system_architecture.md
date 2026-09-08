# System Architecture

## Objective

The instrument is designed as a complete mixed-signal acquisition and generation platform around the PYNQ-Z2 rather than as a standalone ADC breakout.

The design is split into five domains:

1. **Analog acquisition**
2. **Data conversion and clocking**
3. **FPGA capture/control**
4. **Waveform generation**
5. **Power and physical implementation**

## Acquisition modes

### DUAL mode

Both ADC channels are acquired simultaneously. The architecture targets 62.5 MSPS per channel.

### FAST mode

One selected analog channel is routed through the fast path for 125 MSPS selected-channel acquisition.

The front-end filter selection is tied to the intended acquisition bandwidth: the board contains separate approximately 20 MHz and 40 MHz analog-filter paths instead of forcing one compromise filter onto both modes.

## External interfaces

The PCB exposes:

- CH1 BNC input;
- CH2 BNC input;
- dedicated function-generator BNC output;
- PYNQ-Z2 interface connectors;
- logic-analyzer interface;
- power/control headers;
- test points for internal rails and critical nodes.

## Main devices

| Device | Role |
|---|---|
| AD9655BCPZ-125 | Dual 16-bit ADC |
| ADA4927-2 | Fully differential ADC driver |
| ADA4817-2 | High-speed analog gain/buffer/output stages |
| AD9102BCPZ | 14-bit waveform DAC / DDS |
| TMUX1574 | High-speed signal-path switching |
| LM27762 | Bipolar analog rail generation |
| LP5907 | Local low-noise regulation |
| TXS0104E / SN74LVCH8T245 | Digital level translation |
| PYNQ-Z2 / XC7Z020 | Capture, control and processing |

## Evidence philosophy

Each numerical claim must be classified as one of:

- **DESIGN TARGET**
- **DEVICE CAPABILITY**
- **SCHEMATIC SIMULATION**
- **POST-LAYOUT SIMULATION**
- **MEASURED**

The repository deliberately does not convert simulation results into hardware claims.
