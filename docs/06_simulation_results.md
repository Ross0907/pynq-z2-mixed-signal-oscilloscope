# Simulation Results

This page summarizes the current pre-fabrication simulation results for Rev. A.

## Loaded analog AC response

The loaded AC matrix covers CH1 and CH2, LOW and HIGH input ranges, DUAL and FAST filtering, AC/DC coupling, active-device bias and the modeled ADC load.

| Mode | -3 dB bandwidth | Passband ripple | Rejection at mode Nyquist |
|---|---:|---:|---:|
| DUAL | **22.054–22.073 MHz** | **0.865–0.914 dB** | **36.191–36.278 dB @ 31.25 MHz** |
| FAST | **41.368–41.471 MHz** | **0.959–1.134 dB** | **41.736–42.224 dB @ 62.5 MHz** |

The AC-coupled cases give a **3.441–3.471 Hz** high-pass corner.

The FAST response prioritizes alias rejection at 62.5 MHz; its residual deterministic passband shape is suitable for calibration rather than reducing the anti-alias attenuation.

## Input range and impedance

The final input-network compensation is:

```text
C3 / C17 = 43 pF
C4 / C18 = 7.5 pF
C7 / C11 = 110 pF
```

Post-layout frontend results:

| Metric | Result |
|---|---:|
| Worst flatness | **0.545893 dB** |
| Worst HIGH/LOW separation error | **0.436622 dB** |
| Input resistance | **0.997589–0.999792 Mohm** |
| Effective input capacitance @ 10 kHz | **16.471–41.815 pF** |
| P6060 compatibility | **PASS** |

An earlier extraction showed a much larger HIGH/LOW range error and was used to identify compensation/parasitic interaction. The values above are from the corrected frontend configuration used for Rev. A.

## High-frequency transient response

The transient analysis covers both channels, both range states and both acquisition modes. The principal display cases are:

- LOW / FAST / 40 MHz
- LOW / DUAL / 20 MHz
- HIGH / FAST / 40 MHz
- HIGH / DUAL / 20 MHz

The DUAL plots use a longer time window so the settled periodic response is visible. Across the full eight-case settled set, ADC differential utilization is **74.95–88.97%** of the 2.8 Vpp full-scale reference.

Raw transient CSVs are retained under `verification/raw/afe/transient/` and the presentation plots are under `docs/assets/plots/`.

## ADC + AFE dynamic-performance model

Across the four principal operating cases:

- system SINAD: **75.54–76.97 dB**
- system ENOB: **12.255–12.493 bits**
- useful-band AFE noise: **~25.4–26.0 uV RMS** in DUAL and **~36.3–36.8 uV RMS** in FAST
- modeled AFE-induced SINAD degradation: **~0.25–0.50 dB**

These are simulation results, not hardware measurements.

## Waveform-generator path

The AD9102/output path was evaluated in transient and post-layout AC simulation. The principal results are:

- output-path -3 dB bandwidth: **~84.7425 MHz**
- 1 MHz BNC output with modeled 50 ohm load: **~1.598 Vpp**
- ADA4817-2 output in the same simulation: **~3.199 Vpp**

## ADC digital passive SI

The D1B branch to the J9 auxiliary connector was extracted as a six-port network:

```text
IC2 D1B+/-
    |-- U9 D1B+/-
    `-- J9 D1B+/-
```

The S6P contains **4005 frequency points from 1 MHz to 10 GHz**, is passive and is reciprocal to numerical precision.

| Frequency | IC2 to U9 SDD21 | IC2 to J9 SDD21 | Input SDD11 | J9 mode conversion |
|---:|---:|---:|---:|---:|
| 1 MHz | -3.533 dB | -3.519 dB | -9.558 dB | -79.4 dB |
| 125 MHz | -3.577 dB | -3.491 dB | -9.625 dB | -40.2 dB |
| 500 MHz | -3.808 dB | -3.278 dB | -9.852 dB | -29.1 dB |
| 1 GHz | -4.269 dB | -3.081 dB | -9.380 dB | -23.7 dB |

The roughly 3.5 dB branch level is primarily the expected three-port tee split. J9 P/N skew is **29.7 ps at 500 MHz**, about **3.0% of a 1 ns UI**.

## Result files

The concise current numerical summary is in `verification/results/final_validation/`. Earlier raw simulation tables are kept under `verification/results/` and `verification/raw/` for traceability.
