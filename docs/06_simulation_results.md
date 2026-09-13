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

PSpice transient datasets:

| Case | Source CSV |
|---|---|
| LOW / FAST / 40 MHz | `trans(20260903-220723).csv` |
| LOW / DUAL / 20 MHz | `trans(20260904-072702).csv` |
| HIGH / FAST / 40 MHz | `trans(20260904-084345).csv` |
| HIGH / DUAL / 20 MHz | `trans(20260904-074916).csv` |

The figures use the full available source record. No waveform data is extrapolated, repeated, or synthesized. The differential plots use a common ±1.7 V Y-axis for direct visual comparison.

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

The AD9102/output path has a 1 MHz transient result and post-layout AC response.

Current values:

- approximately 1.598 Vpp at the modeled 50 Ω BNC load in the 1 MHz case;
- approximately 3.199 Vpp at the output-amplifier side of the modeled 50 Ω division;
- interpolated post-layout `-3 dB` bandwidth approximately 84.7425 MHz.

## HIGH/LOW range-transfer verification

The earlier FULL222/source-S47P diagnostic exposed a genuine compensation/parasitic sensitivity in the then-current frontend values. That diagnostic showed approximately 12 dB separation at DC collapsing toward approximately 2.2 dB through the MHz region. It remains useful root-cause evidence, but it is **not** the final absolute range model.

The final absolute range signoff uses the later authoritative open-red frontend extraction and the final compensation set:

```text
C3 / C17 = 43 pF
C4 / C18 = 7.5 pF
C7 / C11 = 110 pF
```

Final open-red nominal verification:

| Metric | Result |
|---|---:|
| Open-red extraction provenance | **PASS** |
| ~1 MΩ topology preflight | **PASS** |
| Worst frontend flatness | **0.545893 dB** |
| Worst HIGH/LOW range-separation error | **0.436622 dB** |
| P6060 compatibility | **PASS** |
| Input resistance | **0.997589–0.999792 MΩ** |
| Effective input capacitance @ 10 kHz | **16.471–41.815 pF** |

The previous 2.1–2.3 dB range-separation result belongs to the superseded pre-retune extraction state and must not be used as the final vertical-range metric.

**Final HIGH/LOW range-scaling status: PASS.**

## ADC digital passive-SI verification

The original upstream ADC digital PCB path was already frozen after the validated broadband extraction. The only later geometry change that required a new passive-SI check was the D1B tee to the J9 auxiliary connector.

A focused PowerSI extraction was therefore run for:

```text
IC2 D1B+/-
    ├── U9 D1B+/-
    └── J9 D1B+/-
```

The final S6P contains **4005 unique frequency points from 1 MHz to 10 GHz**, is reciprocal to approximately `7.1e-15`, has maximum singular value `0.999999324`, and is passive.

Representative extracted mixed-mode results:

| Frequency | IC2 → U9 SDD21 | IC2 → J9 SDD21 | Input SDD11 | J9 mode conversion |
|---:|---:|---:|---:|---:|
| 1 MHz | -3.533 dB | -3.519 dB | -9.558 dB | -79.4 dB |
| 125 MHz | -3.577 dB | -3.491 dB | -9.625 dB | -40.2 dB |
| 500 MHz | -3.808 dB | -3.278 dB | -9.852 dB | -29.1 dB |
| 1 GHz | -4.269 dB | -3.081 dB | -9.380 dB | -23.7 dB |

The approximately 3.5 dB branch level is the expected three-port tee power split, not PCB trace loss. J9 P/N skew is **29.7 ps at 500 MHz**, approximately **3.0% of a 1 ns UI** for the ~1 Gb/s D1 lane.

Final passive-board disposition:

- existing upstream ADC digital SI: **FROZEN / VERIFIED**;
- D1B tee connectivity and polarity symmetry: **PASS**;
- J9 routing: **PASS**;
- passivity and reciprocity: **PASS**;
- 500 MHz insertion behavior: **PASS**;
- mode conversion: **PASS**;
- P/N skew: **PASS**;
- D1B PCB/J9 passive SI: **SIGNED OFF**.

The optional off-board J9 cable/receiver eye test remains a hardware/system-level validation for the auxiliary dual-FAST mode; it is not an unresolved passive PCB extraction.

## Historical PSpice output-expression failure

An earlier PSpice run stopped because the test harness attempted to print undefined differential expressions for `CH1_DIFF` and `CH2_DIFF`. That was an output-expression problem rather than a circuit failure. The later compact-GSpice runs completed the intended analog AC, bias, and coupling checks.
