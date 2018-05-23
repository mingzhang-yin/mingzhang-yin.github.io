function An = normalizeSym(A,L)
if nargin==1
    L=0;
end

n=size(A,1);
d=sum(A,1);
d(d==0)=1e10;
if L==0
    d=1./sqrt(d);
    %d=1./d;
    D=spdiags(d',0,n,n);
    An=D*A*D;
    An=.5*(An+An');
else
    d=1./(d);
    %d=1./d;
    D=spdiags(d',0,n,n);
    An=D*A;
    %An=.5*(An+An');
end