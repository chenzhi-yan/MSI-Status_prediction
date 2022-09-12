rm(list = ls())   
options()$repos 
options()$BioC_mirror
options(BioC_mirror="https://mirrors.ustc.edu.cn/bioc/")
options("repos" = c(CRAN="https://mirrors.tuna.tsinghua.edu.cn/CRAN/"))
options()$repos 
options()$BioC_mirror

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("KEGG.db",ask = F,update = F)
#BiocManager::install("minfi",ask = F,update = F)
BiocManager::install("ChAMP",ask = F,update = F)
#BiocManager::install("methylationArrayAnalysis",ask = F,update = F) 
#BiocManager::install("wateRmelon",ask = F,update = F) 
#BiocManager::install("ChAMPdata",ask = F,update = F)
BiocManager::install("Illumina450ProbeVariants.db",ask = F,update = F)

BiocManager::install("shiny",ask = F,update = F,force = TRUE)
#BiocManager::install(c("minfi","ChAMPdata","Illumina450ProbeVariants.db","sva","IlluminaHumanMethylation450kmanifest","limma","RPMM","DNAcopy","preprocessCore","impute","marray","wateRmelon","goseq","plyr","GenomicRanges","RefFreeEWAS","qvalue","isva","doParallel","bumphunter","quadprog","shiny","shinythemes","plotly","RColorBrewer","DMRcate","dendextend","IlluminaHumanMethylationEPICmanifest","FEM","matrixStats","missMethyl","combinat"),ask = F,update = F)


BiocManager::install(c("GSEABase","GSVA","clusterProfiler" ),ask = F,update = F)
BiocManager::install(c("GEOquery","limma","impute" ),ask = F,update = F)
BiocManager::install(c("org.Hs.eg.db","hgu133plus2.db" ),ask = F,update = F)

options()$repos
#install.packages('WGCNA')
install.packages(c("FactoMineR", "factoextra"))
install.packages(c("ggplot2", "pheatmap","ggpubr"))