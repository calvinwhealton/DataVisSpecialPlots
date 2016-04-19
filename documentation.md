##Documentation for code in 'DataVisSpecialPlots' (repository by Calvin Whealton on GitHub, https://github.com/calvinwhealton/DataVisSpecialPlots)

Only the main functions are documented in the following code, not functions called within a function provided that the secondary function calls have inputs that are defined in the overall function call.

## `kernelSmoothTraces()`

**_General Info_**:

This function plots a smoothed kernel density estimate based on several traces of a simulation/optimization run. The data should be formatted in a data frame with a time/distance/NFE index and the value for each trace at that index. Examples might be monthy values of the squirrel population based on 50 simulations of the population (in example, actually the data is made up) or the hypervolume from an optimization algorithm for different number of function evaluations with different random seeds. Saving a plot as a PDF can be memory intensive because the kernel is estimated at 512 places (default values) for each time step (ns steps), so the total number of polygons drawn is 511*(ns-1). For 20 time steps, this would be 9709 polygons (it takes some time), so consider using png or jpg as alternatives.

**_Inputs_**:

_Data Frame and Miscellaneous_

**dataTraces**: R  data frame (or traces) that has the first column as the time/distance/NFE and the remainder of the columns are individual traces.

**add**: Is the plot to be added to an existing plot. Default `add = F`.

**norm**: Normalization method used before assigning colors. Default `norm = 'zeroone'` so that at each time step the kernel values are normalized to the range [0,1]. Other options include 'onemode' for scaling the maximum kernel value to 1 at each time step and 'nonorm' for the maximum of all the kernal values (maximum of all time steps) scaled to 1. Using 'nonorm' will not be as informative if the traces have a wide range in spread at different steps because the estimated kernel will be very small when there is large spread.

_Color Variables_

**colPal**: Color palette that will be interoplated when making the plot. Default `colPal = brewer.pal(9,'PuBu')` for the blue/gray Color Brewer palette.

**colAssign**: Method of assigning the color to a polygon based on the kernel values at its for corners. Default `colAssign = 'mean'` for using the mean of the four points to assign the color. Other options include 'prod' for the product, 'median' for the median, and 'logmean' for the mean log-space value.

**colN**: Number of colors used in the color scale. Default `colN = 100` for 100 colors. This is passed as the number of interpolation colors in the `colorRampPalette()` within the function. Increase value for smoother look and decrease value for more discrete look.

_Kernel Estimation_

**kernN**: Number of interpolation points in the kernel passed to `density()` as `n` . Default `kernN = 512` (also default for `density()` in R). Should be a power of 2.

**kernAdj**: Adjustment to the bandwidth passed to `density()` as `adjust`. Default 'kernAdj == 1` (also default for `density()` in R). Increasing the value makes it smoother and decreasing the value makes it more bumpy.

**kernType**: Type of kernel to use passed to `density()` as `kernel`. Default `kernType = 'gaussian'` for a Gaussian kernel. See documentation of `density()` for other options.

**kernRange**: Range of the kernel interpolation used to define `to` and `from` in `density()`. Default `kernRange = 'minmax'` so the kernel estimation will not be beyond the minimum and maximum of the traces at a given time step. Set to `NA` for using the `density()` default values.

_Plot Parameters_

**ptxlab**: Label for the x-axis. Default `ptxlab = ''` for no label.

**ptylab**: Label for the y-axis. Default `ptylab = ''` for no label.

**ptmain**: Title for plot. Default `ptmain = ''` for no title.

**ptxlim**: Limits for the x-axis. Default `ptxlim = NA` uses the minimum and maximum of the time/distance/NFE index.

**ptylim**: Limits for the y-axis. Default `ptylim = NA` uses the minimum and maximum of the traces.

**ptBg**: Background for the plot. Default `ptBg = NA` means no background color for the plot. Change to a color for the background box as desired (e.g. 'blue' or 'gray').

_Grid Parameters_

**gridOrd**: Order of the grid plotting. Default `gridOrd = 'bottom'` for the gridlines below the kernel smoothed polygons. Change to 'top' for the gridlines to be drawn ontop of the smoothed kernel.

**gridLwd**: Line weight for the grid lines. Default `gridLwd = 2`, increase value for thicker grid lines, decrease value for thinner grid lines.

**gridLty**: Line type for the grid lines. Default `gridLty = 2` for dashed. Look at R graphical parameters for lines for other options.

_Additional Lines_

**linAdd**: Vector of strings for lines to add to the plot. Default `linAdd = c('mean')` for adding the mean, can also add 'median', 'min', and 'max' by adding those strings to the vector.

**linCol**: Vector of colors for lines (same order as `linAdd`). Default `linCol = 'black'` for a black line. Can use any R colors.

