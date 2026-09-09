# Results Index

This page indexes the numerical tables, plots, source simulation data, and SI/PI setup files used by the current Rev. A documentation.

## Analog frequency response

Primary figures:

- `AFE_DUAL_relative_transfer.png`
- `AFE_FAST_relative_transfer.png`
- `AFE_FAST_vs_DUAL_CH1.png`

Numeric tables:

- `verification/results/AC_RESPONSE_METRICS.csv`
- `verification/results/AC_COUPLING_METRICS.csv`
- `verification/results/ANALOG_GSPICE_V7_RUN_STATUS.csv`

## README verification plots

These figures are derived directly from the numerical tables:

- `VERIFICATION_AFE_bandwidth_consistency.svg` — `-3 dB` bandwidth spread across all 16 loaded AC cases.
- `VERIFICATION_AD9655_system_sinad.svg` — ADC-only versus modeled AFE+ADC SINAD.
- `VERIFICATION_range_transfer_diagnostic.svg` — extracted HIGH/LOW range scaling compared with the schematic reference.

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

Combined view:

- `transient_matrix_differential.png`
- `transient_matrix_differential.pdf`


Raw transient sources:

- `verification/raw/afe/transient/trans(20260903-220723).csv` — LOW FAST;
- `verification/raw/afe/transient/trans(20260904-072702).csv` — LOW DUAL;
- `verification/raw/afe/transient/trans(20260904-084345).csv` — HIGH FAST;
- `verification/raw/afe/transient/trans(20260904-074916).csv` — HIGH DUAL.

Numerical transient summary:

- `verification/results/COMPUTED_METRICS.csv`

## ADC/noise model

- `verification/results/AD9655_PERFORMANCE_SUMMARY.csv`

This table reports ADC-only and AFE+ADC modeled SNR/SINAD/ENOB values together with the AFE noise contribution used by the pre-fabrication model.

## HIGH/LOW range-transfer analysis

- `verification/results/RANGE_TRANSFER_KEY_POINTS.csv`
- `verification/results/FULL222_VS_MERGED_S47P.csv`

The extracted source network and larger extracted model agree closely at the checked frequencies. The difference from the schematic-reference HIGH/LOW scaling still requires further analysis.

## Waveform generator

Figures:

- `AWG_postlayout_AC_response.png`
- `AWG_postlayout_phase.png`
- `AWG_1MHz_BNC_transient.png`
- `AWG_1MHz_output_stage.png`

Current simulated values:

- approximately 84.7425 MHz post-layout `-3 dB` bandwidth;
- approximately 1.598 Vpp at the modeled 50 Ω BNC for the 1 MHz transient;
- approximately 3.199 Vpp at the output-amplifier side before the modeled 50 Ω division.

## Signal integrity

Setup files:

- `verification/si_pi/POWERSI_26PORT_VALIDATION.txt`
- `verification/si_pi/POWERSI_26PORT_SETUP.txt`

The 26-port SPD passes structural validation. The final S26P numerical solve is pending.

## Power integrity

- `verification/si_pi/POWERDC_LOADS_BASELINE.csv`
- `verification/si_pi/POWERDC_FINAL_AWG_UPDATE.txt`

The current screenshots correspond to the earlier solved load set. A new PowerDC run with the finalized AWG loads is pending.

## Raw simulation directories

- `verification/raw/afe/ac/`
- `verification/raw/afe/transient/`
- `verification/raw/awg/`

Simulation, extracted-network, setup-validation, and future measured results are labeled separately throughout the repository.
