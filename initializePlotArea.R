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