# PYNQ-Z2 Mixed-Signal Oscilloscope / MDO

<p align="center">
  <img src="docs/assets/hardware/pcb_render.png" width="960" alt="PYNQ-Z2 MDO mixed-signal oscilloscope PCB render">
</p>

A custom **dual-channel 16-bit mixed-signal oscilloscope, logic-analyzer interface, and arbitrary-waveform/function-generator platform** designed around the **PYNQ-Z2**, **AD9655**, **AD9102**, **ADA4927-2**, and **ADA4817-2**.

The project covers the complete mixed-signal path from BNC input to FPGA capture: input protection, selectable attenuation and coupling, high-speed amplification, switchable anti-alias filtering, fully differential ADC drive, source-synchronous converter interfacing, four-layer PCB implementation, waveform generation, SPICE simulation, post-layout extraction, signal-integrity analysis, and power-integrity analysis.

The current revision is a **pre-fabrication Rev. A design**. Numerical bandwidth, SINAD/ENOB, waveform, and power figures are simulation or post-layout simulation results unless explicitly labeled as measured.

---

## System summary

| Subsystem | Implementation |
|---|---|
| Analog channels | 2 |
| ADC | AD9655BCPZ-125, dual 16-bit |
| ADC device sample rate | 125 MSPS |
| DUAL acquisition mode | 62.5 MSPS/channel simultaneous |
| FAST acquisition mode | 125 MSPS selected channel |
| Analog filtering | Selectable ~20 MHz / ~40 MHz anti-alias paths |
| Input range | High / Low attenuation |
| Input coupling | AC / DC selectable |
| Differential ADC driver | ADA4927-2 |
| High-speed amplifiers | ADA4817-2 |
| Function generator / AWG | AD9102, 14-bit DAC |
| AWG board clock | 156.25 MHz |
| AD9102 device capability | Up to 180 MSPS |
| FPGA platform | PYNQ-Z2 / XC7Z020 |
| PCB | 4-layer mixed-signal board |

---

## Instrument architecture

```text
                         ACQUISITION CHANNEL

BNC input
   │
   ├── Input protection
   ├── AC/DC coupling
   ├── High/Low attenuation
   │
   ▼
ADA4817-2 high-speed buffer / gain stage
   │
   ▼
Selectable 20 MHz / 40 MHz anti-alias network
   │
   ▼
TMUX1574 acquisition-mode switching
   │
   ▼
ADA4927-2 fully differential driver
   │
   ▼
AD9655 16-bit ADC
   │
   ▼
Source-synchronous differential interface
   │
   ▼
PYNQ-Z2 / XC7Z020
```

```text
                          WAVEFORM GENERATOR

PYNQ-Z2 control
   │
   ├── SPI / trigger / reset
   ▼
AD9102 14-bit waveform DAC
   │
   ▼
Analog reconstruction / output stage
   │
   ▼
ADA4817-2
   │
   ▼
50 Ω BNC output
```

---

## PCB implementation

### Standalone board

<p align="center">
  <img src="docs/assets/hardware/pcb_3d_top.png" width="48%" alt="PCB top render">
  <img src="docs/assets/hardware/pcb_3d_oblique_front.png" width="48%" alt="PCB oblique render">
</p>

### PYNQ-Z2 integration

<p align="center">
  <img src="docs/assets/hardware/pynq_z2_integrated_render.png" width="900" alt="PYNQ-Z2 with oscilloscope board">
</p>

The board integrates two analog-input BNCs, a dedicated function-generator BNC, FPGA interconnects, logic-analyzer connectivity, clocking, power conversion, local low-noise regulation, and distributed test points.

### Copper layers

<p align="center">
  <img src="docs/assets/hardware/pcb_layer_fcu.png" width="48%" alt="Front copper">
  <img src="docs/assets/hardware/pcb_layer_in1_ground.png" width="48%" alt="Inner ground layer">
</p>

<p align="center">
  <img src="docs/assets/hardware/pcb_layer_in2_power_routing.png" width="48%" alt="Inner power and routing layer">
  <img src="docs/assets/hardware/pcb_layer_bcu.png" width="48%" alt="Back copper">
</p>

The four-layer layout uses a continuous reference plane for critical high-speed paths, dense ground stitching, short FDA-to-ADC interconnects, symmetric channel structures, localized converter decoupling, and physical separation between acquisition, digital, power, and waveform-generation regions.

---

## Schematic

The top-level schematic contains the dual-channel acquisition chain, high/low attenuation control, selectable 20 MHz and 40 MHz filters, ADA4927-2 differential drive, AD9655 conversion, 125 MHz converter clocking, FPGA-level translation, logic-analyzer interface, power rails, and the function-generator subsystem.

[Full schematic PDF](docs/schematics/Pynq_Oscilloscope_schematic.pdf) · [PCB layer PDF](docs/pcb/Pynq_Oscilloscope_pcb_layers.pdf)

---

## Analog front end

