# Measurement Methodology

Physical characterization is structured to separate front-end accuracy, converter performance, timebase behavior, and waveform-generation performance.

## Analog input characterization

The acquisition-channel measurement set includes:

- input impedance;
- attenuation ratio;
- DC offset;
- noise floor;
- frequency response;
- passband flatness;
- step response;
- channel isolation;
- channel-to-channel gain matching;
- channel skew.

## ADC dynamic performance

FFT-based characterization covers:

- SNR;
- SINAD;
- ENOB;
- SFDR;
- harmonic levels;
- broadband noise floor.

Coherent sampling is preferred for converter-performance measurements, with windowed analysis used where coherent sampling is not practical.

## Timebase characterization

The acquisition sample clock is compared with an independent frequency reference to quantify timebase error and long-term stability.

## Waveform-generator characterization

The AD9102 path is characterized for frequency accuracy, output amplitude, offset, flatness, output impedance, THD, SFDR, and reconstruction behavior.

## Loopback characterization

The on-board waveform generator provides a repeatable source for end-to-end AWG-to-ADC measurements across multiple frequencies, amplitudes, and acquisition modes.