**linLty**: Vector of line types for lines (same order as `linAdd`). Default `linLty = c(1)` for a solid line. Can use other line types defined in R.

**linLwd**: Vector of line weights for lines (same order as `linAdd`). Default `linLwd = 2`, increase for thicker lines, decrease for thinner lines.

**_Output_**:

Graph that plots the smoothed kernel density estimate and any of the desired lines.

## `evalPlotIndsRadCon()`

**_General Info_**

Function to plot the results of a Sobol' sensitivity analysis with first-order, total-order, and second-order indices. The results should be formatted as shown in the example files, which were based off of output from the python package `SALib`. The code selects which indices are important based on several user-specified criteria and then only plots results for those indices.

**_Inputs_**:

**df**: Data frame with the S1's, ST's, names of variables, and confidence intervals if using `s1stmeth = 'sig'`.

**dfs2**: Data frame/matrix with S2 values in upper triangular form. Values are assumed in the same order as the S1's and ST's.

**dfs2Conf**: Data frame/matrix with S2 confidence interval values in upper triangular form. Values are assumed in the same order as the S1's and ST's.

**gpNameList**: List with groups. The list is composed of group names with a vector of variables assigned to each. An example entry in the list would be `'group1' = c('x1','x2','x3')`, which would be interpreted as the group "group1" is composed of variables "x1", "x2", and "x3".

**gpColList**: List of colors for each group. Default `col_list = NULL` implies that a Color Brewer palette will be used. User-specified entries should be of the form `'group1'='deepskyblue'`, which means that "group1" would be assigned a color of "deepskyblue".

**s1stgtr**: Used as threshold for evaluating significant indices when `s1stmeth ='gtr'`. Default `s1stgtr=0.01`, so all indices that are greater than 0.01 will be considered significant.

**s1stmeth**: Method for evaluating significance of indices. Default option is `s1stmeth='sig'` for index must be statistically significant based on the confidence intervals. Other option is `s1stmeth='gtr'` for index must be greater than a value to be significant.

**s1stsigCri**: Parameter for controling whether when a variable is significant for plotting. Default `s1stsigCri='either'` so that if either the first- or total-order index is significant the variable will be plotted. If `s1stsigCri='S1'` then only varibles with significant first-order indices will be plotted. If `s1stsigCri='ST'` then only variables with significant total-order indices will be plotted. If `s1stsigCri='both'` then both the first- and total-order indices must be significant for the variable to be plotted.

**s2meth**: Method for evaluating significance of indices. Default option is `s2meth ='sig'` for index must be statistically significant based on the confidence intervals. Other option is `s2meth ='gtr'` for index must be greater (absolute value greater) than a value to be significant.

**s2gtr**: Used as threshold for evaluating significant indices when `s2gtr ='gtr'`. Default `s2gtr =0.01`, so all indices that are greater than 0.01 will be considered significant.

**ptTitle**: Title for the plot. Default is `ptTitle = ''` for no title.

**ptFileNm**: File name for the saved plot. Default `ptFileNm = 'plot'`. Do not include the file extension.

**ptType**: Format for saving the plot. Default `ptType = 'EPS'`. Other options include 'PNG' and 'PDF'.

**ptS2**: Should second-order indices be plotted (connecting lines). Default `ptS2 = TRUE'`.

**ptRadSc**: Radius scaling of plot. Default `ptRadSc = 2`. Increasing `ptRadSc` will increase the spacing between points.

**ptScCirc**: Scaling factor applied to individual circle and line sizes. Default `ptScCirc = 1`. Increasing `ptScCirc` will cause the points and lines to become wider, so closter together.

**ptCircSc**: Power used when scaling the width of circles and lines. Default `ptCircSc = 0.5` for square root, so area of the circles is proportional to the index. If `ptCircSc = 1` then the diameter of the circules would be proportional to the index.

**ptSTthick**: Value used to assign thickness of the total-order sensitivity index circle. Default `ptSTthick = 0.05`. Increasing `ptSTthick` makes the  total-order index circles thicker.

**ptLineCol**: Color for the lines. Default `ptLineCol = 'gray48'`.

**ptStcol**: Color for the total-order index ring. Default `ptStcol = 'black'`.

**ptS1col**: Color for the first-order index circile. Default `ptS1col = 'gray48'`.

**ptVarNmMult**: Location of the variable name with respect to the radius of the plot. Default `ptVarNmMult = 1.2`. Increasing the value will move the names farther away from the circles.

**gpNmMult**: Location of the group name with respect to the radius of the plot. Default `gpNmMult = 1.6`. Increasing the value will move the names farther away from the circles.

**ptLegLoc**: Legend location. Default `ptLegLoc = 'topleft'`. Other options are 'bottomright', 'bottomleft', and 'topright'.

**ptLegPos**: Legend relative position. Default `ptLegPos = 1.9`.

