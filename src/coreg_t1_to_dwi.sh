#!/bin/bash
#
# Coregister T1 (nu.mgz) to dwi

cd testdir 


epi_reg \
	--epi=b0_mean \
	--t1=nu \
	--t1brain=norm \
	--out=rdwi 
	
exit 0


# Binarize and dilate aparc for inweight
fslmaths aparc.DKTatlas+aseg -bin -dilM -dilM -dilM -bin in_mask

# Same for refweight
fslmaths b0_mask -bin -dilM -dilM -dilM -bin ref_mask


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

cd ~-
