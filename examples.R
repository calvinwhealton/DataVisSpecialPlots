################################################
# example scripts for the functions in
# the repository 'dataVisSpecialPlots'
################################################

#### libraries ####
library("RColorBrewer")   # nice color palettes
library("grDevices")      # polygon function
library("graphics")       # color ramp & color ramp palettes

#### loading scripts ####
# changing working directory for location of scripts
# must change based on local machine
setwd('/Users/calvinwhealton/GitHub/DataVisSpecialPlots')

# loading functions defined in each file
source('kernSmoothFunc.R')
source('TaylorDiagram.R')
source('Spaghetti.R')

################################################
# example of smoothed kernel density of traces
###############################################
# reading-in sample data from the file 'squirrelPopData.csv'
# data is in csv with first column the "time" index
# and all other columns a trace
dataKern <- read.table('squirrelPopData.csv' # example data file
                       ,header=T             # includes header
                       ,sep=','              # comma separated
                       )
# creating a plot with devault values
# exporting the plot as a PDF
pdf(file="example_kernelSmooth1.pdf" # name
    ,width=7  # in inches
    ,height=7 # in inches
    )
kernalSmoothTraces(dataTraces                     # data frame with traces as a funciton of time (or other variable)
                   ,colPal = brewer.pal(9,'PuBu') # color palette for the plot
                   ,colAssign='mean'              # method of assigning color
                   ,colN = 100                    # number of colors
                   ,add=F                         # is plot being added to existing plot
                   ,kernN = 512                   # number of points at which to estimate kernel
                   ,kernAdj = 1                   # adjustment of the bandwitch
                   ,kernType='gaussian'           # kernel used
                   ,kernRange = 'minmax'          # range to interpolate the kernel desity
                   ,norm='zeroone'                # method used to normalize the kernel
                   ,ptxlab='Time (months)'        # xlabel for plot
                   ,ptylab='Squirrel Popuation'   # ylabel for plot
                   ,ptmain='Modeled Squirrel Population'                     # title for plot
                   ,ptxlim=NA                     # x axis limits
                   ,ptylim=NA                     # y axis limits
                   ,ptBg=NA                       # plot background color
                   ,gridCol=NA                    # color of gridlines
                   ,gridOrd='bottom'              # order of plotting gridlines
                   ,gridLwd=2                     # line weight for gridlines
                   ,gridLty=2                     # line type for gridlines
                   ,linAdd = c('mean')            # lines to add
                   ,linCol = c('black')           # colors of lines in linAdd (same order)
                   ,linLty = c(1)                 # line types of lines in linAdd (same order)
                   ,linLwd = c(2)
)
dev.off()

# creating a plot with
#     added background box
#     non-default color palette
#     adjusted kernel
#     log-space mean
#     rectangular kernel (no Gaussian)
#     additional lines for median, min, and max
# exporting the plot as a png with some other values
png(file="example_kernelSmooth2.png" # name
    ,width=1100  # in inches
    ,height=1100 # in inches
    ,res=200
)
kernalSmoothTraces(dataTraces                     # data frame with traces as a funciton of time (or other variable)
                   ,colPal = brewer.pal(11,'RdBu') # color palette for the plot
                   ,colAssign='logmean'              # method of assigning color
                   ,colN = 100                    # number of colors
                   ,add=F                         # is plot being added to existing plot
                   ,kernN = 512                   # number of points at which to estimate kernel
                   ,kernAdj = 0.5                   # adjustment of the bandwitch
                   ,kernType='rectangular'           # kernel used
                   ,kernRange = NA          # range to interpolate the kernel desity
                   ,norm='onemode'                # method used to normalize the kernel
                   ,ptxlab='Time (months)'        # xlabel for plot
                   ,ptylab='Squirrel Popuation'   # ylabel for plot
                   ,ptmain='Modeled Squirrel Population \n(second version)'                     # title for plot
                   ,ptxlim=NA                     # x axis limits
                   ,ptylim=NA                     # y axis limits
                   ,ptBg="gray48"                       # plot background color
                   ,gridCol="white"                    # color of gridlines
                   ,gridOrd='bottom'              # order of plotting gridlines
                   ,gridLwd=2                     # line weight for gridlines
                   ,gridLty=2                     # line type for gridlines
                   ,linAdd = c('mean','median','min','max')            # lines to add
                   ,linCol = c('black','seagreen','purple','purple')           # colors of lines in linAdd (same order)
                   ,linLty = c(1,2,3,4)                 # line types of lines in linAdd (same order)
                   ,linLwd = c(2,2,1,1)
)
dev.off()

################################################
# example of Taylor diagram
###############################################
