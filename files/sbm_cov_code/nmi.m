function v = nmi(label, result)
% Nomalized mutual information

label = label(:);
result = result(:);

n = length(label);

label_unique = unique(label);
result_unique = unique(result);

% check the integrity of result
%if length(label_unique) ~= length(result_unique)
%    disp 'The clustering result is not consistent with label.';
%end;

c = length(label_unique);
c1 = length(result_unique);
if c==1 || c1==1,
v=0;
else,
% distribution of result and label
Ml = double(repmat(label,1,c) == repmat(label_unique',n,1));
Mr = double(repmat(result,1,c1) == repmat(result_unique',n,1));
Pl = sum(Ml)/n;
Pr = sum(Mr)/n;

% entropy of Pr and Pl
Hl = -sum( Pl .* log2( Pl + eps ) );
Hr = -sum( Pr .* log2( Pr + eps ) );


% joint entropy of Pr and Pl
% M = zeros(c);
% for I = 1:c
% 	for J = 1:c
% 		M(I,J) = sum(result==result_unique(I)&label==label_unique(J));
% 	end;
% end;
% M = M / n;
if c==c1,
    M = Ml'*Mr/n;
else
    for I = 1:c1
     	for J = 1:c
     		M(I,J) = sum(result==result_unique(I)&label==label_unique(J));
        end;
    end;
    M = M/n;
end
Hlr = -sum( M(:) .* log2( M(:) + eps ) );

% mutual information
MI = Hl + Hr - Hlr;

% normalized mutual information
v = sqrt((MI/Hl)*(MI/Hr)) ;
end
