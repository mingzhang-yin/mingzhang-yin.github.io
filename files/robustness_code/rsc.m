function [class,U1] = rsc(A, K, method)
%
% Regularized spectral clustering
% Input: A: Adjacency matrix
%        K: number of clusters
%        method: 'adj': use adjacency matrix
%                'noreg': use unregularized graph laplacian
%                'pos': use regularized graph laplacian
%Output: class: class labels
%        U1: eigenvectors

%Author: Bowei Yan
%Last Update: Mar 20, 2017

    [nv,~] = size(A);
    tau = mean(A(:));
    if strcmp(method,'pos')
        A_tau = A + tau*ones(nv,nv);
        L_tau = normalizeSym(A_tau);
    elseif strcmp(method,'noreg')
        L_tau = normalizeSym(A);
    elseif strcmp(method,'adj')      
    % Use adjacency matrix
        L_tau = (A+A')/2;
    end
    [U1,~] = eigs(L_tau,K);
    % Row renormalization for spectral clustering
    if strcmp(method,'noreg'),
        U1 = normr(U1);
    end
    % K-means with restarts
    maxsum = inf;
    for i=1:10,
        [class0,~,sumD] = kmeans(U1(:,1:K),K);
	if maxsum > sum(sumD),
		maxsum = sum(sumD);
		class=class0;
	end
    end
end
