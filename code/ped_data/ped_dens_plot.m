% function ped_dens_plot(X,X_gt,)
img_sz = [360 640];
m2p = 112;% sigma = 0.2;% 1/4/;1/2;
% den_gt = zeros(size(X,2),1);
% den_gauss = den_gt;
% den_vor = den_gt;
SIGMA = 0.1:0.1:1;
% for s = 1:size(SIGMA,2);
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
        diff = gau_den - double(vor_den(:,:,f));% imagesc(diff);pause(1);
        diff = diff.^2;
        std(f) = sum(sum(diff))/(img_sz(1)*img_sz(2)) ;
        %     vor_den(:,:,f) = Vornoic_density(loc,img_sz,m2p);
        %     den_gt(f)    = size(loc,1)*(m2p)^2 /(img_sz(1)*img_sz(2));
        %     den_gauss(f) = sum(sum(gau_den))/(img_sz(1)*img_sz(2));
        %     den_vor(f)   = sum(sum(vor_den))/(img_sz(1)*img_sz(2));
    end
    std_f = sum(std)/f;
    err_sigma(s) = std_f;
% end
plot(SIGMA,err_sigma);
% imshow(zeros(1000,1000));
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % %  global density Vs frame { Ground Truth,Vornoic ,Gaussian }
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% x =1:size(den_gt,1); plot(x,den_gt,'b',x,den_gauss,'r',x,den_vor,'g');


% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % %  Gaussian Error in local Density Vs simga 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% plot(SIGMA,err_sigma); % error  = rms(local_gaussian_density - local_vornoic density)
