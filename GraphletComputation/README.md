# Graphlet computation for microbial networks

The folder GraphletComputation/ shows how to do microbial network comparisons for networks of different sizes. It is based on 
the Graphlet Correlation Distance (GCD), as introduced in 
* [4] Yaveroglu et al., [Revealing the Hidden Language of Complex Networks](https://www.nature.com/articles/srep04547), 
Scientific Reports vol 4:4547 (2014)

For computation of the graphlets (i.e., small induced subgraphs), the orca package is used, as introduced in
* [5] Hocevar & Demsar, [A combinatorial approach to graphlet counting](https://academic.oup.com/bioinformatics/article/30/4/559/205331), Bioinformatics vol 30:4,559--565 (2014)
The github CRAN read-only mirror for the orca package can be found [here.](https://github.com/cran/orca)

* [6] Hocevar & Demsar, [Computation of graphlet orbits for nodes and edges in sparse graphs](https://www.jstatsoft.org/article/view/v071i10/0), Journal of Statistical Software,  vol 71:10 (2016)
The orca homepage with supporting information can be found [here.](http://www.biolab.si/supp/Rorca/)

## Installation

You may need to compile the orca package on your machine first before using it within MATLAB. See [here.](http://www.biolab.si/supp/Rorca/) for installation guidance

## Graphlet computations

After downloading the MNA package, go to the GraphletComputation/ folder and run the script

```MATLAB
% Run this script
testGraphletComputation
```
The script loads five microbial networks used in the PAT study [2] and shows 
* how to computation graphlet correlation (GC) matrices for each network,
* how to compute distances between networks using these GC matrices,
* how to do a 2D MDS embedding.

All MATLAB files are documented.

