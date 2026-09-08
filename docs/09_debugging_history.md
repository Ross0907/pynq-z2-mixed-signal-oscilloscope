# Design Iteration History

The project evolved through repeated schematic, simulation, extraction, and PCB-layout iterations.

## Analog-front-end development

The analog path was refined around the loaded behavior of the filter, FDA, and ADC interface rather than ideal standalone stages. Filter response, large-signal behavior, common-mode level, and ADC loading were evaluated across both range states and both acquisition modes.

## Post-layout model development

Extracted-network work included correction of port mapping, differential-path connectivity, component-model association, and high-speed interconnect representation before the final post-layout response set was produced.

## PCB refinement

Layout iterations concentrated on the separation between the two analog channels, shorter FDA-to-ADC routes, ground-reference continuity, high-speed pair geometry, power distribution, and the placement of stitching vias around critical regions.

## Digital-interface development

The ADC interface architecture separates physical-lane reception, source-synchronous timing, word reconstruction, mode selection, buffering, and higher-level capture control. This structure allows digital-interface faults to be isolated from the analog front end during FPGA and hardware testing.

## Current revision

The repository represents the Rev. A pre-fabrication design together with its associated simulation and PCB-analysis results.
