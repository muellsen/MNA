# Computation of results and Reproduction of Figures 5 and S5 in the manuscript [2]

* [2] Ruiz et al., [A single early-in-life macrolide course has lasting effects on murine microbial network topology and immunity](https://www.nature.com/articles/s41467-017-00531-6), Nature Communications vol 8:518 (2017)


## Plotting ##
Using the data comprised in the .mat file, the following script allows the creation of the published Figures 5 and S5 in [2].

```MATLAB
% Run this script to create the figures
createPATFigures.m
```

## Analysis ##
Using the networks as input, the following script shows the workflow for creating the data behind the published Figures 5 and S5 in [2].

```MATLAB
% This will redo the robustness and graphlet analysis on the networks and should result in (near) identical results that have been provided in the .mat files

analyzePATNetworks.m
```
