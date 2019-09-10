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
% =========================================================================

% Description:  The code is developed to calculate the Clustering Accuracy and NMI


function [acc_r nmi_r] = CalMetricOfCluster(Predict_label,ttls)
if size(Predict_label,1)<size(Predict_label,2)
    Predict_label=Predict_label';
end;
if size(ttls,1)<size(ttls,2)
    ttls=ttls';
end;
for i = 1:size(Predict_label,2)
    acc_r(i) = accuracy(ttls, Predict_label(:,i));
    nmi_r(i) = nmi(ttls, Predict_label(:,i));
end


