# Hardware Bring-up

The board should not be powered for the first time with every subsystem enabled.

## Stage 0 — visual and passive checks

- microscope inspection;
- polarity/orientation audit;
- check exposed-pad soldering;
- inspect fine-pitch ADC/DAC/logic packages;
- resistance-to-ground on each rail;
- verify connector pinout continuity.

## Stage 1 — power only

Use a current-limited supply.

Verify:

- PYNQ_3V3;
- CP_3V3;
- +3V0;
- -3V0;
- +1V8;
- +1V8D;
- ADC_3V3 / local rails.

Compare against the PowerDC model.

## Stage 2 — clocks

Verify:

- 125 MHz ADC clock;
- 156.25 MHz AWG clock;
- logic levels;
- differential amplitude where applicable;
- startup behavior.

## Stage 3 — digital converter interface

- SPI initialization;
- deterministic ADC pattern;
- DCO/FCO;
- lane polarity;
- word reconstruction;
- timing margin.

## Stage 4 — analog channel

Start at low frequency and low amplitude.

Then sweep:

- range selection;
- AC/DC coupling;
- 20 MHz filter;
- 40 MHz filter;
- both channels;
- FAST selection.

## Stage 5 — AWG

- power rails;
- SPI;
- reset/trigger;
- low-frequency sine;
- output offset;
- amplitude into 50 Ω;
- frequency sweep;
- spectrum.

## Stage 6 — loopback

Connect AWG output to CH1/CH2 through appropriate attenuation and compare programmed waveform against captured waveform.

## Stage 7 — calibration

Only after the hardware is electrically stable:

- gain calibration;
- offset calibration;
- channel skew;
- frequency-response correction;
- timebase validation.
