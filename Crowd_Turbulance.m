% % % ===================== METHOD - I ================= % % %
clear ux;clear uy;
% % clear all; clc;
load('dataset/vid_Turbulance.mat','vid');
% compile;
tic
f = 1;
hz = 30;
pixel_area = 1/25; % 1/25  m^(-2)
fd =1;winN = [];winSig =1;sigma_op = 1;thr = 2e-6;show = 2;
base = 40;s_i = [size(vid,1),size(vid,2)];

for f =1:size(vid,4)-1
tic
% % % % % % % For Location Estimation % % % % % %
show = 1;
center = crowd_turb_local_max(vid(:,:,f),hz,show);

% % % % % % %  For Density Estimation * * * % % %
% density = Gauss_Density(center,f,s_i,pixel_area);% Density_Estimation\

% % % % % % %  For Velocity Estimation * * * % % %
[vx vy flowlk ] = optFlowLk(vid(:,:,1,f) ,vid(:,:,1,f+fd), winN, winSig, sigma_op,thr,show ); % toolbox_opFlow\

% % % % % % %  For Variation in Velocity  * * * % % %
bin = rem(f,base)+1;ux{bin} = vx;uy{bin} = vy; % Creating a buffer matrix for storing last {base} optical flow
vel_var = Var_Velocity(ux,uy,s_i,1,f,bin); % Velocity_Estimation\;
% figure(01);imagesc(vel_var);
% %  saving "vel_var" Vs "time"
y_vel_var(f) = sum(sum(vel_var))/(s_i(1)*s_i(2));x_vel_var(f) = f; 

[c_var sup] =  show_imagesc(vel_var,vid(:,:,1,f),0.5,0.2); % show\;
 figure(02);imshow(c_var);figure(03);imshow(sup);
toc
end

% %  showing Vel_var Vs time
plot(1:f,y_vel_var);



% for f = 1:size(vid,4)