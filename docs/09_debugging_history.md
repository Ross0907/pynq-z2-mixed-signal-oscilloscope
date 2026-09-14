# Engineering Iteration Notes

Rev. A developed through repeated schematic, simulation, extraction and layout iterations. The points below record the changes that materially improved the design or the analysis method.

## Loaded analog modelling

Early stage-level checks did not capture the interaction between the anti-alias filters, fully differential driver and AD9655 input loading. The analog analysis was therefore expanded to the complete loaded path across both channels, both input ranges, FAST/DUAL selection and AC/DC coupling.

This produced the final loaded AC ranges of **22.054–22.073 MHz** in DUAL and **41.368–41.471 MHz** in FAST, together with the settled transient set.

## TMUX1574 vendor-model check

The TI TMUX1574 testbench initially appeared to show roughly half-amplitude output. The cause was the deliberate 50 ohm source / 50 ohm load divider in the vendor testbench, not switch insertion loss. Those external testbench resistors were not copied into the oscilloscope AFE.

## PSpice differential-output expression

One early PSpice run stopped because the harness attempted to print undefined differential expressions for the two channels. The circuit itself was not the cause; the output expression was corrected in the later simulations.

## PowerSI port mapping

PowerSI setup work exposed port-mapping and solver-graph issues around the ADC digital interface. After correcting the mapping, the upstream digital path and the later D1B branch to J9 were extracted successfully.

The focused D1B/J9 S6P contains **4005 points from 1 MHz to 10 GHz**. At 500 MHz the two branches are **-3.808 dB to U9** and **-3.278 dB to J9**, J9 P/N skew is **29.7 ps**, and differential-to-common conversion is **-29.1 dB**.

## Input-range compensation

An earlier frontend extraction showed HIGH/LOW separation degrading through the MHz region. Comparing the extracted network with the schematic model isolated the issue to compensation/parasitic interaction.

The final compensation values are **43 pF / 7.5 pF / 110 pF**. With these values the post-layout frontend gives **0.545893 dB** worst flatness, **0.436622 dB** worst HIGH/LOW separation error and **0.997589–0.999792 Mohm** input resistance.

## Transient display window

The original 0–200 ns figures were too short to show the DUAL-mode settled response clearly. The current plots use matched LOW/HIGH time scales within each acquisition mode and a longer DUAL interval.

## PowerDC refresh

The power model was updated after the AD9102 path and TPS61033-to-LM27762 power architecture were finalized. The completed PowerDC model includes the AWG load, clock load, bipolar analog rails and the latest board power routing.

## Hardware phase

The remaining work is physical bring-up and measurement: rail and clock characterization, ADC timing margin, analog frequency response, noise/SINAD/ENOB, AWG performance, loopback testing and thermal behavior.
