# NMR-MD Workflow Repository

## Overview

This repository provides an automated workflow for NMR-Mardigras-Molecular Dynamics (MD) simulations. It has been successfully applied in the determination of DNA-ligand and dsDNA structures, particularly in chemical biology labs. The workflow is well-documented and ready for further integration with tools like AmberTools, Python scripts, or NMR software for broader applications.

## Workflow Diagram

The figure below provides an overview of the compiled automated workflow:

![Workflow Diagram](../doc/Exe%20flowchart.png)


![nOe restrained MD cofnromation](../doc/nOe_restrained_MD_conformation.gif)

**Figure:** Required input files include a list of intensities (`.lst`) and template model (`.pdb`). User-defined files are shown in **red** (e.g., `pseudo.inp`, `filter.list`, and `Template.PARAM`). To begin, execute the `run.sh` script with `./run.sh`. The program prompts for four variables, highlighted in **black**. It calls a library of scripts, including Bash, Expect, Mardigras, AmberTools, and Amber programs, which must be pre-installed.

---

## Applications

The workflow has been successfully applied to:
- Determining DNA-ligand and dsDNA structures.
- Chemical biology experiments involving complex molecular dynamics.
- Producing results that are primed for refactoring into broader applications.

---

## Installation and Setup

### Requirements
- Linux Ubuntu 20.04
- Amber 18 (PMEMD.CUDA) and GPU license (optional but recommended for GPU acceleration)
- CUDA drivers for GPU acceleration
- GNU Parallel (requires separate installation)
- `expect` (may be required for automation)

### Installation Instructions
1. Clone the repository to your local system:
    ```bash
    git clone https://github.com/yourusername/NMRrMD.git
    ```
2. Make sure the script files have executable permissions:
    ```bash
    chmod u+x scripts/*.sh
    chmod u+x scripts_in/*
    ```

3. Download the required tutorial folders (e.g., `inp`, `scripts_in`, `Library_*`) and the demo script `demo_NMR_MD_IY.sh`.


## Usage

To run the demo tutorial, follow these steps:

1. Ensure your system meets the requirements listed above.
2. Download the necessary folders and files:
    - `inp`
    - `scripts_in`
    - `Library_*`
    - `demo_NMR_MD_IY.sh`

3. Make the script executable:
    ```bash
    chmod u+x demo_NMR_MD_IY.sh
    ```

4. Run the demo:
    ```bash
    ./demo_NMR_MD_IY.sh
    ```

The executable will create a directory called `GTAC_iPr` containing all Mardi and MD calculations, along with a log file for intermediate outputs.

## Description of the Executable Script

### `Demo_NMR_MD_IY.sh`

The script requires the following **user input**:
- **(NamePA, NameDNA, runN)**:
  - `runN`: Set to `0` if recycling the initial template is not needed.

---

### Key Steps in the Script:

#### 1. Initialization of Global Variables:
- Examples: `NameDNA`, `NamePA`, `AmberRun`, and `WFPATH`.

#### 2. Library Calls:
- **`Library_T17.sh`**: Functions include `worktree`, `select_5`, and `mardigras_calculations`.
- **`Library_toggle_scripts.sh`**: Functions include `confsampling`, `annealing`, `production`, etc.
- **`Library_tleap.sh`**: Parameter initialization and solvation functions.
- **`Library_cpptraj.sh`**: Clustering and 3DNA functions.
- **`Library_MD.sh`**: Functions for molecular dynamics.

#### 3. Execution Flow:
- **Worktree**: Creates directories and subdirectories.
- **Mardigras Calculations**: Generates `.rest` and other Mardigras files.
- **Conformational Sampling**: Solvates and clusters starting structures.
- **Annealing**: Applies restraints and generates energy-ranked files.
- **Production Simulations**: Runs MD simulations.
- **Analysis**: Generates final ensembles with dihedrals and 3DNA parameters.

#### 4. Logical Conditions:
- Automatically selects the Amber engine (`pmemd.cuda` or `sander`) based on system configuration.
- Uses **GNU Parallel** for efficient Mardigras calculations.

---

### Key Functions:

#### `select_5`:
- Filters and ranks energy penalties.
- Generates arrays for selected file processing.

#### `recycling`:
- Reuses templates for iterative improvements.

---

## Contributing

Contributions are welcome! Feel free to submit:
- Issues and bug reports
- Pull requests to add features or refactor code

## License

(Include license information here)
