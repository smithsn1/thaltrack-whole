#!/bin/bash
#
### TRACTOGRAPHY - FREESURFER THALAMUS TO FREESURFER CORTICAL MASKS

echo Running ${0}


# Probtrack function for single ROI
function track () {
	trackopts="${1}"
	bedpost_dir="${2}"
	roi_dir="${3}"
	out_dir="${4}"
	roi_from="${5}"
	roi_to="${6}"

	probtrackx2 \
		-s "${bedpost_dir}"/merged \
		-m "${bedpost_dir}"/nodif_brain_mask \
		-x "${roi_dir}"/"${roi_from}" \
		--targetmasks="${roi_dir}"/"${roi_to}" \
		--stop="${roi_dir}"/"${roi_to}" \
		--avoid="${roi_dir}"/"${roi_to}"_AVOID \
		--dir="${out_dir}"/"${roi_from}"_to_"${roi_to}" \
		${trackopts}

}


# Options for all tracking
trackopts="-l --onewaycondition --verbose=1 --forcedir --modeuler --pd --os2t --s2tastext --opd --ompl"


# Thalamus to individual cortical regions
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


# Set up for multiple targets
cd "${out_dir}"/OUTPUTS_FS6
cp "${targets_dir}"/TARGETS_FS6_?.txt .

# L thalamus to L multiple targets
probtrackx2 \
	-s "${bedpost_dir}"/merged \
	-m "${bedpost_dir}"/nodif_brain_mask \
	-x "${rois_dwi_dir}"/FS_THALAMUS_L \
	--targetmasks=TARGETS_FS6_L.txt \
	--stop="${rois_dwi_dir}"/FS_LHCORTEX_STOP \
	--avoid="${rois_dwi_dir}"/FS_RH_AVOID \
	--dir=FS_THALAMUS_L_to_TARGETS_L \
	${trackopts}

# R thalamus to R multiple targets
probtrackx2 \
	-s "${bedpost_dir}"/merged \
	-m "${bedpost_dir}"/nodif_brain_mask \
	-x "${rois_dwi_dir}"/FS_THALAMUS_R \
	--targetmasks=TARGETS_FS6_R.txt \
	--stop="${rois_dwi_dir}"/FS_RHCORTEX_STOP \
	--avoid="${rois_dwi_dir}"/FS_LH_AVOID \
	--dir=FS_THALAMUS_R_to_TARGETS_R \
	${trackopts}

