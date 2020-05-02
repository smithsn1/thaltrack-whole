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
