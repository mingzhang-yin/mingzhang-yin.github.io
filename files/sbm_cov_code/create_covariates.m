function Y = create_covariates(n,k,p,Z,center,sigma,hidim)
% Create covariate matrix
% Input: k - number of clusters
%        p - dimension
%        center - scalar, where the center of clusters being center*I_k
%        sigma - k vector, variance for each cluster
%        hidim - if true, normalize the noise
    if nargin == 6,
	hidim = 1;
    end
    M = eye(k)*center;
    p0 = k;
    if hidim,
    	signal = [M(Z,:),zeros(n,p-p0)];
    	Y = repmat(sigma(Z),1,p).*randn(n,p)/sqrt(p)+signal;
    else
	signal = M(Z,:);
	Y = repmat(sigma(Z),1,p).*randn(n,p)+signal;
    end
end
