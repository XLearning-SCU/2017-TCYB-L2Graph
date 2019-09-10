

function CKSym = BuildAdjacency(CMat,K)

N = size(CMat,1);
CAbs = abs(CMat);
for i = 1:N
    c = CAbs(:,i);
    [PSrt,PInd] = sort(c,'descend');
    if abs( c(PInd(1)) ) ~=0
        CAbs(:,i) = CAbs(:,i) ./ abs( c(PInd(1)) );
    else
        CAbs(:,i) = CAbs(:,i) ./ 1e-12;
    end
end

CSym = CAbs + CAbs';

if (K ~= 0)
    [Srt,Ind] = sort( CSym,1,'descend' );
    CK = zeros(N,N);
    for i = 1:N
        for j = 1:K
            if CSym( Ind(1,i),i )~=0
                CK( Ind(j,i),i ) = CSym( Ind(j,i),i ) ./ 1e-12;
            else
                CK( Ind(j,i),i ) = CSym( Ind(j,i),i ) ./ CSym( Ind(1,i),i );
            end
        end
    end
    CKSym = CK + CK';
else
    CKSym = CSym;
end