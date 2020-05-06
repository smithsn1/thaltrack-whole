#!/bin/bash
#
### EXTRACT CORTICAL REGIONS FROM FREESURFER DKT ATLAS
### MAKE COMBINED FS_MASKS
### MAKE AVOID MASKS

#roi_dir=./TRACTOGRAPHY_WHOLE_THALAMUS/FS_2_FSL
roi_dir=testdir


# Set up
source functions.sh
roi_niigz=aparc.DKTatlas+aseg
cd "${roi_dir}"



# Create single-ROI masks for the needed ROIs, labeled by number
for v in \
	16 \
	7 8 \
	46 47 \
	11 12 13 \
	50 51 52 \
	17 18 \
	53 54 \
	1003 1017 1024 \
	2003 2017 2024 \
	1005 1011 1013 1021 \
	2005 2011 2013 2021 \
	1002 1012 1014 1018 1019 1020 1026 1027 1028 \
	2002 2012 2014 2018 2019 2020 2026 2027 2028 \
	1008 1025 1029 1010 1023 1031 \
	2008 2025 2029 2010 2023 2031 \
	1022 \
	2022 \
	1006 1007 1009 1015 1016 1030 1034 \
	2006 2007 2009 2015 2016 2030 2034 \
	1012 1014 1028 \
	2012 2014 2028 \
	1018 1019 1020 1027 \
	2018 2019 2020 2027 \
	1002 1026 \
	2002 2026 \
	1008 1025 1029 \
	2008 2025 2029 \
	1010 1031 \
	2010 2031 \
	1030 1034 \
	2030 2034 \
	1006 1007 1009 1015 1016 \
	2006 2007 2009 2015 2016 \
; do
	split_roi "${roi_niigz}" $v
done



# Re-join into the needed single-ROI masks, labeled by name
join_rois "${roi_niigz}"   	FS_BRAINSTEM          "16"

join_rois "${roi_niigz}"   	FS_CEREBELLUM_L       "7 8"
join_rois "${roi_niigz}"   	FS_CEREBELLUM_R       "46 47"

join_rois "${roi_niigz}"   	FS_CAUD_PUT_PALL_L    "11 12 13"
join_rois "${roi_niigz}"   	FS_CAUD_PUT_PALL_R    "50 51 52"

join_rois "${roi_niigz}"   	FS_AMYG_HIPP_L        "17 18"
join_rois "${roi_niigz}"   	FS_AMYG_HIPP_R        "53 54"
	
join_rois "${roi_niigz}"   FS_MOTOR_L     "1003 1017 1024"
join_rois "${roi_niigz}"   FS_MOTOR_R     "2003 2017 2024"

join_rois "${roi_niigz}"   FS_OCC_L       "1005 1011 1013 1021"
join_rois "${roi_niigz}"   FS_OCC_R       "2005 2011 2013 2021"

join_rois "${roi_niigz}"   FS_PFC_L       "1002 1012 1014 1018 1019 1020 1026 1027 1028"
join_rois "${roi_niigz}"   FS_PFC_R       "2002 2012 2014 2018 2019 2020 2026 2027 2028"

join_rois "${roi_niigz}"   FS_POSTPAR_L   "1008 1025 1029 1010 1023 1031"
join_rois "${roi_niigz}"   FS_POSTPAR_R   "2008 2025 2029 2010 2023 2031"

join_rois "${roi_niigz}"   FS_SOMATO_L    "1022"
join_rois "${roi_niigz}"   FS_SOMATO_R    "2022"

join_rois "${roi_niigz}"   FS_TEMP_L      "1006 1007 1009 1015 1016 1030 1034"
join_rois "${roi_niigz}"   FS_TEMP_R      "2006 2007 2009 2015 2016 2030 2034"

join_rois "${roi_niigz}"   FS_MOFC_L      "1012 1014 1028"
join_rois "${roi_niigz}"   FS_MOFC_R      "2012 2014 2028"

join_rois "${roi_niigz}"   FS_LPFC_L      "1018 1019 1020 1027"
join_rois "${roi_niigz}"   FS_LPFC_R      "2018 2019 2020 2027"

