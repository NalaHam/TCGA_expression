#EXPLORING AND DOWNLOADING USING RECOUNT PACKAGE

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("recount3")

library("recount")
library("recount3")
library("GenomicRanges")
library("limma")
library("edgeR")
library("DESeq2")
library("regionReport")
library("clusterProfiler")
library("org.Hs.eg.db")
library("gplots")
library("derfinder")
library("GenomicState")
library("bumphunter")
library("derfinderPlot")
library("sessioninfo")

projects <- available_projects("human") #all projects in the recount project. Inlcudes TCGA, GTEx, and SRA

unique(projects$file_source) #sra, tcga, gtex

tcga_projects <- subset(projects, projects$file_source == "tcga") #get only TCGA projects

gtex_projects <- subset(projects, projects$file_source == "gtex") #get only GTEx projects

gtex_colon_project <- subset(gtex_projects, gtex_projects$project == "COLON") #get the info for colon tissue from GTEx project

gtex_colon_rse <- create_rse(
  gtex_colon_project,
  type = "gene")             #create a RangedSummaryExperiment(rse) from GTEx colon tissue
                             #a rse inlcudes data on gene, exon, and exon-exon junction count matrices
                             #it also provides information about the expression features (for example gene IDs) and the samples.
                             #feature information is accessed with rowRanges(rse), the counts with assays(rse)$counts 
                             #and the sample metadata with colData(rse) 

dim(gtex_colon_rse) #number of genes by number of samples. 63856 genes x 822 samples


gtex_colon_genes <- rowRanges(gtex_colon_rse)

assays(gtex_colon_rse)$counts

gtex_metadata <- colData(gtex_colon_rse)
