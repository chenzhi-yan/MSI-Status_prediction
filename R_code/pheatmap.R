rm(list = ls())
options(stringsAsFactors = F)

if(!requireNamespace('pheatmap',quietly = TRUE))
 install.packages("pheatmap")
library(pheatmap)

if(!requireNamespace('showtext',quietly = TRUE))
 install.packages("showtext")
library(showtext)
#font_add("times","times.ttf")
showtext.auto()


library(data.table)
data = fread("./data/final_data.csv",data.table = F )
rownames(data) = data[,1]
data = data[,-1]


annotation_col <- read.csv("./data/final_msi.csv",header = T,row.names = 1)
annotation_col <- as.data.frame(annotation_col)
annotation_col <- data.frame(group=annotation_col)

pheatmap(data,
         annotation_col = annotation_col,
         cluster_rows = T,
         cluster_cols = F,
         show_colnames = F,
         show_rownames = F,
         fontsize_number = 15,
         fontsize = 20,
         legend_labels = 30,
         filename = "./pic/heatmap.png")

# Correlation of probes
# matrix <- cor(data[-1])
# pheatmap(matrix,show_colnames = F,show_rownames = F,filename = "probe_correlation.png")
