rm(list = ls())
options(stringsAsFactors = F)

require(GEOquery)
require(Biobase)
library("impute")
library(data.table)
library(ChAMP)

# Import msi.txt file
msi=read.table("./data/All_msi.txt",sep="\t",header=T) 
rownames(msi)=msi[,1] #The row name takes the value of the first column

All_data=fread("./data/All_data.txt",data.table = F )
rownames(All_data)=All_data[,1] 
All_data=All_data[,-1] 
All_data=as.matrix(All_data)# Convert All_data to matrix

# It must be ensured that the methylation signal value matrix, 
# and the MSI information, are in one-to-one correspondence
identical(colnames(All_data),rownames(msi))


# There cannot be NA values in the beta signal value matrix
myLoad=champ.filter(beta = All_data,pd = msi)
myLoad
FilterData <- myLoad$beta
write.table(FilterData,file ="../../data/All_FilterData.csv", sep =",", row.names =TRUE, col.names =TRUE, quote =TRUE)

