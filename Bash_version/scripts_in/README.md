# Molecular Dynamics Workflow Instructions and Scripts

This repository provides a comprehensive set of instructions and scripts to facilitate the execution and analysis of molecular dynamics (MD) simulations. The workflow, as illustrated in the accompanying figure, is divided into two major sections:

1. **Conformational Sampling**
2. **NMR-Restrained Simulations and Analysis**

## Workflow Overview

The molecular dynamics workflow begins with a template DNA-ligand complex and a ligand PDB file, generating multiple conformations for downstream analysis. The NMR-derived restraints are then applied during simulated annealing, allowing the selection of conformers with the lowest restraint energy penalties. Finally, production simulations and analysis are performed.

The figure above highlights the following key components:

- **White Boxes:** Input and output files.
- **Blue Boxes:** Instruction files (`.in`), used for programs like `tleap`, `cpptraj`, and AMBER engines.
- **Green Boxes:** Simulation steps using `sander` or `pmemd.cuda`.
- **Yellow Boxes:** Analysis steps using `cpptraj`.
- **Orange Boxes:** Operations in `tleap`.
- **Red Boxes:** Calculations of ligand parameters using `antechamber` and `parmchk2`.

The `.in` files in this workflow act as templates, modified programmatically using Bash scripts to incorporate variables that define input/output file paths and settings. This ensures seamless linkage across individual steps in the workflow.

---

## Directory: `scripts_in`

The `scripts_in` directory contains all the default protocols and templates required for the MD workflow, organized as follows:

### 1. **MD Instruction Files**
These files contain the necessary instructions for running various simulation steps. Users can modify these templates to suit their experimental needs. Key files include:

- `dna_min1.in` and `dna_min2.in`: Structure optimization protocols.
- `dna_md1.in`: Heating protocol (300 K).
- `dna_md2.in`: 20 ps equilibration protocol.
- `dna_md4.in`: 5 ns production simulation with restraints.
- `dna_md4_unrest.in`: 5 ns production simulation without restraints.
- `Anneal_flip.in`: 520 ps annealing protocol with restraints.

### 2. **Library Scripts**

#### `Library_tleap.sh`
Functions for generating and modifying `tleap_script.in` files. Key functions include:

- `tleap_start`: Defines forcefield libraries for the workflow.
- `tleap_conf` and `tleap_solvate_prod`: Modify solvation and neutralization procedures by adding solvent models and ion types.

#### `Library_cpptraj.sh`
Contains functions for generating and modifying analysis instruction files (`3DNA.in`, `cpptraj.in`, `cpptraj_clustering.in`), supporting:

- 3DNA analysis for hydrogen bonds, polyamide dihedrals, and structural properties.
- K-nearest clustering for conformational sampling.

> **Note:** `3DNA.in` requires manual updates for new DNA structures due to hardcoded residue masks and atom labels.

#### `Library_MD.sh`
Functions for generating MD instruction files and executing simulations using `sander` or `pmemd.cuda`. Includes:

- Protocols for minimization, heating, equilibration, annealing, and production simulations.

### 3. **MARDIGRAS Support Files**
The directory also contains:

- **Binary Files:** Required for the MARDIGRAS workflow, stored in the `Final_scripts` subdirectory. These are copied into the operating directory during execution and removed post-run.

---

## Key Workflow Steps

1. **Conformational Sampling**
   - Begins with a DNA-ligand complex and ligand PDB file.
   - Generates 20 conformers through k-nearest clustering (`cpptraj_clustering.in`).

2. **NMR-Restrained Simulations**
   - Applies restraints from MARDIGRAS to conformers during annealing.
   - Extracts restraint energy penalties and selects the 5 conformers with the lowest penalties for production simulations.

3. **Production Simulations**
   - Executes 5 ns restrained and unrestrained simulations for the selected conformers.
   - Outputs are analyzed using `cpptraj` for structural insights (e.g., hydrogen bonds, dihedrals).

4. **Final Analysis**
   - Calculates MMGB/GBSA free energy using analysis scripts.

---

## Modifying the Workflow

Users can modify the default protocols by:

1. Editing `.in` files in the `scripts_in` directory.
2. Updating `Library_*` scripts to customize file paths, residue masks, and forcefield settings.
3. Adjusting bash variables for different input/output file naming conventions.

---

## Dependencies

- AMBER/AmberTools
- Bash
- MARDIGRAS binaries (included in `Final_scripts`)

---

For further details, refer to the workflow diagram provided.