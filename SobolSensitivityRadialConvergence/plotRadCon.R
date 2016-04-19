# function to complete all significance and plotting
evalPlotIndsRadCon <- function(df                   # data frame of S1 and ST indices (and confidence intervals if evaluating significance)
                               ,dfs2                # matrix/data frame of S2 indices
                               ,dfs2Conf            # matrix/data frame of S2 indices confidence interval
                               ,gpNameList          # list of variables names for each group
                               ,gpColList=NULL      # list of colors for each group
                               ,s1stgtr=0.01        # criteria for significance of S1 and ST if using method 'gtr'
                               ,s1stmeth='sig'      # method for evaluating significant of S1 and ST
                               ,s1stsigCri='either' # method for determining plotting significance based on S1 and ST
                               ,s2meth='sig'      # method for evaluating significant S2 indices
                               ,s2gtr = 0.01        # threshold used when s2 method is gtr
                               ,ptTitle = ''        # title for plot
                               ,ptFileNm='plot'     # name for plot
                               ,ptType = 'EPS'      # type of file for plot
                               ,ptS2 = TRUE         # plot S2's
                               ,ptRadSc = 2         # radius scaling of entire plot
                               ,ptScCirc=1          # scaling factor for plot
                               ,ptCircSc = 0.5      # power used in scaling width, 0.5 is root, 1 is simple multiple
                               ,ptSTthick = 0.05    # value used in determining the width of the ST circle
                               ,ptLineCol ='gray48' # color used for lines
                               ,ptStcol = 'black'   # color for total-order index circle
                               ,ptS1col = 'gray48'  # color for first-order index disk(filled circle)
                               ,ptVarNmMult = 1.2   # location of variable name with respect to the plot radius
                               ,gpNmMult = 1.6      # location of the group name with respect to the plot radius
                               ,ptLegLoc = 'topleft'# legend location
                               ,ptLegTh=c(0.1,0.5)  # legend thickensses
                               ,ptLegPos=1.9        # relative location of legend
                               ,ptRes=100           # resolution for the plot file
                               ,ptQual=90           # quality of a JPG
                               
){
  
  
  # evaluating the signficant points for plotting
  dfcalc <- stat_sig_s1st(df=df
                          ,greater = s1stgtr
                          ,method=s1stmeth
                          ,sigCri = s1stsigCri)
  
  # evaluating significant S2's
  dfs2plot <- stat_sig_s2(dfs2 = dfs2
                          ,dfs2Conf = dfs2Conf
                          ,method = s2meth
                          ,greater=s2gtr)
  
  # assigning group information
  dfcalc <- gp_name_col(name_list=gpNameList  
                        ,col_list=gpColList 
                        ,df=dfcalc)
  
  # plotting results
  plotRadCon(df=dfcalc
             ,s2=dfs2
             ,s2_sig=dfs2plot
             ,title=ptTitle
             ,filename = ptFileNm
             ,plotType = ptType
             ,plotS2 = ptS2
             ,radSc = ptRadSc
             ,scaling=ptScCirc
             ,widthSc = ptCircSc
             ,STthick = ptSTthick
             ,line_col = ptLineCol
             ,st_col = ptStcol
             ,s1_col = ptS1col
             ,varNameMult = ptVarNmMult
             ,gpNameMult = gpNmMult
             ,legLoc = ptLegLoc
             ,legThick = ptLegTh
             ,legPos=ptLegPos
             ,res = ptRes
             ,qual=ptQual)
  
  # returning data frame with calculations
  return(dfcalc)
}


