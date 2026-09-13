# Design Iteration and Debugging History

This project was developed through repeated schematic, simulation, extraction, and layout iterations. The entries below record engineering problems that materially changed the design or analysis process.

## 1. Analog front-end analysis moved from ideal blocks to loaded system models

Early stage-level checks were insufficient because the anti-alias filter, fully differential driver, and AD9655 input loading interact. The analysis was changed to evaluate the complete loaded analog path across both channels, both input ranges, FAST/DUAL selection, AC/DC coupling, transient response, and AC response.

The compact-GSpice run set remains useful for loaded filter/coupling behavior, while the later open-red extraction is authoritative for absolute frontend range/input-impedance verification.

## 2. TMUX1574 model was checked against the vendor testbench

The TI TMUX1574 Capture testbench was kept as a known model reference. Its apparent half-amplitude output was traced to the testbench's deliberate 50 Ω source / 50 Ω load divider rather than switch insertion loss. Those resistors were therefore not copied into the oscilloscope AFE.

## 3. Historical PSpice differential-output PRINT failure

An earlier verification run stopped because the test harness attempted to print undefined differential expressions for the two channels. This was an output-expression problem rather than a circuit failure.

The later compact-GSpice runs completed the intended analog AC, bias, and coupling checks.

## 4. Solver-graph continuity and port mapping

Sigrity/PowerSI extraction required correction of port mapping and solver-graph continuity around the digital ADC interface. The upstream digital block was subsequently validated and frozen. The only later PCB change requiring focused re-verification was the D1B tee to the J9 auxiliary connector.

The final focused D1B extraction used six physical ports:

- IC2 D1B+/-;
- U9 D1B+/-;
- J9 D1B+/-. 

The resulting S6P contains 4005 unique points from 1 MHz to 10 GHz, is passive, and is reciprocal to numerical precision. At 500 MHz the two branches are -3.808 dB to U9 and -3.278 dB to J9; this is dominated by the expected three-port tee split, not PCB dissipation. J9 P/N skew is 29.7 ps at 500 MHz and mode conversion is -29.1 dB.

**Final disposition:** existing upstream ADC digital SI is frozen/verified and the D1B PCB/J9 passive SI is signed off. The optional off-board cable/receiver eye test remains a separate hardware/system validation for the auxiliary dual-FAST mode.

## 5. HIGH/LOW range-transfer discrepancy isolated and closed

A dedicated diagnostic compared:

1. the extracted source S47P;
2. the frozen compact-GSpice representation;
3. the schematic-reference range model;
4. a larger extracted FULL222 network reduced to the same interface.

The then-current extracted source network showed HIGH/LOW separation falling to roughly 2.1–2.3 dB through much of the MHz band. This was traced to compensation/parasitic interaction in the pre-retune frontend and was useful root-cause evidence, but it is no longer the final absolute range result.

The later authoritative open-red frontend extraction and retune closed the item using the final `43 pF / 7.5 pF / 110 pF` compensation set. Final nominal verification gives:

- worst flatness: 0.545893 dB;
- worst HIGH/LOW range-separation error: 0.436622 dB;
- input resistance: 0.997589–0.999792 MΩ;
- P6060 compatibility: PASS.

**Final disposition:** HIGH/LOW range scaling PASS. The old 2.1–2.3 dB result is retained only as historical diagnostic evidence.

## 6. Transient display window

The original 0–200 ns figures did not show enough of the DUAL-mode settling behavior. The current plots use matched LOW/HIGH time scales within each acquisition mode, with a longer DUAL interval so the steady periodic response is visible.

## 7. PowerDC baseline was refreshed after the AWG and local boost were finalized

The original PowerDC screenshots became stale after the AWG and local TPS61033 → LM27762 power architecture were finalized. A later solve updated the board loads and current distribution.

The final pre-fabrication PowerDC reporting set includes the local TPS61033 boost stage, LM27762 bipolar rails, finalized AWG loads, regulator/sink voltages, discrete-current checks, and board-level power-loss checks.

**Final disposition:** updated PowerDC PASS / CLOSED for the current pre-fabrication revision.

## Current revision

Rev. A remains a pre-fabrication design. The previously stale HIGH/LOW range-transfer and ADC passive-SI analysis items are closed. Remaining work is fabrication-related DFM cleanup and post-fabrication characterization/calibration rather than another range-transfer or passive ADC-PCB PowerSI investigation.
