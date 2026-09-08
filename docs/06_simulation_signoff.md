# Simulation Signoff

## Purpose

Simulation is used as a signoff gate, not as decorative documentation.

## Analog-front-end matrix

The final nominal matrix covers both range settings and both acquisition/filter modes.

| Range | Mode | Stimulus |
|---|---|---|
| Low | FAST | 40 MHz |
| Low | DUAL | 20 MHz |
| High | DUAL | 20 MHz |
| High | FAST | 40 MHz |

For each run the following are tracked:

- FDA differential output;
- ADC input differential voltage;
- FDA common mode;
- ADC common mode.

## AC response

The final post-layout AFE response exports are stored in:

`verification/raw/afe/ac/`

Computed values currently include:

| Mode | CH1 -3 dB BW | CH1 rejection at mode Nyquist |
|---|---:|---:|
| DUAL | ~21.95 MHz | ~36.08 dB @ 31.25 MHz |
| FAST | ~41.21 MHz | ~41.86 dB @ 62.5 MHz |

These are simulation results.

## AWG

The accepted AWG transient and post-layout AC sweep are stored in:

`verification/raw/awg/`

Current simulated values include:

- output-path -3 dB bandwidth ≈ 84.74 MHz;
- accepted 1 MHz BNC output ≈ 1.598 Vpp into the modeled 50 Ω path.

## Reproducibility

All primary figures are generated from committed CSVs. Screenshots may be used to show simulator configuration, but CSV data is preferred for quantitative plots.
