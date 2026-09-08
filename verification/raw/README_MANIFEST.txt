PYNQ-Z2 OSCILLOSCOPE / AWG - SIMULATION DATASET SUMMARY
Packaged: 2026-09-09

OSCILLOSCOPE AFE - NOMINAL TRANSIENT MATRIX
============================================
1) trans(20260903-220723).csv
   LOW range + FAST AAF
   AAFSELV=1, ATT1V=ATT2V=3.3 V, FREQ=40 MHz, VIN1AMP=1.70 Vpk, VIN2AMP=0
   Final ADC differential ~= 2.20466 Vpp

2) trans(20260904-072702).csv
   LOW range + DUAL AAF
   AAFSELV=0, ATT1V=ATT2V=3.3 V, FREQ=20 MHz, VIN1AMP=1.70 Vpk, VIN2AMP=0
   Final ADC differential ~= 2.44-2.45 Vpp

3) trans(20260904-074916).csv
   HIGH range + DUAL AAF
   AAFSELV=0, ATT1V=ATT2V=0 V, FREQ=20 MHz, VIN1AMP=5.0 Vpk, VIN2AMP=0
   Final ADC differential ~= 2.13199 Vpp

4) trans(20260904-084345).csv
   HIGH range + FAST AAF
   AAFSELV=1, ATT1V=ATT2V=0 V, FREQ=40 MHz, VIN1AMP=5.0 Vpk, VIN2AMP=0
   Settled ADC differential ~= 1.93892 Vpp
   Settled FDA differential ~= 2.71901 Vpp

OSCILLOSCOPE AFE - POST-LAYOUT AC RESPONSE
===========================================
5) acanaafv=1att=3v3(1).csv
   FAST AAF, ATT=3.3 V
   Measured TI 3.3 V TMUX1574 RSV S-parameter path converted through Cadence Broadband SPICE
   -3 dB bandwidth ~= 41.2 MHz
   Attenuation ~= 41.76 dB @ 62.5 MHz (CH1)

6) acanaafv=0att=3v3(1).csv
   DUAL AAF, ATT=3.3 V
   Measured TI 3.3 V TMUX1574 RSV S-parameter path converted through Cadence Broadband SPICE
   -3 dB bandwidth ~= 22.0 MHz
   Attenuation ~= 36.16 dB @ 31.25 MHz (CH1)

AWG / FUNCTION GENERATOR - SIGNAL-PATH RESPONSE
===============================================
7) RUN_FG_V8.csv
   1 MHz transient
   AD9102-equivalent differential drive -> ADA4817 output path -> 49.9 ohm -> 50 ohm BNC load
   BNC ~= 1.5983 Vpp; op-amp output ~= 3.199 Vpp

8) RUN_FG_V9_AC.csv
   Post-layout AWG AC sweep
   ADA4817 vendor model + extracted PCB interconnect + 49.9 ohm source termination + 50 ohm load
   ~= -0.424 dB around 31 MHz; -3 dB bandwidth ~= 85.8 MHz

PCB REVISION CONTEXT
====================
The oscilloscope AFE response extraction was generated before the later 2026-09-06 manual AC/DC coupling-switch addition near the ADA4817 inputs (S2, C125/C126, R89/R90). The AFE CSVs therefore describe the earlier extracted post-layout signal path. The later geometry change is documented separately in the PCB revision history.

The AWG V8/V9 files are the most recent waveform-generator signal-path response data in this dataset.

OTHER FILES IN THE SOURCE ARCHIVE
=================================
- asc(2)..asc(5): noise-analysis exports rather than AC transfer-response data.
- RUN_V10A / RUN_V10B / RUN_V10_4B: regulator/power transient tests.
- acana(2), acana(3), and earlier acana* exports: earlier AFE response runs preceding the measured-TMUX pair listed above.
