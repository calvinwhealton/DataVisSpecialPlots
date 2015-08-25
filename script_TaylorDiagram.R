# example code for creating a Taylor Diagram

# setting working directory
setwd('/Users/calvinwhealton/GitHub/TaylorDiagrams')

# importing functions defined in other files
source('initializePlotArea.R')  # code to initialize the plot area
source('addCorrelations.R')     # code to add correlation major and minor tick marks and lines
source('addStdDevs.R')          # code to add standard deviation semicircles
source('addRMS.R')              # code to add RMS semicircles

################################################################
# model values used in plotting (points on the plot)
# substitute your values here
names_mod <- paste("model",seq(1,8),sep='')
correl_names <- seq(-0.6,0.8,by=0.2)
std_names <- seq(2,4,by=0.26)
color_names <- topo.colors(length(names_mod))
################################################################

################################################################
## creating the plot and axes

standardDevLim <- 4 # general limit used to determine plot size

# initializing the plot area
initializePlotArea(std_lim=standardDevLim)

# adding standard deviation lines
addStandardDeviations(majors=c(1,2,3,4))

# adding correlation lines and ticks
addCorrelTicks(majors=c(seq(-1,1,0.1),-0.95,0.95)
               ,minors=c(seq(-1,-0.95,0.01),seq(-0.9,9,0.05),seq(0.95,1,0.01))
               ,std_lim=standardDevLim)

# adding RMS lines
addRMS(majors=c(1,2,3,4,5,6,7)
        ,obs=2
        ,std_lim=standardDevLim)

# adding points
points(std_names*cos(acos(correl_names))
       ,std_names*sin(acos(correl_names))
       ,col=color_names
       ,pch=19
       ,cex=1.5)

# adding legend
par(xpd=TRUE)
legend(0,-2
       ,names_mod
       ,pc=19
       ,col=color_names
       ,ncol=3
       ,bty='n'
       ,xjust=0.5)
################################################################
