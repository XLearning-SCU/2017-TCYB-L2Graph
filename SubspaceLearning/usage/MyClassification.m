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

% Description: Perform Classification using the nearest neighborhood
% classifier
% =========================================================================

function [t_1nn_ac] = MyClassification(tr_dat, tt_dat, trls, ttls, eigvector)

% maxDim=min(300,length(eigvalue));
for d=1:size(eigvector,2)
    % 1-nn classifier
    trY=eigvector(:,1:d)'*tr_dat;
    teY=eigvector(:,1:d)'*tt_dat;
    class=knnclassify(teY',trY',trls');
    correctRate = length(find(class'-ttls==0))/length(ttls);
    t_1nn_ac(d)=correctRate;

end

