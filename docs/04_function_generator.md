# Function Generator / AWG

## Architecture

The waveform generator is built around the **AD9102BCPZ**.

The schematic includes:

- dedicated 156.25 MHz board clock;
- SPI control;
- reset and trigger;
- AD9102 differential current outputs;
- analog output conversion/filtering;
- ADA4817-2 output amplification;
- 49.9 Ω output termination;
- dedicated BNC connector.

The AD9102 itself supports update rates up to 180 MSPS; this board is clocked at 156.25 MHz.

## Device-level DDS check

ADIsimDDS screenshots are retained under `docs/assets/adi/` for low-frequency and 10 MHz operating points.

These are device/tool-level predictions, not board measurements.

## Board-level simulation

The validated post-layout output-path simulation produces:

- approximately **84.74 MHz** simulated -3 dB bandwidth;
- approximately **1.598 Vpp** at the 50 Ω BNC for the accepted 1 MHz transient;
- approximately **3.199 Vpp** at the output amplifier in that transient.

Raw evidence is under:

`verification/raw/awg/`

## Hardware characterization plan

After fabrication, verify:

- output offset;
- amplitude accuracy;
- amplitude flatness vs frequency;
- 50 Ω load behavior;
- harmonic distortion;
- SFDR;
- waveform memory operation;
- DDS frequency accuracy;
- trigger latency;
- loopback through the oscilloscope acquisition path.
