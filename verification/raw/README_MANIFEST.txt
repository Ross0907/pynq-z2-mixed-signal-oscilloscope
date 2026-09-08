PYNQ-Z2 OSCILLOSCOPE / AWG — LATEST VALIDATED RESPONSE CSV SET
Packaged: 2026-09-09

OSCILLOSCOPE AFE — FINAL NOMINAL TRANSIENT MATRIX
================================================
1) trans(20260903-220723).csv
   LOW range + FAST AAF
   AAFSELV=1, ATT1V=ATT2V=3.3 V, FREQ=40 MHz, VIN1AMP=1.70 Vpk, VIN2AMP=0
   Final ADC differential ~= 2.20466 Vpp
   Status: PASS

2) trans(20260904-072702).csv
   LOW range + DUAL AAF
   AAFSELV=0, ATT1V=ATT2V=3.3 V, FREQ=20 MHz, VIN1AMP=1.70 Vpk, VIN2AMP=0
   Final ADC differential ~= 2.44-2.45 Vpp
   Status: PASS

3) trans(20260904-074916).csv
   HIGH range + DUAL AAF
   AAFSELV=0, ATT1V=ATT2V=0 V, FREQ=20 MHz, VIN1AMP=5.0 Vpk, VIN2AMP=0
   Final ADC differential ~= 2.13199 Vpp
   Status: PASS

4) trans(20260904-084345).csv
   HIGH range + FAST AAF
   AAFSELV=1, ATT1V=ATT2V=0 V, FREQ=40 MHz, VIN1AMP=5.0 Vpk, VIN2AMP=0
   Settled ADC differential ~= 1.93892 Vpp
   Settled FDA differential ~= 2.71901 Vpp
   Status: PASS

OSCILLOSCOPE AFE — FINAL MEASURED-TMUX POST-LAYOUT AC SIGNOFF
==============================================================
5) acanaafv=1att=3v3(1).csv
   FAST AAF, ATT=3.3 V
   Uses the measured TI 3.3 V TMUX1574 RSV S-parameter path converted through Cadence Broadband SPICE
   Final -3 dB bandwidth ~= 41.2 MHz
   Nyquist rejection ~= 41.76 dB @ 62.5 MHz (CH1)
   Status: PASS / AAF FROZEN

6) acanaafv=0att=3v3(1).csv
   DUAL AAF, ATT=3.3 V
   Uses the measured TI 3.3 V TMUX1574 RSV S-parameter path converted through Cadence Broadband SPICE
   Final -3 dB bandwidth ~= 22.0 MHz
   Nyquist rejection ~= 36.16 dB @ 31.25 MHz (CH1)
   Status: PASS / AAF FROZEN

AWG / FUNCTION GENERATOR — LATEST SIGNAL-PATH RESPONSE
======================================================
7) RUN_FG_V8.csv
   Accepted 1 MHz transient
   AD9102-equivalent differential drive -> ADA4817 output path -> 49.9 ohm -> 50 ohm BNC load
   BNC ~= 1.5983 Vpp; op-amp output ~= 3.199 Vpp
   Status: PASS

8) RUN_FG_V9_AC.csv
   Latest post-layout AWG AC sweep
   Real ADA4817 vendor model + extracted PCB interconnect + 49.9 ohm source termination + 50 ohm load
   ~= -0.424 dB around 31 MHz; -3 dB bandwidth ~= 85.8 MHz
   Status: PASS

IMPORTANT PCB-REVISION NOTE
===========================
These are the latest VALIDATED response CSVs available from the completed post-layout simulation work.
The oscilloscope AFE response extraction predates the later 2026-09-06 manual AC/DC coupling-switch addition near the ADA4817 inputs (S2, C125/C126, R89/R90). No newer full AFE AC/transient CSV incorporating that added switch geometry has been located in the project history. Therefore the AFE CSVs above are authoritative for the previously extracted post-layout signal path and AAF/TMUX signoff, but must not be described as a fresh re-extraction of the 2026-09-06 AC/DC-switch PCB revision.

The AWG V8/V9 signal-path results are the latest accepted AWG response results found.

NOT INCLUDED
============
- asc(2)..asc(5): noise-analysis exports, not AC transfer-response CSVs.
- RUN_V10A / RUN_V10B / RUN_V10_4B: regulator/power transient tests, not signal response.
- acana(2), acana(3), and earlier acana* exports: superseded for AAF signoff by the final measured-TMUX pair above.
