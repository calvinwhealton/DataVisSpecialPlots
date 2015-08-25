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