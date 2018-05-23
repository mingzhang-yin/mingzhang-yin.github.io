function K = gaus_ker_dist(X)
% Compute the distance matrix
% Author: Bowei Yan
% Last Updated: Mar 14, 2017
[n,~]=size(X);
d = sum(X.*X,2);
K = d*ones(1,n)+ones(n,1)*d'-2*X*X';
end