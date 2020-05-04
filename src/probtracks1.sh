#!/bin/bash
#
### TRACTOGRAPHY - FREESURFER THALAMUS TO FREESURFER CORTICAL MASKS

mask_dir="./TRACTOGRAPHY_WHOLE_THALAMUS/FS_2_FSL_2_DIFF"
out_dir="./TRACTOGRAPHY_WHOLE_THALAMUS/OUTPUT_FS6"

trackopts="-l --onewaycondition --verbose=1 --forcedir --modeuler --pd --os2t --s2tastext --opd --ompl"

trackcmd="track ${trackopts} ${bedpost_dir} ${mask_dir} ${out_dir}"

${trackcmd} FS_THALAMUS_L FS_PFC_L
${trackcmd} FS_THALAMUS_R FS_PFC_R

${trackcmd} FS_THALAMUS_L FS_MOTOR_L
${trackcmd} FS_THALAMUS_R FS_MOTOR_R

${trackcmd} FS_THALAMUS_L FS_SOMATO_L
${trackcmd} FS_THALAMUS_R FS_SOMATO_R

${trackcmd} FS_THALAMUS_L FS_POSTPAR_L
${trackcmd} FS_THALAMUS_R FS_POSTPAR_R

${trackcmd} FS_THALAMUS_L FS_OCC_L
${trackcmd} FS_THALAMUS_R FS_OCC_R

${trackcmd} FS_THALAMUS_L FS_TEMP_L
${trackcmd} FS_THALAMUS_R FS_TEMP_R



# L THALAMUS TO L TARGETS

probtrackx2 \
    -s "${bedpost_dir}"/merged \
    -m "${bedpost_dir}"/nodif_brain_mask \
    -x ./TRACTOGRAPHY_WHOLE_THALAMUS/FS_2_FSL_2_DIFF/FS_THALAMUS_L_2_b0_mean_brain_bin.nii.gz \
    --targetmasks=./TRACTOGRAPHY_WHOLE_THALAMUS/INPUTS/TARGETS_FS6_L.txt \
    --stop=./TRACTOGRAPHY_WHOLE_THALAMUS/FS_2_FSL_2_DIFF/FS_LHCORTEX_STOP.nii.gz \
    --avoid=./TRACTOGRAPHY_WHOLE_THALAMUS/FS_2_FSL_2_DIFF/FS_RH_AVOID.nii.gz \
    -l \
    --onewaycondition \
    --verbose=1 \
    --forcedir \
    --modeuler \
    --pd \
    --dir=./TRACTOGRAPHY_WHOLE_THALAMUS/OUTPUT_FS6/L_THALAMUS_2_L_TARGETS \
    --os2t \
    --s2tastext \
    --opd \
    --ompl

# R THALAMUS TO R TARGETS

probtrackx2 \
    -s ./BEDPOSTX/merged \
    -m ./BEDPOSTX/nodif_brain_mask \
    -x ./TRACTOGRAPHY_WHOLE_THALAMUS/FS_2_FSL_2_DIFF/FS_THALAMUS_R_2_b0_mean_brain_bin.nii.gz \
    --targetmasks=./TRACTOGRAPHY_WHOLE_THALAMUS/INPUTS/TARGETS_FS6_R.txt \
    --stop=./TRACTOGRAPHY_WHOLE_THALAMUS/FS_2_FSL_2_DIFF/FS_RHCORTEX_STOP.nii.gz \
    --avoid=./TRACTOGRAPHY_WHOLE_THALAMUS/FS_2_FSL_2_DIFF/FS_LH_AVOID.nii.gz \
    -l \
    --onewaycondition \
    --verbose=1 \
    --forcedir \
    --modeuler \
    --pd \
    --dir=./TRACTOGRAPHY_WHOLE_THALAMUS/OUTPUT_FS6/R_THALAMUS_2_R_TARGETS \
    --os2t \
    --s2tastext \
    --opd \
    --ompl
