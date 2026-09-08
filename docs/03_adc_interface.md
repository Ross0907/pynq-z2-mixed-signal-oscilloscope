# AD9655 ADC and Clocking

The acquisition converter is the **AD9655BCPZ-125**, configured as a dual 16-bit ADC with a 125 MHz converter clock.

## Analog interface

The AD9655 input is driven by the ADA4927-2 fully differential stage. The converter section includes local AVDD and DRVDD decoupling together with the reference, common-mode, and bias support circuitry shown in the schematic.

## Clocking

A dedicated 125 MHz oscillator supplies the converter clock path. The PCB routes this clock as a high-speed differential signal with controlled geometry and a continuous reference path.

Clock quality directly affects converter performance at high analog input frequencies, so the clock path is treated independently from the lower-speed digital control interface.

## Digital interface

The converter presents differential data together with DCO and FCO timing signals. These routes form the source-synchronous interface to the PYNQ-Z2.

The FPGA architecture is based on dedicated input resources for differential reception, timing alignment, word reconstruction, and acquisition-mode handling.

## Converter control

SPI control provides deterministic converter configuration and access to test modes. The digital test-pattern path supports interface validation independently of the analog signal chain during hardware characterization.
