#!/bin/bash
#
# Support functions


# Split a single ROI mask from a multi-ROI image
function split_roi () {
	in_niigz="${1}"
	val="${2}"
	
	out_niigz=$( basename "${in_niigz}" .nii.gz )_"${val}".nii.gz
	fslmaths "${in_niigz}" -thr "${val}" -uthr "${val}" -bin "${out_niigz}"
}


# Join multiple ROI masks into a single one
function join_rois () {
	in_niigz="${1}"
	out_niigz="${2}"
	vals="${3}"
	
	addstr=""
	for v in $vals ; do
		fstr=$( basename ${in_niigz} .nii.gz)_"${v}".nii.gz
		addstr="${addstr} -add ${fstr}"
	done
	fslmaths "${in_niigz}" -thr 0 -uthr 0 ${addstr} -bin "${out_niigz}"
}


# Probtrack
function track () {
	trackopts=$"{1}"
	bedpost_dir="${2}"
	mask_dir="${3}"
	out_dir="${4}"
	roi_from="${5}"
	roi_to="${6}"

	probtrackx2 \
		-s "${bedpost_dir}"/merged \
		-m "${bedpost_dir}"/nodif_brain_mask \
		-x "${mask_dir}"/"${roi_from}"_2_b0_mean_brain_bin.nii.gz \
 	   --targetmasks="${mask_dir}"/"${roi_to}"_2_b0_mean_brain_bin.nii.gz \
		--stop="${mask_dir}"/"${roi_to}"_2_b0_mean_brain_bin.nii.gz \
		--avoid="${mask_dir}"/"${roi_to}"_AVOID.nii.gz \
		--dir="${out_dir}"/"${roi_from}"_2_"${roi_to}" \
		${trackopts}
 	   -l \
 	   --onewaycondition \
		--verbose=1 \
		--forcedir \
		--modeuler \
		--pd \
		--os2t \
		--s2tastext \
		--opd \
		--ompl

}

