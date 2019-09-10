% =========================================================================
% An example code for the algorithm proposed in
%
%   [1] Xi Peng, Zhang Yi, and Huajin Tang.
%       Robust Subspace Clustering via Thresholding Ridge Regression.
%       The Twenty-Ninth AAAI Conference on Artificial Intelligence (AAAI), Austin, Texas, USA, January 25–29, 2015.

%   [2] Xi Peng, et al.
%       Constructing the L2-Graph for Robust Subspace Learning and Subspace Clustering.
%       Under review.

%
% Written by Xi Peng @ I2R A*STAR
% Nov., 2014.

% Description: L2-Graph for subspace learning.
% =========================================================================


clc;
best_knn_ac  = 0;
for i = 1:size(KNN_ac,1)
    for j=1:size(KNN_ac,2)
        tmp = KNN_ac(i,j,:);        
        if best_knn_ac < max(tmp);
            best_knn_ac = max(tmp);
            best_knn_ac_dim = find(best_knn_ac==tmp);
            best_knn_ac_k = options.adjKnn(j);
            best_knn_ac_lambda = options.lambda(i);
            cor_PC_time = PC_tElapsed(i,j);
            cor_whole_time = Whole_tElapsed(i,j);
        elseif best_knn_ac == max(tmp);
            tmp3 = find(best_knn_ac==tmp);
            best_knn_ac_dim = [best_knn_ac_dim; tmp3];
            best_knn_ac_k = [best_knn_ac_k; options.adjKnn(j)];
            best_knn_ac_lambda = [best_knn_ac_lambda; options.lambda(i)];
        end
    end;
end;
fprintf(['*The best accuracy for 1NN classifer is about ' num2str(best_knn_ac) ',\n|when lambda=' num2str(best_knn_ac_lambda') ',|adjk=' num2str(best_knn_ac_k') ',|dim=' num2str(best_knn_ac_dim') '\n\n']);
fprintf(['|where training number is ' num2str(length(options.gnd)) '\n']);
fprintf(['| the time for building graph is about   ' num2str(cor_PC_time) '\n']);
fprintf(['| the total time for processing is about ' num2str(cor_whole_time) '\n']);
