# Design Iteration and Debugging History

This project was developed through repeated schematic, simulation, extraction and layout iterations. This log records the engineering failure modes that materially changed the verification flow.

## 1. Analog front-end verification moved from ideal blocks to loaded system models

Early stage-level checks were insufficient because the anti-alias filter, fully differential driver and AD9655 input loading interact. The verification flow was therefore changed to evaluate the complete loaded analog path across:

- CH1 and CH2;
- HIGH and LOW range;
- FAST and DUAL filter selection;
- AC and DC input coupling;
- transient and AC response.

The final compact-GSpice V7 matrix is the current analog-filter/coupling reference.

## 2. TMUX1574 model was validated against the vendor harness

The supplied TI TMUX1574 Capture testbench was kept as a known-good model reference. Its apparent half-amplitude output was traced to the vendor testbench's deliberate 50 Ω source / 50 Ω load divider rather than switch insertion loss. Those testbench resistors were therefore not copied into the oscilloscope AFE.

This avoided propagating a model-harness artifact into the actual schematic.

## 3. Historical PSpice differential-output PRINT failure

An earlier signoff run stopped because the test harness attempted to print undefined differential expressions for the two channels. That failure was classified as an automation/output-expression problem, not a circuit failure.

The later V7 compact-GSpice verification matrix superseded that harness and completed the intended analog AC, bias and coupling gates.

## 4. Solver-graph continuity and port mapping

Sigrity/PowerSI extraction required correction of port mapping and solver-graph continuity around the digital ADC interface. The final 26-port package incorporates the proven continuity repairs remapped onto the final ODB geometry.

The final validation found:

- 26 ports;
- all referenced terminal nodes present;
- same-net repair endpoints;
- maximum native-node remap displacement of only 0.002236 mm.

This closes **setup integrity**, not the final S26P solve.

## 5. Range-transfer discrepancy isolated

A dedicated root-cause diagnostic compared:

1. the extracted source S47P;
2. the frozen compact-GSpice representation;
3. the schematic-reference range model;
4. a larger extracted FULL222 network reduced to the same interface.

The important result is that the extracted source network shows HIGH/LOW separation collapsing to roughly 2.1–2.3 dB through much of the MHz band, whereas the schematic-reference model retains roughly 10 dB. The larger extracted network agrees closely with the reduced S47P at the checked frequencies.

Therefore the discrepancy cannot be dismissed as a plotting error or compact-GSpice reduction artifact. The OPEN investigation is centered on the schematic range relay/attenuator/compensation networks K1/K2 and their associated R/C networks.

## 6. Transient figures were presentation-cropped too early

The first publication figures displayed only 0–200 ns even though the committed raw transient CSVs are longer. For the DUAL cases in particular, the ADC waveform is still visibly approaching its periodic steady state within that window.

The repository plotting policy was changed to use the full available source record for every case. No waveform samples are synthesized, repeated or extrapolated.

## 7. PowerDC baseline became stale after the AWG was finalized

The existing PowerDC screenshots predate the final AWG load update. The final load note adds the AD9102, the AWG clock, the output amplifier and the increased LM27762-equivalent input demand.

Consequently the earlier PowerDC solve remains historical baseline evidence only. A new final solve is required before PI closure.

## Current revision

Rev. A remains a pre-fabrication design. Closed and open gates are tracked in `12_prefabrication_signoff_matrix.md`; source-evidence provenance is tracked in `13_evidence_provenance.md`.