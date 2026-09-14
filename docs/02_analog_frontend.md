# Analog Front End

The analog front end is evaluated as a loaded signal chain from the BNC connector to the AD9655 input.

## Input network

Each channel includes input protection, selectable AC/DC coupling and high/low range selection. The final compensation values are:

- C3 / C17: **43 pF**
- C4 / C18: **7.5 pF**
- C7 / C11: **110 pF**

Post-layout range and input-impedance analysis gives **0.545893 dB** worst flatness, **0.436622 dB** worst HIGH/LOW separation error and **0.997589–0.999792 Mohm** input resistance.

## High-speed amplification

ADA4817-2 amplifiers provide the high-speed buffering and gain functions. The layout uses compact feedback paths, short high-frequency current loops and local decoupling around each amplifier.

## Selectable anti-alias filtering

Two filter paths support the two acquisition modes:

| Mode | -3 dB bandwidth | Passband ripple | Rejection at Nyquist |
|---|---:|---:|---:|
| DUAL | 22.054–22.073 MHz | 0.865–0.914 dB | 36.191–36.278 dB @ 31.25 MHz |
| FAST | 41.368–41.471 MHz | 0.959–1.134 dB | 41.736–42.224 dB @ 62.5 MHz |

The AC-coupled cases give a **3.441–3.471 Hz** high-pass corner.

## Differential ADC drive

The ADA4927-2 drives the AD9655 differentially. Simulation tracks the FDA differential output, loaded ADC differential input and common-mode behavior independently.

## Transient operation

The settled transient set covers both channels, both input ranges and both acquisition modes. All eight cases remain below the 2.8 Vpp ADC differential full-scale reference, with a maximum simulated utilization of **88.97%**.

Detailed plots and numerical results are in [Simulation Results](06_simulation_results.md).
