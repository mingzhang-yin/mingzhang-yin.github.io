function [err,alidx] = alignidx(idx,trueidx,method)
%
% Compute error rate with best alignment
% Input: idx: predicted label
%        trueidx: true label
%        method: 'err': Hamming accuracy
%                'nmi': normalized mutual information
%                
%Output: err: error rate
%        alidx: predicted index with rotation
%Author: Bowei Yan
%Last Update: Dec 14, 2016

    n = length(trueidx);
    k = max(length(unique(trueidx)),length(unique(idx)));
    err = inf;
    alidx = idx;
    allperm = perms(1:k);
    for i = 1:length(allperm),
        reorder = allperm(i,:);
        try
            trans2 = reorder(idx)';
        catch
            disp 'Fail to align two labels';
        end
        if strcmp(method,'err'),
            err_tmp = sum(trueidx~=trans2)/n;
        elseif strcmp(method,'nmi'),
            err_tmp = 1-nmi(trueidx,trans2);
        end
        if err_tmp < err,
            err = err_tmp;
            alidx = trans2;
        end
    end
end