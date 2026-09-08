# Hardware Bring-Up and Characterization

The hardware characterization sequence is organized to separate power, clocking, digital-interface, analog-front-end, and waveform-generator behavior.

## Power-up phase

Initial testing begins with passive continuity and resistance checks followed by current-limited power application. The principal rails are the PYNQ-derived 3.3 V domains, local 3.0 V and 1.8 V domains, and the positive and negative analog rails.

The measured values will be compared with the PowerDC predictions already included in the project documentation.

## Clock phase

The 125 MHz ADC clock and 156.25 MHz AD9102 clock are characterized before full converter operation. The measurements cover frequency, amplitude, differential behavior, startup, and noise/jitter characteristics.

## Digital converter interface

AD9655 digital test modes isolate the FPGA receive path from the analog front end. DCO, FCO, lane polarity, word reconstruction, and timing margin are characterized before analog performance measurements.

## Analog acquisition

Channel characterization spans both attenuation states, AC/DC coupling, both anti-alias filter modes, both acquisition modes, and simultaneous dual-channel operation.

## Waveform generation

The AD9102 output path is characterized for output amplitude, offset, frequency response, harmonic content, and 50 Ω load behavior.

## End-to-end operation

The final system-level characterization includes AWG-to-ADC loopback, channel matching, timebase validation, and software-controlled acquisition through the PYNQ-Z2.
