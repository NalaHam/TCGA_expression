if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("TCGAbiolinks")


library(TCGAbiolinks)
library(dplyr)

#COAD
clin <- GDCquery_clinic("TCGA-COAD", 
                        type = "clinical", 
                        save.csv = FALSE)

sum(clin$gender == "female", na.rm = TRUE) #216
sum(clin$gender == "male", na.rm = TRUE) #243



clin <- data.frame(clin$project, clin$submitter_id, clin$ajcc_pathologic_stage, 
                   clin$tissue_or_organ_of_origin, clin$primary_diagnosis, 
                   clin$ajcc_staging_system_edition, clin$ajcc_pathologic_t, 
                   clin$ajcc_pathologic_n, clin$icd_10_code, clin$site_of_resection_or_biopsy, 
                   clin$race, clin$gender, clin$vital_status, clin$age_at_index)


clin <- clin %>% 
  rename( 
    project = clin.project,
    patient_id = clin.submitter_id, 
    ajcc_pathologic_stage = clin.ajcc_pathologic_stage,
    tissue_or_organ_of_origin = clin.tissue_or_organ_of_origin,
    diagnosis = clin.primary_diagnosis, 
    ajcc_staging_system_edition = clin.ajcc_staging_system_edition, 
    ajcc_pathologic_t = clin.ajcc_pathologic_t, 
    ajcc_pathologic_n = clin.ajcc_pathologic_n, 
    icd_10_code = clin.icd_10_code,
    site_of_biopsy = clin.site_of_resection_or_biopsy, 
    race= clin.race, 
    gender = clin.gender, 
    vital_status = clin.vital_status,
    age = clin.age_at_index)

getDataCategorySummary("TCGA-COAD") #gives summary of data types associated with this project

COAD_omics <- getLinkedOmicsData("TCGA-COADREAD", "RNAseq (GA, Gene level)")

unique(clin$tissue_or_organ_of_origin)



colon.gtex <- TCGAquery_recount2(project = "gtex", tissue = "colon")

data_frame <- as.data.frame(do.call(cbind, colon.gtex))

gtex_rowRanges <- data.frame(gtex_rowRanges)

gtex_colData <- data.frame(gtex_colon_info@colData)



