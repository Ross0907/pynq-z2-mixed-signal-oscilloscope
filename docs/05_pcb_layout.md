# PCB Layout

The oscilloscope is implemented as a four-layer mixed-signal PCB designed around the PYNQ-Z2 mechanical and electrical interface.

## Layer structure

The committed layer views show:

- front copper and component routing;
- an inner ground/reference layer;
- an inner power and secondary-routing layer;
- back copper and auxiliary routing.

## Analog placement

The two acquisition channels use closely matched physical structures. Attenuation, amplification, filtering, and differential-drive sections follow the signal direction from the BNC connectors toward the ADC.

The FDA-to-ADC interconnect is deliberately compact to reduce parasitic imbalance at the converter input.

## Digital routing

The AD9655 source-synchronous interface routes toward the FPGA connector with controlled differential geometry and deliberate pair matching. DCO/FCO and converter clock routes are treated as timing-critical interconnects.

## Ground and return paths

Dense ground stitching surrounds major functional regions and provides short return paths across the board. Critical analog and high-speed digital routes remain referenced to continuous plane regions through their principal routing sections.

## Power layout

Power conversion and regulation occupy dedicated regions away from the analog BNC inputs. Local decoupling is concentrated around the ADC, high-speed amplifiers, clock circuitry, logic translation, and AD9102 subsystem.

## Mechanical integration

The board outline clears the PYNQ-Z2 connector and mechanical geometry while preserving access to BNCs, headers, test points, and mounting holes.
