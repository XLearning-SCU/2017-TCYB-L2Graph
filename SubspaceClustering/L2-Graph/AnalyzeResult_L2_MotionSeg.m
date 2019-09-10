% Description: L2-Graph for image clustering.

% clc;
% clear all;
addpath('../data/')
load Motion_indx;

clc
for i =1:length(par.lambda)
    for j=1:length(par.adjKnn)
        CurError = error(:,i,j);
%         fprintf([' =============== when lambda = ' num2str(par.lambda(i)) ', adjKnn = ' num2str(par.adjKnn(j)) 'results of all 156 sequences: =============== \n']);
%         fprintf(['max = ' num2str(max(CurError)) ',min=' num2str(min(CurError)) ...
%            ',mean=' num2str(best156.mean*100)  ',median=' num2str(best156.median*100) ',std=' num2str(best156.std*100) '\n'] );
        if i == 1 && j == 1
            best156.max = max(CurError);
            best156.min = min(CurError);
            best156.median = median(CurError);
            best156.mean = mean(CurError);
            best156.std = std(CurError);
            best156.lambda = par.lambda(i);
            best156.adjK = par.adjKnn(j);
        elseif best156.mean>mean(CurError)
            best156.max = max(CurError);
            best156.min = min(CurError);
            best156.median = median(CurError);
            best156.mean = mean(CurError);
            best156.std = std(CurError);
            best156.lambda = par.lambda(i);
            best156.adjK = par.adjKnn(j);
        end
        
        CurError = CurError([1:id-1,id+1:end]);
%         fprintf([' =============== when lambda = ' num2str(par.lambda(i)) ', adjKnn = ' num2str(par.adjKnn(j)) 'results of all 155 sequences: =============== \n']);
%         fprintf(['max = ' num2str(max(CurError)) ',min=' num2str(min(CurError)) ...
%            ',mean=' num2str(best156.mean*100)  ',median=' num2str(best156.median*100) ',std=' num2str(best156.std*100) '\n'] );
        if i == 1 && j == 1
            best155.max = max(CurError);
            best155.min = min(CurError);
            best155.median = median(CurError);
            best155.mean = mean(CurError);
            best155.std = std(CurError);
            best155.lambda = par.lambda(i);
            best155.adjK = par.adjKnn(j);
        elseif best155.mean>mean(CurError)
            best155.max = max(CurError);
            best155.min = min(CurError);
            best155.median = median(CurError);
            best155.mean = mean(CurError);
            best155.std = std(CurError);
            best155.lambda = par.lambda(i);
            best155.adjK = par.adjKnn(j);
        end
    end;
end;
clc;

fprintf([' ------------------------- the best performance for 156 seqs -------------------------\n '])
fprintf(['when lambda = ' num2str(best156.lambda), ', adjk = ' num2str(best156.adjK) ' \n max = ' num2str(best156.max) ',min=' num2str(best156.min) ...
           ',mean=' num2str(best156.mean*100)  ',median=' num2str(best156.median*100) ',std=' num2str(best156.std*100) '\n'] );

fprintf([' ------------------------- the best performance for 155 seqs -------------------------\n '])
fprintf(['when lambda = ' num2str(best155.lambda), ', adjk = ' num2str(best155.adjK) ' \n max = ' num2str(best155.max) ',min=' num2str(best155.min) ...
           ',mean=' num2str(best155.mean*100)  ',median=' num2str(best155.median*100) ',std=' num2str(best155.std*100) '\n\n\n'] );







lam_L = length(par.lambda);
adjk_L = length(par.adjKnn);
motion2_error = error(motion2_ind,:,:);
motion3_error = error(motion3_ind,:,:);

error = motion2_error;
for i =1:length(par.lambda)
    for j=1:length(par.adjKnn)
        CurError = error(:,i,j);
