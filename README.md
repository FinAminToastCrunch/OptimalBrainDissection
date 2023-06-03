# Gene Regulatory Network Discovery (GRND)
This repository contains the code for disoovering regulatory networks given gene expressions over time. The code is seperated into two parts. The first part is *old code*. The old code are various scripts which have tried to tackle this problem before I (Fin), joined. This includes scripts to normalize and extract the gene data. And it also contains the initil attempt at creating an autoencoder. However, this existing code has various issues such as being implemented in tensorflow 1. These prior scripts are placed in the "old code" folder for reference. 

The original purpose of this project was to discrover the regulatory network within the Arabidopsis plant. However, due to this dataset being unpublishable, we modified our work to run/evaluate on the *Dream 4 insilico_size100_{N}_timeseries* dataset (where N = {1,2,3,4,4}). 

The remaining files are the most recent attempts at solving the GRND problem. Some of the paths within the scripts might need to be changed to match your directory structure (we did not use relative paths when writing these scripts). The code should work without any issue with any version tensorflow 2.X as long as you have the usual libraries installed (ie, matplotlib, numpy, scipy). **Tensorflow 1 is NOT supported**.  

Any question about this repository should posted in the issues section or emailed to samin2@ncsu.edu 
