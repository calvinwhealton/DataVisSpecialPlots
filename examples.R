################################################
# example scripts for the functions in
# the repository 'dataVisSpecialPlots'
################################################

#### libraries ####
library("RColorBrewer")   # nice color palettes
library("grDevices")      # polygon function, some color palettes
library("graphics")       # color ramp & color ramp palettes
library("plotrix")        # used for circles and rectanges in Sobol'

################################################
# example of Sobol' Sensitivity Analysis Radial Convergence
###############################################

# loading function
setwd('/Users/calvinwhealton/GitHub/DataVisSpecialPlots/SobolSensitivityRadialConvergence')
source('plotRadCon.R')

####
# Example 1:
#   Single function call
#   Using significance criteria
#   Using minimum number of specified function arguments
####

## importing data from sensitivity analysis----
# see Python files for examples of how the input was saved to csv files

# importing first- and total-order indices with their confidence intervals
s1st_opt1 <- read.csv("S1ST_output.csv"
                      , sep=','
                      , header=TRUE
                      ,as.is=c(TRUE,rep(FALSE,4)))

# importing second-order indices with their confidence intervals
# both should be a k-by-k matrix with numbers in the upper triangular
# portion and nans elsewhere (k = number of parameters)
s2_opt1 <- read.csv("S2_output.csv"
                    , sep=','
                    , header=FALSE)

s2_conf_opt1 <- read.csv("S2_conf_output.csv"
                         , sep=','
                         , header=FALSE)

# defining lists of the variables for each group
name_list_opt1 <- list("group1" = c('x1', 'x4', 'x7', 'x8')
                       ,"group2" = c('x2', 'x3', 'x9')
                       ,"group3" = c('x5', 'x6', 'x10'))

## completing calculations of statistical significance
# and creating plot from single function call
# using all default values when possible
stst_opt1 <- evalPlotIndsRadCon(df=s1st_opt1                # data frame of S1 and ST indices (and confidence intervals if evaluating significance)
                                ,dfs2=s2_opt1              # matrix/data frame of S2 indices
                                ,dfs2Conf=s2_conf_opt1     # matrix/data frame of S2 indices confidence interval
                                ,gpNameList=name_list_opt1 # list of variables names for each group
)

####
# Example 2:
#   Single function call
#   Only plotting values greater than 0.02
#   Controlling output plot name and format (pdf, png)
####
## importing data from sensitivity analysis----
# see Python files for examples of how the input was saved to csv files

# importing first- and total-order indices with their confidence intervals
s1st_opt2 <- read.csv("S1ST_output.csv"
                      , sep=','
                      , header=TRUE
                      ,as.is=c(TRUE,rep(FALSE,4)))

# importing second-order indices with their confidence intervals
# both should be a k-by-k matrix with numbers in the upper triangular
# portion and nans elsewhere (k = number of parameters)
s2_opt2 <- read.csv("S2_output.csv"
                    , sep=','
                    , header=FALSE)

s2_conf_opt2 <- read.csv("S2_conf_output.csv"
                         , sep=','
                         , header=FALSE)

# defining lists of the variables for each group
name_list_opt2 <- list("group1" = c('x2', 'x4', 'x7', 'x10')
                       ,"group2" = c('x1', 'x5', 'x9')
                       ,"group3" = c('x3', 'x6', 'x8'))

## completing calculations of statistical significance
# and creating plot from single function call
# using all default values when possible
stst_opt2 <- evalPlotIndsRadCon(df=s1st_opt2               # data frame of S1 and ST indices (and confidence intervals if evaluating significance)
                                ,dfs2=s2_opt2              # matrix/data frame of S2 indices
                                ,dfs2Conf=s2_conf_opt2     # matrix/data frame of S2 indices confidence interval
                                ,gpNameList=name_list_opt2 # list of variables names for each group
                                ,s1stmeth='gtr'            # method for significance of S1 and ST
                                ,s1stgtr = 0.02            # threshold for significance of S1 and ST
                                ,s2meth = 'gtr'            # method for significance of S2
                                ,s2gtr = 0.02              # threshold for significance of S2
                                ,ptTitle = 'Example 2'     # title for plot
                                ,ptFileNm = 'exam2'        # name for file
                                ,ptType = 'PNG'            # type of file
                                ,ptRes=100                 # resolution for the plot
)

