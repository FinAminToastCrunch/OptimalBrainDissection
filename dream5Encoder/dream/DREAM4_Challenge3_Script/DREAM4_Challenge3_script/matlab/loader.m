function [A rowlabels collabels] = loader(filename)

d = importdata(filename);
A = d.data;
collabels = d.textdata(1,:);
rowlabels = [ d.textdata(:,1) d.textdata(:,2) ];