**ptRes**: Resolution of the plot for .png files. Default `ptRes=100`. If getting errors about figure margins change this parameter.

**ptQual**: Quality of the jpeg file in % of the original. Default `ptQual = 90`. Currently not used because jpegs not generated.

## `makeTaylorDiag()`

**_General Info_**:

Function to make a Taylor diagram. The code calls several subsidiary functions for adding the correlation, RMS, and standard deviation lines. Many graphical parameters must be specified including the tick marks and values of the plotted "grid".


**_Input**:

_Model Calculations_

**stdevs**: Vector of standard deviations of the models. Must be specified by the user.

**correls**: Vector of correlations of the model with the observation. Must be specified by the user.

**corMajors**: Vector of values of the correlations that will have lines extending to the center of the plot.

**CorMinors**: Vector of values of the correlations that will only have tick marks.

**stdevLim**: Limit to the standard devaition values plotted.

**stdevMajors**: Vector of major values of the standard devaitions with semicircular lines.

**RMSmajors**: Vector of major values of the RMSs with semicircular lines. Can make this larger than `stdevLim` so that the RMS lines will still plot otherwise some might be missing. The RMS lines can be off-centered so the values need to be larger to fill the space. See example plots.

**RMSobj**: Offset for the RMS center.

**namMod**: Vector of the names of the models.

_Points_

**ptsCols**: Vector of colors for the models/points. Default `ptsCols = NA` uses a the `topo.colors()` in grDevices. Must be as long as the number of models.

_Standard Deviation Grid_

**stdevCol**: Color of the standard devaition grid lines. Default `stdevCol = 'black'`. Can be changed to any R color.

**stdevLwd**: Line weight of the standard deviation grid lines. Default `stdevLwd = 1`. Increase to make grid lines thicker. Decrease to make grid lines thinner.

**stdevLty**: Line type of the standard deviation grid lines. Default `stdevLty = 1` for solid lines. Can change to any R line type.

**stdevLabAdj**: Adjustment to the standard deviation label location. Default `stdevLabAdj = -0.2` for moving it 0.2 units below the axis. Will need to change based on the scale of the plot.

**stdevTitleLAdj**: Adjustment to the standard deviation axis title location. Default `stdevLabAdj = -0.6` for moving it 0.6 units below the axis. Will need to change based on the scale of the plot.

**stdevTextCex**: Character expansion for the standard devation text. Default `stdevTextCex = 0.7`. Increase to make text larger, decrease to make text smaller.

_Correlation Grid_

**corColor**: Color for the correlation grid. Default `corColor = 'blue'`. Can change to any R color.

**corLwd**: Line weight for the correlation grid. Default `corLwd = 1`. Increase for thicker grid lines and decrease for thinner grid liens.

**corLty**: Line type for the correlation grid. Default `corLty = 1` for a solid line. Can use any R line type.

**corTickAdjMaj**: Adjustment for the major correlation tick labels. Default `corTickAdjMaj = 0.02`. Increase value for a larger spacing.

**corTickAdjMin**: Adjustment for the minor correlation tick labels. Default `corTickAdjMin = 0.01`. Increase value for larger spacing.

**corTextCex**: Character expansion for the correlation lables. Default `corTextCex = 0.5`. Increase for larger text.

**corTextAdj**: Adjustment for the title. Default `corTextAdj = 0.05`. Increase to make the title farther above the axis.

_RMS Grid_

**RMScolor**: Color for the RMS grid. Default `RMScolor = 'green'` for a green grid. Can be changed to any valid R color.

**RMSlty**: Line type for the RMS grid. Default `RMSlty = 1` for a solid line. Any valid R line type can be used.

**RMSweight**: Line weight for the RMS grid. Default `RMSlwd = 1`. Increase for thicker grid lines.

**RMStitleAjd**: Adjustment for the location of the RMS title. Default `RMStitleAdj = -1.2` for 1.2 units below the horizontal axis.

**RMStextCex**: Character expansion for the RMS title. Default `RMStextCex = 0.7`. Increase for larger RMS  axis title.

**RMSobsPch**: Plotting symbol for the center of the RMS axis. Default `RMSobsPch = 15` for a square. Any valid R plotting symbol can be used.

_Points_

**ptsPch**: Plotting symbol for model points. Default `ptsPch = 19` for a circle. Any valid R plotting symbol can be used.

**ptsCex**: Plotting symbol expansion for the model points. Default `ptsCex = 1.5`. Increase for larger model points and decrease for smaller model points.

_Legend_

**leg**: Should legend be plotted. Default `leg = T`.

**legDY**: Vertical offset for legend. Default `legDY = -2`. Change based on the scale of the axis.

**legColumn**: Number of columns for the legend. Default `legColumn = 3`.
