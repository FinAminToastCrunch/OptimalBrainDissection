function [m b rho] = fit_line(x,y)

%% remove Nan
idx = find(~isnan(x));
x = x(idx,:);
y = y(idx);

%% linear fit
X = [ ones(length(x),1) x ];
myfit = X \ y;
b = myfit(1);
m = myfit(2);

%% corr coeff
rho = corr(x,y);

