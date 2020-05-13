#!/bin/bash
#
# Coregister T1 (nu.mgz) to dwi

echo Running ${0}

cd "${out_dir}"

# Get input files
cp "${fs_subject_dir}"/mri/{norm,nu}.mgz .
mri_convert nu.mgz nu.nii.gz
mri_convert norm.mgz norm.nii.gz

cp "${b0mean_niigz}" ./b0_mean.nii.gz

epi_reg \
	--epi=b0_mean \
	--t1=nu \
	--t1brain=norm \
	--out=rdwi
	
exit 0

# CREATE FREESURFER TO B0 XFORM
convert_xfm \
	-omat norm_2_b0_mean.mat \
	-inverse rdwi.mat


# COREG FREESURFER NORM BRAIN TO B0
flirt \
	-in norm \
	-ref b0_mean \
	-out norm_2_b0_mean.nii.gz \
	-applyxfm \
	-init norm_2_b0_mean.mat \
	-interp trilinear

# COREG DKT ATLAS TO B0
flirt \
	-in aparc.DKTatlas+aseg.nii.gz \
	-applyxfm \
	-init norm_2_b0_mean.mat \
	-out aparc.DKTatlas+aseg_2_b0_mean.nii.gz \
	-paddingsize 0.0 \
	-interp nearestneighbour \
	-ref b0_mean
	
# COREG THALAMUS TO B0
flirt \
	-in ThalamicNuclei.v10.T1.FSvoxelSpace.nii.gz \
	-applyxfm \
	-init norm_2_b0_mean.mat \
	-out ThalamicNuclei.v10.T1.FSvoxelSpace_2_b0_mean.nii.gz \
	-paddingsize 0.0 \
	-interp nearestneighbour \
	-ref b0_mean




# Alternate approach:

# Binarize and dilate aparc for inweight
fslmaths aparc.DKTatlas+aseg -bin -dilM -dilM -dilM -dilM -dilM -bin in_mask

# Same for refweight
fslmaths b0_mask -bin -dilM -dilM -bin ref_mask

# Register
flirt \
	-in nu \
	-inweight in_mask \
	-ref b0_mean \
	-refweight ref_mask \
	-omat fs_to_dwi.mat \
	-out rnu \
	-bins 256 \
	-cost corratio \
	-dof 6
