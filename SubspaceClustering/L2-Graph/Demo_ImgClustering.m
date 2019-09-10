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

% Description: L2-Graph for image clustering.
% Each column corresponds to a data point.

% ***NOTICED that***:
% If the codes or data sets are helpful to you, please appropriately cite our works. Thank you very much!

% =========================================================================

close all;
clear all;
clc;

% --------------------------------------------------------------------------
addpath ('../usages/');
addpath ('../data/');

fprintf('Beginning!\n');

% % ==================================  
CurData = 'AR_55_40_permute';
load (CurData);  
% parameters configuration
par.nClass             =   100;% the first nClass subjects are used to test
par.nDim               =   167;% feature dimensionality of PCA
par.lambda             =   [1e-3];
par.adjKnn             =   [7];

% % ==================================  
% CurData = 'ExYaleB_54_48_permute';
% load (CurData);  
% % -----parameters configuration
% par.nClass             =   39;% the first nClass subjects are used to test
% par.nDim               =   116;% feature dimensionality of PCA
% par.lambda             =   [1.0];
% par.adjKnn             =   [5];

% % ==================================  
% CurData = 'AR_glass_permute';
% load (CurData);  
% % -----parameters configuration
% par.nClass             =   100;% the first nClass subjects are used to test
% par.nDim               =   170;% feature dimensionality of PCA
% par.lambda             =   [1e-3];
% par.adjKnn             =   [12];

% % % ==================================  
% CurData = 'AR_scarve_permute';
% load (CurData);  
% % -----parameters configuration
% par.nClass             =   100;% the first nClass subjects are used to test
% par.nDim               =   173;% feature dimensionality of PCA
% par.lambda             =   [1e-3];
% par.adjKnn             =   [14];


%% --------------------
% each column of DAT denotes a data point
DATA       =   double(DAT(:,labels<=par.nClass));
labels     =   labels(labels<=par.nClass);

dat = FeatureEx(DATA, par);
clear DATA;

% --- get the clustering result based on L2-graph
[accuracy nmi time Time_BuildGraph] = ClusteringL2Graph(dat, labels, par);
clear tmp1 tmp2 tmp3 i DAT1 DAT2 LABEL1 LABEL2 dat1 dat2 dat order;
clear DAT DATA ans labels;
AnalyzeResult_L2_ImgClustering;