The front end is simulated as a complete loaded signal chain rather than as isolated amplifier stages. The model includes attenuation, switching, filtering, FDA drive, ADC loading, both channels, both range states, and AC/DC coupling.

### DUAL filter mode

<p align="center">
  <img src="docs/assets/plots/AFE_DUAL_relative_transfer.png" width="760" alt="DUAL mode AFE response">
</p>

Across the current V7 loaded AC runs:

- `-3 dB` bandwidth: **21.955–21.978 MHz**
- attenuation at the 31.25 MHz mode Nyquist: **36.03–36.12 dB**
- passband ripple: **0.658–0.702 dB**

### FAST filter mode

<p align="center">
  <img src="docs/assets/plots/AFE_FAST_relative_transfer.png" width="760" alt="FAST mode AFE response">
</p>

Across the current V7 loaded AC runs:

- `-3 dB` bandwidth: **41.011–41.091 MHz**
- attenuation at the 62.5 MHz mode Nyquist: **42.00–42.22 dB**
- passband ripple: **0.832–0.922 dB**

### Filter-mode comparison

<p align="center">
  <img src="docs/assets/plots/AFE_FAST_vs_DUAL_CH1.png" width="760" alt="FAST and DUAL AFE comparison">
</p>

The two anti-alias paths align the analog bandwidth with the corresponding acquisition mode instead of using one fixed bandwidth for both operating conditions. All eight AC-coupling cases also pass, with an extracted high-pass corner of **3.441–3.471 Hz**.

---

## High-frequency transient simulation

The transient set spans both input ranges and both acquisition modes. Each plot shows the fully differential amplifier output together with the differential voltage presented to the ADC input.

The four differential transient figures use a common time scale for direct visual comparison. The displayed samples come directly from the committed PSpice exports; no waveform data is extrapolated, repeated, or synthesized.


<p align="center">
  <img src="docs/assets/plots/TRANSIENT_LOW_FAST_40MHz_differential.svg" width="48%" alt="Low range FAST mode transient">
  <img src="docs/assets/plots/TRANSIENT_LOW_DUAL_20MHz_differential.svg" width="48%" alt="Low range DUAL mode transient">
</p>

<p align="center">
  <img src="docs/assets/plots/TRANSIENT_HIGH_FAST_40MHz_differential.svg" width="48%" alt="High range FAST mode transient">
  <img src="docs/assets/plots/TRANSIENT_HIGH_DUAL_20MHz_differential.svg" width="48%" alt="High range DUAL mode transient">
</p>

Common-mode behavior was evaluated separately at the FDA output and at the loaded ADC input. The source CSVs are under [`verification/raw/afe/transient/`](verification/raw/afe/transient/).

---

## Function generator / AWG

The waveform-generation subsystem is based on the **AD9102** and uses a **156.25 MHz board clock**. The DAC output is followed by the analog reconstruction/output stage and a dedicated 50 Ω BNC path.

### ADIsimDDS

<p align="center">
  <img src="docs/assets/adi/adisimdds_ad9102_1khz.png" width="100%" alt="AD9102 ADIsimDDS 1 kHz operating point">
  <img src="docs/assets/adi/adisimdds_ad9102_10mhz.png" width="100%" alt="AD9102 ADIsimDDS 10 MHz operating point">
</p>

### Board-level output simulation

<p align="center">
  <img src="docs/assets/plots/AWG_postlayout_AC_response.png" width="760" alt="AWG post-layout AC response">
</p>

Post-layout simulation:

- `-3 dB` output-path bandwidth: **~84.7425 MHz**
- 1 MHz BNC output with the modeled 50 Ω load: **~1.598 Vpp**
- ADA4817-2 output swing in the same simulation: **~3.199 Vpp**

<p align="center">
  <img src="docs/assets/plots/AWG_1MHz_BNC_transient.png" width="48%" alt="AWG 1 MHz BNC transient">
  <img src="docs/assets/plots/AWG_1MHz_output_stage.png" width="48%" alt="AWG output-stage transient">
</p>

---

## Power distribution

The power architecture includes the PYNQ-derived supply, local 3.3 V distribution, bipolar analog rails, 1.8 V rails, and local low-noise regulation around the converter and analog circuitry.

PowerDC simulations were used to examine regulator output voltages, sink voltages, rail current, and board-level power loss.

<p align="center">
  <img src="docs/assets/powerdc/vrm_voltage_summary.png" width="100%" alt="PowerDC regulator voltage results">
  <img src="docs/assets/powerdc/sink_voltage_summary.png" width="100%" alt="PowerDC sink voltage results">
</p>

These screenshots show the earlier solved board-power model. A new PowerDC run with the finalized AWG loads is still pending.

---

## Verification highlights

### Analog AC consistency

<p align="center">
  <img src="docs/assets/plots/VERIFICATION_AFE_bandwidth_consistency.svg" width="820" alt="Analog filter bandwidth consistency across 16 loaded AC runs">
