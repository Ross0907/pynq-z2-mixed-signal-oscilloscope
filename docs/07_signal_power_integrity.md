# Signal and Power Integrity

## Signal-integrity scope

Critical paths include:

- ADA4927-2 to AD9655 differential analog routes;
- AD9655 converter clock;
- AD9655 source-synchronous digital interface;
- FPGA-facing high-speed connections;
- function-generator output path.

The signoff workflow includes extracted post-layout models where available.

## Return paths

The review does not treat trace length as sufficient evidence. Each critical route is checked against its reference plane and return-current path, especially near:

- layer transitions;
- connector launches;
- plane boundaries;
- power islands;
- high-speed device pads.

## Power integrity

PowerDC screenshots committed under `docs/assets/powerdc/` capture:

- VRM voltage results;
- sink-voltage results;
- discrete-current results;
- power-loss summary.

These are simulation results and must be compared against physical rail measurements after fabrication.

## Hardware PI acceptance

For every important rail:

1. measure no-load voltage;
2. measure loaded voltage;
3. verify startup;
4. verify ripple/noise;
5. compare regulator current against model;
6. inspect hot spots;
7. verify analog rail noise under ADC/AWG activity.
