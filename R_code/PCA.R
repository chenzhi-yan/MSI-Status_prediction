# After load-data.R
rm(list = ls())   
options(stringsAsFactors = F)
library("ChAMP")
library("minfi")
require(GEOquery)
require(Biobase)
load(file = 'load-data.Rdata')
myLoad
myNorm <- myLoad$beta
pD=myLoad$pd #Sample + MSI

beta.m=myNorm
group_list=myLoad$pd #MSI
dim(beta.m) 

dat=t(beta.m)# Convert rows and columns, behavior samples, columns as probes
dat[1:4,1:4]
# To draw a principal component analysis diagram, you need to load these two packages
library("FactoMineR")# This package is used for analysis
library("factoextra")# This package is used for visualization

dat.pca <- PCA(dat , graph = FALSE)

ind.p <- fviz_pca_ind(dat.pca,
                      axes = c(1,2),
                      geom.ind = "point", # show points only (nbut not "text")
                      col.ind = group_list, # color by groups
                      palette = c("#00AFBB", "#E7B800"),
                      addEllipses = TRUE, # Concentration ellipses
                      legend.title = "Group" # Category legend name
)
ggpubr::ggpar(ind.p, title = "Principal Component Analysis",
              caption = "Source: factoextra",
              font.tickslab = 20,
              font.title = 20,
              font.x = 15,font.y = 15,
              font.legend = 15,
              legend.title = "Group", legend.position = "top",
              ggtheme = theme_gray(), palette = "jco")


ggsave('./pic/all_samples_PCA.png')
