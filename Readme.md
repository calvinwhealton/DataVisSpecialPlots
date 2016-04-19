##DataVisSpecialPlots
Scripts and Functions for Data Visualization and Specialized Plots

__Introduction__

Most of these plotting functions were the result of questions on stackoverflow.com or graphics that my colleagues wanted to make but were unsure how to develop. Some of the methods of representing the data were developed by others, but I did implement it in code. Generally, the code is designed to be easily "hacked" by users so that they can modify inputs to control the output. 

Currently, there are the following dependencies on R libraries: RcolorBrewer, grDevices, graphics.

The specialized plots available are: Taylor Diagram and Smoothed Desnity Estimate of Traces. More details are provided below.

##__Smoothed Density Estimate of Traces__
----
This plot is designed to plot the results of several optimization/simulation runs by giving distributional shape information instead of many lines. For each of these simulations/optimizations, there must be simulation/optimization values for each trace at the same set of time steps, distance steps, or number of function evaulations. The code reads-in this data as a CSV file (first column is the time/distance/NFE) and the other columns are the value associated with the traces at that step. It then uses the `density` function in R to estimate the kernel at each of the steps. The values cal be rescaled so that the values are in the range [0,1] for interpolation in color. Individual polygons are drawn between the kernel estimation points in each step and the corresponding points in the next step (first kernel point in step 1 matches to first kernal point in step 2). An example plot is shown below with an added line for the mean. More detail on the graphical options is aviable in "documentation.md".

![Image of a Smoothed Kernel Density Plot for Traces](https://github.com/calvinwhealton/DataVisSpecialPlots/blob/master/example_kernelSmooth3.jpg)




![Image of a Taylor Diagram](https://github.com/calvinwhealton/DataVisSpecialPlots/blob/master/example_TaylorDiagram2.png)



The specialized plots currently available are:

__Taylor Diagram__ (used for comparing models with data)



More information on the functions is available in 'DOCUMENTATION.md'.
