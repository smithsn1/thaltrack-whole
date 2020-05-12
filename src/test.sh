#!/bin/bash

# FSL Setup
FSLDIR=/usr/local/fsl5
PATH=${FSLDIR}/bin:${PATH}
export FSLDIR PATH
. ${FSLDIR}/etc/fslconf/fsl.sh

# Freesurfer
export FREESURFER_HOME=/usr/local/freesurfer
. $FREESURFER_HOME/SetUpFreeSurfer.sh


src_dir=/repo/thaltrack-whole/src
export PATH=${src_dir}:$PATH

pipeline.sh \
--fs_subject_dir ${src_dir}/testdir/assessors/freesurfer/SUBJECT \
--fs_nii_thalamus_niigz ${src_dir}/testdir/assessors/freesurfer/NII_THALAMUS/ThalamicNuclei.v10.T1.FSvoxelSpace.nii.gz \
--b0mean_niigz ${src_dir}/testdir/assessors/dwipre/B0_MEAN/b0_mean.nii.gz \
--out_dir ${src_dir}/testdir/OUTPUTS
