function X = projSp(X0,r,tol)
    n = size(X0,1);
    if nargin < 2
        try
            [U,D] = eig(symmetrize(X0));
        catch
            %keyboard
            [U,S,V] = svd(symmetrize(X0));
            D = diag(diag(U'*X0*U));
            %[U,D] = eig(symmetrize(X0)+eps*eye(n));
        end
    else
        opts = struct('issym',1);
        if nargin > 2
            opts.tol = tol;
        end
%         opts
        [U,D] = eigs(symmetrize(X0),r,'lm',opts);
    end
    
    idx = diag(D) >= 0;
    X = U(:,idx)*D(idx,idx)*U(:,idx)';
end

function Z = symmetrize(X)
    Z = 0.5*(X+X');
end
