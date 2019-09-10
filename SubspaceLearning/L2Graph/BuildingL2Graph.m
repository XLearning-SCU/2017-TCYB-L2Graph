% =========================================================================
% An example code for the algorithm proposed in
%
%   [1] Xi Peng, Zhang Yi, and Huajin Tang.
%       Robust Subspace Clustering via Thresholding Ridge Regression.
%       The Twenty-Ninth AAAI Conference on Artificial Intelligence (AAAI), Austin, Texas, USA, January 25–29, 2015.

%   [2] Xi Peng, et al.
%       Constructing the L2-Graph for Robust Subspace Learning and Subspace Clustering.
%       IEEE Trans. on Cybernetics, In Press.

%
% Written by Xi Peng @ I2R A*STAR
% Nov., 2014.
% More information can be accessed from www.pengxi.me

% Description: L2-Graph for subspace learning.
% Each column corresponds to a data point.

% ***NOTICED that***:
% If the codes or data sets are helpful to you, please appropriately cite our works. Thank you very much!
% =========================================================================


function CKSym = BuildingL2Graph(tr_dat, lambda, adjKnn)

    coef = [];
    % --- computing the project matrix
    tmp = tr_dat'*tr_dat;     
    if lambda == 0
        Proj_M = pinv(tmp);
    else
        Proj_M = tmp + (lambda) *eye(size(tmp));
        Proj_M =  inv(Proj_M);    
    end
    clear tmp;
    Q_matrix = Proj_M * tr_dat';
    % --- get coeffient matrixs of tr_dat
    for ii  = 1:size(tr_dat,2)
        stdOrthbasis = zeros(size(tr_dat,2),1);
        stdOrthbasis(ii) = 1;
        tmp1 = stdOrthbasis'* Q_matrix *tr_dat(:,ii);
        tmp2 = pinv(stdOrthbasis'* Proj_M * stdOrthbasis);
        tmp = Proj_M * (tr_dat'*tr_dat(:,ii) - (tmp1*tmp2)*stdOrthbasis) ;
        coef = [coef tmp];
    end
    clear ii tmp1 tmp2 tmp;       
    clear Proj_M;
    
    coef = coef - eye(size(coef)).*coef;
    coef = coef./( repmat(sqrt(sum(coef.*coef)), [size(coef, 1),1]) );
    
    % --- CKSym: NxN symmetric adjacency matrix
    % --- Building Adjacency graph
    CKSym = BuildAdjacency(coef,adjKnn);
end
