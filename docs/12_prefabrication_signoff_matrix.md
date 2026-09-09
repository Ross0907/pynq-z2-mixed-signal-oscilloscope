# Rev. A Pre-Fabrication Signoff Matrix

This matrix is the authoritative repository-level gate status. A gate is marked PASS only when the supplied evidence directly supports it.

| Gate | Status | Evidence / closure criterion |
|---|---|---|
| Schematic architecture consistency | PASS | Current KiCad design and documented architecture reviewed |
| DUAL 20 MHz anti-alias response | PASS | V7 AC matrix: -3 dB 21.955–21.978 MHz, Nyquist attenuation 36.03–36.12 dB |
| FAST 40 MHz anti-alias response | PASS | V7 AC matrix: -3 dB 41.011–41.091 MHz, Nyquist attenuation 42.00–42.22 dB |
| AC-coupling transfer | PASS | Eight cases pass; extracted corner 3.441–3.471 Hz |
| FDA/ADC transient operation | PASS | Four committed loaded transient records; no source-data extrapolation |
| FDA/ADC common-mode behavior | PASS | Settled ADC common-mode mean ~0.9006–0.9008 V in committed metrics |
| AFE useful-band noise model | PASS | ~25.4–26.0 µV RMS DUAL, ~36.3–36.8 µV RMS FAST |
| Modeled AD9655 + AFE dynamic performance | PASS | system SINAD 75.54–76.97 dB; ENOB 12.255–12.493 bits |
| AWG 1 MHz loaded transient | PASS | ~1.598 Vpp at modeled 50 Ω BNC |
| AWG post-layout AC response | PASS | interpolated -3 dB point ~84.7425 MHz |
| PCB reference-plane / routing review | PASS for supplied layout evidence | Four-layer geometry and critical-path routing reviewed |
| Extracted range HIGH/LOW scaling | **OPEN** | extracted source network collapses to ~2.1–2.3 dB separation in MHz band; reconcile K1/K2 attenuator/compensation networks |
| Final ADC digital 26-port PowerSI | **OPEN** | SPD structurally validated; final S26P + CKT solve and numerical checks still required |
| Final AWG-updated PowerDC | **OPEN** | load update defined; new final copper solve required |
| Fabricated-board electrical validation | **OPEN** | requires hardware |
| Calibration accuracy | **OPEN** | requires hardware + calibration dataset |
| Thermal validation at sustained load | **OPEN** | requires hardware |

## Closed analog-filter criteria

The analog PASS label refers to the filter/coupling/loaded-simulation acceptance matrix. It must not be interpreted as closure of the separate range-transfer discrepancy.

## Range-transfer closure requirement

Before the range gate can be closed, the extracted behavior must be reconciled at schematic level around:

- CH1 K1, R1–R5 and C1–C10 range/compensation network;
- CH2 K2, R10–R14 and C11–C20 range/compensation network.

The final accepted model should demonstrate the intended HIGH/LOW scaling over the usable acquisition band, not merely at DC.

## Digital-SI closure requirement

Final PowerSI closure requires the solved 26-port S26P/CKT output and numerical checks for passivity, reciprocity, insertion/return loss, crosstalk and the required mixed-mode paths.

## PI closure requirement

Final PowerDC closure requires a new solve using the AWG-updated load set. Planning current estimates are not signoff values.

## Measurement closure requirement

After fabrication the minimum evidence set is:

- supply rails at idle and combined acquisition/AWG load;
- ADC clock quality;
- ADC data/DCO timing margin;
- input-range gain calibration;
- bandwidth and step/sine response;
- FFT/SNR/SINAD/ENOB;
- channel crosstalk;
- AWG amplitude/frequency response and load behavior;
- thermal behavior.

Until those measurements exist, the repository remains explicitly **pre-fabrication**.