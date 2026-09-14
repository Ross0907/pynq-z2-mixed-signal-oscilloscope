# Results Index

This page points to the principal plots and numerical data for Rev. A.

## Current analog results

The concise numerical summary is in:

- `verification/results/final_validation/metrics.csv`
- `verification/results/final_validation/summary.json`

Current loaded AC ranges:

| Mode | -3 dB bandwidth | Passband ripple | Rejection at mode Nyquist |
|---|---:|---:|---:|
| DUAL | 22.054–22.073 MHz | 0.865–0.914 dB | 36.191–36.278 dB @ 31.25 MHz |
| FAST | 41.368–41.471 MHz | 0.959–1.134 dB | 41.736–42.224 dB @ 62.5 MHz |

AC-coupling corner: **3.441–3.471 Hz**.

Primary plots:

- `docs/assets/plots/AFE_DUAL_relative_transfer.png`
- `docs/assets/plots/AFE_FAST_relative_transfer.png`
- `docs/assets/plots/AFE_FAST_vs_DUAL_CH1.png`
- `docs/assets/plots/FINAL_filter_ripple.svg`
- `docs/assets/plots/FINAL_nyquist_rejection.svg`

Earlier compact-model tables remain under `verification/results/` as development data; the `final_validation` summary contains the Rev. A headline figures.

## Input range and impedance

Final compensation: **43 pF / 7.5 pF / 110 pF**.

- worst frontend flatness: **0.545893 dB**
- worst HIGH/LOW separation error: **0.436622 dB**
- input resistance: **0.997589–0.999792 Mohm**
- effective input capacitance @10 kHz: **16.471–41.815 pF**

The earlier FULL222/S47P comparison files are kept as engineering-development data rather than the Rev. A range metric.

## High-frequency transients

Differential plots:

- `TRANSIENT_LOW_FAST_40MHz_differential.svg`
- `TRANSIENT_LOW_DUAL_20MHz_differential.svg`
- `TRANSIENT_HIGH_FAST_40MHz_differential.svg`
- `TRANSIENT_HIGH_DUAL_20MHz_differential.svg`

Common-mode plots are stored beside the differential plots. The settled eight-case set uses **74.95–88.97%** of the 2.8 Vpp ADC differential full-scale reference.

Raw transient sources are under `verification/raw/afe/transient/`.

## ADC / noise model

`verification/results/AD9655_PERFORMANCE_SUMMARY.csv` contains the modeled ADC-only and AFE+ADC performance data. The principal modeled system range is **75.54–76.97 dB SINAD** and **12.255–12.493 ENOB**.

## Waveform generator

Figures:

- `AWG_postlayout_AC_response.png`
- `AWG_postlayout_phase.png`
- `AWG_1MHz_BNC_transient.png`
- `AWG_1MHz_output_stage.png`

Principal simulated values:

- **~84.7425 MHz** post-layout -3 dB bandwidth
- **~1.598 Vpp** at the modeled 50 ohm BNC in the 1 MHz transient
- **~3.199 Vpp** at the output-amplifier side of the modeled 50 ohm division

## Signal integrity

Detailed setup files:

- `verification/si_pi/POWERSI_26PORT_VALIDATION.txt`
- `verification/si_pi/POWERSI_26PORT_SETUP.txt`

The completed passive-SI set contains 12 PowerSI result sets. The focused D1B/J9 extraction contains 4005 points from 1 MHz to 10 GHz and is passive and reciprocal to numerical precision.

## Power integrity

The completed AWG-updated board-power model is documented by:

- `verification/si_pi/POWERDC_LOADS_BASELINE.csv`
- `verification/si_pi/POWERDC_FINAL_AWG_UPDATE.txt`
- `docs/assets/powerdc/vrm_voltage_summary.png`
- `docs/assets/powerdc/sink_voltage_summary.png`
- `docs/assets/powerdc/discrete_current_summary.png`
- `docs/assets/powerdc/power_loss_summary.png`

## Raw simulation directories

- `verification/raw/afe/ac/`
- `verification/raw/afe/transient/`
- `verification/raw/awg/`
