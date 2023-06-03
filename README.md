# Gene Regulatory Network Discovery (GRND) via Optimal Brain Dissection (OBD)

The following repository contains code for pruning autoencoders to perform GRND. GRND is the task of identifiying which protiens pairs have regulator-target interactions. The methdology of OBD is as follows: 
- Autoencoders are tasked with reconstructing an input while maintaining a bottleneck in the size of the encoded input. They do this by learning a compressed representation of the input to be decoded by a decoder. The decoder is trained to reconstruct the input given the compressed representation produced by the encoder. The overall goal is to have the output of the autoencoder be as similar to the input as possible while maintaining a certain target compression ratio.   
- Because the encoder learns a compressed representation of the input, some of the input features are discarded/not used during the compression--conversely, some features are extremely important and if they are not used, they harm the reconstruction capabilities. 
- When the autoencoder is constructed, a mask which represents the suspected regulator-target interactions is used to initialize the weights associated with the input. The connections between candidate regulator-targets are represented by a mask/adjacency-matrix. For example, if there were 5 protiens, there would be a mask of size 5x5. A potential regulator-target connection between protein 2 (regulator) and protein 3 (target) would be represented in this mask by a 1 in mask[2][3]. A 0 represents no suspected connection. The encoder performs the following operation at the input: G x M, where G are the input gene expressions over time (num time steps x num proteins), and M is the afformentioned mask (num protiens x num protiens).  
- Pruning is the process of reducing the number of weights in a neural network while maintaining network performance. During pruning, we find the weights which are most important (ie, the ones which should be kept if we want to maintain reconstruction performance). In other words... what would happen if we prune the mask?

**Key hypothesis: The weights which influence the error the most correspond with key regulator-target connections.**

 
## Old Code
This repository contains the code for discovering regulatory networks given gene expressions over time. The code is seperated into two parts. The first part is *old code*. The old code are various scripts which have tried to tackle this problem before I (Fin), joined. This includes scripts to normalize and extract the gene data. And it also contains the initil attempt at creating an autoencoder. However, this existing code has various issues such as being implemented in tensorflow 1. These prior scripts are placed in the "old code" folder for reference. 

## Arabidopsis GRND

The original purpose of this project was to discover the regulatory network within the Arabidopsis plant using 5 different datasets. The way this is done is by amalgamating the time-series data of the five datasets in two different ways: 
    1) One way is to generate an entirely synthetic dataset using the linear model which matches the dimensionality and time stepping of dataset 1 (the colombia dataset). We call this dataset the *synthetic dataset* for Arabidopsis. 
    2) Another way is to interpolate additional time steps within existing datasets to match the dimensionality but not necessarily the time steps of experiment 1. We call this dataset the *interpolated dataset* for Arabidopsis. 
    
The Data_interpolation.ipynb file produces these two datasets given the 5 datasets for the Arabidopsis plant. 

## Dream 4 GRND

However, due to the datasets for Arabidopsis being unpublishable, we modified our work to run/evaluate on the *Dream 4 insilico_size100_{N}_timeseries* dataset (where N = {1,2,3,4,4}). 

The remaining files are the most recent attempts at solving the GRND problem. Some of the paths within the scripts might need to be changed to match your directory structure (we did not use relative paths when writing these scripts). The code should work without any issue with any version tensorflow 2.X as long as you have the usual libraries installed (ie, matplotlib, numpy, scipy). **Tensorflow 1 is NOT supported**.  

Any question about this repository should posted in the issues section or emailed to samin2@ncsu.edu 
