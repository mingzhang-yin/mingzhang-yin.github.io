function [X,delta,T_term] = admm_imb(As,K,alpha, opts)
%
% ADMM for solving the following SDP of unequal sized clustering
% max  trace(AX)
% s.t. X\succeq 0, X1=1, tr(X)\le k, 0\le X\le \alpha
% Input: 
%     As: adjacency matrix
%     K: number of clusters
%     alpha: elementwise upper bound in the SDP
%     opts: options
%         rho: learning rate of ADMM
%         T:   max iteration
%         quiet: whether to print result at each step
%         tol: tolerance for stopping criterion
%         report_interval: frequency to print intermediate result
%         r: expected rank of the solution, leave blank if no constraint is required.
% Output:
%     X: optmal solution
%     delta: relative error when converge
%     T_term: number of iteration taken to converge
% Author: Bowei Yan
% Last Updated: Mar 14, 2017
%
n = size(As,1);
[U,V] = deal(zeros(n));
[X,Y,Z] = deal(ones(n));


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
    tic, X = projAXb( 0.5*(Z-U+Y-V+As_rescaled),K,n); dt(1)=toc;
    tic, Z = max(X+U,0); Z = min(Z,alpha); dt(2)=toc;
    
    if r < inf
        tic, Y = projSp(X+V,r,1e-3); dt(3)=toc;
    else
        tic, Y = projSp(X+V); dt(3)=toc;
    end
    U = U+X-Z;
    V = V+X-Y;
%     delta(t) = norm(X-Xold,'fro')/sqrt(n);
    delta(t) = norm(X-Xold)/norm(Xold);
    infeas = norm(X-Z)^2+norm(X-Y)^2;
    CONVERGED = delta(t) < tol && infeas < tol;
    
    if mod(t,report_interval) == 0 && ~quiet, 
        fprintf('%4d | %15e | %8.5f | %8.5f | %8.5f \n', ...
            t, delta(t), dt(1), dt(2), dt(3)), 
    end
    
    t = t + 1;
end

T_term = t-1;

end

function X = projAXb(X0,k,n)
    % k is trace of X
    b = [2*ones(n,1); k];
    X = X0 - Acs( Pinv( Ac(X0,n)-b, n ), n);
end

function Z = Acs(z,n)
    mu = z(1:n);
    [U,V] = meshgrid(mu,mu);
    Z = U+V+z(n+1)*eye(n);
end

function x = Pinv(z,n)
    mu = z(1:n);
    nu = z((n+1):end);
    x = [1/2/n*(eye(n)-(n-2)/n/(2*n-2)*ones(n))*mu(:)+1/n/(2-2*n)*ones(n,1)*nu;...
        -1/n/(2*n-2)*ones(1,n)*mu(:)+nu/(n-1)];
end

function z = Ac(X,n)
    z = [2*X*ones(n,1); trace(X)];
end