join_rois "${roi_niigz}"   FS_ACC_L       "1002 1026"
join_rois "${roi_niigz}"   FS_ACC_R       "2002 2026"

join_rois "${roi_niigz}"   FS_PPC_L       "1008 1025 1029"
join_rois "${roi_niigz}"   FS_PPC_R       "2008 2025 2029"

join_rois "${roi_niigz}"   FS_PARDMN_L    "1010 1031"
join_rois "${roi_niigz}"   FS_PARDMN_R    "2010 2031"

join_rois "${roi_niigz}"   FS_AUD_L       "1030 1034"
join_rois "${roi_niigz}"   FS_AUD_R       "2030 2034"

join_rois "${roi_niigz}"   FS_ITEMP_L     "1006 1007 1009 1015 1016"
join_rois "${roi_niigz}"   FS_ITEMP_R     "2006 2007 2009 2015 2016"



# Create 6- and 10-ROI single-image sets

# 6-ROI
fslmaths FS_PFC_L     -add FS_PFC_R       -mul 1             tmp
fslmaths FS_MOTOR_L   -add FS_MOTOR_R     -mul 2  -add tmp   tmp
fslmaths FS_SOMATO_L  -add FS_SOMATO_R    -mul 3  -add tmp   tmp
fslmaths FS_POSTPAR_L -add FS_POSTPAR_R   -mul 4  -add tmp   tmp
fslmaths FS_OCC_L      -add FS_OCC_R      -mul 5  -add tmp   tmp
fslmaths FS_TEMP_L    -add FS_TEMP_R      -mul 6  -add tmp   tmp
mv tmp.nii.gz FS_6MASKS.nii.gz

# 10-ROI
fslmaths FS_MOFC_L    -add FS_MOFC_R     -mul 1              tmp
fslmaths FS_LPFC_L    -add FS_LPFC_R     -mul 2   -add tmp   tmp
fslmaths FS_ACC_L     -add FS_ACC_R      -mul 3   -add tmp   tmp
fslmaths FS_PPC_L     -add FS_PPC_R      -mul 4   -add tmp   tmp
fslmaths FS_PARDMN_L  -add FS_PARDMN_R   -mul 5   -add tmp   tmp
fslmaths FS_AUD_L     -add FS_AUD_R      -mul 6   -add tmp   tmp
fslmaths FS_ITEMP_L   -add FS_ITEMP_R    -mul 7   -add tmp   tmp
fslmaths FS_MOTOR_L   -add FS_MOTOR_R    -mul 8   -add tmp   tmp
fslmaths FS_SOMATO_L  -add FS_SOMATO_R   -mul 9   -add tmp   tmp
fslmaths FS_OCC_L     -add FS_OCC_R      -mul 10  -add tmp   tmp
mv tmp.nii.gz FS_10MASKS.nii.gz


# Subcortical mask
fslmaths \
	FS_BRAINSTEM \
	-add FS_CEREBELLUM_L    -add FS_CEREBELLUM_R \
	-add FS_CAUD_PUT_PALL_L -add FS_CAUD_PUT_PALL_R \
	-add FS_AMYG_HIPP_L     -add FS_AMYG_HIPP_R \
	-bin \
	FS_CEREBELLAR_SUBCORTICAL


# Whole brain gray matter mask
fslmaths FS_PFC_R -add FS_MOTOR_R -add FS_SOMATO_R -add FS_POSTPAR_R -add FS_OCC_R -add FS_TEMP_R \
	-add FS_PFC_L -add FS_MOTOR_L -add FS_SOMATO_L -add FS_POSTPAR_L -add FS_OCC_L -add FS_TEMP_L \
	tmp_gm

# Include white matter and subcortical to make avoid masks
fslmaths tmp_gm -add FS_WM_R -add FS_CEREBELLAR_SUBCORTICAL -bin FS_RH_LHCORTEX_AVOID
fslmaths tmp_gm -add FS_WM_L -add FS_CEREBELLAR_SUBCORTICAL -bin FS_LH_RHCORTEX_AVOID


