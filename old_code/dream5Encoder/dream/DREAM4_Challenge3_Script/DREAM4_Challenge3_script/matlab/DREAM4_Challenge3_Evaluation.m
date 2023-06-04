%
% This function produces the DREAM4 scores for Challenge 3.
%
% See go.m for an example of how to call it.
%
% Gustavo A. Stolovitzky, Ph.D.
% Adj. Assoc Prof of Biomed Informatics, Columbia Univ
% Mngr, Func Genomics & Sys Biology, IBM  Research
% P.O.Box 218 					Office :  (914) 945-1292
% Yorktown Heights, NY 10598 	Fax     :  (914) 945-4217
% http://www.research.ibm.com/people/g/gustavo
% http://domino.research.ibm.com/comm/research_projects.nsf/pages/fungen.index.html 
% gustavo@us.ibm.com
%
% Robert Prill, Ph.D.
% Postdoctoral Researcher
% Computational Biology Center, IBM Research
% P.O.Box 218
% Yorktown Heights, NY 10598 	
% Office :  914-945-1377
% http://domino.research.ibm.com/comm/research_people.nsf/pages/rjprill.index.html
% rjprill@us.ibm.com
%

function [overall_score, prediction_score, pvals, edge_count] = DREAM4_Challenge3_Evaluation(DATADIR,GOLDDIR,PDFDIR,edge_count)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%DATADIR = '../INPUT/my_processed_prediction/';
%GOLDDIR = '../INPUT/gold_standard/';
%PDFDIR  = '../INPUT/probability_densities/';
%edge_count = 20;

goldfile = [ GOLDDIR 'DREAM4_GoldStandard_SignalingNetworkPredictions_Test.csv' ];
PDF_ROOT = 'pdf_score_';

COST_PER_LINK = 0.0827;
%% COST_PER_LINK was determined empirically from all the teams' submissions
%% as r = min(prediction_score / edge_count).

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% load gold standard
[G G_rowlabels G_collabels] = loader(goldfile);
G_time = G(:,1);
G = G(:,2:end);
G_idx_30 = find(G_time == 30);
G = G(G_idx_30,:);
labels = G_collabels(4:end);

%% load prediction 
files = directory_list(DATADIR);
file = [ DATADIR files{1} ];
[T T_rowlabels T_collabels] = loader(file);
T = T(G_idx_30,2:end);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% compute error and pval for each molecular species

figure(1)
pn = 4;
pm = 3;
pj = 0;

%% for each molecular species (column)
for si = 1:size(G,2)
%for si = 1;

	%% fetch normalization based on common experiments
	[m b rho] = fetch_normalization(si);

	%% one column at a time
	t = T(:,si);
	g = G(:,si);

	%% zero counting correction prevents log(0)
	x_log = log10(t + 1);
	y_log = log10(g + 1);

	%% normalize
	x_norm_log = m * x_log + b;

	%% transform back to original space
	x_norm_lin = 10.^x_norm_log;
	y_lin = 10.^y_log;

	%% the same prediction score from DREAM3
	numerator = (y_lin - x_norm_lin).^2;	%% cancels +1 correction
	denominator = 300^2 + (0.08*g).^2;
	error_individual = numerator ./ denominator;

	%% add the individual scores
	idx = find(~isnan(error_individual));
	errors(si) = sum(error_individual(idx));

	%% load prob density function
	pdffile = [ PDFDIR PDF_ROOT num2str(si) ];
	load(pdffile)		%% sets X, Y, C

	%% compute pval
	x = errors(si);
	p = probability(X,Y,x);
	pvals(si) = p;

	%% show something
	pj = pj + 1;
	subplot(pn,pm,pj)
	plot(x_norm_log,y_log,'.')
	LIM = [ min(axis) max(axis) ];
	axis square; axis equal; axis([LIM LIM]);
	grid on
	lsline
	hold on
	plot(LIM,LIM,'k--')
	hold off
	title(labels{si})

end

prediction_score = -mean(log10(pvals)')';
overall_score = prediction_score - COST_PER_LINK .* edge_count;

%% annotate plot
subplot(pn,pm,1)
xlabel('norm. prediction (log_1_0)')
ylabel('gold (log_1_0)')