# functions for substituting group information into dataframe
# function for assigning group name and color to group
gp_name_col <- function(name_list       # list of variables names for each group
                        ,col_list=NULL  # list of colors for each group
                        ,df             # data frame of values with ind as the variable name
){
  
  # initializing columns
  df$gp_name <- NA # group name
  df$gp_col <- NA  # group colors
  
  # checking for the same variable names
  n1 <- sort(names(name_list))
  if(is.null(col_list) == TRUE){
    n2 <- n1
  }else{
    n2 <- sort(names(col_list))
  }
  
  if(is.null(col_list)){
    print('Group color list not defined, using default')
    assignCol <- TRUE
  }else if(length(setdiff(n1,n2)) != 0){
    print('Group names do not match across the two lists')
    assignCol <- FALSE
  }else{
    assignCol <- TRUE
  }
  
  # loop over the variables in each group and assign group name
  for(i in 1:length(n1)){
    
    # extracting the variable names for the given element
    var_names <- unlist(name_list[names(name_list)[i]])
    
    # loop over the values in each list
    for(j in 1:length(var_names)){
      # substituting group name in for the variable
      df$gp_name[which(df$ind %in% var_names[j])] <- names(name_list)[i]
    }
  }
  
  # loop over the group names and assign the color
  if(assignCol == TRUE){
    if(is.null(col_list)==TRUE){
      colorsGps <- brewer.pal(length(names(name_list)),'Set1')
      for(i in 1:length(names(name_list))){
        df$gp_col[which(df$gp_name %in% unlist(names(name_list))[i])] <- colorsGps[i]
      }
    }else{
      for(i in 1:length(names(col_list))){
        df$gp_col[which(df$gp_name %in% unlist(names(name_list))[i])] <- unlist(col_list[names(col_list)[i]])
      }
    }
  }
  
  # returning data frame with additional columns
  return(df)
}


