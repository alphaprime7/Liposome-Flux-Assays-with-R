#import my principal data set
navab227_norm2 <- read.csv(file = 'navab227_norm2.csv', header = T)

#Clarity in Data Analysis
#Plotting the first line ylim=range(c(avg-sdev, avg+sdev))

#PLOT 227
plot(E0norm ~ WELLNUM, data = navab227_norm2, type = "o", frame = T, 
            pch = 1, col = "blue", lwd = 2, xlim = c(0,20),
            main = "NavAb Liposome Flux Assay (Cs Inside)", 
            xlab = "Cycle No", ylab = "Avg Normalized Fluorescence (Log)")
#arrows(img1, error_values, img1, error_values, code = 3, angle = 90, text(img1,2, paste("n =", n.worm)))
# Add a second line
lines(F0norm ~ WELLNUM, data = navab227_norm2, pch = 2, col = "red", type = "o", lty = 2, lwd = 2)

#lines(f6smooth ~ Time, data = navablfa_norm, pch = 2, col = 4, type = "o", lty = 2, lwd = 2)

# Add a third line
lines(G0norm ~ WELLNUM, data = navab227_norm2, pch = 10, col = "green", type = "o", lty = 2, lwd = 2)

# Add a 4th line
#lines(T5norm ~ WELLNUM, data = navab221_norm2, pch = 8, col = "black", type = "o", lty = 2, lwd = 2)

#Legend , box.col = "black" x y direction for inset
legend("topright", inset = c(-0.4, 0), legend=c("Exp", "NC","PC"), 
       title = "20 uM ACMA", title.col = "purple", box.col = "black", 
       box.lwd = 0, col=c("blue","red","green"), 
       lty = 1:3, lwd = 3, cex=0.7, xpd = T)

#NEXT PLOT 221
#lines(g6smooth ~ Time, data = navablfa_norm, pch = 7, col = "red", type = "o", lty = 2, lwd = 2)
plot(logE04 ~ Timeadj, data = navab227_norm1, type = "o", frame = T, 
     pch = 1, col = "blue", lwd = 2, xlim = c(0,400),  
     main = "NavAb Liposome Flux Assay", 
     xlab = "Time(s)", ylab = "Normalized Fluorescence(Log)")
#arrows(img1, error_values, img1, error_values, code = 3, angle = 90, text(img1,2, paste("n =", n.worm)))
# Add a second line
lines(logF06 ~ Timeadj, data = navab227_norm1, pch = 2, col = "red", type = "o", lty = 2, lwd = 2)

#lines(f6smooth ~ Time, data = navablfa_norm, pch = 2, col = 4, type = "o", lty = 2, lwd = 2)

# Add a third line
lines(logG06 ~ Timeadj, data = navab227_norm1, pch = 7, col = "green", type = "o", lty = 2, lwd = 2)

#lines(g6smooth ~ Time, data = navablfa_norm, pch = 7, col = "red", type = "o", lty = 2, lwd = 2)

#Add legend
legend("bottomleft", legend=c("Test", "Negative Control","Positive Control"), 
       title = "2uM ACMA", title.col = "purple", box.lwd = 0, 
       box.col = "black", col=c("blue","red","green"), lty = 1:2, lwd = 3, cex=0.8)
# X-axis
xlim = c(min, max)
axis(1, at = c(60,600))

# Y-axis
axis(2, at = c(0, 0.5, 1))
ylim = c(min,max)

#Add log data of E04 
navablfa_norm$logE04 = log10(navablfa_norm$E04)
navablfa_norm$logF06 = log10(navablfa_norm$F06)
navablfa_norm$logG06 = log10(navablfa_norm$G06)

#smoothen data
library(zoo)
library(reshape)
navablfa_norm$e4smooth<-rollmean(navablfa_norm$E04,3,fill="extend")
navablfa_norm$f6smooth<-rollmean(navablfa_norm$F06,3,fill="extend")
navablfa_norm$g6smooth<-rollmean(navablfa_norm$G06,3,fill="extend")


#Plotting 20uM ACMA data
# the first line
write.csv(navablfa_norm,file = 'navablfanormsmooth.csv')
plot(E09 ~ Time, data = navablfa_norm, type = "o", frame = T, 
     pch = 1, col = 3, lwd = 2, xlim = c(30,360), main = "NavAb Liposome Flux Assay", 
     xlab = "Time(s)", ylab = "Normalized Fluorescence")
# Add a second line
lines(F09 ~ Time, data = navablfa_norm, pch = 2, col = 4, type = "o", lty = 2, lwd = 2)
#lines(f6smooth ~ Time, data = navablfa_norm, pch = 2, col = 4, type = "o", lty = 2, lwd = 2)

# Add a third line
lines(G09 ~ Time, data = navablfa_norm, pch = 7, col = "red", type = "o", lty = 2, lwd = 2)
#lines(g6smooth ~ Time, data = navablfa_norm, pch = 7, col = "red", type = "o", lty = 2, lwd = 2)



# Add a legend to the plot
#title.adj = 0.5# Horizontal adjustment of the title
#lty = c(1, 2), col = c(2, 3), lwd = 2)
#box.lty = 2, # Line type of the box
#box.lwd = 2, # Width of the line of the box
#box.col = 4, # Color of the line of the box
#lty = c(1, 2),
#col = c(2, 3),
#lwd = 2)
windows(width = 4.5, height = 4)
opar <- par(no.readonly = TRUE)
#par(mar = c(5, 5, 4, 6))
par(mar = c(4, 4, 3, 5))
plot(E09 ~ Time, data = navablfa_norm, type = "o", frame = T, 
     pch = 1, col = 3, lwd = 2, xlim = c(30,360), main = "NavAb Liposome Flux Assay", 
     xlab = "Time(s)", ylab = "Normalized Fluorescence")
