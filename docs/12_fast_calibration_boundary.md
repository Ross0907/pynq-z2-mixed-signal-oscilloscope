# FAST-mode calibration boundary

This note records the current pre-fabrication FAST-path tolerance and calibration boundary for Rev. A. It does not change any populated hardware values.

The current FAST ladder remains:

- 43 pF / 110 pF / 120 pF / 47 pF differential shunt capacitors;
- 200 nH / 270 nH / 240 nH series inductors per leg;
- C70/C91 DNP trim positions left unpopulated;
- authoritative AD9655 input representation of 30 ohm in series with 6.7 pF;
- current extracted PCB/TMUX/GSpice blocks unchanged.

The V13 tolerance study used the frozen extracted linear network and evaluated all 512 coherent component-tolerance corners. The raw `<= 1 dB` passband-ripple target is now treated as an engineering target rather than an absolute fabrication blocker because stable deterministic in-band amplitude response can be calibrated per unit. Aliasing and analog clipping remain hardware constraints because they cannot be repaired after conversion.

## Current FAST tolerance results

| 240 nH tolerance case | Worst raw ripple, 1–40 MHz | Minimum rejection at 62.5 MHz | Strict 40 dB alias target | 39.5 dB comparison |
|---|---:|---:|---|---|
| 2% | 1.700126 dB | 40.212531 dB | PASS | PASS |
| 5% | 2.449870 dB | 39.796430 dB | OPEN by 0.203570 dB | PASS |

The 39.5 dB column is only a practical comparison. The original 40 dB FAST alias-rejection target remains documented separately.

## Per-unit amplitude calibration study

The calibration screen stores a frequency-response correction per board/channel/range/mode and applies interpolation only inside the usable passband. With linear-in-dB interpolation, the worst residual amplitude ripple across the 512 corners was:

| Calibration-point spacing | 240 nH 2% | 240 nH 5% |
|---|---:|---:|
| 2.0 MHz | 0.527592 dB | 0.670403 dB |
| 1.0 MHz | 0.337012 dB | 0.422379 dB |
| 0.5 MHz | 0.237644 dB | 0.297149 dB |
| 0.25 MHz | 0.101197 dB | 0.118948 dB |
| 0.125 MHz | 0.070279 dB | 0.082351 dB |
| 0.0625 MHz | 0.008444 dB | 0.009156 dB |

The calibration-density gate is therefore closed at **0.125 MHz spacing** for both 240 nH tolerance scenarios against the `<= 0.10 dB` residual target. The 0.0625 MHz grid provides substantial additional numerical margin but is not required by the current calibration target.

This does not waive the pre-ADC alias requirement. In particular, the 5% 240 nH scenario still misses the original 40 dB FAST alias target by approximately 0.204 dB even though its deterministic in-band amplitude response is software-correctable.

## Headroom screen

Using the existing FAST 40 MHz transient-equivalent amplitudes as the anchor, the tolerance study predicts the following worst-case input derating to guarantee the AD9655 remains below 2.8 Vpp differential:

| 240 nH tolerance case | Worst input derating | Guaranteed HIGH-range input limit | Guaranteed LOW-range input limit |
|---|---:|---:|---:|
| 2% | 9.6223% | 5.000 Vpeak | 1.1297 Vpeak |
| 5% | 17.5447% | 4.7680 Vpeak | 1.0307 Vpeak |

This is a screening result anchored to the existing transient-equivalent data, not a replacement for final active-device overload/recovery verification.

## Software ownership

The FPGA, Linux daemon, ngscopeclient integration, and calibration implementation live in the companion software repository:

- [Ross0907/pynq-scope](https://github.com/Ross0907/pynq-scope)

That repository already defines calibration profiles keyed by board serial/revision, channel, attenuation range, and acquisition mode, while preserving immutable raw ADC samples. This hardware repository remains the authority for schematic, PCB, extracted-network, analog, SI/PI, power, and pre-fabrication hardware evidence.

The two repositories should therefore stay synchronized at their interface boundary rather than duplicating implementation details.