# function for plotting the radial convergence plots
# function takes input data frame
plotRadCon <- function(df                   # dataframe with S1 and ST indices
                       ,s2                  # S2 indices
                       ,s2_sig              # S2 significance matrix
                       ,title=''            # title for the plot
                       ,filename = 'plot'   # file name for the saved plot
                       ,plotType = 'EPS'    # plot type
                       ,plotS2 = TRUE       # whether to plot S2 indices
                       ,radSc = 2           # radius scaling of entire plot
                       ,scaling=1           # scaling factor for plot
                       ,widthSc = 0.5       # power used in scaling width, 0.5 is root, 1 is simple multiple
                       ,STthick = 0.05      # value used in determining the width of the ST circle
                       ,line_col ='gray48'  # color used for lines
                       ,st_col = 'black'    # color for total-order index circle
                       ,s1_col = 'gray48'   # color for first-order index disk(filled circle)
                       ,varNameMult = 1.2   # location of variable name with respect to the plot radius
                       ,gpNameMult = 1.6    # location of the group name with respect to the plot radius
                       ,legLoc = 'topleft'  # legend location
                       ,legThick=c(0.1,0.5) # legend thickensses
                       ,legPos=1.9          # legend relative position
                       ,res = 100           # resolution for the plot
                       ,quality=90          # quality of the image
){
  
  # finding number of points to plot
  num_plot <- sum(df$sig)
  
  # polar cooridantes angular-values of locations
  angles <- radSc*pi*seq(0,num_plot-1)/num_plot
  
  # assigning coordinates to varaibles based on groups
  df$rad <- radSc
  df$ang <- NA 
  
  ## coordinates in polar for each variable
  # finding number of groups with a significant variable
  sig_gps <- unique(df$gp_name[which(df$sig %in% 1)])
  
  # initializing vector to hold the number of significant variables for each group
  num_sig_gp <- rep(0,length(sig_gps))
  
  # counter used for indexing the values in the angle vector
  counter <- 0
  
  for(i in 1:length(sig_gps)){
    # indices of variables in group and significant
    sig_in_gp <- intersect(which(df$gp_name %in% sig_gps[i]),which(df$sig %in% 1))
    
    # taking sequential values in the angles vector
    df$ang[sig_in_gp] <- angles[seq(counter+1,counter+length(sig_in_gp),1)]
    
    # indexing counter
    counter <- counter + length(sig_in_gp)
    
    # vector for counting number of statistically signficant variables in the applicable groups
    num_sig_gp[i] <- length(sig_in_gp)
  }
  
  ## converting to Cartesian coordinates
  df$x_val <- df$rad*cos(df$ang)
  df$y_val <- df$rad*sin(df$ang)
  
  ## file set-up storage
  if(plotType == 'EPS'){
    fname <- paste(filename,'.eps',sep='')
    savePlot <- TRUE
    setEPS()
    postscript(fname)
  }else if(plotType == 'PNG'){
    fname <- paste(filename,'.png',sep='')
    png(fname,res=res)
    savePlot <- TRUE
  }else if(plotType == 'PDF'){
    fname <- paste(filename,'.pdf',sep='')
    pdf(fname)
    savePlot <- TRUE
  }#else if(plotType == 'JPEG'){
  #fname <- paste(filename,'.jpg',sep='')
  #jpeg(fname,quality)
  #savePlot <- TRUE
  #}
  else{
    print('Plot not automatically saved')
    savePlot <- FALSE
  }
  ## plotting
  par(pty="s")
  
  # initial plot is empty
  plot(NA
       , NA
       , xlim = c(-2*radSc,2*radSc)
       , ylim = c(-2*radSc,2*radSc)
       , xaxt = 'n'
       , yaxt = 'n'
       , xlab = ''
       , ylab = ''
  )
  
  # plotting all lines that were significant----
  if(plotS2 == TRUE){
    for(i in 1:nrow(s2_sig)){
      for(j in 1:nrow(s2_sig)){
        # only plot second order when the two indices are significant
        if(s2_sig[j,i]*(df$sig[i]*df$sig[j]) == 1){
          
          # coordinates of the center line
          clx <- c(df$x_val[i],df$x_val[j])
          cly <- c(df$y_val[i],df$y_val[j])
          
          # calculating the angle of the center line
          # calculating tangent as opposite (difference in y) 
          # divided by adjacent (difference in x)
          clAngle1 <- atan((cly[2]-cly[1])/(clx[2]-clx[1]))
          
          # adding angle when both values are negative to make it on (-pi/2,3*pi/2)
          if(cly[2]-cly[1] < 0){
            clAngle1 <- clAngle1 + pi
          }
          
          # half width of the line
          line_hw <- scaling*(s2[j,i]^widthSc)/2
          
          # creating vector of polygon coordinates
          polyx <- rep(0,4)
          polyy <- rep(0,4)
          
          polyx[1] <- clx[1] - line_hw*sin(clAngle1)
          polyx[2] <- clx[1] + line_hw*sin(clAngle1)
          polyx[3] <- clx[2] + line_hw*sin(clAngle1)
          polyx[4] <- clx[2] - line_hw*sin(clAngle1)
          
          polyy[1] <- cly[1] + line_hw*cos(clAngle1)
          polyy[2] <- cly[1] - line_hw*cos(clAngle1)
          polyy[3] <- cly[2] - line_hw*cos(clAngle1)
          polyy[4] <- cly[2] + line_hw*cos(clAngle1)
          
          # making polygons
          polygon(polyx,polyy
                  ,density=200
                  ,border=NA
                  ,col=line_col)
        }
      }
    }
  }
  
  for(i in 1:nrow(df)){
    if(df$sig[i] == 1){
      
      # circle for total order index
      draw.circle(df$x_val[i]
                  ,df$y_val[i]
                  ,radius <- scaling*(df$ST[i]^widthSc)/2
                  ,nv=200
                  ,border=NA
                  ,col=st_col
      )
      
      # white circle to make total-order an outline
      draw.circle(df$x_val[i]
                  ,df$y_val[i]
                  ,radius <- (1-STthick)*scaling*(df$ST[i]^widthSc)/2
                  ,nv=200
                  ,border=NA
                  ,col="white"
      )
      
      # gray circle for first-order
      draw.circle(df$x_val[i]
                  ,df$y_val[i]
                  ,radius <- scaling*(df$S1[i]^widthSc)/2
                  ,nv=200
                  ,border=NA
                  ,col=s1_col
      )   
    }
  }
  
  ## adding text to the plots
  # adding variable names
  for(i in 1:nrow(df)){
    if(is.na(df$ang[i]) == FALSE){
      text(varNameMult*df$rad[i]*cos(df$ang[i]), varNameMult*df$rad[i]*sin(df$ang[i])
           , df$ind[i]
           , col = df$gp_col[i]
           , srt = df$ang[i]*360/(2*pi)
           , adj = 0 
      )
    }
  }
  
  # adding group names
  counter <- 0
  for(i in 1:length(num_sig_gp)){
    
    angle_gp <- mean(angles[seq(counter+1,counter+num_sig_gp[i],1)])
    
    counter <- counter + num_sig_gp[i]
    
    text(gpNameMult*radSc*cos(angle_gp), gpNameMult*radSc*sin(angle_gp)
         , sig_gps[i]
         , col = df$gp_col[which(df$gp_name %in% sig_gps[i])[i]]
         , srt =  angle_gp*360/(2*pi) - 90
         , adj = 0.5 # for centering
    )
  }
  
  ## adding legend
  if(legLoc == 'topleft'){
    xloc <- rep(-legPos*radSc ,length(legThick))
    yloc <- seq(legPos*radSc,1*radSc,by=-0.3*radSc )
  }
  else if(legLoc=='topright'){
    xloc <- rep(legPos*radSc ,length(legThick))
    yloc <- seq(legPos*radSc,1*radSc,by=-0.3*radSc )
  }
  else if(legLoc=='bottomleft'){
    xloc <- rep(-legPos*radSc ,length(legThick))
    yloc <- seq(-legPos*radSc ,-1*radSc ,by=0.3*radSc )
  }
  else{
    xloc <- rep(legPos*radSc ,length(legThick))
    yloc <- seq(-legPos*radSc ,-1*radSc ,by=0.3*radSc )
  }
  for(i in 1:length(xloc)){
    # gray circle for legend
    draw.circle(xloc[i]
                ,yloc[i]
                ,radius <- scaling*(legThick[i]^widthSc)/2
                ,nv=200
                ,border=NA
                ,col=s1_col
    )   
    text(xloc[i]*0.8,yloc[i]
         ,as.character(legThick[i])
         ,col=s1_col)
  }
  
  ## adding title for the plot
  text(0,1.8*radSc
       ,labels=title
       ,adj=0.5
       ,cex=1.5)
  
  # closing plot if save to external file
  if(savePlot == TRUE){
    dev.off()
    print(paste('Plot saved to ',fname,sep=''))
  }
}

