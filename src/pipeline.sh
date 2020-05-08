#!/bin/bash
#
# Main pipeline

# Initialize defaults (will be changed later if passed as options)
default=""

# Parse options
while [[ $# -gt 0 ]]
do
  key="$1"
  case $key in
    --project)
        export project="$2"; shift; shift ;;
    --subject)
        export subject="$2"; shift; shift ;;
    --session)
        export session="$2"; shift; shift ;;
    --scan)
        export scan="$2"; shift; shift ;;
    --fs_subject_dir)
        export fs_subject_dir="$2"; shift; shift ;;
    --fs_nii_thalamus_niigz)
        export fs_nii_thalamus_niigz="$2"; shift; shift ;;
    --out_dir)
        export out_dir="$2"; shift; shift ;;
    *)
        shift ;;
  esac
done

# Inputs report
echo "${project} ${subject} ${session} ${scan}"
echo "fs_subject_dir:          ${fs_subject_dir}"
echo "fs_nii_thalamus_niigz:   ${fs_nii_thalamus_niigz}"
echo "out_dir:                 ${out_dir}"



### EXTRACT CORTICAL REGIONS FROM FREESURFER DKT ATLAS
make_fs_rois.sh

