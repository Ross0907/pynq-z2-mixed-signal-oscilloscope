# Signal and Power Integrity

This page summarizes the current pre-fabrication SI/PI setup and results. Structural setup validation is kept separate from numerical S-parameter and DC-power results.

## PCB reference structure

The four-layer PCB uses the following physical stack in the current PowerSI package:

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

Critical high-speed routing is referenced to continuous ground structure where possible. The principal analysis targets are the FDA-to-ADC analog differential paths, AD9655 source-synchronous digital interface, DCO, FAST/AUX switching path, PYNQ connector transition, and 125 MHz clock path.

## Extracted passive-network checks

Sampled extracted networks were used to check connectivity and passive behavior. The sampled frontend network is reciprocal to numerical precision and is effectively passive through the acquisition band. These checks do not replace the final digital 26-port solve.

## ADC digital PowerSI setup

The current 26-port SPD package passes structural validation.

`verification/si_pi/POWERSI_26PORT_VALIDATION.txt` records:

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

### Remaining PowerSI work

The final 26-port numerical solve is pending. The required sequence is:

1. solve the current 26-port SPD;
2. export S26P in RI, 50 Ω, single-ended form;
3. export the companion CKT;
4. check numerical validity;
5. check passivity and reciprocity;
6. convert/check the required mixed-mode insertion and return-loss paths;
7. evaluate DCO/data-lane transmission and crosstalk over the relevant spectrum.

The setup parameters are in `verification/si_pi/POWERSI_26PORT_SETUP.txt`.

## Existing PowerDC results

The screenshots show the previously solved board-power model and provide baseline source/sink voltage and rail-distribution results. They predate the finalized AWG load set.

The baseline load table includes:

- AD9655 1.8 V analog/digital-equivalent loads;
- clock rail load;
- bipolar analog loads;
- AFE and switch loads;
- the historical LM27762-equivalent input sink of 0.255 A.

The exact baseline table is `verification/si_pi/POWERDC_LOADS_BASELINE.csv`.

## AWG PowerDC load update

The finalized AWG update adds or changes:

- U13 AD9102: 30 mA from PYNQ_3V3;
- Y2 125 MHz LVDS oscillator: 27 mA from CLK3V3;
- U12 ADA4817-2 AWG output amplifier: conservative 22 mA device current, represented on both split-supply rails as appropriate;
- LM27762-equivalent CP_3V3 input load: 0.255 A to 0.277 A because the negative-rail load rises.

Planning totals from the update:

- CP_3V3 / FL1: 0.277 A;
- CLK3V3 / FL3: 0.054 A;
- negative analog rail: 0.192 A;
- positive analog rail: 0.084 A;
- total PYNQ_3V3 demand: approximately 0.708 A.

The 0.708 A value is a planning estimate, not a solved copper-distribution result.

### Remaining PowerDC work

A new solve with the finalized AWG loads is pending. Record at minimum:

- PYNQ_3V3 minimum voltage;
- CLK3V3 minimum voltage;
- CP_3V3 minimum voltage;
- negative-rail worst voltage;
- J3 and J5 current sharing;
- FL1 and FL3 current;
- maximum trace current density;
- maximum via current;
- total conductive PCB loss.

## Measurements after fabrication

Hardware measurements will cover:

- rail DC accuracy and ripple;
- startup sequencing;
- 125 MHz clock amplitude/jitter;
- ADC DCO/data timing margin;
- FFT/noise-floor behavior;
- simultaneous acquisition + AWG supply interaction;
- sustained-load thermal behavior.