# functions for testing statistical significance
# determines which indices to plot based on values

# function inputs are:
#   df = data frame with sensitivity indices (S1 and ST)
#         includes columns for S1, ST, S1_conf, and ST_conf
#   method = method of testing
#           'sig' is statistically significant with alpha
#           'gtr' is greater than a specified value
#   sigCri = significance criteria
#             'either' parameter is signficant if either S1 or ST is significant
#             'S1' parameter is significant if S1 (or S1 and ST) is significant
#             'ST' parameter is significant if ST (or S1 and ST) is significant

#####################################################
# function for testing significance of S1 and ST
# functions assume the confidence are for already defined type I error
stat_sig_s1st <- function(df
                          ,greater = 0.01
                          ,method='sig'
                          ,sigCri = 'either'
){
  
  # initializing columns for the statistical significance of indices
  df$s1_sig <- 0
  df$st_sig <- 0
  df$sig <- 0
  
  # testing for statistical significance
  if(method == 'sig'){
    # testing for statistical significance using the confidence intervals
    df$s1_sig[which(abs(df$S1) - df$S1_conf > 0)] <- 1
    df$st_sig[which(abs(df$ST) - df$ST_conf > 0)] <- 1
  }
  else if(method == 'gtr'){
    # finding indicies that are greater than the specified values
    df$s1_sig[which(abs(df$S1) > greater)] <- 1
    df$st_sig[which(abs(df$ST) > greater)] <- 1
  }
  else{
    print('Not a valid parameter for method')
  }
  
  # determining whether the parameter is signficiant
  if(sigCri == 'either'){
    df$sig <- apply(cbind(df$s1_sig,df$st_sig),FUN=max,MARGIN=1)
  }
  else if(sigCri == 'S1'){
    df$sig <- df$s1_sig
  }
  else if(sigCri == 'ST'){
    df$sig <- df$st_sig
  }else if(sigCri == 'both'){
    df$sig <- df$st_sig*df$s1_sig
  }
  else{
    print('Not a valid parameter for sigCri')
  }
  
  # returned dataframe will have columns for the test of statistical significance
  return(df)
}

#####################################################
# function to test statistical significane of S2 indices
stat_sig_s2 <- function(dfs2              # matrix/data frame of second-order indices
                        ,dfs2Conf         # matrix/data frame of second-order indices confidence interval
                        ,greater = 0.01
                        ,method='sig'){
  
  # initializing matrix to return values
  s2_sig <- matrix(0,nrow(dfs2),ncol(dfs2))
  
  # testing for statistical significance
  if(method == 'sig'){
    # testing for statistical significance using the confidence intervals
    s2_sig[which(abs(dfs2) - dfs2Conf > 0)] <- 1
  }
  else if(method == 'gtr'){
    # finding indicies that are greater than the specified values
    s2_sig[which(abs(dfs2) > greater)] <- 1
  }
  else{
    print('Not a valid parameter for method')
  }
  
  # returned dataframe will have 0's and 1's based on significance of values
  return(s2_sig)
}
