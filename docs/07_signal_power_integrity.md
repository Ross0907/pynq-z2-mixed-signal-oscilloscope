# Signal and Power Integrity

This document records the pre-fabrication SI/PI evidence and, equally importantly, the remaining solver gates. Structural setup validation is not presented as a solved S-parameter or DC-power result.

## PCB reference structure

The four-layer PCB uses the following physical stack in the final PowerSI-ready package:

| Layer | Thickness |
|---|---:|
| F.Mask | 10.0000 µm |
| F.Cu | 34.2646 µm |
| dielectric 1 | 100.0000 µm |
| In1.Cu | 17.1323 µm |
| dielectric 2 | 1275.0000 µm |
| In2.Cu | 17.1323 µm |
| dielectric 3 | 100.0000 µm |
| B.Cu | 34.2646 µm |
| B.Mask | 10.0000 µm |
| **Total** | **1597.7938 µm** |

Critical high-speed routing is referenced to continuous ground structure where possible. The principal pre-fabrication review targets are the FDA-to-ADC analog differential paths, the AD9655 source-synchronous digital interface, DCO, the FAST/AUX switching path, the PYNQ connector transition and the 125 MHz clock path.

## Analog passive/extracted-network checks

Sampled extracted-network evidence was used to check connectivity and passive behavior before the full solver packages were reduced for review. The supplied sampled frontend network is reciprocal to numerical precision and is effectively passive through the acquisition band. These sampled files are review aids; they are not substitutes for the final digital 26-port solve.

## Final ADC digital PowerSI package

The final PowerSI-ready SPD package is structurally validated.

The committed validation file records:

- all expected stack layers present;
- 1597.7938 µm total stack thickness;
- unique node and trace IDs;
- 26 ports present;
- all 96 referenced terminal-node references exist;
- J9 AUX ports mapped to physical pad nodes;
- 15 repair components and 14 repair traces present;
- all repair resistor and repair trace endpoints are same-net;
- causality enabled;
- 50 Ω reference impedance;
- 1 MHz to 10 GHz, 1001-point logarithmic sweep;
- native-node remap maximum displacement 0.002236 mm.

The port set covers the AD9655 D0A, D0B, D1A, D1B and DCO pairs, corresponding switched/terminated endpoints, and the J9 AUX endpoint.

### Digital-SI status

**OPEN — solver run required.**

The validation artifact explicitly states that the final SPD is structurally ready but the final 26-port PowerSI solve has not yet been accepted. Closure requires:

1. solve the supplied final 26-port SPD;
2. export S26P in RI, 50 Ω, single-ended form;
3. export the companion CKT;
4. check numerical validity;
5. check passivity and reciprocity;
6. convert/check the required mixed-mode insertion/return-loss paths;
7. evaluate DCO/data-lane transmission and crosstalk over the relevant spectrum.

The setup validation and manifest are committed under `verification/si_pi/`.

## Existing PowerDC evidence

The committed screenshots show the previously solved board-power model and are useful as baseline evidence for source/sink voltage and rail distribution. They are not represented as the final AWG-loaded result.

The baseline load table includes, among other loads:

- AD9655 1.8 V analog/digital-equivalent loads;
- clock rail load;
- bipolar analog loads;
- AFE and switch loads;
- the historical LM27762-equivalent input sink of 0.255 A.

The exact baseline table is committed as `verification/si_pi/POWERDC_LOADS_BASELINE.csv`.

## Final AWG PowerDC update

The final AWG update adds/changes the following schematic-level loads:

- U13 AD9102: 30 mA from PYNQ_3V3;
- Y2 125 MHz LVDS oscillator: 27 mA from CLK3V3;
- U12 ADA4817-2 AWG output amplifier: conservative 22 mA device current, represented on both split-supply rails as appropriate;
- LM27762-equivalent CP_3V3 input load: update from 0.255 A to 0.277 A because the negative-rail load rises.

The planning totals in the supplied update are approximately:

- CP_3V3 / FL1: 0.277 A;
- CLK3V3 / FL3: 0.054 A;
- negative analog rail: 0.192 A;
- positive analog rail: 0.084 A;
- total PYNQ_3V3 demand: approximately 0.708 A.

The 0.708 A value is explicitly a **planning estimate**, not a solved copper-distribution result.

### Power-integrity status

**OPEN — final PowerDC solve required.**

The final solve must record at minimum:

- PYNQ_3V3 minimum voltage;
- CLK3V3 minimum voltage;
- CP_3V3 minimum voltage;
- negative-rail worst voltage;
- J3 and J5 current sharing;
- FL1 and FL3 current;
- maximum trace current density;
- maximum via current;
- total conductive PCB loss.

## Hardware closure after fabrication

The pre-fabrication model must eventually be correlated with:

- rail DC accuracy and ripple;
- startup sequencing;
- 125 MHz clock amplitude/jitter;
- ADC DCO/data eye or timing margin;
- FFT/noise-floor behavior;
- simultaneous acquisition + AWG supply interaction;
- thermal behavior at sustained load.

These are intentionally left as hardware gates rather than inferred from simulation.