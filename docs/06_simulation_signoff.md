# Simulation Results

The analog simulation set covers frequency response, loaded transient behavior, common-mode behavior, filter switching, acquisition-mode switching, and waveform-generator output response.

## Analog-front-end frequency response

The final post-layout response data gives:

| Mode | CH1 -3 dB bandwidth | CH2 -3 dB bandwidth | Attenuation at mode Nyquist |
|---|---:|---:|---:|
| DUAL | ~21.95 MHz | ~21.96 MHz | ~36.1 dB @ 31.25 MHz |
| FAST | ~41.21 MHz | ~41.25 MHz | ~41.8 dB @ 62.5 MHz |

## High-frequency transient matrix

The transient set evaluates both attenuation states and both acquisition modes at the corresponding high-frequency operating points.

The plotted quantities are:

- FDA differential output;
- ADC differential input;
- FDA common mode;
- ADC common mode.

The README figures use a 200 ns viewing window, which shows several waveform cycles together with the initial settling behavior.

## AWG simulation

The AD9102 output path was simulated through the board-level analog stage. The current post-layout result gives approximately 84.74 MHz `-3 dB` bandwidth and approximately 1.598 Vpp at the modeled 50 Ω BNC in the 1 MHz transient case.

## Data files

The numeric simulation exports are stored under `verification/raw/`, with the corresponding plotted figures under `docs/assets/plots/`.
