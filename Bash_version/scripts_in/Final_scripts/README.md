# NMR-Restrained Computation Using MARDIGRAS

This repository provides scripts and instruction files for performing NMR-restrained computations from 2D {H,H} homonuclear NOEASY spectra using the MARDIGRAS workflow. The directory contains tools and resources to streamline the workflow and generate AMBER-readable restraint files for proton-proton networks.

## Workflow Overview

### Workflow Diagram

Below is the workflow diagram illustrating the steps involved in the MARDIGRAS computation process:

![MARDIGRAS Workflow](image.png)

### Process Description
1. **Independent Starting Points**:
   - Formatting intensity files (`.lst`) for MARDIGRAS input.
   - Preparing the starting template file (`.pdb`).
2. **Parallel Calculations**:
   - MARDIGRAS calculations for proton-proton distances are executed using GNU Parallel to utilize multiple CPU cores efficiently.
   - Instruction files (`.PARM`) control individual MARDIGRAS calculations, and GNU Parallel processes all calculations concurrently.
3. **Final Steps**:
   - Results from all calculations are combined to generate averaged distance bonds.
   - An AMBER-readable restraint file is produced for the proton-proton network.

The directory includes scripts and templates for modifying default workflow parameters to adapt to specific experimental setups.

---

## Directory Contents

### Main Scripts and Templates
1. **`Demo_NMR_MD_IY.sh`**
   - Controls the workflow for correlation time inputs (e.g., 1–8 ns).
   - Key variable: `ns` (assigned for correlation time).

2. **`S1_iso_corma_expect.sh`**
   - Configures molecule type (nucleic acids or others) and tumbling motion model (e.g., isotropic, model-free).
   - Default settings: nucleic acids with isotropic tumbling.
   - Custom templates can be created for other molecule types or motion models.

3. **`Template.PARM`**
   - Instructions for MARDIGRAS calculations.
   - Editable parameters include:
     - Input/output file names.
     - NMR spectrometer frequency (MHz).
     - Noise absolute unnormalized value.
     - Models for molecular motion (e.g., methyl jump, three-site).
     - Normalization procedure (e.g., max intensity or average).
     - Number of `RANDMARDI` calculations (default: 10).
     - Output options for `.dst` (distance files) and `.rate` (relaxation rates).

4. **`T3_run_rand_restr.sh` & `S3_run_rand_restr_expect.sh`**
   - Define experimental conditions, correlation time combinations, and percentage error tolerance.
   - Default tolerance: 10%.

5. **`T4-run_m2ahomo.sh`**
   - Generates AMBER restraint files with adjustable parameters:
     - Lower & upper force constants (default: 20 kcal/mol).
     - Lower & upper parabolic widths (default: 1 Å).
   - Adaptable for generating restraint files in other formats (e.g., GROMACS).

---

## Input/Output File Descriptions

### Input Files
- **`.lst`**: Intensity files formatted for MARDIGRAS.
- **`.pdb`**: Template structure file.
- **`.INT.1`**: Intermediate intensity files generated during preprocessing.

### Output Files
- **`.dst` & `.rate`**: Distance and relaxation rate files from MARDIGRAS.
- **`.rand`**: Averaged distance files.
- **`.rest`**: Final AMBER-readable restraint file.

---

## Parallel Computation with GNU Parallel

GNU Parallel is used to optimize MARDIGRAS calculations by running multiple processes simultaneously. Each `.PARM` file corresponds to an independent calculation. To run MARDIGRAS in parallel:

```bash
parallel -j <num_cores> mardigras ::: <list_of_parm_files>
```

# Example
For 15 calculations, GNU Parallel reduces computation time significantly compared to sequential execution.

---

## Modifying Workflow Parameters

### Key Modifiable Parameters
- **Correlation Time**: Defined in `Demo_NMR_MD_IY.sh`.
- **Molecule Type & Motion Model**: Edited in `S1_iso_corma_expect.sh`.
- **Spectrometer Frequency & Noise Value**: Specified in `Template.PARM`.
- **Error Tolerance**: Defined in `S3_run_rand_restr_expect.sh` (default: 10%).
- **Force Constants & Parabolic Widths**: Edited in `T4-run_m2ahomo.sh`.

### Notes
- Ensure consistency across related parameters (e.g., `RANDMARDI` values in `Template.PARM` and `S3_run_rand_restr_expect.sh`).
- For custom workflows, duplicate and modify templates as needed.

---

## Example Case: GTAC-iPr

The repository includes example input files and templates for the GTAC-iPr system with five experimental conditions and three correlation times. Adjust the scripts and templates as needed for other systems.

---

## Running the Workflow
1. Format `.lst` and `.pdb` files.
2. Execute MARDIGRAS calculations using GNU Parallel.
3. Combine results and generate the `.rest` file.

---

## Troubleshooting

- **Incorrect Output**: Check parameter consistency across scripts and templates.
- **MARDIGRAS Errors**: Ensure input files and noise values match the expected format.
- **Parallel Processing Issues**: Verify GNU Parallel installation and configuration.