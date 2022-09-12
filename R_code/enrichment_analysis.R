rm(list = ls())
options(stringsAsFactors = F)

if(!requireNamespace('BiocManager',quietly = TRUE))
  install.packages('BiocManager')
if(!requireNamespace('methylGSA',quietly = TRUE))
  BiocManager::install('methylGSA')
library(methylGSA)

# 450K chip
library(IlluminaHumanMethylation450kanno.ilmn12.hg19)

info=read.table("./data/final_msi.csv",sep=",",header=T)
library(data.table)
b=info
rownames(b)=b[,1] #The row name takes the value of the first column

a=fread("./data/final_data.csv",data.table = F )
a[1:4,1:4]
rownames(a)=a[,1]
tmp = a
a=a[,-1] #remove the first column
a=as.matrix(a)#convert a to a matrix
 
identical(colnames(a),rownames(b))

if(!requireNamespace('ChAMP',quietly = TRUE))
  BiocManager::install("ChAMP",ask = F,update = F)
library(ChAMP)
# There cannot be NA values in the beta signal value matrix
myLoad=champ.filter(beta = a,pd = b)
myLoad
beta = myLoad$beta
myNorm = beta

group_list = myLoad$pd$Group #Classification label information
myDMP <- champ.DMP(beta=myNorm,pheno=group_list,adjPVal = 0.06) #Differential analysis of various results
gene_info <- myDMP[[1]] #myDMP[[1]] is a variety of differentiated data
# DMP.GUI()

adjpv <- gene_info[5]
adjv = as.vector(unlist(gene_info[5]))
names(adjv) <- rownames(gene_info)

# methylglm
#resGO = methylglm(cpg.pval = adjv, minsize = 200, maxsize = 500, GS.type = "GO")
#barplot(resGO, xaxis = "Size", num = 8, colorby = "padj",title = "methylglm-GO")#

#resKE = methylglm(cpg.pval = adjv, minsize = 200, maxsize = 500, GS.type = "KEGG")
#barplot(resKE, xaxis = "Size", num = 8, colorby = "padj",title = "methylglm-KEGG")


# methylRRA
resOR_GO = methylRRA(cpg.pval = adjv, method = "ORA",GS.type = "GO", minsize = 100, maxsize = 500)
resOR_KE = methylRRA(cpg.pval = adjv, method = "ORA",GS.type = "KEGG", minsize = 100, maxsize = 500)
barplot(resOR_GO, xaxis = "Size", num = 5, colorby = "padj",title = "methylRRA-GO")


barplot(resOR_KE, xaxis = "Size", num = 5, colorby = "padj",title = "methylRRA-KEGG")




write.table(resOR_GO,file = "./data/resOR_GO.csv",sep = ",")
write.table(resOR_KE,file = "./data/resOR_KE.csv",sep = ",")
write.table(gene_info,file = "./data/gene_info.csv",sep = ",",row.names = TRUE,col.names = TRUE)
