function [A,idx,Ap,Z]=create_block_model(n,rho,P,piV,true)
%[A,idx,Ap]=create_block_model(n,rho,P,piV,true)

k=size(P,1);
if nargin==3
    piV=1/k*ones(1,k);
end

if nargin<5
   true=1; 
end


Z = zeros(n,k);
idx = zeros(n,1);
%nv = [floor(n*piV(1:k-1)) n-sum(floor(n*piV(1:k-1)))];
total=0;
start1=1;
T=rand(n,n); R = triu(T)+triu(T,1)';
%T=rand(n,n); R1 = triu(T)+triu(T,1)';

for i=1:k-1
    %nk = poissrnd(nv);
    nk = floor(n*piV(i));
    Z(start1:start1+nk-1,i)=1;
    idx(start1:start1+nk-1)=i;
    total=total+nk;
    start1 = start1+nk;
end
Z(total+1:end,k)=1;
idx(total+1:end)=k;

Ap=Z*P*Z'*rho;

if true
    Ap=Ap-diag(diag(Ap));
end
A = double(sparse(R<Ap));


end