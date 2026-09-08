# Engineering Debugging History

This document should retain failed approaches because the path to a stable high-speed board is part of the engineering evidence.

## Categories to preserve

### Analog simulation

Record:

- unstable or peaking amplifier configurations;
- incorrect ADC loading assumptions;
- common-mode violations;
- filter values that failed passband/stopband targets;
- unrealistic ideal-switch assumptions;
- model substitutions.

### Post-layout extraction

Record:

- broken extracted differential networks;
- invalid port topology;
- incorrect component-model mapping;
- via/contact graph issues;
- return-path discontinuities;
- corrected extraction models.

### PCB

Record:

- routing changes driven by SI;
- component-footprint corrections;
- differential-pair skew corrections;
- ground-stitching additions;
- channel isolation improvements;
- manufacturing-rule corrections.

### FPGA

Record:

- lane-order/polarity errors;
- DCO/FCO timing issues;
- SelectIO/IDELAY training;
- DMA/trigger bugs;
- capture alignment failures.

## Entry format

For each issue:

```text
Date:
Subsystem:
Observed evidence:
Root cause:
Schematic/layout/RTL change:
Verification used:
Result:
Residual risk:
```

Do not replace a failed result with the final screenshot only. Keep the evidence trail.
