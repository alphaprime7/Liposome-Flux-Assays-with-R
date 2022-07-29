#import my principal data set
navab227_norm2 <- read.csv(file = 'navab227_norm3.csv', header = T)
navab221_avgnorm <- read.csv(file = 'navab221_norm3.csv', header = T)


# plot of log normalized fluorescence for test sample
## Create an R Graphics Device or container for plots
windows(width = 4.5, height = 4)
opar <- par(no.readonly = TRUE)
#par(mar = c(5, 5, 4, 6))
par(mar = c(4, 4, 3, 5))

plot.signal1 <- function(x){
  plot(E2norm ~ WELLNUM, data = navab227_norm2, type = "o", frame = T, 
       pch = 1, col = "blue", lwd = 2, xlim = c(1,40), main = "NavAb Liposome Flux Assay", 
       xlab = "Cycle No", ylab = "Average Normalized Fluorescence")
  # Add a second line
  lines(F2norm ~ WELLNUM, data = navab227_norm2, pch = 2, col = "red", 
        type = "o", lty = 2, lwd = 2)
  #lines(f6smooth ~ Time, data = navablfa_norm, pch = 2, col = 4, type = "o", lty = 2, lwd = 2)
  
  # Add a third line
  lines(G2norm ~ WELLNUM, data = navab227_norm2, pch = 7, col = "green", 
        type = "o", lty = 2, lwd = 2)
  
  #lines(g6smooth ~ Time, data = navablfa_norm, pch = 7, col = "red", type = "o", lty = 2, lwd = 2)
  
  legend("topright", inset = c(0.0, 0), legend=c("Test", "NC","PC"), 
         title = "2uM ACMA (Cs inside)", title.col = "black", box.lwd = 1, 
         box.col = "orange", col=c("blue","red","green"), lty = 1:2, lwd = 3, 
         cex=0.7, xpd = T)
}

# call function
plot.signal1()

# An alternate approach. The pitfalls sometimes of R.It seems 
#plotly is a part of python de facto. It is more interactive
library(plotly)
library(tidyr)
library(plyr)

plotly.fun<- function(a){
  fig1 <- plot_ly(navab227_norm2, x = ~WELLNUM, y = ~E2norm, 
                  type = 'scatter', mode = 'markers', name = 'Test')
  fig1 <- fig1 %>% add_trace(y = ~F2norm, name = 'Negative Control')
  fig1 <- fig1 %>% add_trace(y = ~G2norm, name = 'Positive Control')
  fig1
  fig1 %>% layout(yaxis = list(range=c(-0.8,0), 
           title = 'Log Normalized Fluorescence'),title = 'NavAb Liposome Flux Assay')
  
}  

#Call out the function
plotly.fun()

# Plot in signal zone for Cs inside
library(ggplot2)
library(ggdark)
library(ggthemes)
p1 = ggplot(navab227_norm2, aes(x=WELLNUM)) + 
  geom_point(aes(y=E2norm), size=3, color="blue") +
  geom_point(aes(y=F2norm), size=3, color="red") +
  geom_point(aes(y=G2norm), size=3, color="green") +
  geom_line(aes(y=E2norm, color='Test'), size=0.8) + 
  geom_line(aes(y=F2norm, color='Negative Control'), size =0.8) + 
  geom_line(aes(y=G2norm, color='Positive Control'), size =0.8) + 
  dark_mode()+
  xlim(0,20) +
  ylim(0,1) +
  labs(title = 'NavAb Liposome Flux Assay (2uM ACMA)', 
       x = 'Time(s)', y='Avg Normalized Fluorescence', color='2uM ACMA (Cs Inside)')

# call plot
p1 #or print(p1)