</p>

All **16 loaded AC cases pass** the current DUAL/FAST filter criteria. Channel, range, and coupling state produce only a small spread in the extracted `-3 dB` corner within each acquisition mode.

### Modeled ADC + AFE dynamic performance

<p align="center">
  <img src="docs/assets/plots/VERIFICATION_AD9655_system_sinad.svg" width="820" alt="Modeled AD9655 and analog-front-end system SINAD">
</p>

Across the four principal operating cases, the pre-fabrication model gives:

- system SINAD: **75.54–76.97 dB**
- system ENOB: **12.255–12.493 bits**
- useful-band AFE noise: **~25.4–26.0 µV RMS** in DUAL and **~36.3–36.8 µV RMS** in FAST
- modeled AFE-induced SINAD degradation: **~0.25–0.50 dB**

These are modeled results, not hardware measurements.

### HIGH/LOW range-transfer discrepancy

<p align="center">
  <img src="docs/assets/plots/VERIFICATION_range_transfer_diagnostic.svg" width="820" alt="Extracted high-low range transfer comparison">
</p>

The anti-alias filters pass, but the extracted HIGH/LOW range scaling still requires further analysis. The source S47P shows approximately **2.1–2.3 dB LOW-minus-HIGH separation** through most of the MHz acquisition band, while the schematic-reference network remains near **10 dB**. The larger extracted network closely matches the reduced S47P at the checked frequencies.

The schematic-level range networks to analyze are K1/K2 and their associated attenuation/compensation resistor-capacitor networks documented in [`docs/06_simulation_results.md`](docs/06_simulation_results.md).

### Current pre-fabrication status

| Item | Result |
|---|---|
| DUAL anti-alias response | **PASS** |
| FAST anti-alias response | **PASS** |
| AC-coupling transfer | **PASS** |
| FDA/ADC loaded transients and common mode | **PASS** |
| Modeled AD9655 + AFE dynamic performance | **PASS** |
| AWG loaded transient / post-layout AC response | **PASS** |
| Extracted HIGH/LOW range scaling | **Further analysis required** |
| ADC digital 26-port PowerSI solve | **Pending** |
| AWG-updated PowerDC solve | **Pending** |
| Fabricated-board characterization / calibration / thermal validation | **Pending fabrication** |

---

## Simulation and PCB analysis

The project combines several analysis levels:

- **PSpice / SPICE:** AC response, large-signal transient behavior, ADC-loaded differential drive, common-mode behavior, switch/filter modes, and AWG output response.
- **Post-layout extraction:** critical analog and high-speed interconnect behavior with PCB parasitics.
- **Cadence Sigrity / PowerSI:** 26-port ADC digital-interface setup, structural validation, and numerical SI analysis.
- **PowerDC:** regulator, sink-voltage, rail-current, and power-loss analysis.
- **KiCad:** schematic capture, four-layer PCB implementation, DRC, differential routing, stackup, and fabrication outputs.
- **FPGA:** AD9655 control, source-synchronous capture, acquisition-mode logic, buffering, triggering, and host communication.

Raw simulation data and derived quantitative result tables are under [`verification/`](verification/).

---

## Hardware characterization

Physical measurements begin after board fabrication. The characterization set covers input bandwidth, passband flatness, vertical gain and offset, channel matching, channel skew, ADC SNR/SINAD/ENOB/SFDR, timebase accuracy, AWG amplitude flatness and spectral purity, end-to-end AWG-to-ADC loopback, rail quality, and sustained-load thermal behavior.

Those measurements are intentionally separate from the pre-fabrication simulation figures shown in this repository.

---

## Documentation

- [System architecture](docs/01_system_architecture.md)
- [Analog front end](docs/02_analog_frontend.md)
- [ADC and clocking](docs/03_adc_interface.md)
- [Function generator](docs/04_function_generator.md)
- [PCB layout](docs/05_pcb_layout.md)
- [Simulation results](docs/06_simulation_results.md)
- [Signal and power integrity](docs/07_signal_power_integrity.md)
- [Hardware bring-up and characterization](docs/08_bringup.md)
- [Design iteration history](docs/09_debugging_history.md)
- [Measurement methodology](docs/10_measurement_plan.md)
- [Results index](docs/11_results.md)

---

## Repository contents

```text
.
├── README.md
├── docs/
│   ├── 01_system_architecture.md
│   ├── 02_analog_frontend.md
│   ├── 03_adc_interface.md
│   ├── 04_function_generator.md
│   ├── 05_pcb_layout.md
│   ├── 06_simulation_results.md
│   ├── 07_signal_power_integrity.md
│   ├── 08_bringup.md
│   ├── 09_debugging_history.md
│   ├── 10_measurement_plan.md
│   ├── 11_results.md
│   ├── assets/
│   ├── schematics/
│   └── pcb/
├── verification/
│   ├── raw/
│   ├── results/
│   └── si_pi/
├── fpga/
└── software/
```
