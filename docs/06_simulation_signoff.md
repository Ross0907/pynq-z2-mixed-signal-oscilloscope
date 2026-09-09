# Simulation and Analog Signoff

This document records the pre-fabrication analog verification state for the Rev. A PYNQ-Z2 oscilloscope/MDO. Results are separated into **closed gates**, **diagnostics**, and **open gates** so that a successful filter simulation is not misrepresented as complete system signoff.

## Verification matrix

The final compact post-layout GSpice V7 matrix contains both channels, both range states, both acquisition filters, and both coupling states. The committed `verification/results/ANALOG_GSPICE_V7_RUN_STATUS.csv` records PASS for the complete matrix plus the bias, AC-metric, and AC-coupling gates.

The matrix covers:

- CH1 and CH2;
- LOW and HIGH input ranges;
- DUAL 20 MHz and FAST 40 MHz anti-alias paths;
- AC and DC coupling;
- FDA/ADC loading and bias;
- passband ripple, -3 dB bandwidth and attenuation at acquisition-mode Nyquist;
- low-frequency AC-coupling transfer.

## Anti-alias filter signoff

The exact V7 metrics are committed in `verification/results/AC_SIGNOFF_METRICS.csv`.

| Mode | Range/channel spread | -3 dB bandwidth | Passband ripple | Attenuation at mode Nyquist |
|---|---|---:|---:|---:|
| DUAL | all CH1/CH2, LOW/HIGH, AC/DC | 21.955–21.978 MHz | 0.658–0.702 dB | 36.03–36.12 dB @ 31.25 MHz |
| FAST | all CH1/CH2, LOW/HIGH, AC/DC | 41.011–41.091 MHz | 0.832–0.922 dB | 42.00–42.22 dB @ 62.5 MHz |

These criteria are closed for the supplied extracted model.

## AC-coupling signoff

All eight range/mode/channel AC-coupling cases pass. The extracted high-pass corner is 3.441–3.471 Hz. The full numeric table is committed as `verification/results/AC_COUPLING_METRICS.csv`.

## High-frequency transient matrix

The four committed PSpice source exports are:

| Case | Source CSV |
|---|---|
| LOW / FAST / 40 MHz | `trans(20260903-220723).csv` |
| LOW / DUAL / 20 MHz | `trans(20260904-072702).csv` |
| HIGH / FAST / 40 MHz | `trans(20260904-084345).csv` |
| HIGH / DUAL / 20 MHz | `trans(20260904-074916).csv` |

The originally published figures were cropped to 0–200 ns. That window is a presentation limitation because it includes much of the initial settling interval, especially at the ADC input.

The plotting policy is therefore:

1. use the **actual committed CSV samples only**;
2. display the **full available source-record duration** for each case;
3. never extrapolate or repeat waveform data;
4. keep the common ±1.7 V differential Y-axis so the four cases remain visually comparable;
5. retain vector SVG plus high-resolution PNG output;
6. report the source filename and exact plotted time window in `TRANSIENT_PLOT_WINDOWS.csv`.

This change does not alter the circuit simulation or reported settled metrics. It only exposes more of the already-existing record so the post-startup periodic behavior is visible.

### Existing settled differential metrics

`verification/results/COMPUTED_METRICS.csv` remains the canonical summary:

| Case | FDA Vpp | ADC-input Vpp | ADC common-mode mean |
|---|---:|---:|---:|
| LOW FAST | 3.11085 V | 2.20466 V | 0.90075 V |
| LOW DUAL | 3.13120 V | 2.45717 V | 0.90057 V |
| HIGH FAST | 2.72421 V | 1.93892 V | 0.90079 V |
| HIGH DUAL | 2.73816 V | 2.13199 V | 0.90060 V |

The raw 0–200 ns extrema used in the earlier plots were:

