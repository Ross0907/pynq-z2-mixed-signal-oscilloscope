# System Architecture

The PYNQ-Z2 MDO combines two high-resolution analog acquisition channels, a logic-analyzer interface, an FPGA capture path, and an AD9102 waveform generator on a single mixed-signal platform.

## Acquisition path

Each analog channel contains input protection, selectable AC/DC coupling, high/low attenuation, an ADA4817-2 high-speed stage, selectable anti-alias filtering, TMUX1574 mode switching, and an ADA4927-2 fully differential ADC driver. The resulting differential signal is digitized by the AD9655.

The converter interface is source-synchronous and routes differential data, DCO, and FCO signals to the XC7Z020 on the PYNQ-Z2.

## Acquisition modes

**DUAL mode** acquires both analog channels simultaneously at 62.5 MSPS/channel.

**FAST mode** uses a selected channel at the full 125 MSPS converter data rate.

The analog filtering follows the acquisition mode. The DUAL path is centered around the ~20 MHz filter network, while the FAST path uses the ~40 MHz network.

## Waveform generation

The AD9102 subsystem provides the waveform-generation path. A 156.25 MHz board clock drives the DAC, with SPI control and trigger/reset signals originating from the PYNQ-Z2. The differential DAC output is converted and filtered before the ADA4817-2 output stage and 50 Ω BNC connector.

## Power architecture

The board distributes PYNQ-derived 3.3 V power and generates the local analog and converter rails required by the acquisition and waveform-generation circuits. Bipolar analog rails support the high-speed amplifiers, while local low-noise regulators supply sensitive converter domains.

## Mechanical integration

The PCB is shaped around the PYNQ-Z2 interface geometry and exposes two acquisition BNCs, one waveform-generator BNC, logic-analyzer connectivity, digital headers, test points, and mounting holes.
