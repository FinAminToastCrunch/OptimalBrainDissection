function [m b rho] = fetch_normalization(jj)
%% jj is the index of the molecule (1-7)

%% experiments in gold that were identical conditions to test
trainingfile = '../INPUT/normalization/common_training.csv';
goldfile = '../INPUT/normalization/common_gold.csv';

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% the first col of T and G is time, the rest are measurements the 
[T T_rowlabels T_collabels] = loader(trainingfile);
[G G_rowlabels G_collabels] = loader(goldfile);
labels = T_collabels(4:end);

%% seperate the time col from the measurements
T_time = T(:,1);
G_time = G(:,1);
T = T(:,2:end);
G = G(:,2:end);

x = log10(T(:,jj) + 1);
y = log10(G(:,jj) + 1);

[m b rho] = fit_line(x,y);

