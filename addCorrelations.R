# function to add correlations
# adds lines for major correlation 
# and tick marks for minor correlation

addCorrelTicks <- function(majors             # correlations for major tick marks and lines
                           ,minors            # correlations for minor tick marks (no lines)
                           ,std_lim           # standard deviation limit
                           ,color='blue'      # color of the lines
                           ,weight=2          # line weight
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