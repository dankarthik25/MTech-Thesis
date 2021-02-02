% % function ped_dens_plot(X,X_gt,)
% img_sz = [360 640];
% m2p = 112;% sigma = 0.2;% 1/4/;1/2;
% 
% 
% SIGMA = 0.1:0.1:1;
% den_gauss = zeros(size(X,2),size(SIGMA,2)); 
% den_gt = zeros(size(X,2),1);
% for f =1:size(X,2)
%     loc = ceil(X_gt{f});
%     den_gt(f)    = size(loc,1)*(m2p)^2 /(img_sz(1)*img_sz(2));
% end
for s = 9:size(SIGMA,2)
    sigma = SIGMA(s);
    std = zeros(size(X,2),1);
    for f =1:size(X,2)
        loc = ceil(X_gt{f});
        for i = 1: size(loc,1)
            if (ceil(loc(i,1))>1)&&(ceil(loc(i,1))<img_sz(1))
                x =ceil(loc(i,1)) ;
            elseif ceil(loc(i,1))<=1
                x =2;
            else
                x = img_sz(1)-1;
            end
            if (ceil(loc(i,2))>1)&&(ceil(loc(i,2))<img_sz(2))
                y = ceil(loc(i,2));
            elseif ceil(loc(i,2))<=1
                y =2;
            else
                y = img_sz(2)-1;
            end
            loc(i,1) =x;loc(i,2) = y;
            
        end
        gau_den = gauss_den(loc,img_sz,m2p,sigma);
        den_gauss(f,s) = sum(sum(gau_den))/(img_sz(1)*img_sz(2));
        std(f) = den_gt(f) -den_gauss(f,s);
    end
    std_f = sqrt(sum(std.^2)/f);
    global_error(s) = std_f;
    x = 1:size(X,2);
    plot(x,den_gauss(:,s));
    fprintf('s = %d\n',s);
end
plot(SIGMA,global_error);
plot(SIGMA,local_error,SIGMA,global_error,'LineWidth',3);% hypot(local_error,global_error));
xlabel({'\sigma'},'FontSize',24);
ylabel({'Error (person per m^2)'},'FontSize',24);
title({'Error in Gaussian Density Distribution'},'FontSize',36);
legend({'Local Error','Global Error'},'FontSize',20);

%% %%%%%%%%%
load fisheriris
x = meas(51:end,3:4);
y_data = strcmp(species,'versicolor');y_data = 2*y_data -1;
y = y_data(51:end);

svms = svmtrain(x,y);
est_y = svmclassify(svms,x)
%     No of SupportVectors: n_sv
%           SupportVectors: [n_sv X 2 double]
%                    Alpha: [n_sv X 1 double]
%                     Bias: 0.1964
%           KernelFunction: @linear_kernel
%       KernelFunctionArgs: {}
%               GroupNames: [100  X 1 double]
%     SupportVectorIndices: [n_sv X1 double]
%                ScaleData: [1x1 struct]
%            FigureHandles: []

alpha   = svms.Alpha;                 % no(svm) X 1
y_sv    = y(svms.SupportVectorIndices);    % no(svm) X 1
x_sv    = svms.SupportVectors;         % no(svm) X x_dimension
b       = svms.Bias;
w = (alpha.*y_sv)' *x_sv;

b = sum(y'.*(1-y'.*(w*x')))/length(y);% b_var  = y'.*(1-y'.*(w*x'));
% b_s = y_sv' .* (w*x_sv');
% b = sum(b_s)/length(b_s);
class = - sign((w*x'+b)');
error = y -class;
no_error = length(find(error ~=0))
%% %

