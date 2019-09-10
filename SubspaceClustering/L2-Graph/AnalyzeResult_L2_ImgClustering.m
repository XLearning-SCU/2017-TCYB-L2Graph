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

% =========================================================================
% Description: L2-Graph for image clustering.


clc;
best_ac = max(max(accuracy));
[row col]= find(best_ac==accuracy);
best_ac_lambda = par.lambda(row);
best_ac_adjk = par.adjKnn(col);
best_ac_nmi = nmi(row,col);

fprintf(['The best accuracy is ' num2str(best_ac)  ', the corresponding nmi is ' num2str(best_ac_nmi(1)), ...
     ', \n time = ' num2str(time(row(1),col(1)))...
     ', \n when lambda = ' num2str(best_ac_lambda) ', and adjk = ' num2str(best_ac_adjk) '\n']);

best_nmi = max(max(nmi));
[row col]= find(best_nmi==nmi);
best_nmi_lambda = par.lambda(row);
best_nmi_adjk = par.adjKnn(col);
best_nmi_ac = accuracy(row,col);
fprintf(['The best NMI is ' num2str(best_nmi)  ', the corresponding nmi is ' num2str(diag(best_nmi_ac)'), ...
    '\n, when lambda = ' num2str(best_nmi_lambda) ', and adjk = ' num2str(best_nmi_adjk) '\n']);