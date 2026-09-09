# Design Iteration and Debugging History

This project was developed through repeated schematic, simulation, extraction, and layout iterations. The entries below record engineering problems that materially changed the design or analysis process.

## 1. Analog front-end analysis moved from ideal blocks to loaded system models

Early stage-level checks were insufficient because the anti-alias filter, fully differential driver, and AD9655 input loading interact. The analysis was changed to evaluate the complete loaded analog path across both channels, both input ranges, FAST/DUAL selection, AC/DC coupling, transient response, and AC response.

The compact-GSpice V7 run set is the current analog filter/coupling reference.

## 2. TMUX1574 model was checked against the vendor testbench

The TI TMUX1574 Capture testbench was kept as a known model reference. Its apparent half-amplitude output was traced to the testbench's deliberate 50 Ω source / 50 Ω load divider rather than switch insertion loss. Those resistors were therefore not copied into the oscilloscope AFE.

## 3. Historical PSpice differential-output PRINT failure

An earlier verification run stopped because the test harness attempted to print undefined differential expressions for the two channels. This was an output-expression problem rather than a circuit failure.

The later V7 compact-GSpice runs completed the intended analog AC, bias, and coupling checks.

## 4. Solver-graph continuity and port mapping

Sigrity/PowerSI extraction required correction of port mapping and solver-graph continuity around the digital ADC interface. The current 26-port package incorporates the continuity repairs remapped onto the final ODB geometry.

The validation found:

- 26 ports;
- all referenced terminal nodes present;
- same-net repair endpoints;
- maximum native-node remap displacement of 0.002236 mm.

This validates the setup structure; the final S26P numerical solve is still pending.

## 5. HIGH/LOW range-transfer discrepancy isolated

A dedicated diagnostic compared:

1. the extracted source S47P;
2. the frozen compact-GSpice representation;
3. the schematic-reference range model;
4. a larger extracted FULL222 network reduced to the same interface.

The extracted source network shows HIGH/LOW separation falling to roughly 2.1–2.3 dB through much of the MHz band, whereas the schematic-reference model retains roughly 10 dB. The larger extracted network agrees closely with the reduced S47P at the checked frequencies.

The investigation is centered on the schematic range relay/attenuator/compensation networks K1/K2 and their associated resistor-capacitor networks.

## 6. Transient display window

The original 0â€“200 ns figures did not show enough of the DUAL-mode settling behavior. The current plots use matched LOW/HIGH time scales within each acquisition mode, with a longer DUAL interval so the steady periodic response is visible.
## 7. PowerDC baseline became stale after the AWG was finalized

The existing PowerDC screenshots predate the finalized AWG load update. The load update adds the AD9102, AWG clock, output amplifier, and increased LM27762-equivalent input demand.

The earlier solve therefore remains a baseline result. A new PowerDC run with the finalized loads is pending.

## Current revision

Rev. A remains a pre-fabrication design. Current numerical results and pending analyses are summarized in `11_results.md`.
