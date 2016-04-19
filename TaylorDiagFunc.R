# function to plot a Taylor Diagram
makeTaylorDiag <- function(stdevs                    # standard deviations
                           ,correls                  # correlations
                           ,corMajors                # correlations for major tick marks and lines
                           ,corMinors                # correlations for minor tick marks (no lines)
                           ,stdevLim                 # limit of standard deviation
                           ,stdevMajors              # major values for standard deviation
                           ,RMSmajors                # major values of the RMS
                           ,RMSobj                   # displacement of the RMS circles
                           ,namMod                   # names of models
                           ,ptsCols=NA               # colors for points
                           ,stdevCol='black'         # color of lines for standard deviation
                           ,stdevLty=1               # line type for standard deviation
                           ,stdevLwd=1               # line weight for standard deviation
                           ,stdevLabAdj=-0.2         # adjustment of the labels for standard deviation
                           ,stdevTitleAdj=-0.6       # adjustment of the axis title for standard deviation
                           ,stdevTextCex=0.7         # multiplier for text for standard deviation
                           ,corColor='blue'          # color of the lines for correlation
                           ,corLwd=1                 # line weight for the correlation
                           ,corLty=1                 # line type for the correlation
                           ,corTickAdjMaj=0.02       # adjustment of the major tick marks (fraction of standard deviation limits) for correlation
                           ,corTickAdjMin=0.01       # adjustment of the minor tick marks (fraction of standard deviation limits) for correlation
                           ,corTextCex=0.5           # multiplier of text size for correlation labels
                           ,corTextAdj=0.05          # adjustment of text location for correlation
                           ,ptsPch = 19              # plotting symbol for points
                           ,ptsCex = 1.5             # multiplier for points plotting
                           ,leg=T                    # legend should be plotted
                           ,legDY=-2                 # vertical displacement of legend
                           ,legColumn=3              # number of columns in legend
                           
  
){
  
  # initializing the plot areas
  initializePlotArea(std_lim=stdevLim)
  
  # adding standard deviation lines
  addStandardDeviations(majors=stdevMajors     # major standard deviations plotted
                        ,color=stdevCol        # color of text and lines
                        ,type=stdevLty         # type of line
                        ,weight=stdevLwd       # weight of the line 
                        ,labAdj=stdevLabAdj    # adjustment of the labels
                        ,titleAdj=stdevTitleAdj  # adjustment of the axis title
                        ,textCex=stdevTextCex   # multiplier of label text size
                        )
  
  # adding correlation lines and ticks
  addCorrelTicks(majors=corMajors
                 ,minors=corMinors
                 ,std_lim=stdevLim)
  
  # adding RMS lines
  addRMS(majors=RMSmajors
         ,obs=RMSobj
         ,std_lim=stdevLim)
  
  # adding points
  # assigning colors
  if(is.na(ptsCols)){
    cols <- terrain.colors(length(stdevs))
  }else{
    cols <- ptsCols
  }
  points(stdevs*cos(acos(correls))
         ,stdevs*sin(acos(correls))
         ,col=cols
         ,pch=ptsPch
         ,cex=ptsCex)
  
  # adding legend
  par(xpd=TRUE)
  if(leg==T){
    legend(0,legDY
           ,namMod
           ,pc=ptsPch
           ,col=cols
           ,ncol=legColumn
           ,bty='n'
           ,xjust=0.5)
  }
  par(xpd=F)
}# end function

# function to initialize plot area
# makes plot square with no axes
initializePlotArea <- function(std_lim){
  
  # plot parameters
  par(pty='s') # to make it square
  par(mar=c(3,3,3,3)+0.1) # to make margins large enough
  
  # creating plot with correct space based on the sigma_test limits
  plot(NA                           # no x data
       ,NA                          # no y data
       ,xlim=c(-1*std_lim,std_lim)  # limits based on standard deviation limit
       ,ylim=c(-1*std_lim,std_lim)  # limits based on standard deviation limit
       ,xaxt='n'                    # no x axis
       ,yaxt='n'                    # no y axis
       ,xlab=''                     # no x labels
       ,ylab=''                     # no y labels
       ,bty='n'                     # no box
  )
}

# function for adding standard deviation lines (semicircles)
addStandardDeviations <- function(majors          # major standard deviations plotted
                                  ,color='black'  # color of text and lines
                                  ,type=1         # type of line
                                  ,weight=1       # weight of the line 
                                  ,labAdj=-0.2    # adjustment of the labels
                                  ,titleAdj=-0.6  # adjustment of the axis title
                                  ,textCex=0.7    # multiplier of label text size
){
  
  # adding semicircles for the standard deviation
  for(i in 1:length(majors)){
    lines(majors[i]*cos(seq(0,pi,pi/1000)) # x locations
          ,majors[i]*sin(seq(0,pi,pi/1000)) # y locations
          ,col=color    # line color
          ,lty=type     # line type
          ,lwd=weight   # line weight
    )
  }
  
  # adding labels
  text(c(-1*majors,0,majors) # x locations
       ,labAdj               # y location
       ,as.character(c(majors,0,majors)) # values converted to characters
       ,col=color            # color of the text
       ,cex=textCex          # text multiplier
  )
  
  # adding title for the axis
  text(0                       # centered
       ,titleAdj               # slightly below axis
       ,"Standard Deviation"   # name of axis
       ,col=color   # color of text
       ,cex=1                  # multiplier of the text
  )
}

