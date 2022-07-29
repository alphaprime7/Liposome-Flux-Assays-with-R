#Set my working directory
setwd("~/Flux Assay DBFs")

#Load the package needed for dbf files
library(foreign)


#Read dbf files
navab218 = read.dbf('218.dbf', as.is = FALSE)
navab221 = read.dbf('221.dbf', as.is = FALSE)
navab227 = read.dbf('227.dbf', as.is = FALSE)

#Write dbf files to csv files for rearrangement in excel. I could do this in R but choose not to
write.csv (navab218, file = 'navab218.csv', row.names = FALSE)
write.csv (navab221, file = 'navab221.csv', row.names = FALSE)
write.csv (navab227, file = 'navab227.csv', row.names = FALSE)

#Read transposed csv files into R for normalization
navab218csv = read.csv('navab218.csv', as.is = FALSE)
navab221csv = read.csv('navab221.csv', as.is = FALSE)
navab227csv = read.csv('navab227.csv', as.is = FALSE)

#Read normalized data with adj time to remove 0 seconds from time points
navab218_norm1 = read.csv('navab218_norm.csv', as.is = FALSE)
navab221_norm1 = read.csv('navab221_norm.csv', as.is = FALSE)
navab227_norm1 = read.csv('navab227_norm.csv', as.is = FALSE)

#define Min-Max normalization function in R (Taken from online)
min_max_norm <- function(x) {
  (x - min(x)) / (max(x) - min(x))
}

#apply Min-Max normalization to my data sets:I notice that i start them from col 3(green numbers)
navab218_norm <- as.data.frame(lapply(navab218csv[3:11], min_max_norm))
navab221_norm <- as.data.frame(lapply(navab221csv[3:38], min_max_norm))
navab227_norm <- as.data.frame(lapply(navab227csv[3:29], min_max_norm))

#view first six rows of normalized flux assay data sets
head(navab218_norm)
head(navab221_norm)
head(navab227_norm)

#Add the dropped column
navab218_norm$WELLNUM <- navab218csv$WELLNUM
navab218_norm$Time <- navab218csv$Time
navab221_norm$WELLNUM <- navab221csv$WELLNUM
navab221_norm$Time <- navab221csv$Time
navab227_norm$WELLNUM <- navab227csv$WELLNUM
navab227_norm$Time <- navab227csv$Time

#Save the workspace to ensure not losing this work on data cleanup
save.image("~/Flux Assay DBFs/NavAb LFA.RData")

#write normalized data to csv
write.csv (navab218_norm, file = 'navab218_norm.csv', row.names = FALSE)
write.csv (navab221_norm, file = 'navab221_norm.csv', row.names = FALSE)
write.csv (navab227_norm2, file = 'navab227_norm2.csv', row.names = FALSE)

#read the normalized csv file if you are working in a new workspace
navablfa_norm = read.csv ('navablfa_norm.csv', as.is = FALSE)

#read 221 normalized average for test,neg and pos @ 5uM (similar to 2uM)
navab221_norm2 = read.csv('navab221.csv', as.is = FALSE)
navab227_norm2 = read.csv('navab227.csv', as.is = FALSE)

#Working on log of data
## 227 data
log_norm =log10(navab218_norm[1:9])
navab218_normlog = cbind(navab218_norm, log_norm)
rm(navab218_normlog)
navab227_norm2$logE2norm = log10(navab227_norm2$E2norm)
navab227_norm2$logF2norm = log10(navab227_norm2$F2norm)
navab227_norm2$logG2norm = log10(navab227_norm2$G2norm)
## 221 data A02,A05,A07,A11
navab221_norm1$logA02 = log10(navab221_norm1$A02)
navab221_norm1$logA05 = log10(navab221_norm1$A05)
navab221_norm1$logA07 = log10(navab221_norm1$A07)
navab221_norm1$logA11 = log10(navab221_norm1$A11)
#B03, B05, B09, B11
navab221_norm1$logB03 = log10(navab221_norm1$B03)
navab221_norm1$logB05 = log10(navab221_norm1$B05)
navab221_norm1$logB09 = log10(navab221_norm1$B09)
navab221_norm1$logB11 = log10(navab221_norm1$B11)
#C03, C06, C08, C11
navab221_norm1$logC03 = log10(navab221_norm1$C03)
navab221_norm1$logC06 = log10(navab221_norm1$C06)
navab221_norm1$logC08 = log10(navab221_norm1$C08)
navab221_norm1$logC11 = log10(navab221_norm1$C11)

#5uM ACMA A10,B10,C10
navab221_norm1$logC03 = log10(navab221_norm1$C03)
navab221_norm1$logC06 = log10(navab221_norm1$C06)
navab221_norm1$logC08 = log10(navab221_norm1$C08)
navab221_norm1$logC11 = log10(navab221_norm1$C11)


navab218_norm$log_norm
#Plotting diagnostics using line plots (does not work well with LFA data)
p1 = plot(E04 ~ WELLNUM, data=navab227_norm,
     pch=16,
     col="dodgerblue1",
     main = "NavAb Liposome Flux Assay",
     xlab = "Cycle Number",
     ylab = "Normalized Fluorescence")
plot(E04 ~ WELLNUM, data = navablfacsv_norm, type = "b", frame = FALSE, pch = 19, 
     col = "red", main = "NavAb Liposome Flux Assay", xlab = "Cycle No", ylab = "Normalized Fluorescence")
abline(p1, col="blue")
p2 = scatterplot(E04 ~ WELLNUM, data=navablfacsv_norm,
          pch=16,
          col="dodgerblue1",
          main = "NavAb Liposome Flux Assay",
          xlab = "Cycle Number",
          ylab = "Normalized Fluorescence")
#plotting using ggplot2
library(ggplot2)
