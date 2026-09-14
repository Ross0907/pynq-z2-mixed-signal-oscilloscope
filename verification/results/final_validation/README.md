# Final pre-fabrication validation snapshot

No new PowerSI, Broadband SPICE, AC PSpice, or transient PSpice run is performed by this recovery package. It consolidates the already-completed validated result sets.

- Open-red frontend: **43 pF / 7.5 pF / 110 pF**, worst flatness **0.545893 dB**, HIGH/LOW separation error **0.436622 dB**, input resistance **0.997589–0.999792 MΩ**.
- DUAL loaded AC: ripple **0.865–0.914 dB**, Nyquist rejection **36.191–36.278 dB**, f3dB **22.054–22.073 MHz**.
- FAST loaded AC: ripple **0.959–1.134 dB**, Nyquist rejection **41.736–42.224 dB**, f3dB **41.368–41.471 MHz**. The residual FAST response shape is reported for calibration; the ≥40 dB alias-rejection criterion is met.
- AC-coupling corner: **3.441–3.471 Hz**.
- Settled transient: **8/8 complete**, maximum ADC differential utilization **88.97% of 2.8 Vpp** in this loaded set.
- Passive SI: **12/12 Sep-13 PowerSI result sets verified**.
- Validated fabrication revision: **0 DRC violations, 0 unconnected pads, 0 footprint errors; 0 ERC errors/warnings**. Live KiCad project hashes are intentionally not used as a recovery gate.

