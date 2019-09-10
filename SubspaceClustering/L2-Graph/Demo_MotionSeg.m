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

% Description: L2-Graph for motion segmentation.
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
% loading data

% ==================================  
CurData = 'Hopkins_motionSeg156';
load (CurData);  
% parameters configuration
par.lambda             =    [0.1];
par.adjKnn             =    [10 14];
% --------------------
for i = 1:length(data)
    X = data(i).X;    
    gnd = data(i).ids;     
    par.nClass = length(unique(gnd));

    if abs(par.nClass-2)>0.1 && abs(par.nClass-3)>0.1
        id = i; % the discarded seq.
    end
    fprintf([' **************************** begin to segment Seq ' num2str(i) ' **************************** \n\n']);   
    [t_accuracy nmi time Time_BuildGraph] = ClusteringL2Graph(X, gnd, par);
    accuracy(i,:,:) = t_accuracy;
    error(i,:,:)=1 - t_accuracy;
end;

clear tElapsed fid ans Predict_label coef1 coef2 kk trls ttls;
clear LapKernel SingVals i j pos t_err t_nmi dat labels tmp_iter tmp_x;
clear L S U V Z k r K DAT order X data gnd tmp1 tmp2 W data;
AnalyzeResult_L2_MotionSeg
