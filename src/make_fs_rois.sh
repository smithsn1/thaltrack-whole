#!/bin/bash
#
### EXTRACT CORTICAL REGIONS FROM FREESURFER DKT ATLAS

roi_dir=./TRACTOGRAPHY_WHOLE_THALAMUS/FS_2_FSL
roi_niigz=aparc.DKTatlas+aseg

join_rois "${roi_dir}" "${roi_niigz}"   FS_MOTOR_L     "1003 1017 1024"
join_rois "${roi_dir}" "${roi_niigz}"   FS_MOTOR_R     "2003 2017 2024"

join_rois "${roi_dir}" "${roi_niigz}"   FS_OCC_L       "1005 1011 1013 1021"
join_rois "${roi_dir}" "${roi_niigz}"   FS_OCC_R       "2005 2011 2013 2021"

join_rois "${roi_dir}" "${roi_niigz}"   FS_PFC_L       "1002 1012 1014 1018 1019 1020 1026 1027 1028"
join_rois "${roi_dir}" "${roi_niigz}"   FS_PFC_R       "2002 2012 2014 2018 2019 2020 2026 2027 2028"

join_rois "${roi_dir}" "${roi_niigz}"   FS_POSTPAR_L   "1008 1025 1029 1010 1023 1031"
join_rois "${roi_dir}" "${roi_niigz}"   FS_POSTPAR_R   "2008 2025 2029 2010 2023 2031"

join_rois "${roi_dir}" "${roi_niigz}"   FS_SOMATO_L    "1022"
join_rois "${roi_dir}" "${roi_niigz}"   FS_SOMATO_R    "2022"

join_rois "${roi_dir}" "${roi_niigz}"   FS_TEMP_L      "1006 1007 1009 1015 1016 1030 1034"
join_rois "${roi_dir}" "${roi_niigz}"   FS_TEMP_R      "2006 2007 2009 2015 2016 2030 2034"

join_rois "${roi_dir}" "${roi_niigz}"   FS_MOFC_L      "1012 1014 1028"
join_rois "${roi_dir}" "${roi_niigz}"   FS_MOFC_R      "2012 2014 2028"

join_rois "${roi_dir}" "${roi_niigz}"   FS_LPFC_L      "1018 1019 1020 1027"
join_rois "${roi_dir}" "${roi_niigz}"   FS_LPFC_R      "2018 2019 2020 2027"

join_rois "${roi_dir}" "${roi_niigz}"   FS_ACC_L       "1002 1026"
join_rois "${roi_dir}" "${roi_niigz}"   FS_ACC_R       "2002 2026"

join_rois "${roi_dir}" "${roi_niigz}"   FS_PPC_L       "1008 1025 1029"
join_rois "${roi_dir}" "${roi_niigz}"   FS_PPC_R       "2008 2025 2029"

join_rois "${roi_dir}" "${roi_niigz}"   FS_PARDMN_L    "1010 1031"
join_rois "${roi_dir}" "${roi_niigz}"   FS_PARDMN_R    "2010 2031"

join_rois "${roi_dir}" "${roi_niigz}"   FS_AUD_L       "1030 1034"
join_rois "${roi_dir}" "${roi_niigz}"   FS_AUD_R       "2030 2034"

join_rois "${roi_dir}" "${roi_niigz}"   FS_ITEMP_L     "1006 1007 1009 1015 1016"
join_rois "${roi_dir}" "${roi_niigz}"   FS_ITEMP_R     "2006 2007 2009 2015 2016"


