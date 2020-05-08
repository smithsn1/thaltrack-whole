#!/bin/bash
#
### TRACTOGRAPHY - FREESURFER THALAMUS TO FREESURFER CORTICAL MASKS

trackopts="-l --onewaycondition --verbose=1 --forcedir --modeuler --pd --os2t --s2tastext --opd --ompl"


# Thalamus to cortical regions
trackcmd="track ${trackopts} ${bedpost_dir} ${rois_dwi_dir} ${out_dir}/OUTPUT_FS6"
for region in \
  FS_PFC \
  FS_MOTOR \
  FS_SOMATO \
  FS_POSTPAR \
  FS_OCC \
  FS_TEMP \
do
	${trackcmd} FS_THALAMUS_L ${region}_L
	${trackcmd} FS_THALAMUS_R ${region}_R
done



# L thalamus to L multiple targets

cat > "${out_dir}"/OUTPUTS_FS6/TARGETS_L.txt <<HERE
"${rois_dwi_dir}"/FS_PFC_L
"${rois_dwi_dir}"/FS_MOTOR_L
"${rois_dwi_dir}"/FS_SOMATO_L
"${rois_dwi_dir}"/FS_POSTPAR_L
"${rois_dwi_dir}"/FS_OCC_L
"${rois_dwi_dir}"/FS_TEMP_L
HERE

probtrackx2 \
	-s "${bedpost_dir}"/merged \
	-m "${bedpost_dir}"/nodif_brain_mask \
	-x "${rois_dwi_dir}"/FS_THALAMUS_L \
	--targetmasks="${out_dir}"/OUTPUTS_FS6/TARGETS_L.txt \
	--stop="${rois_dwi_dir}"/FS_LHCORTEX_STOP \
	--avoid="${rois_dwi_dir}"/FS_RH_AVOID \
	--dir="${out_dir}"/OUTPUT_FS6/FS_THALAMUS_L_to_TARGETS_L \
	${trackopts}


# R thalamus to R multiple targets

cat > "${out_dir}"/OUTPUTS_FS6/TARGETS_R.txt <<HERE
"${rois_dwi_dir}"/FS_PFC_R
"${rois_dwi_dir}"/FS_MOTOR_R
"${rois_dwi_dir}"/FS_SOMATO_R
"${rois_dwi_dir}"/FS_POSTPAR_R
"${rois_dwi_dir}"/FS_OCC_R
"${rois_dwi_dir}"/FS_TEMP_R
HERE

probtrackx2 \
	-s "${bedpost_dir}"/merged \
	-m "${bedpost_dir}"/nodif_brain_mask \
	-x "${rois_dwi_dir}"/FS_THALAMUS_R \
	--targetmasks="${out_dir}"/OUTPUTS_FS6/TARGETS_R.txt \
	--stop="${rois_dwi_dir}"/FS_RHCORTEX_STOP \
	--avoid="${rois_dwi_dir}"/FS_LH_AVOID \
	--dir="${out_dir}"/OUTPUT_FS6/FS_THALAMUS_R_to_TARGETS_R \
	${trackopts}