#Plot in signal zone for K inside
#E,N,P = exp,neg and pos respectively
#Ensure to take notes, i was working for hours and had no idea
#why i called them this
p2 = ggplot(navab221_avgnorm, aes(x=WELLNUM)) + 
  geom_point(aes(y=Enorm2), size=3, color="blue") +
  geom_point(aes(y=Nnorm2), size=3, color="red") +
  geom_point(aes(y=Pnorm2), size=3, color="green") +
  geom_line(aes(y=Enorm2, color='Test'), size=0.8) + 
  geom_line(aes(y=Nnorm2, color='Negative Control'), size =0.8) + 
  geom_line(aes(y=Pnorm2, color='Positive Control'), size =0.8) + 
  dark_mode()+
  xlim(0,20) +
  ylim(0,1) +
  labs(title = 'NavAb Liposome Flux Assay (2uM ACMA)', 
       x = 'Time(s)', y='Avg Normalized Fluorescence', color='2uM ACMA (K Inside)')

# call plot
p2 #or print(p1)

#plotting in the noise zone at >=(20uM-inf) with Cs inside
p3 = ggplot(navab227_norm2, aes(x=WELLNUM)) + 
  geom_point(aes(y=E20norm), size=3, color="blue") +
  geom_point(aes(y=F20norm), size=3, color="red") +
  geom_point(aes(y=G20norm), size=3, color="green") +
  geom_line(aes(y=E20norm, color='Test'), size=0.8) + 
  geom_line(aes(y=F20norm, color='Negative Control'), size =0.8) + 
  geom_line(aes(y=G20norm, color='Positive Control'), size =0.8) + 
  dark_mode()+
  xlim(0,20) +
  ylim(0,1) +
  labs(title = 'NavAb Liposome Flux Assay (20uM ACMA)', 
       x = 'Time(s)', y='Avg Normalized Fluorescence', color='20uM ACMA (Cs Inside)')

# call plot
p3 #or print(p1)

#plotting in the noise zone at <=(1-2) with Cs inside
p4 = ggplot(navab227_norm2, aes(x=WELLNUM)) + 
  geom_point(aes(y=E0norm), size=3, color="blue") +
  geom_point(aes(y=F0norm), size=3, color="red") +
  geom_point(aes(y=G0norm), size=3, color="green") +
  geom_line(aes(y=E0norm, color='Test'), size=0.8) + 
  geom_line(aes(y=F0norm, color='Negative Control'), size =0.8) + 
  geom_line(aes(y=G0norm, color='Positive Control'), size =0.8) + 
  dark_mode()+
  xlim(0,20) +
  ylim(0,1) +
  labs(title = 'NavAb Liposome Flux Assay (0.2uM ACMA)', 
       x = 'Time(s)', y='Avg Normalized Fluorescence', color='0.2uM ACMA (Cs Inside)')

# call plot
p4 #or print(p1)

# The driver of control point of this signal noise zones (ACMA)
# concentrations of ACMA drive signal-noise zones advocating balance

p5 = ggplot(navab221_avgnorm, aes(x=WELLNUM)) + 
  geom_point(aes(y=T2norm), size=3, color="blue1") +
  geom_point(aes(y=T3norm), size=3, color="blue2") +
  geom_point(aes(y=T4norm), size=3, color="blue3") +
  geom_point(aes(y=T5norm), size=3, color="blue4") +

  geom_line(aes(y=T2norm, color='2uM ACMA'), size=0.8) + 
  geom_line(aes(y=T3norm, color='3uM ACMA'), size =0.8) + 
  geom_line(aes(y=T4norm, color='4uM ACMA'), size =0.8) + 
  geom_line(aes(y=T5norm, color='5uM ACMA'), size =0.8) + 
  dark_mode()+
  xlim(0,20) +
  ylim(0,1) +
  labs(title = 'NavAb Liposome Flux Assay (for i in ACMA,i+)', 
       x = 'Time(s)', y='Avg Normalized Fluorescence', color='Signal ACMA uM')

# call plot
p5 #or print(p1)

# End of documentation project.