# Add a second line
lines(F09 ~ Time, data = navablfa_norm, pch = 2, col = 4, 
      type = "o", lty = 2, lwd = 2)
#lines(f6smooth ~ Time, data = navablfa_norm, pch = 2, col = 4, type = "o", lty = 2, lwd = 2)

# Add a third line
lines(G09 ~ Time, data = navablfa_norm, pch = 7, col = "red", 
      type = "o", lty = 2, lwd = 2)
#lines(g6smooth ~ Time, data = navablfa_norm, pch = 7, col = "red", type = "o", lty = 2, lwd = 2)

legend("topright", inset = c(-0.3, 0), legend=c("Test", "NC","PC"), 
       title = "20uM ACMA", title.col = "purple", box.lwd = 1, 
       box.col = "orange", col=c(3,4,"red"), lty = 1:2, lwd = 3, 
       cex=0.7, xpd = T)
# X-axis
xlim = c(min, max)
axis(1, at = c(60,600))

# Y-axis
axis(2, at = c(0, 0.5, 1))
ylim = c(min,max)

#Add log data of E04 
navablfa_norm$logE04 = log10(navablfa_norm$E04)
navablfa_norm$logF06 = log10(navablfa_norm$F06)
navablfa_norm$logG06 = log10(navablfa_norm$G06)

# Adding Error bars
avg = mean(navablfa_norm$E04)
sdev = sd(navablfa_norm$E04)
plot(x, avg,
     ylim=range(c(avg-sdev, avg+sdev)),
     pch=19, xlab="Measurements", ylab="Mean +/- SD",
     main="Scatter plot with std.dev error bars"
)

#Plotting error bars in R using Hmisc package
error_values = c(navablfa_norm$E04)
errbar(navablfa_norm$Time, navablfa_norm$E04 + error_values,navablfa_norm$E04-error_values,type='b')

#using tapply to calculate statistical parameters
install.packages('tapply')

#Quick ggplots
#p2 = ggplot(navablfa_norm, aes(x=WELLNUM, y=logE04)) + geom_point(col='brown', size=4) + geom_line(size=0.8) + xlim(0,15)  + labs(title = '                                                                                                              
            #Fluorescence Intensity (Y) vs Cycle Num (X)', x = 'Cycle Number', y='Normalized Fluorescence', color='Fluxassay')
#geom_errorbar(aes(ymin=len-sd, ymax=len+sd), width=.2,
              #position=position_dodge(0.05))
library(ggplot2)
p1 = ggplot(navab221_norm2, aes(x=WELLNUM)) + 
geom_point(aes(y=Enorm5), size=3, color="blue") +
geom_point(aes(y=Nnorm5), size=3, color="red") +
geom_point(aes(y=Pnorm5), size=3, color="green") +
geom_line(aes(y=Enorm5, color='Experiment'), size=0.8) + 
geom_line(aes(y=Nnorm5, color='Negative Control'), size =0.8) + 
geom_line(aes(y=Pnorm5, color='Positive Control'), size =0.8) + 
xlim(0,20) +
ylim(0,1) +
labs(title = 'NavAb Liposome Flux Assay (5uM ACMA)', 
x = 'Time(s)', y='Avg Normalized Fluorescence', color='5uM ACMA')
p1
#geom_errorbar(aes(ymin=logE04-sdeve4, ymax=logE04+sdeve4), width=.01) +


#working on error bar 1
sdeve4 = sd(navablfa_norm$E04)
sdevf06 = sd(navablfa_norm$F06)
sdevg06 = sd(navablfa_norm$G06)
# Working on the error bar (end here 2152022 for now)2
head(navablfa_norm)
data_summary <- function(data, varname){
  require(plyr)
  summary_func <- function(x, col){
    c(mean = mean(x[[col]], na.rm=TRUE),
      sd = sd(x[[col]], na.rm=TRUE))
  }
  data_sum<-ddply(data, groupnames, .fun=summary_func,
                  varname)
  data_sum <- rename(data_sum, c("mean" = varname))
  return(data_sum)
}
navabsum <- data_summary(navablfa_norm, varname="rule", groupnames = c("Time", "WELLNUM", "G06ev"))
navablfa_norm$navabsumm = error_values

#fun code for this error bars
#Create fake data
x <-rep(1:10, each =3)
y <- rnorm(30, mean=4,sd=1)

#Loop to get standard deviation from data
sd.y = NULL
for(i in 1:10){
  sd.y[i] <- sd(y[(1+(i-1)*3):(3+(i-1)*3)])
}
sd.y<-rep(sd.y,each = 3)

#Loop to get mean from data
mean.y = NULL
for(i in 1:10){
  mean.y[i] <- mean(y[(1+(i-1)*3):(3+(i-1)*3)])
}
mean.y<-rep(mean.y,each = 3)

#Put together the data to view it so far
data <- cbind(x, y, mean.y, sd.y)

#Make an empty matrix to fill with shrunk data
data.1 = matrix(data = NA, nrow=10, ncol = 4)
colnames(data.1) <- c("X","Y","MEAN","SD")

#Loop to put data into shrunk format
for(i in 1:10){
  data.1[i,] <- data[(1+(i-1)*3),]
}

#Create atomic vectors for arrows
x <- data.1[,1]
mean.exp <- data.1[,3]
sd.exp <- data.1[,4]

#Plot the data
plot(x, mean.exp, ylim = range(c(mean.exp-sd.exp,mean.exp+sd.exp)))
abline(h = 4)
arrows(x, mean.exp-sd.exp, x, mean.exp+sd.exp, length=0.05, angle=90, code=3)


