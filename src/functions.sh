#!/bin/bash
#
# Support functions


# Split a single ROI mask from a multi-ROI image
function split_roi () {
	in_niigz="${1}"
	val="${2}"
	
	out_niigz=$( basename "${in_niigz}" .nii.gz )_"${val}"
	fslmaths "${in_niigz}" -thr "${val}" -uthr "${val}" -bin "${out_niigz}"
}


# Join multiple ROI masks into a single one
function join_rois () {
	in_niigz="${1}"
	out_niigz="${2}"
	vals="${3}"
	
	addstr=""
	for v in $vals ; do
		fstr=$( basename ${in_niigz} .nii.gz)_"${v}"
		addstr="${addstr} -add ${fstr}"
	done
	fslmaths "${in_niigz}" -thr 0 -uthr 0 ${addstr} -bin "${out_niigz}"
}


# Probtrack
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
		--dir="${out_dir}"/"${roi_from}"_2_"${roi_to}" \
		${trackopts}

}

