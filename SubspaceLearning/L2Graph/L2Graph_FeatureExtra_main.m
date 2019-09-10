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

% ***NOTICED that***:
% If the codes or data sets are helpful to you, please appropriately cite our works. Thank you very much!

% Description: L2-Graph for subspace learning.
% Each column corresponds to a data point.
% =========================================================================

close all;
clear all;
clc;

% --------------------------------------------------------------------------
addpath ('../usage/');
addpath ('../data/');
% loading data
CurData = 'AR_glass_permute_600vs600';
load (CurData);  
% ---------- data option parameters configuration
options.nClass             = 100;  % the first nClass subjects are tested
options.nDim               = 2200; %input dimensionality corresponding to the cropped size
% ---------- embedding option parameters configuration
options.ReducedDim         = 600; % the feature dim
options.PCARatio           = 1;   % the feature dim measured by PCARatio
% ---------- similarity graph optionsameters configuration
options.lambda             =   [0.1];
options.adjKnn             =   [3];

% -------------- preprocess the data
% ----------preprocess with PCA if size(DAT,1) > options.nDim
% ----------perform test using the first option.nClass subjects
[tr_dat tt_dat trls ttls] = Preprocess(NewTrain_DAT, NewTest_DAT, trainlabels, testlabels, options);
clear NewTest_DAT NewTrain_DAT testlabels trainlabels;

options.gnd = trls;
options.NameStr = ['L2Graph_SL_' CurData '_Class' num2str(options.nClass) '_PCAdim' num2str(options.nDim) '_lambda#' num2str(length(options.lambda)) '_adjknn#' num2str(length(options.adjKnn))];

% ---------- perform coding, embedding, and classification
% -------subspace learning with L2graph
for i = 1:length(options.lambda)
    for j = 1:length(options.adjKnn)
        tic;
        % ------building the similarity graph using Principle Components
        CKSym = BuildingL2Graph(tr_dat, options.lambda(i), options.adjKnn(j));
        fprintf(['+building the graph using ' num2str(options.adjKnn(j)) ' principle components graph, finished!\n']);
        fprintf(['|lambda=' num2str(options.lambda(i)) ' and adjKnn=' num2str(options.adjKnn(j)) '\n']);
        PC_tElapsed(i,j) = toc;
        
        % ------embedding
        tic;
        [eigvector, eigvalue] = LGE(CKSym, [], options, tr_dat'); 
        fprintf('|embedding the principle components graph, finished!\n');

        %  ------ projection & classification
        [t_1nn_ac] = MyClassification(tr_dat, tt_dat, trls, ttls, eigvector);
        KNN_ac(i,j,1:length(t_1nn_ac)) = reshape(t_1nn_ac,[],1);
        Whole_tElapsed(i,j)=PC_tElapsed(i,j)+toc;
        
        fprintf(['|the BEST classification Accuracy is        ' num2str(max(t_1nn_ac))...
               '\n|where the time cost is about               ' num2str(Whole_tElapsed(i,j)) ' seconds!\n\n']);           
    end   
end;

clear ans Predict_label kk trls ttls tr_dat DAT tt_dat CurRepeat;
clear eigvector eigvalue;
clear j coef CKSym i t_1nn_ac;
AnalyzeResult_embed;
