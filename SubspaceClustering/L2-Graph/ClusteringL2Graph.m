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

% Description: L2-Graph for subspace clustering.
% Each column corresponds to a data point.

% ***NOTICED that***:
% If the codes or data sets are helpful to you, please appropriately cite our works. Thank you very much!
% =========================================================================



function [accuracy nmi time Time_BuildGraph] = ClusteringL2Graph(dat, labels, par)

accuracy = zeros(size(par.lambda,2),length(par.adjKnn));
nmi = zeros(size(par.lambda,2),length(par.adjKnn));
pos = 0;


for i = 1:length(par.lambda)
    coef = [];
    % --- computing the project matrix
    tic;
    tmp = dat'*dat;     
    if par.lambda(i) == 0
        Proj_M = pinv(tmp);
    else
        Proj_M = tmp + (par.lambda(i)) *eye(size(tmp));
        Proj_M =  inv(Proj_M);    
    end
    Q = Proj_M*dat';
    clear tmp;
    
    % --- get coeffient matrixs
    for ii  = 1:size(dat,2)
        stdOrthbasis = zeros(size(dat,2),1);
        stdOrthbasis(ii) = 1;
        tmp1 = stdOrthbasis'* Q *dat(:,ii);
        tmp2 = pinv(stdOrthbasis'* Proj_M * stdOrthbasis);
        tmp = Proj_M * (dat'*dat(:,ii) - (tmp1*tmp2)*stdOrthbasis) ;
        coef = [coef tmp];
    end
    clear ii tmp1 tmp2 tmp;   
    
    clear Proj_M;
    coef = coef - eye(size(coef)).*coef;
    coef = coef./( repmat(sqrt(sum(coef.*coef)), [size(coef, 1),1]) );

    Time_BuildGraph(i)=toc;
    for j = 1:length(par.adjKnn)
        % --- CKSym: NxN symmetric adjacency matrix
        tic;
        CKSym = BuildAdjacency(coef,par.adjKnn(j)); 
        % --- perform spectral clustering, 3 clusters are tested, e.g.
        % Unnormalized Method, Random Walk Method and Normalized Symmetric
        Predict_label = SC(CKSym,length(unique(labels)));
        time(i,j)=Time_BuildGraph(i)+toc;
        fprintf([' * The time cost for clustering is ' num2str(time(i,j)) ' seconds!\n']);
        % if the value is nan, then randomly assign a label, maybe a
        % more suitable strategy is to reject label assignment as it is a outlier
        for ii = 1:size(Predict_label,1)
            for jj = 1:size(Predict_label,2)
                if isnan(Predict_label(ii,jj))==1
                    tmp = unique(labels);
                    tmp2= tmp(randperm(length(tmp)));
                    Predict_label(ii,jj) = tmp2(1);
                end;
            end
        end;
        clear ii jj tmp tmp2;
        % --- get accuracy and normalized mutual information for clustering result
        [t_accuracy t_nmi]= CalMetricOfCluster(Predict_label,labels);
        t_accuracy = t_accuracy./100;
        accuracy(i,j) = t_accuracy;
        nmi(i,j) = t_nmi;
        pos = pos + 1;
        fprintf([' | the ' num2str(pos) 'th result | lambda = ' num2str(par.lambda(i)) ' | adjKnn = ' num2str(par.adjKnn(j)) '\n']);
        fprintf([' + The accuracy                      scores are: ' num2str(t_accuracy) '\n']);
        fprintf([' + The normalized mutual information scores are: ' num2str(t_nmi) '\n']);       
        fprintf(' + The time cost for building graph is about %f seconds \n', Time_BuildGraph(i));
        fprintf(' + The total time cost is about              %f seconds \n\n', time(i));        
    end;
end;
