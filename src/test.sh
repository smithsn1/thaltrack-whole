#!/bin/bash
source functions.sh

for v in 1003 1017 1024 ; do
	split_roi testdir aparc.DKTatlas+aseg.nii.gz $v
done


join_rois testdir aparc.DKTatlas+aseg.nii.gz roi.nii.gz "1003 1017 1024"
