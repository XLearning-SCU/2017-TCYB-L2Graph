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
% =========================================================================


function [tr_dat tt_dat trls ttls] = Preprocess(NewTrain_DAT, NewTest_DAT, trainlabels, testlabels, options)
% only the first nClass subjest samples are used 
Tr_DAT   =   double(NewTrain_DAT(:,trainlabels<=options.nClass));
trls     =   trainlabels(trainlabels<=options.nClass);
Tt_DAT   =   double(NewTest_DAT(:,testlabels<=options.nClass));
ttls     =   testlabels(testlabels<=options.nClass);
%--------------------------------------------------------------------------
% eigenface extracting
if options.nDim < size(Tr_DAT,1)
    [disc_set,disc_value,Mean_Image]  =  Eigenface_f(Tr_DAT,options.nDim);
    tr_dat  =  disc_set'*Tr_DAT;
    tt_dat  =  disc_set'*Tt_DAT;
else
    tr_dat = Tr_DAT;
    tt_dat = Tt_DAT;
end;
tr_dat  =  tr_dat./( repmat(sqrt(sum(tr_dat.*tr_dat)), [size(tr_dat, 1),1]) );
tt_dat  =  tt_dat./( repmat(sqrt(sum(tt_dat.*tt_dat)), [size(tt_dat, 1),1]) );
clear disc_set disc_value Mean_Image Tr_DAT Tt_DAT;
tr_dat = real(tr_dat);
tt_dat = real(tt_dat);