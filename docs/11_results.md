# Results and Evidence Index

This page is the navigation index for numerical, graphical and solver evidence. For gate status, see `12_prefabrication_signoff_matrix.md`.

## Analog frequency response

Primary figures:

- `AFE_DUAL_relative_transfer.png`
- `AFE_FAST_relative_transfer.png`
- `AFE_FAST_vs_DUAL_CH1.png`

Exact V7 acceptance metrics:

- `verification/results/AC_SIGNOFF_METRICS.csv`
- `verification/results/AC_COUPLING_METRICS.csv`
- `verification/results/ANALOG_GSPICE_V7_RUN_STATUS.csv`

## High-frequency transients

Differential plots:

- `TRANSIENT_LOW_FAST_40MHz_differential.svg`
- `TRANSIENT_LOW_DUAL_20MHz_differential.svg`
- `TRANSIENT_HIGH_FAST_40MHz_differential.svg`
- `TRANSIENT_HIGH_DUAL_20MHz_differential.svg`

Common-mode plots:

- `TRANSIENT_LOW_FAST_40MHz_common_mode.svg`
- `TRANSIENT_LOW_DUAL_20MHz_common_mode.svg`
- `TRANSIENT_HIGH_FAST_40MHz_common_mode.svg`
- `TRANSIENT_HIGH_DUAL_20MHz_common_mode.svg`

Combined presentation:

- `transient_matrix_differential.png`
- `transient_matrix_differential.pdf`

The current plotting policy is to use the entire time interval present in each raw CSV rather than cropping all cases to 200 ns. `TRANSIENT_PLOT_WINDOWS.csv` is generated with the plots and records the exact window used.

Canonical raw sources:

- `verification/raw/afe/transient/trans(20260903-220723).csv` — LOW FAST;
- `verification/raw/afe/transient/trans(20260904-072702).csv` — LOW DUAL;
- `verification/raw/afe/transient/trans(20260904-084345).csv` — HIGH FAST;
- `verification/raw/afe/transient/trans(20260904-074916).csv` — HIGH DUAL.

Numerical transient summary:

- `verification/results/COMPUTED_METRICS.csv`.

## ADC/noise model

- `verification/results/AD9655_SIGNOFF_SUMMARY.csv`

This file reports the ADC-only and AFE+ADC modeled SNR/SINAD/ENOB values and the AFE noise contribution used by the pre-fabrication model.

## Range-transfer root-cause evidence

- `verification/results/RANGE_TRANSFER_KEY_POINTS.csv`
- `verification/results/FULL222_VS_MERGED_S47P.csv`

These files support the OPEN range-scaling gate. They are retained even though the anti-alias filter matrix itself passes.

## Waveform generator

Figures:

- `AWG_postlayout_AC_response.png`
- `AWG_postlayout_phase.png`
- `AWG_1MHz_BNC_transient.png`
- `AWG_1MHz_output_stage.png`

Current simulated summary:

- approximately 84.7425 MHz post-layout -3 dB bandwidth;
- approximately 1.598 Vpp at the modeled 50 Ω BNC for the 1 MHz transient;
- approximately 3.199 Vpp at the output-amplifier side before the modeled 50 Ω division.

## Signal integrity

Setup/provenance:

- `verification/si_pi/POWERSI_26PORT_VALIDATION.txt`
- `verification/si_pi/POWERSI_26PORT_MANIFEST.txt`

The 26-port SPD is structurally validated but the final S26P solver result remains OPEN.

## Power integrity

- `verification/si_pi/POWERDC_LOADS_BASELINE.csv`
- `verification/si_pi/POWERDC_FINAL_AWG_UPDATE.txt`

The existing PowerDC screenshots remain baseline evidence. The final AWG-loaded PowerDC solve remains OPEN.

## Raw simulation directories

- `verification/raw/afe/ac/`
- `verification/raw/afe/transient/`
- `verification/raw/awg/`

## Interpretation rule

A committed plot is evidence only for the source data and model state from which it was generated. Simulated, extracted, structurally validated, and measured results are deliberately labelled separately throughout this repository.