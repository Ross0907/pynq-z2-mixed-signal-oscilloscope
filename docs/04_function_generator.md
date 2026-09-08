# Function Generator / AWG

The waveform-generation subsystem is centered on the **AD9102BCPZ** 14-bit waveform DAC.

## Clock and control

The AD9102 is clocked at 156.25 MHz on the current board revision. SPI, trigger, and reset signals connect the DAC to the PYNQ-Z2 control path.

The AD9102 device itself supports update rates up to 180 MSPS; the board implementation operates from the 156.25 MHz local clock shown in the schematic.

## Analog output path

The DAC differential current output feeds the analog reconstruction and conversion network, followed by an ADA4817-2 output stage and the dedicated 50 Ω BNC path.

## ADIsimDDS results

ADIsimDDS operating points at 1 kHz and 10 MHz are included in the repository to show the expected DDS image and harmonic structure for the AD9102 device.

## Board-level simulation

The post-layout output-path simulation gives:

- approximately **84.74 MHz** `-3 dB` bandwidth;
- approximately **1.598 Vpp** at the modeled 50 Ω BNC for the 1 MHz transient case;
- approximately **3.199 Vpp** at the ADA4817-2 output in the same simulation.

The raw AWG simulation CSVs are stored under `verification/raw/awg/`.
