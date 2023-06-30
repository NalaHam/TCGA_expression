#Expression Data

#transform omic data so that the rows and columns are switched. Right now rows are genes and columns are sample IDs.
#I want rows to be sample IDs and columns to be genes

#rename column names from attrib_name to gene_name and TCGA.A6.2670 to TCGA-A6-2670
names(COAD_omics)[1] <- 'gene_name'  #change attrib_name to gene_name
names(COAD_omics) <- gsub(".", "-", names(COAD_omics), fixed=TRUE) #change TCGA.A6.2670 to TCGA-A6-2670

df_3 <- t(COAD_omics) #transpose omics data

colnames(df_3) <- df_3[1,] #rename columns to be genes

df_3 <- df_3[-1,] #remove first row because columns are now the genes

df_3 <- data.frame(df_3)

patient_ids <- colnames(COAD_omics[,2:265]) #make a list of all the patient ids from omics data

df_3$patient_id <- patient_ids #add in patient id info into new df

df_3 <- df_3[,c(20502,1:20501)]

#Merging clinical data and omics

COAD_expressions <- merge(clin, df_3, by = "patient_id")

