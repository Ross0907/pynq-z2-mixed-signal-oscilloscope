# PCB Layout

## Stack

The design is a four-layer mixed-signal PCB.

The supplied layer views are committed under:

- `pcb_layer_fcu.png`
- `pcb_layer_in1_ground.png`
- `pcb_layer_in2_power_routing.png`
- `pcb_layer_bcu.png`

## Layout priorities

### Analog channels

- keep the two channels structurally similar;
- minimize coupling between channel input paths;
- keep amplifier feedback loops compact;
- avoid plane discontinuities under critical analog routes;
- place filter and FDA components according to signal flow.

### ADC region

- minimize FDA-to-ADC interconnect length;
- preserve differential symmetry;
- maintain reference-plane continuity;
- place converter decoupling directly at supply pins;
- isolate noisy digital return currents from the input structures.

### Digital converter interface

- route source-synchronous differential signals with controlled geometry;
- constrain pair skew;
- keep DCO/FCO routing intentional;
- avoid unnecessary layer transitions;
- stitch reference planes at transitions where needed.

### Function generator

The AWG occupies a separate region of the PCB with its own clocking, output stage and BNC connector so its switching activity does not share the sensitive acquisition input geometry.

### Ground stitching

The board uses extensive ground-via stitching around edges and functional boundaries. This is intended to:

- improve return-current locality;
- reduce plane resonance;
- provide shielding between blocks;
- reduce discontinuity around edge and connector regions.

## Review evidence

See:

- [PCB layers PDF](pcb/Pynq_Oscilloscope_pcb_layers.pdf)
- [Top 3D render](assets/hardware/pcb_3d_top.png)
- [Bottom 3D render](assets/hardware/pcb_3d_bottom.png)
