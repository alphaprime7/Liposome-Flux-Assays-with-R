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

# just noting that we can use data.table or dplyr for dealing with duplicate rows how???
library(data.table)
navab2018demo = transpose(navab218)
navab2018demo2<-subset(navab2018demo, V1!="NA")
navab2018demo2<-subset(navab2018demo2, V2!="C")
navab2018demo2 <-  navab2018demo2 %>% select(-V2)
library(dplyr)
navab2018demo2 <- navab2018demo2 %>% mutate_if(is.character, as.numeric)
new_navab2018demo2 <- navab2018demo2 %>% 
  rename(
    Time = V1,
     E10=V3,
    E11=V4 ,
     E12=V5,
     F10=V6,
    F11=V7,
     F12=V8,
     G10=V9,
     G11=V10,
     G12=V11
  )

WELLNUM <- seq(from=1, to=40, by=1)
head(WELLNUM)
navab2018fix <- cbind(WELLNUM,new_navab2018demo2)
navab2018demo2[-c(seq(40, 42))]

#Read transposed csv files into R for normalization
navab218t = read.csv('navab218.csv', as.is = FALSE)
navab221t = read.csv('navab221.csv', as.is = FALSE)
navab227 = read.csv('navab227.csv', as.is = FALSE)

rm(navab2018demo2)

# End of rudimentary cleanup code
