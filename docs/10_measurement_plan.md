# Measurement Plan

## Analog-input characterization

Measure:

- input impedance;
- attenuation accuracy;
- DC offset;
- noise floor;
- bandwidth;
- passband flatness;
- step response;
- channel isolation;
- channel-to-channel gain mismatch;
- channel skew.

## ADC performance

At several input frequencies and amplitudes:

- FFT;
- SNR;
- SINAD;
- ENOB;
- SFDR;
- harmonic levels;
- noise floor.

Use coherent sampling when possible and document windowing otherwise.

## Timebase

Validate acquisition timebase against an independent frequency reference.

## AWG

Measure:

- frequency accuracy;
- amplitude accuracy;
- offset;
- flatness;
- output impedance;
- THD;
- SFDR;
- reconstruction behavior.

## Loopback

Run repeatable AWG → oscilloscope tests at multiple frequencies and ranges.

## Reporting rule

No simulation-derived metric is promoted to a measured claim. Measurement CSVs should be stored separately from simulation CSVs and labeled with instrument/setup metadata.
