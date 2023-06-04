%
% This script demonstrates how to call the function 
% DREAM4_Challenge3_Evaluation().
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

clear all

%% directory for the predictions
DATADIR = '../INPUT/my_processed_prediction/';

%% directory for the gold standards
GOLDDIR = '../INPUT/gold_standard/';

%% directory for the precomputed probability densities
PDFDIR  = '../INPUT/probability_densities/';

%% *** VERY IMPORTANT *** 
%% YOU MUST TELL HOW MANY LINKS ARE IN YOUR NETWORK
edge_count = 20;

%% evaluate
[overall_score, prediction_score, pvals, edge_count] = DREAM4_Challenge3_Evaluation(DATADIR,GOLDDIR,PDFDIR,edge_count)

