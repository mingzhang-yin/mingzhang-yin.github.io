% An example for using admm_imb

% Generate graph
n = 300;
clsize=[1,2,3];
clsize = clsize/sum(clsize);
k = length(clsize);
% weakly assortative
prob = [.5,.4,.2;.4,.5,.25;.2,.25,.3];
rho = 1;
[A,Z,~,~] = create_block_model(n,rho,prob,clsize,1);
Z_mat=[];
for j=1:k,
    Z_mat=[Z_mat,1/sqrt(sum(Z==j))*(Z==j)];
end
truth = Z_mat*Z_mat';

% Generate covariates
p = 100;
M = diag([0.4,0.1,0.1]);
p0 = k;
sigma = ones(k,1);
signal = [M(Z,:),zeros(n,p-p0)];
Y = randn(n,p)/sqrt(p)+signal;
K = gaus_ker_dist(Y);
alpha = 1/(n*min(clsize));
opts = struct('rho',1,'T',10000,'tol',1e-2,'report_interval',100,'quiet',0);

% Grid search for tuning parameter
lambda = [.5,1,1.5,2,2.5];
for ilam = 1:length(lambda),
    x_sdp2 = admm_imb(A+lambda(ilam)*exp(-K),k,alpha,opts);
    % clustering
    cl_t{ilam} = rsc(x_sdp2,k,'pos');
    eig_xhat = eig(x_sdp2);
    eig_gap(ilam) = (eig_xhat(k)-eig_xhat(k+1))/eig_xhat(k);
end
[~,imin] = max(eig_gap);
cl = cl_t{imin};

% report NMI
nmi_sdp = nmi(cl,Z);
fprintf('NMI: %f\n',nmi_sdp);

