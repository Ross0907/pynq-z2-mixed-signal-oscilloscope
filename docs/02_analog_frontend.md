# Analog Front End

The analog front end was designed as a loaded end-to-end signal chain extending from the BNC connector to the AD9655 input.

## Input network

Each channel includes protection, AC/DC coupling, and selectable high/low attenuation. The attenuation network extends the usable input range while maintaining the signal amplitude required by the active stages.

## High-speed amplification

ADA4817-2 amplifiers provide the high-speed buffering and gain functions. The PCB layout around these devices uses compact feedback paths and local decoupling to limit parasitic inductance and capacitive loading.

## Selectable anti-alias filtering

Two filter paths support the two acquisition modes:

| Mode | Post-layout simulated -3 dB bandwidth |
|---|---:|
| DUAL | ~21.95 MHz |
| FAST | ~41.21 MHz |

The DUAL filter provides approximately 36.1 dB attenuation at 31.25 MHz, while the FAST filter provides approximately 41.9 dB attenuation at 62.5 MHz.

## Differential ADC drive

The ADA4927-2 drives the AD9655 differentially. Simulation tracks the FDA differential output, ADC differential input, FDA common-mode voltage, and ADC common-mode voltage independently.

This separation captures both signal amplitude and common-mode behavior under the actual modeled ADC loading.

## Transient matrix

The high-frequency transient set contains four operating combinations:

- Low range, FAST mode, 40 MHz
- Low range, DUAL mode, 20 MHz
- High range, FAST mode, 40 MHz
- High range, DUAL mode, 20 MHz

The corresponding raw CSV files are stored under `verification/raw/afe/transient/`.
