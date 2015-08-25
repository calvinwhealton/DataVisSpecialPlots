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