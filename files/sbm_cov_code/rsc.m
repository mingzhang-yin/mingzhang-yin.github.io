
function [class,U1] = rsc(A, K, method, prior)

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

    if nargin==3,
        prior = 1/K*ones(K,1);
    end
    [nv,~] = size(A);
    tau = mean(A(:));
    if strcmp(method,'pos')
        A_tau = A + tau*ones(nv,nv);
        L_tau = normalizeSym(A_tau);
    elseif strcmp(method,'neg')
        L = normalizeSym(A);
        d = A*ones(nv,1);
        d = 1/sqrt(d);
        rho = .02; p = 0.8*rho;q = 0.2*rho;
        alpha = log(p*(1-q)/q/(1-p));
        beta = log((1-p)/(1-q));
        L_tau = alpha*L + beta*d*d';
        [~,l,~]=svd(L_tau);
        l=diag(l);
    elseif strcmp(method,'noreg')
        L_tau = normalizeSym(A);
    elseif strcmp(method,'adj')      
    % Use adjacency matrix
        L_tau = (A+A')/2;
    elseif strcmp(method,'deg')
        % L = normalizeSym(A);
        d = A*ones(nv,1);
        L_tau = d*d';
    elseif strcmp(method,'degreg')
        D_tau = mean(A(:));
        L_tau = diag(sqrt(1./D_tau))*A*diag(sqrt(1./D_tau));
    end
    [U1,~] = eigs(L_tau,K);
    % Row renormalization for spectral clustering
    if strcmp(method,'noreg'),
        U1 = normr(U1);
    end
    % K-means with restarts
    maxsum = inf;
    nrestart = 100;
    for i=1:nrestart,
        [class0,~,sumD] = kmeans(U1(:,1:K),K);
	if maxsum > sum(sumD),
		maxsum = sum(sumD);
		class=class0;
	end
    end
end