stst_opt2 <- evalPlotIndsRadCon(df=s1st_opt2               # data frame of S1 and ST indices (and confidence intervals if evaluating significance)
                                ,dfs2=s2_opt2              # matrix/data frame of S2 indices
                                ,dfs2Conf=s2_conf_opt2     # matrix/data frame of S2 indices confidence interval
                                ,gpNameList=name_list_opt2 # list of variables names for each group
                                ,s1stmeth='gtr'            # method for significance of S1 and ST
                                ,s1stgtr = 0.02            # threshold for significance of S1 and ST
                                ,s2meth = 'gtr'            # method for significance of S2
                                ,s2gtr = 0.02              # threshold for significance of S2
                                ,ptTitle = 'Example 2'     # title for plot
                                ,ptFileNm = 'exam2'        # name for file
                                ,ptType = 'PDF'            # type of file
)

stst_opt2 <- evalPlotIndsRadCon(df=s1st_opt2               # data frame of S1 and ST indices (and confidence intervals if evaluating significance)
                                ,dfs2=s2_opt2              # matrix/data frame of S2 indices
                                ,dfs2Conf=s2_conf_opt2     # matrix/data frame of S2 indices confidence interval
                                ,gpNameList=name_list_opt2 # list of variables names for each group
                                ,s1stmeth='gtr'            # method for significance of S1 and ST
                                ,s1stgtr = 0.02            # threshold for significance of S1 and ST
                                ,s2meth = 'gtr'            # method for significance of S2
                                ,s2gtr = 0.02              # threshold for significance of S2
                                ,ptTitle = 'Example 2'     # title for plot
                                ,ptFileNm = 'exam2'        # name for file
                                ,ptType = 'EPS'            # type of file
)


#####
# Example 3:
#   Single function call
#   Plotting all values
#   Changing color scheme from default
####
## importing data from sensitivity analysis----
# see Python files for examples of how the input was saved to csv files

# importing first- and total-order indices with their confidence intervals
s1st_opt3 <- read.csv("S1ST_output.csv"
                      , sep=','
                      , header=TRUE
                      ,as.is=c(TRUE,rep(FALSE,4)))

# importing second-order indices with their confidence intervals
# both should be a k-by-k matrix with numbers in the upper triangular
# portion and nans elsewhere (k = number of parameters)
s2_opt3 <- read.csv("S2_output.csv"
                    , sep=','
                    , header=FALSE)

s2_conf_opt3 <- read.csv("S2_conf_output.csv"
                         , sep=','
                         , header=FALSE)

# defining lists of the variables for each group
name_list_opt3 <- list("group1" = c('x2', 'x4', 'x7', 'x10')
                       ,"group2" = c('x1', 'x5', 'x9')
                       ,"group3" = c('x3', 'x6', 'x8'))

# defining colors for the groups
color_list_opt3 <- list("group1"='deeppink'
                        ,"group2" = "goldenrod1"
                        ,"group3"="mediumvioletred")

## completing calculations of statistical significance
# and creating plot from single function call
# using all default values when possible
stst_opt2 <- evalPlotIndsRadCon(df=s1st_opt2                # data frame of S1 and ST indices (and confidence intervals if evaluating significance)
                                ,dfs2=s2_opt2               # matrix/data frame of S2 indices
                                ,dfs2Conf=s2_conf_opt2      # matrix/data frame of S2 indices confidence interval
                                ,gpNameList=name_list_opt2  # list of variables names for each group
                                ,gpColList =color_list_opt3 # color list
                                ,ptTitle = 'Example 3'      # title for plot
                                ,ptFileNm = 'exam3'         # name for file
                                ,ptType = 'EPS'             # type of file
                                ,ptRes=100                  # resolution for the plot
)


