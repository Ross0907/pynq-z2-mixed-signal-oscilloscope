# Simulation Results

This page summarizes the current pre-fabrication analog simulation results for Rev. A.

## Loaded analog test set

The final compact post-layout GSpice V7 runs cover:

- CH1 and CH2;
- LOW and HIGH input ranges;
- DUAL 20 MHz and FAST 40 MHz anti-alias paths;
- AC and DC coupling;
- FDA/ADC loading and bias;
- passband ripple, `-3 dB` bandwidth, and attenuation at acquisition-mode Nyquist;
- low-frequency AC-coupling transfer.

`verification/results/ANALOG_GSPICE_V7_RUN_STATUS.csv` records the result of each run.

## Anti-alias filter results

Exact values are in `verification/results/AC_RESPONSE_METRICS.csv`.

| Mode | Range/channel spread | -3 dB bandwidth | Passband ripple | Attenuation at mode Nyquist |
|---|---|---:|---:|---:|
| DUAL | all CH1/CH2, LOW/HIGH, AC/DC | 21.955–21.978 MHz | 0.658–0.702 dB | 36.03–36.12 dB @ 31.25 MHz |
| FAST | all CH1/CH2, LOW/HIGH, AC/DC | 41.011–41.091 MHz | 0.832–0.922 dB | 42.00–42.22 dB @ 62.5 MHz |

## AC coupling

All eight range/mode/channel AC-coupling cases pass. The extracted high-pass corner is 3.441–3.471 Hz. Numeric values are in `verification/results/AC_COUPLING_METRICS.csv`.

## High-frequency transients

The committed PSpice source exports are:

| Case | Source CSV | Plot interval |
|---|---|---:|
| LOW / FAST / 40 MHz | `trans(20260903-220723).csv` | 0–280.370 ns |
| LOW / DUAL / 20 MHz | `trans(20260904-072702).csv` | 0–500.000 ns |
| HIGH / FAST / 40 MHz | `trans(20260904-084345).csv` | 0–750.000 ns |
| HIGH / DUAL / 20 MHz | `trans(20260904-074916).csv` | 0–334.055 ns |

The figures use the full available source record. No waveform data is extrapolated, repeated, or synthesized. The differential plots use a common ±1.7 V Y-axis for direct visual comparison.

`verification/results/TRANSIENT_PLOT_WINDOWS.csv` records the exact source file and plotted interval for each case.

### Settled differential metrics

`verification/results/COMPUTED_METRICS.csv` contains the numerical summary:

| Case | FDA Vpp | ADC-input Vpp | ADC common-mode mean |
|---|---:|---:|---:|
| LOW FAST | 3.11085 V | 2.20466 V | 0.90075 V |
| LOW DUAL | 3.13120 V | 2.45717 V | 0.90057 V |
| HIGH FAST | 2.72421 V | 1.93892 V | 0.90079 V |
| HIGH DUAL | 2.73816 V | 2.13199 V | 0.90060 V |

The earlier 0–200 ns plot extrema were:

| Case | FDA differential | ADC differential |
|---|---:|---:|
| LOW FAST | -1.552254 to +1.555528 V | -1.078652 to +1.084240 V |
| LOW DUAL | -1.561852 to +1.566025 V | -1.047968 to +1.102303 V |
| HIGH FAST | -1.358085 to +1.361100 V | -0.943733 to +0.948628 V |
| HIGH DUAL | -1.366369 to +1.370394 V | -0.916957 to +0.964347 V |

## ADC dynamic-performance model

`verification/results/AD9655_PERFORMANCE_SUMMARY.csv` combines the AFE-noise contribution with the AD9655 model used for the pre-fabrication performance estimate.

Across the four principal operating cases:

- system SINAD: 75.54–76.97 dB;
- system ENOB: 12.255–12.493 bits;
- AFE-induced SNR degradation: approximately 0.28–0.56 dB;
- useful-band AFE noise: approximately 25.4–26.0 µV RMS in DUAL and 36.3–36.8 µV RMS in FAST.

These are modeled results, not hardware measurements.

## AWG analog-path results

The AD9102/output path has a committed 1 MHz transient result and post-layout AC response.

Current values:

- approximately 1.598 Vpp at the modeled 50 Ω BNC load in the 1 MHz case;
- approximately 3.199 Vpp at the output-amplifier side of the modeled 50 Ω division;
- interpolated post-layout `-3 dB` bandwidth approximately 84.7425 MHz.

## HIGH/LOW range-transfer discrepancy

The extracted anti-alias-filter shapes pass, but the extracted HIGH/LOW range scaling still requires further analysis.

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

The schematic reference stays near 10 dB through the MHz band. CH2 follows the same extracted trend. The key values are in `verification/results/RANGE_TRANSFER_KEY_POINTS.csv`.

`verification/results/FULL222_VS_MERGED_S47P.csv` shows that the reduced S47P representation agrees closely with the larger extracted network at the checked frequencies.

The schematic-level networks to investigate are:

- CH1 range relay K1;
- CH1 LOW attenuation/compensation network R1, R2, C1, C2, C3;
- CH1 HIGH attenuation/compensation network R3, R4, R5, C4, C5, C6;
- CH1 compensation capacitors C7, C8, C9, C10;
- CH2 range relay K2;
- CH2 LOW attenuation/compensation network R11, R13, C15, C16, C17;
- CH2 HIGH attenuation/compensation network R10, R12, R14, C18, C19, C20;
- CH2 compensation capacitors C11, C12, C13, C14.

## Historical PSpice output-expression failure

An earlier PSpice run stopped because the test harness attempted to print undefined differential expressions for `CH1_DIFF` and `CH2_DIFF`. That was an output-expression problem rather than a circuit failure. The later V7 compact-GSpice runs completed the intended analog AC, bias, and coupling checks.
