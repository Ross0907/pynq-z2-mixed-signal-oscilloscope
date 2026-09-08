# AD9655 ADC and Clocking

## Converter

The acquisition converter is the **AD9655BCPZ-125**, a dual 16-bit ADC.

The schematic includes:

- analog AVDD rails;
- digital DRVDD;
- VREF / VCM / RBIAS support;
- differential clock input;
- SPI control;
- source-synchronous differential data outputs;
- FCO and DCO;
- local decoupling;
- FPGA-facing interface networks.

## Clocking

The board uses a dedicated 125 MHz oscillator for the converter clock path.

Clock integrity is treated as a separate high-speed design problem because ADC SNR at high input frequencies is strongly affected by clock jitter.

Pre-hardware verification therefore includes:

- clock-source electrical compatibility;
- differential path symmetry;
- series/termination elements;
- return-path continuity;
- FPGA clock-resource mapping;
- source-synchronous timing constraints.

## Data interface

The ADC exposes differential data lanes plus DCO/FCO timing signals. The interface is routed to the PYNQ-Z2 and must be captured with SelectIO resources and explicit timing constraints rather than unconstrained fabric sampling.

## Bring-up sequence

1. Verify all converter rails.
2. Verify converter clock.
3. Hold analog stimulus at a safe low-frequency level.
4. Bring up SPI.
5. Read/verify converter state.
6. Enable deterministic test pattern.
7. Verify all physical lanes.
8. Verify DCO/FCO relationship.
9. Verify reconstructed words.
10. Only then enable normal analog conversion.