# function to add RMS semicircles to plot
addRMS <- function(obs             # observed value (center of circle)
                   ,majors         # values for the RMS circules
                   ,std_lim        # standard deviation limit used in plotting
                   ,color='green'  # color of text and lines
                   ,type=1         # type of line
                   ,weight=1       # weight of the line 
                   ,titleAdj=-1.2  # adjustment of the axis title
                   ,textCex=0.7    # text multiplier
                   ,obsPch=15      # pch for the observation
){
  
  # adding rms semicircles
  for(i in 1:length(majors)){
    inds <- which((majors[i]*cos(seq(0,pi,pi/1000))+obs)^2 + (majors[i]*sin(seq(0,pi,pi/1000)))^2 < std_lim^2)
    
    lines(majors[i]*cos(seq(0,pi,pi/1000))[inds]+obs
          ,majors[i]*sin(seq(0,pi,pi/1000))[inds]
          ,col=color
          ,lty=type
          ,lwd=weight
    )
  }
  
  # adding observed point
  points(obs # x location
         ,0 # y location, on axis
         ,pch=obsPch # symbol
         ,col=color
         ,cex=1
  )
  
  # adding labels for the rms lines
  # first 4 are white text for creating a buffer
  text(-1*majors*cos(pi/10)+obs-0.01
       , majors*sin(pi/10)-0.01
       ,as.character(majors) # labels
       ,col='white' # color
       ,cex=textCex # text multipier
       ,adj=1 # left justified
  )
  text(-1*majors*cos(pi/10)+obs-0.01
       , majors*sin(pi/10)+0.01
       ,as.character(majors) # labels
       ,col='white' # color
       ,cex=textCex # text multipier
       ,adj=1 # left justified
  )
  text(-1*majors*cos(pi/10)+obs+0.01
       , majors*sin(pi/10)-0.01
       ,as.character(majors) # labels
       ,col='white' # color
       ,cex=textCex # text multipier
       ,adj=1 # left justified
  )
  text(-1*majors*cos(pi/10)+obs+0.01
       , majors*sin(pi/10)
       ,as.character(majors) # labels
       ,col='white' # color
       ,cex=textCex # text multipier
       ,adj=1 # left justified
  )
  
  # adding labels for the rms lines
  text(-1*majors*cos(pi/10)+obs
       , majors*sin(pi/10)
       ,as.character(majors) # labels
       ,col=color # color
       ,cex=textCex # text multipier
       ,adj=1 # left justified
  )
  
  # adding title
  text(0        # centered
       ,titleAdj # y location
       ,'Centered RMS Difference' # title
       ,col=color     # color
       ,cex=1         # text multiplier
       ,adj=0.5       # centered on coordinates
  )
}

# function to add correlations
# adds lines for major correlation 
# and tick marks for minor correlation
addCorrelTicks <- function(majors             # correlations for major tick marks and lines
                           ,minors            # correlations for minor tick marks (no lines)
                           ,std_lim           # standard deviation limit
                           ,color='blue'      # color of the lines
                           ,weight=1          # line weight
                           ,type=1            # line type
                           ,tickAdjMaj=0.02   # adjustment of the major tick marks (fraction of standard deviation limits)
                           ,tickAdjMin=0.01   # adjustment of the minor tick marks (fraction of standard deviation limits)
                           ,textCex=0.5       # multiplier of text size for correlation labels
                           ,textAdj=0.05      # adjustment of text location
){
  
  # adding lines for major tick marks
  # locations are based on inverse cosine of the correlation
  for(i in 1:length(majors)){
    
    lines(c(0,(1+tickAdjMaj)*std_lim*cos(acos(majors[i])))  # converting to Cartesian coordiantes using inverse cosine to get angle
          ,c(0,(1+tickAdjMaj)*std_lim*sin(acos(majors[i]))) # converting to Cartesian coordiantes using inverse cosine to get angle
          ,lwd=weight # weight of lines
          ,lty=type   # type of lines
          ,col=color  # color of lines
    )
  }
  
  # adding minor tick marks for correlation
  for(i in 1:length(minors)){
    
    lines(std_lim*cos(acos(minors[i]))*c(1,1+tickAdjMin)  # converting to Cartesian coordiantes using inverse cosine to get angle
          ,std_lim*sin(acos(minors[i]))*c(1,1+tickAdjMin) # converting to Cartesian coordiantes using inverse cosine to get angle
          ,lwd=weight # weight of lines
          ,lty=1      # type of lines (1 because needs to be solid)
          ,col=color  # color of lines
    )
  }
  
  # adding labels for correlation
  text((1+textAdj)*std_lim*cos(acos(majors)) # converting to Cartesian coordiantes using inverse cosine to get angle
       ,(1+textAdj)*std_lim*sin(acos(majors)) # converting to Cartesian coordiantes using inverse cosine to get angle
       ,as.character(majors) # converting correlations to text as labels
       ,col=color         # color used for correlation
       ,cex=textCex       # text multiplier
  )
  par(xpd=TRUE)
  # adding correlation title for axis
  text(0                  # centered
       ,std_lim+0.5       # 0.5 units above peak of semicirle
       ,"Correlation"     # name
       ,col=color         # same color as correlations
       ,cex=1             # text multiplier
  )
  par(xpd=FALSE)
}