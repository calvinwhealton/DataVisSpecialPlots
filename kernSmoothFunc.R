# function for completing smoothing traces using
# kernel density and plotting the results
kernalSmoothTraces <- function(dataTraces                     # data frame with traces as a funciton of time (or other variable)
                               ,colPal = brewer.pal(9,'PuBu') # color palette for the plot
                               ,colAssign='mean'              # method of assigning color
                               ,colN = 100                    # number of colors
                               ,add=F                         # is plot being added to existing plot
                               ,kernN = 512                   # number of points at which to estimate kernel
                               ,kernAdj = 1                   # adjustment of the bandwitch
                               ,kernType='gaussian'           # kernel used
                               ,kernRange = 'minmax'          # range to interpolate the kernel desity
                               ,norm='zeroone'                # method used to normalize the kernel
                               ,ptxlab=''                     # xlabel for plot
                               ,ptylab=''                     # ylabel for plot
                               ,ptmain=''                     # title for plot
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
                               ,linLwd = c(2)                 # line weights of lines in linAdd (same order)
                               
){
  # number of steps (time, distance, etc.)
  ns <- nrow(dataTraces)
  
  # number of traces, 1 column of dataTraces is the step values
  nt <- ncol(dataTraces)-1
    
  #### completing kernel density estimation
  # initializing matrices to hold the density and the locations
  kernDens <- matrix(NA,ns,kernN)
  kernLocs <- matrix(NA,ns,kernN)
  
  # looping over the steps
  for(i in 1:ns){
    # cases for different kernel density estimation
    if(is.na(kernRange)){ # case for no from-to specified
      kernTemp <- density(unlist(dataTraces[i,-1])
                          ,adjust=kernAdj  # adjustment to bandwidth
                          ,n=kernN         # number of points to estimate kernel
                          ,kernel=kernType # kernel to use
      )
    }else if(kernRange == 'minmax'){# case of minimum and maximum used as range for step
      kernTemp <- density(unlist(dataTraces[i,-1])    # accessing row from matrix (less column 1)
                          ,from=min(dataTraces[i,-1])    # lower limit is minimum
                          ,to=max(dataTraces[i,-1])      # upper limit is maximum
                          ,adjust=kernAdj  # adjustment to bandwidth
                          ,n=kernN         # number of points to estimate kernel
                          ,kernel=kernType # kernel to use
                          )
    }
 
    # storing values, "y" is the density and "x" are the locations
    kernDens[i,] <- kernTemp[['y']]
    kernLocs[i,] <- kernTemp[['x']]
  }
  
  # normalizing results
  kernDensSc <- kernDens
  if(norm == 'zeroone'){
    for(i in 1:ns){ # scaling all values to [0,1] at a given time step
      kernDensSc[i,] <- (kernDensSc[i,] -min(kernDensSc[i,]))/(max(kernDensSc[i,]) -min(kernDensSc[i,]))
    }
  }else if(norm == 'onemode'){
    for(i in 1:ns){ # scaling all values so the mode is 1
      kernDensSc[i,] <- kernDensSc[i,]/max(kernDensSc[i,])
    }
  }else if(norm == 'nonorm'){
    # no normalization of the values
    kernDensSc <- kernDensSc
  }
  
  # setting limits
  if(is.na(ptylim)){
    ylims <- c(min(dataTraces[,-1]),max(dataTraces[,-1]))
  }else{
    ylims <- ptylim
  }

  if(is.na(ptxlim)){
    xlims <- c(min(dataTraces[,1]),max(dataTraces[,1]))
  }else{
    xlims <- ptxlim
  }
  
  # initializing plots
  if(add==F){
    plot(NA,NA
         ,ylim=ylims
         ,xlim=xlims
         ,ylab=ptylab
         ,xlab =ptxlab
         ,main=ptmain
    )
  }
  
  # adding a background rectangle, if desired
  if(is.na(ptBg) == F){
    rect(par("usr")[1],par("usr")[3],par("usr")[2],par("usr")[4]
         ,col=ptBg
         ,border=NA)
  }
  
  # adding gridlines, if desired
  if(is.na(gridCol) == F){
    if(gridOrd == 'bottom'){
      grid(col=gridCol
           ,lty=gridLty
           ,lwd=gridLwd)
    }
  }
  
  print("hi")
  # loops to plot all polygons
  # loop over kernel density at a given step
  for(i in 1:(ncol(kernDensSc)-1)){
    # loop over steps
    for(j in 1:(ns-1)){
      
      # choosing method of assigning color
      if(colAssign == 'mean'){ # real-space mean
        assignedVal <- mean(c(kernDensSc[j,i],kernDensSc[j,i+1],kernDensSc[j+1,i+1],kernDensSc[j+1,i]))
      }else if(colAssign == 'prod'){ # product
        assignedVal <- kernDensSc[j,i]*kernDensSc[j,i+1]*kernDensSc[j+1,i+1]*kernDensSc[j+1,i]
      }else if(colAssign == 'logmean'){ # log-space mean
        assignedVal <- exp(log(kernDensSc[j,i]*kernDensSc[j,i+1]*kernDensSc[j+1,i+1]*kernDensSc[j+1,i])/4)
      }else if(colAssign == 'median'){
        assignedVal <- median(c(kernDensSc[j,i],kernDensSc[j,i+1],kernDensSc[j+1,i+1],kernDensSc[j+1,i]))
      }
     
      # making a polygon
      polygon(x=c(dataTraces[j,1],dataTraces[j,1],dataTraces[j+1,1],dataTraces[j+1,1])
              ,y=c(kernLocs[j,i],kernLocs[j,i+1],kernLocs[j+1,i+1],kernLocs[j+1,i])
              ,density=500
              ,border=NA
              ,col=colorRampPalette(colPal)(colN)[(colN-1)*round(assignedVal,digits=floor(log10(colN)))+1]
      )
    }
  }
  
  print("hi2")
  
  # adding lines
  if(is.na(linAdd) == F){
    # loop over arguments
    for(i in 1:length(linAdd)){
      
      if(linAdd[i] == 'mean'){ # mean of traces
        lin <- apply(dataTraces[,-1],1,mean)
      }else if(linAdd[i] == 'median'){ # median of traces
        lin <-  apply(dataTraces[,-1],1,median)
      }else if(linAdd[i] == 'min'){ # minimum of traces
        lin <-  apply(dataTraces[,-1],1,min)
      }else if(linAdd[i] == 'max'){ # maximum of traces
        lin <-  apply(dataTraces[,-1],1,max)
      }
      
      # adding lines
      lines(dataTraces[,1]
            ,lin
            ,col=linCol[i]
            ,lwd=linLwd[i]
            ,lty=linLty[i]
            )
    }
  }
  
  # adding gridlines, if desired
  if(is.na(gridCol) == F){
    if(gridOrd == 'top'){
      grid(col=gridCol
           ,lty=gridLty
           ,lwd=gridLwd)
    }
  }
  
}# end function