% % % % % % % % % % % Estimating the location of head 
% % Detecting Head in Pedistrian Dataset
% % % % % % spatial information [local max based detection in pedestrian Dataset

% % % path = '../08_08_result/';
% function f=  Ped_dataset(vid,GT,method)

% compile;
load('dataset/ped_flow.mat','vid','SVMStruct','Gt_hog_1000');
GT = Gt_hog_1000;clear Gt_hoog_1000;
method.hog_bin = 1;
% SVMStruct = SVMStruct;

show = 4;s_o = 18;small  = ceil(18/4);big = ceil(sqrt(2*s_o^2));

plot_count=  true;
plot_den   =  true ; %false;
if(plot_count ==1)y_people = [];y_gt = [];end
if(plot_den ==1)d_g = [];d_g_gt=[];d_v = [];d_v_gt = [];end

 f = 1;
for f =  f: size(vid,4)
% fprintf('frame:f= %d \n',f);
    img = vid(:,:,:,f);
%     tic 
% % % % % % % % Find Head Location 
loc_max = img2loc(img,small,big,show);
loc =  loc_filt(img,loc_max,SVMStruct,method,[25 25]);
loc_vid{f} = loc;

% loc2bbox([25 25],loc_vid{f},vid(:,:,:,f));
if(rem(f,100)==0)
    fprintf('frame:f= %d \n',f);
    save('detection.mat','loc_vid') ; 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% loc = l_seg2center(img,small,20,show);
% %     1: to show the b_mod of image
% %     2: to show the image opening by 3
% %     3: to show the segmented image
% %     4: to show the location plot 
% if(plot_count ==1)
%     y_people(f) = size(loc,1);
%     y_gt(f) = size(GT{f},1);
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% % % % % % % Finding Density
m2p =112;
sigma = m2p*0.3;
% sigma = 15;
den = density(loc,img,sigma,m2p); figure(01);imagesc(den);
% if(plot_den ==1)
%          t_g = sum(sum(den)) / (size(den,1)* size(den,2));
%          d_g(f) = t_g;
%      end
% den = density(GT{f},img,sigma,m2p);% figure(01);imagesc(den);
% if(plot_den ==1)
%          t_g = sum(sum(den)) / (size(den,1)* size(den,2));
%          d_g_gt(f) = t_g;
% end
% den = Vornoic_density(loc,img,m2p);%  figure(02);imagesc(den);
% % [den den_c sup] = Vornoic_density(GT{f},img,m2p); % figure(01);imshow(sup);
%      if(plot_den ==1)
%          t_g = sum(sum(den)) / (size(den,1)* size(den,2));
%          d_v(f) = t_g ;
%      end
% 
% den = Vornoic_density(GT{f},img,m2p); % figure(02);imagesc(den);
% % [den den_c sup] = Vornoic_density(GT{f},img,m2p); % figure(01);imshow(sup);
%      if(plot_den ==1)
%          t_g = sum(sum(den)) / (size(den,1)* size(den,2));
%          d_v_gt(f) = t_g ;
%      end
end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% 
% if(plot_count)
%     x = [1:f];
%     figure(10)
%     plot( x,y_people,'r',x,y_gt,'b');
%     title('Counting Ped Vs frame');
%     ylabel('Count(people)');
%     xlabel('frame(f)');
%     legend('Detection','Ground Truth');
% end
% 
% if(plot_den)
%     x = [1:size(d_g,2)];
%     figure(11)
%     plot( x,d_g,'r',x,d_g_gt,'b');% 
% %     legend('Gaussian Density','Vornoic Density');
%     title('Gaussian Density');
%     ylabel('Density(per meter sqaure)');
%     xlabel('frame(f)');
%     legend(' Detection ','Ground Truth');
%     figure(11)
%     plot( x,d_v,'r',x,d_v_gt,'b');% 
% %     legend('Gaussian Density','Vornoic Density');
%     title('Vornoic Density');
%     ylabel('Density(per meter sqaure)');
%     xlabel('frame(f)');
%     legend(' Detection ','Ground Truth');
%     %     plot( x,d_g,x,d_g_big,x,d_v);%
% % legend('Gaussian Density 1m2','Gaussian Density 2.2m2','Vornoic Density');
% 
% end