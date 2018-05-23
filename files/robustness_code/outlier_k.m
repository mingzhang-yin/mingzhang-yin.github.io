%{
Code for "On robustness of kernel clustering", NIPS 2016
Exp 1: Inlier accuracy vs number of clusters
Author: Bowei Yan
Last Update: Dec 14, 2016
%}

clear;clc; close all;
addpath(genpath('./'))
m = 5; n = 1500 -2*m;
k_list = [3,4,5,6,7,8];
opts = struct('rho',.1,'T',10000,'tol',5e-3,'report_interval',500,'quiet',1);
for iexp = 1:10,
    for i=1:length(k_list),
        p = 1500;
        k = k_list(i);
        Z = ones(n,1);
        for ik = 1:k-1,
            Z((ik-1)*(floor(n/k))+1:ik*floor(n/k))=ik;
        end
        Z((k-1)*floor(n/k)+1:n)=k;
        center = .3;
        sigma = ones(k,1);

        Y = create_covariates(n,k,p,Z,center,sigma);
        
        % Add outliers
        outliers = [(rand(m,k)-.5)*5,zeros(m,p-k)];
        outliers_large = [(randn(m,k))*5,zeros(m,p-k)];
        Y = [Y;outliers;outliers_large];
        D = pdist2(Y,Y).^2;

	% assign outlier labels
	Z_all = ones(n+2*m,1);
	Z_all(1:n)=Z;
	for ik = 1:k-1,
		Z_all(n+(ik-1)*floor(2*m/k)+1:n+ik*floor(2*m/k))=ik;
	end
	% Construct groundtruth matrix
	X0 = zeros(n+2*m,n+2*m);
	Z_mat = zeros(n+2*m,k);
	for ik=1:k,
		Z_mat(:,ik)=1*(Z_all==ik);
	end
	X0 = Z_mat*Z_mat';

        eta = 1;
	dmin2 = 2*center^2;
	gamma = exp(-eta*2)-exp(-eta*(dmin2+2));
	% kernel SVD
    Kmat = exp(-eta*D);
	cl_svd = rsc(Kmat,k,'adj');
	cl_svd = cl_svd(1:n);
	acc_svd(i,iexp) = 1-alignidx(cl_svd,Z,'err');
	nmi_svd(i,iexp) = nmi(cl_svd,Z);
        
	% Kernel PCA
        Kmat = Kmat - Kmat*ones(size(Y,1))/size(Y,1) ...
            - ones(size(Y,1))*Kmat/size(Y,1) + ones(size(Y,1))*Kmat*ones(size(Y,1))/((size(Y,1))^2);
        cl_pca = rsc(Kmat,k,'adj');
        cl_pca = cl_pca(1:n);
        acc_pca(i,iexp) = 1-alignidx(cl_pca,Z,'err');
        nmi_pca(i,iexp) = nmi(cl_pca,Z);
        
        % K-means
        cl_km = kmeans(Y,k);
        cl_km = cl_km(1:n);
        acc_km(i,iexp) = 1-alignidx(cl_km,Z,'err');
        nmi_km(i,iexp) = nmi(cl_km,Z);
        
        % Spectral clustering
        cl_sc = rsc(exp(-eta*D),k,'noreg');
        cl_sc = cl_sc(1:n);
        acc_sc(i,iexp) = 1-alignidx(cl_sc,Z,'err');
        nmi_sc(i,iexp) = nmi(cl_sc,Z);
        
        % SDP
        [X_ker,~,~] = sdp_admm1(exp(-eta*D),k,opts);
        l1_err(i,iexp)=sum(abs(X_ker(:)-X0(:)))/((n+2*m)^2/k);
        cl_sdp = rsc(X_ker,k,'pos');
        cl_sdp = cl_sdp(1:n);
        acc_sdp(i,iexp) = 1-alignidx(cl_sdp,Z,'err');
        nmi_sdp(i,iexp) = nmi(cl_sdp,Z);
        fprintf('k=%d\t exp=%d\t sep=%f\t l1_err=%f\t acc_sdp=%f\t time:%s\n',k,iexp,gamma-sqrt(log(p)/p),l1_err(i,iexp),acc_sdp(i,iexp),datestr(now,15))
    end
end

