rm(list = ls())
options(stringsAsFactors = F)

require(GEOquery)
require(Biobase)
library("impute")

info=read.csv("./data/final_msi.csv",header = T,row.names = 1)
b=info
# rownames(b)=b[,1]

library(data.table)
a = fread("./data/final_data.csv",data.table = F )
rownames(a) = a[,1] 
a = a[,-1]
beta=as.matrix(a)
a=beta
a[1:4,1:4] 
# It must be ensured that the methylation signal value matrix, 
# and the MSI information, are in one-to-one correspondence
identical(colnames(a),rownames(b))


library(ChAMP)
# There cannot be NA values in the beta signal value matrix
myLoad=champ.filter(beta = a,pd = b)
myLoad
save(myLoad,file = 'load-data.Rdata')