%         fprintf([' =============== when lambda = ' num2str(par.lambda(i)) ', adjKnn = ' num2str(par.adjKnn(j)) 'results of all 156 sequences: =============== \n']);
%         fprintf(['max = ' num2str(max(CurError)) ',min=' num2str(min(CurError)) ...
%             ',median=' num2str(median(CurError)) ',mean=' num2str(mean(CurError)) ',std=' num2str(std(CurError)) '\n'] );
        if i == 1 && j == 1
            best156.max = max(CurError);
            best156.min = min(CurError);
            best156.median = median(CurError);
            best156.mean = mean(CurError);
            best156.std = std(CurError);
            best156.lambda = par.lambda(i);
            best156.adjK = par.adjKnn(j);
        elseif best156.mean>mean(CurError)
            best156.max = max(CurError);
            best156.min = min(CurError);
            best156.median = median(CurError);
            best156.mean = mean(CurError);
            best156.std = std(CurError);
            best156.lambda = par.lambda(i);
            best156.adjK = par.adjKnn(j);
        end     
    end;        
end;

fprintf([' ------------------------- the best performance for 2 MOTIONS  -------------------------\n '])
% fprintf(['when lambda = ' num2str(best156.lambda), ', adjk = ' num2str(best156.adjK) ' \n max = ' num2str(best156.max) ',min=' num2str(best156.min) ...
%         ',median=' num2str(best156.median) ',mean=' num2str(best156.mean) ',std=' num2str(best156.std) '\n'] );
fprintf(['when lambda = ' num2str(best156.lambda), ', adjk = ' num2str(best156.adjK) ' \n '...
           ',mean=' num2str(best156.mean*100)  ',median=' num2str(best156.median*100) ',std=' num2str(best156.std*100) '\n'] );




motion2.L2 = motion2_error(:,find(par.lambda==best156.lambda),find(par.adjKnn==best156.adjK));
        
error = motion3_error;
for i =1:length(par.lambda)
    for j=1:length(par.adjKnn)
        CurError = error(:,i,j);
%         fprintf([' =============== when lambda = ' num2str(par.lambda(i)) ', adjKnn = ' num2str(par.adjKnn(j)) 'results of all 156 sequences: =============== \n']);
%         fprintf(['max = ' num2str(max(CurError)) ',min=' num2str(min(CurError)) ...
%             ',median=' num2str(median(CurError)) ',mean=' num2str(mean(CurError)) ',std=' num2str(std(CurError)) '\n'] );
        if i == 1 && j == 1
            best156.max = max(CurError);
            best156.min = min(CurError);
            best156.median = median(CurError);
            best156.mean = mean(CurError);
            best156.std = std(CurError);
            best156.lambda = par.lambda(i);
            best156.adjK = par.adjKnn(j);
        elseif best156.mean>mean(CurError)
            best156.max = max(CurError);
            best156.min = min(CurError);
            best156.median = median(CurError);
            best156.mean = mean(CurError);
            best156.std = std(CurError);
            best156.lambda = par.lambda(i);
            best156.adjK = par.adjKnn(j);
        end     
    end;        
end;

fprintf([' ------------------------- the best performance for 3 MOTIONS  -------------------------\n '])
% fprintf(['when lambda = ' num2str(best156.lambda), ', adjk = ' num2str(best156.adjK) ' \n max = ' num2str(best156.max) ',min=' num2str(best156.min) ...
%             ',median=' num2str(best156.median) ',mean=' num2str(best156.mean) ',std=' num2str(best156.std) '\n'] );
fprintf(['when lambda = ' num2str(best156.lambda), ', adjk = ' num2str(best156.adjK) ' \n '...
           ',mean=' num2str(best156.mean*100)  ',median=' num2str(best156.median*100) ',std=' num2str(best156.std*100) '\n'] );
motion3.L2 = motion3_error(:,find(par.lambda==best156.lambda),find(par.adjKnn==best156.adjK));

clear CurData CurError adjk_L best156 error i id j lam_L motion2_error motion3_error motion2_ind motion3_ind par