################################################
# example of smoothed kernel density of traces
###############################################

# loading function
setwd('/Users/calvinwhealton/GitHub/DataVisSpecialPlots/SmoothKernelTraces')
source('kernSmoothFunc.R')

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
kernelSmoothTraces(dataTraces                     # data frame with traces as a funciton of time (or other variable)
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
kernelSmoothTraces(dataTraces                     # data frame with traces as a funciton of time (or other variable)
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

# creating a plot with devault values
# exporting the plot as a PDF
jpeg(file="example_kernelSmooth3.jpg" # name
    ,width=1100  # in inches
    ,height=1100 # in inches
    ,res=200
)
kernelSmoothTraces(dataTraces                     # data frame with traces as a funciton of time (or other variable)
                   ,colPal = brewer.pal(9,'PuBu') # color palette for the plot
                   ,ptylab = 'Squirrels'
                   ,ptxlab='Time (months)'
)
dev.off()

################################################
# example of Taylor diagram
###############################################

# loading functions
setwd('/Users/calvinwhealton/GitHub/DataVisSpecialPlots/TaylorDiagram')
source('TaylorDiagFunc.R')

# model values used in plotting (points on the plot)
# substitute your values here
names_mod <- paste("model",seq(1,8),sep='')
correl_names <- seq(-0.6,0.8,by=0.2)
std_names <- seq(2,4,by=0.26)
color_names <- topo.colors(length(names_mod))

# example with many default inputs
pdf('TaylorDiagram1.pdf'
    ,heigh=7 # in inches
    ,width=7 # in inches
    )
makeTaylorDiag(stdevs=std_names               # standard deviations
               ,correls=correl_names                  # correlations
               ,corMajors=c(seq(0.0,1,0.1),-1*seq(0.0,1,0.1))         # correlations for major tick marks and lines
               ,corMinors=c(c(0.96,0.97,0.98,0.99),-1*c(0.96,0.97,0.98,0.99))                # correlations for minor tick marks (no lines)
               ,stdevLim=4                 # limit of standard deviation
               ,stdevMajors=seq(1,4,1)              # major values for standard deviation
               ,RMSmajors=seq(1,10,1)                # major values of the RMS
               ,RMSobj=2
               ,namMod=names_mod                   # names of models
)
dev.off()

# example with many default inputs changed
png('TaylorDiagram2.png'
    ,heigh=1100 # in inches
    ,width=1100 # in inches
    ,res=200
)
makeTaylorDiag(stdevs=std_names               # standard deviations
               ,correls=correl_names                  # correlations
               ,corMajors=c(seq(0.0,1,0.1),-1*seq(0.0,1,0.1))         # correlations for major tick marks and lines
               ,corMinors=c(c(0.96,0.97,0.98,0.99),-1*c(0.96,0.97,0.98,0.99))                # correlations for minor tick marks (no lines)
               ,stdevLim=4                 # limit of standard deviation
               ,stdevMajors=seq(1,4,1)              # major values for standard deviation
               ,RMSmajors=seq(1,10,1)                # major values of the RMS
               ,RMSobj=2
               ,namMod=names_mod                   # names of models
               ,ptsCols=brewer.pal(8,'YlOrRd')               # colors for points
               ,stdevCol='purple'         # color of lines for standard deviation
               ,stdevLty=2              # line type for standard deviation
               ,stdevLwd=2               # line weight for standard deviation
               ,corColor='green'          # color of the lines for correlation
               ,corLwd=3                 # line weight for the correlation
               ,corLty=2                 # line type for the correlation
               ,ptsPch = 16              # plotting symbol for points
               ,ptsCex = 2             # multiplier for points plotting
               ,leg=F                    # legend should be plotted
)
dev.off()