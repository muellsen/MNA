# Microbial Network Analysis (MNA) in MATLAB


This project comprises a collection of functions and scripts for (microbial) network analysis. This repository is constantly expanded and tested. Many of the scripts have been used in a number of publications, see, e.g., in 
* [1] Ruiz et al., [A single early-in-life macrolide course has lasting effects on murine microbial network topology and immunity](https://www.nature.com/articles/s41467-017-00531-6), Nature Communications, vol 8:518 (2017)

* [2] Tipton, Müller, et al. [Fungi stabilize connectivity in the lung and skin microbial ecosystems](https://microbiomejournal.biomedcentral.com/articles/10.1186/s40168-017-0393-0), Microbiome, vol 6:12 (2018) 


The folder Paper-Ruiz-2017/ comprises results from [1].
The folder Tipton-2018/ comprises results from [2].

## Graphlets, graphlet correlations, and graphlet correlation distance computation

The folder GraphletComputation/ shows how to do microbial network comparisons for networks of different sizes. It is based on 
the Graphlet Correlation Distance (GCD), as introduced in 
* [3] Yaveroglu et al., [Revealing the Hidden Language of Complex Networks](https://www.nature.com/articles/srep04547), Scientific Reports, vol 4:4547 (2014).

For computation of the graphlets (i.e., small induced subgraphs), the orca package is used, as introduced in
* [4] Hocevar & Demsar, [A combinatorial approach to graphlet counting](https://academic.oup.com/bioinformatics/article/30/4/559/205331), Bioinformatics, vol 30:4,559--565 (2014).
The github CRAN read-only mirror for the orca package can be found [here.](https://github.com/cran/orca)

* [5] Hocevar & Demsar, [Computation of graphlet orbits for nodes and edges in sparse graphs](https://www.jstatsoft.org/article/view/v071i10/0), Journal of Statistical Software,  vol 71:10 (2016)
The orca homepage with supporting information can be found [here.](http://www.biolab.si/supp/Rorca/) 




