# NMRrMD: A Functional-Style Scripting Workflow for Biomolecule-Ligand NMR-Informed MD Structure Determination

NMRrMD is a versatile scripting workflow designed to automate the process of biomolecule-ligand NMR-informed molecular dynamics (MD) structure determination. The workflow seamlessly integrates:

- **NMR Restraint Calculation**: Powered by Mardigras, it computes NMR restraints to guide the structural modeling process.
- **NMR-Restraint MD Simulation**: Utilizes Amber to perform NMR-restraint-driven MD simulations, offering high fidelity in structure prediction.

## Key Features

- **Parallel Computing**: Leverages GNU Parallel for restraint calculations, enabling an 8x speed-up for large datasets.
- **GPU-Accelerated MD**: Supports GPU acceleration via PMEMD.CUDA for Amber users with appropriate licenses, significantly improving simulation efficiency.

## Applications

The workflow has been successfully applied in the determination of DNA-ligand and dsDNA structures in a chemical biology lab setting. It is well-documented and primed for future refactoring, with potential for integration into tools such as AmberTools, Python-based scripts, or NMR software for broader applications.

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

## Contributing

Feel free to submit issues, bug reports, or pull requests. Contributions are welcome to help improve the workflow, add features, or refactor code for broader applications.


## License

(Include license information here)
