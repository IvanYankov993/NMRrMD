#!/bin/bash

# Declare variable names
NamePA="${PA:-iPr}"  # Default to iPr if PA is not set
NameDNA="${DNA:-GTAC}"  # Default to GTAC if DNA is not set

WFPATH=$(pwd)  
runN="0"
scr="${WFPATH}/scripts_in/"
inp="${WFPATH}/inp/${NameDNA}_${NamePA}_inp/"
NamePA_PA="${NamePA}_PA"

var_path="${scr}Mardigras_programs/"
cd "$var_path" || { echo "Failed to change directory to $var_path"; exit 1; }
files=$(ls)  # Collect mardigras_programs files for later use
cd "$WFPATH" || { echo "Failed to change directory to $WFPATH"; exit 1; }

################### options ###############################
# CHIMERA distance Visualization
# Recycling or single run
# Single run
# Analysis (Final Structure, 3DNA, PA dihedrals - Violin Plots)
# Distance Check (R2 and RMSD)
###########################################################

###########################################################
# Check for whether the input directory DNA_PA_inp exists e.g. 
# Demo run uses GTAC_iPr_inp: 
# PA.frcmod ; PA.lib ; DNA_PA_starting.pdb ; DNA_PA_corma.pdb
# Mardi: 
# .PARM ; filter.list ; pseudo.list ; .INT1
# Add else false stop scripts not a directory please prepare files
if [ -d "$inp" ]; then
    echo "$inp is a directory."
else
    echo "$inp must be a directory."
    exit 1
fi
###########################################################

###########################################################
# Check for the existence of required files
required_files=(
    "${inp}${NamePA}.frcmod"
    "${inp}${NamePA}.lib"
    "${inp}${NameDNA}_${NamePA}_starting.pdb"
    "${inp}${NameDNA}_${NamePA}_corma.pdb"
    "${inp}filter.list"
    "${inp}pseudo.list"
)

for file in "${required_files[@]}"; do
    if [ ! -f "$file" ]; then
        echo "Required file $file does not exist."
        exit 1
    fi
done

# Check for any files with .INT1 extensions

if ! ls "${inp}"*.INT1 1> /dev/null 2>&1; then
    echo "No .INT1 files found in ${inp}"
    exit 1
fi
###########################################################

###########################################################
# Print into a log file
# Check if variables are correctly inserted and substituted in ref all commands.txt
log_file="${WFPATH}/NMR_MD_IY.log"
if [ -f "$log_file" ]; then
    echo "$log_file exists."
else
    echo -e "Log file\n" > "$log_file"
    echo "$log_file created"
fi

{
    echo -e "$(date)\n"
    echo "Check PA ${PA} is ${NamePA}"
    echo "Check dsDNA ${dsDNA} is ${NameDNA}"
    echo "Check Name_PA iPr_PA to ${NamePA_PA}"
    echo "Check NameDNA_NamePA GTAC_iPr to ${NameDNA}_${NamePA}"
    echo "Check WFPATH = ${WFPATH}"
    echo "Check runN = ${runN}"
    echo "Check scr = ${scr}"
    echo "Check inp = ${inp}"
    echo "Check var_path = ${var_path}"
    echo "Check files = ${files}"
} >> "$log_file"
###########################################################

################### CHECK FOR AMBER #######################
if command -v pmemd.cuda &> /dev/null; then
    echo "pmemd.cuda exists. Running GPU accelerated AMBER CODE"
    echo "pmemd.cuda exists. Running GPU accelerated AMBER CODE" >> "$log_file"
    AmberRun=pmemd.cuda
elif command -v sander &> /dev/null; then
    echo "sander exists. Running CPU AMBER CODE"
    echo "sander exists. Running CPU AMBER CODE" >> "$log_file"
    AmberRun=sander
else
    echo "Please, install Amber or load module Amber/Intel-21.0"
    echo "Please, install Amber or load module Amber/Intel-21.0" >> "$log_file"
    exit 1
fi
###########################################################

# Request the following input files INT1. pseudo.inp, filter.list, start.pdb corma.pdb, wc.txt (optional), PA.lib PA.frcmod 
# if free dna skip pa.lib and pa.frcmod

# Export every global variable so it can be used in following scripts
export NameDNA NamePA NamePA_PA runN WFPATH scr inp AmberRun var_path files

# Source necessary library scripts
source Library_tleap.sh
source Library_cpptraj.sh
source Library_MD.sh
source Library_T17.sh
source Library_toggle_scripts.sh

################## Building work directories ################## 
worktree    # request_input non
            # required variables WFPATH DNA PA and runN
            # make dir (DP/RunN/MDPrep;Mardi)          
            # return DP               

# Update single functions with run) to run$(runN_current) 
# In all cases will be default 0 but in recycling then we can make use of the functions

# Run the main workflow steps
mardigras_calculations
confsampling
annealing
production
run0_analysis

# Uncomment and use these functions as needed
# singlerun
# recycling
# analysis
# fin_str_and_analysis_rest_and_unrest