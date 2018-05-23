function [X,delta,T_term] = sdp_admm1(As,K,opts)
%
%ADMM for solving SDP
%Input: As: Adjacency matrix
%       K: number of clusters
%       opts: options
%Output: X: optimal solution
%        delta: diatance from last step
%        T_term: number of iterations
%Author: Bowei Yan
%Last Update: Dec 14, 2016

n = size(As,1);
[U,V] = deal(zeros(n));
[X,Y,Z] = deal(zeros(n));

rho = opts.rho;
T = opts.T;
tol = opts.tol;
report_interval = 1;
quiet = false;
if isfield(opts,'report_interval')
    report_interval = opts.report_interval;
end
if isfield(opts,'quiet')
    quiet = opts.quiet;
end

if isfield(opts,'r')
    r = opts.r;
else 
    r = inf;
end

% rho = 10;
As_rescaled = (1/rho)*As;

alpha = n/K;
if ~quiet
    fprintf('%4s | %15s | %8s | %8s | %8s \n', 't', '|X^{k+1} - X^k|', 'dt1   ','dt2   ','dt3   ')
end
if isinf(T)
    delta = zeros(1000,1);
else
    delta = zeros(T,1);
end
dt = zeros(1,3);
t = 1; 
CONVERGED = false;
while ~CONVERGED && (t <= T)
%     [Xold,Yold,Zold,Uold,Vold] = deal(X,Y,Z,U,V);
    Xold = X;
    tic, X = projAXb( 0.5*(Z-U+Y-V+As_rescaled), alpha, n); dt(1)=toc;
    tic, Z = max(X+U,0); dt(2)=toc;
    
    if r < inf
        tic, Y = projSp(X+V,r,1e-3); dt(3)=toc;
    else
        tic, Y = projSp(X+V); dt(3)=toc;
    end
    U = U+X-Z;
    V = V+X-Y;
%     delta(t) = norm(X-Xold,'fro')/sqrt(n);
    delta(t) = norm(X-Xold);
    CONVERGED = delta(t) < tol;
    
    if mod(t,report_interval) == 0 && ~quiet, 
        fprintf('%4d | %15e | %8.5f | %8.5f | %8.5f \n', ...
            t, delta(t), dt(1), dt(2), dt(3)), 
    end
    
    t = t + 1;
end

T_term = t-1;

end

function X = projAXb(X0,alpha,n)
    % alpha is the row-sum of X
    b = [2*(alpha-1)*ones(n,1); ones(n,1)];
    X = X0 - Acs( Pinv( Ac(X0,n)-b, n ), n);
end

function Z = Acs(z,n)
    mu = z(1:n);
    nu = z((n+1):end);
    [U,V] = meshgrid(mu,mu);
    temp = U + V;
    Z = temp - diag(diag(temp)) + diag(nu);
    
end

function x = Pinv(z,n)
    mu = z(1:n);
    nu = z((n+1):end);
    x = [1/(2*(n-2))*(mu(:) - ones(n,1)*sum(mu)/(2*n-2)); nu(:)];
end

function z = Ac(X,n)
    z = [2*(X-diag(diag(X)))*ones(n,1); diag(X)];
end
