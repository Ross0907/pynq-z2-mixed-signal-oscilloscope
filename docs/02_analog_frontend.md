# Analog Front End

## Signal path

Each oscilloscope channel combines:

1. input protection;
2. selectable input attenuation;
3. AC/DC coupling;
4. high-speed buffering/gain;
5. selectable analog anti-alias filtering;
6. acquisition-mode switching;
7. fully differential ADC drive.

The top-level KiCad schematic explicitly exposes `ATT_CH1`, `ATT_CH2`, `AAF_MODE`, `FAST_CH_SEL`, channel filter networks, the ADA4927-2 driver, and AD9655 inputs.

## Input attenuation and protection

The channel attenuation sheets use relay/switch-controlled high/low attenuation networks and small compensation capacitors. This allows the front end to extend input range without requiring the high-speed gain stage to absorb the complete input voltage.

The protection network is part of the analog transfer function and therefore has to be verified with realistic capacitance rather than treated as an ideal clamp.

## High-speed amplification

ADA4817-2 amplifiers are used in the analog signal chain. The layout around these parts is kept compact because feedback-loop inductance and capacitive loading can change peaking and phase margin at tens of MHz.

## Anti-alias filters

Two analog filtering modes are used:

- **DUAL AAF:** simulated -3 dB bandwidth ≈ 21.95 MHz
- **FAST AAF:** simulated -3 dB bandwidth ≈ 41.21 MHz

The filter paths were evaluated with post-layout simulation data rather than only ideal schematic calculations.

## FDA and ADC loading

The ADA4927-2 converts each signal into the differential representation required by the AD9655.

Validation tracks separately:

- FDA differential output;
- ADC input differential voltage;
- FDA common mode;
- ADC input common mode.

This is important because a waveform that appears correct only as `VOUT+ - VOUT-` can still violate common-mode requirements.

## Validated transient matrix

Committed raw CSVs cover:

- Low range / FAST / 40 MHz
- Low range / DUAL / 20 MHz
- High range / DUAL / 20 MHz
- High range / FAST / 40 MHz

The primary evidence is under:

`verification/raw/afe/transient/`

Generated figures are under:

`docs/assets/plots/`
