#!/bin/bash
#
# Support functions

# Split a single ROI mask from a multi-ROI image
function split_roi () {
	roi_dir="${1}"
	in_niigz="${2}"
	val="${3}"
	
	cd "${roi_dir}"
	out_niigz=$( basename "${in_niigz}" .nii.gz )_"${val}".nii.gz
	fslmaths "${in_niigz}" -thr "${val}" -uthr "${val}" -bin "${out_niigz}"
	cd -
}

# Join multiple ROI masks into a single one
function join_rois () {
	roi_dir="${1}"
	in_niigz="${2}"
	out_niigz="${3}"
	vals="${4}"
	
	cd "${roi_dir}"
	addstr=""
	for v in $vals ; do
		fstr=$( basename ${in_niigz} .nii.gz)_"${v}".nii.gz
		addstr="${addstr} -add ${fstr}"
	done
	fslmaths "${in_niigz}" -thr 0 -uthr 0 ${addstr} -bin "${out_niigz}"
	cd -
}
