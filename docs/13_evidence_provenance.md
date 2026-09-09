# Evidence Provenance and Reproducibility

This repository distinguishes design intent, simulation output, extracted-network results, solver setup validation and future hardware measurement.

## Canonical transient sources

| Operating case | Raw source |
|---|---|
| LOW FAST / 40 MHz | `verification/raw/afe/transient/trans(20260903-220723).csv` |
| LOW DUAL / 20 MHz | `verification/raw/afe/transient/trans(20260904-072702).csv` |
| HIGH FAST / 40 MHz | `verification/raw/afe/transient/trans(20260904-084345).csv` |
| HIGH DUAL / 20 MHz | `verification/raw/afe/transient/trans(20260904-074916).csv` |

The raw source files are authoritative. Plotting scripts must not synthesize missing samples.

## Transient-plot reproducibility policy

Publication plots must:

1. clone/read the current repository source files;
2. parse the complete committed CSV;
3. preserve every finite sample in the source record;
4. use the source's actual start/end time;
5. plot FDA differential output and ADC differential input directly from the raw columns;
6. derive common mode directly from the corresponding positive/negative nodes;
7. export vector SVG and high-resolution PNG;
8. write a machine-readable plot-window manifest;
9. modify only generated result assets when publishing.

The README is intentionally not rewritten by the plot publisher. This prevents unrelated presentation edits, such as image crops, from being overwritten.

## Analog signoff provenance

The final compact-GSpice V7 evidence is mirrored under `verification/results/`:

- `ANALOG_GSPICE_V7_RUN_STATUS.csv`;
- `AC_SIGNOFF_METRICS.csv`;
- `AC_COUPLING_METRICS.csv`.

These files support the anti-alias, coupling and bias PASS gates.

## ADC/noise provenance

`AD9655_SIGNOFF_SUMMARY.csv` is retained as the compact modeled system-performance summary. Its values are pre-fabrication modeled results and must not be described as measured ADC performance.

## Range diagnostic provenance

`RANGE_TRANSFER_KEY_POINTS.csv` is an exact-frequency extract from the supplied full diagnostic and compares extracted/source, frozen compact-model and schematic-reference range behavior.

`FULL222_VS_MERGED_S47P.csv` independently checks the reduced extracted network against the larger FULL222 extraction at selected frequencies. This comparison is retained specifically because it prevents the range discrepancy from being incorrectly attributed to the compact simulation wrapper.

## PowerSI provenance

The final 26-port SPD setup validation and run manifest are mirrored under `verification/si_pi/`.

The validation file itself states that structural validation does not constitute a completed S26P solve. The repository preserves that distinction.

## PowerDC provenance

`POWERDC_LOADS_BASELINE.csv` records the previous solved load model. `POWERDC_FINAL_AWG_UPDATE.txt` records the required final AWG-related load changes.

The older PowerDC screenshots remain useful historical evidence but are not labelled as the final AWG-loaded solve.

## Evidence-status vocabulary

- **Design intent** — schematic/architecture target.
- **Simulated** — circuit-simulator result.
- **Extracted** — post-layout/passive-network result.
- **Structurally validated** — setup/connectivity checks passed, solver result not necessarily produced.
- **Modeled system result** — result combining multiple models/data sources.
- **Measured** — physical hardware observation only.

No result should be promoted to a stronger category without corresponding evidence.