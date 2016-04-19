##Documentation for code in 'DataVisSpecialPlots' (repository by Calvin Whealton on GitHub, https://github.com/calvinwhealton/DataVisSpecialPlots)

Only the main functions are documented in the following code, not functions called within a function provided that the secondary function calls have inputs that are defined in the overall function call.

## `kernelSmoothTraces()`

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

**_Output_**

Graph that plots the smoothed kernel density estimate and any of the desired lines.