| Case | FDA differential | ADC differential |
|---|---:|---:|
| LOW FAST | -1.552254 to +1.555528 V | -1.078652 to +1.084240 V |
| LOW DUAL | -1.561852 to +1.566025 V | -1.047968 to +1.102303 V |
| HIGH FAST | -1.358085 to +1.361100 V | -0.943733 to +0.948628 V |
| HIGH DUAL | -1.366369 to +1.370394 V | -0.916957 to +0.964347 V |

Those extrema are retained as provenance; they are not replacements for the full-record plots.

## ADC dynamic-performance model

The committed `verification/results/AD9655_SIGNOFF_SUMMARY.csv` combines the AFE-noise contribution with the ADC performance model used in the signoff workflow.

Across the four principal operating cases:

- system SINAD: 75.54–76.97 dB;
- system ENOB: 12.255–12.493 bits;
- AFE-induced SNR degradation: approximately 0.28–0.56 dB;
- useful-band AFE noise: approximately 25.4–26.0 µV RMS in DUAL and 36.3–36.8 µV RMS in FAST.

These are **modeled pre-fabrication system results**, not hardware measurements.

## AWG analog-path verification

The AD9102/output path has a committed 1 MHz transient result and post-layout AC response.

Current verified simulation results:

- approximately 1.598 Vpp at the modeled 50 Ω BNC load in the 1 MHz case;
- approximately 3.199 Vpp at the output-amplifier side of the modeled 50 Ω division;
- interpolated post-layout -3 dB bandwidth approximately 84.7425 MHz.

## Range-transfer diagnostic: open gate

The extracted anti-alias-filter shapes pass, but the HIGH/LOW range-transfer ratio is not closed.

The source S47P diagnostic shows LOW-minus-HIGH separation collapsing from approximately 12.06 dB at DC to only about 2.1–2.3 dB through most of the MHz acquisition band, while the schematic-reference network retains approximately 10 dB separation.

Representative CH1 source-S47P values:

| Frequency | LOW - HIGH separation |
|---:|---:|
| DC | 12.064 dB |
| 100 kHz | 4.464 dB |
| 1 MHz | 2.226 dB |
| 2 MHz | 2.177 dB |
| 10 MHz | 2.113 dB |
| ~20.03 MHz | 2.112 dB |
| ~39.90 MHz | 2.130 dB |
| ~62.45 MHz | 2.167 dB |

CH2 follows the same trend. A compact exact-frequency extract from the supplied diagnostic is committed as `verification/results/RANGE_TRANSFER_KEY_POINTS.csv`; the complete diagnostic remains part of the project evidence pack.

`FULL222_VS_MERGED_S47P.csv` shows that the reduced S47P representation agrees closely with the larger extracted network at the checked frequencies, so this is not dismissed as a compact-GSpice artifact.

The schematic-level range networks requiring further review are:

- CH1 range relay K1;
- CH1 LOW attenuation/compensation network R1, R2, C1, C2, C3;
- CH1 HIGH attenuation/compensation network R3, R4, R5, C4, C5, C6;
- CH1 compensation capacitors C7, C8, C9, C10;
- CH2 range relay K2;
- CH2 LOW attenuation/compensation network R11, R13, C15, C16, C17;
- CH2 HIGH attenuation/compensation network R10, R12, R14, C18, C19, C20;
- CH2 compensation capacitors C11, C12, C13, C14.

No schematic change is claimed here. The diagnostic remains OPEN until the extracted-range behavior is reconciled with the intended transfer ratio.

## Historical harness failure

An earlier PSpice signoff harness reported undefined differential PRINT expressions for `CH1_DIFF` / `CH2_DIFF`. That was a test-harness/output-expression failure, not evidence that the analog circuit failed. The later V7 compact-GSpice matrix supersedes that run and completes the analog filter/coupling gates successfully.

## Signoff interpretation

A PASS in the analog matrix means the specified simulation criterion passed for the supplied model. It does not imply:

- final 26-port digital PowerSI closure;
- final AWG-updated PowerDC closure;
- correct extracted HIGH/LOW range scaling;
- fabricated-board measurement closure.

Those items are tracked explicitly in `12_prefabrication_signoff_matrix.md`.