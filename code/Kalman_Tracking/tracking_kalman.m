% function[trk ] =  kft(GT,vid)
clear trk;clc;
% 
% 1x5 struct array with fields:
% 
%     id
%     age
%     Tot_Vis_Count
%     Con_Invis_Count
%     asg
%     x
%     y
sf = 1;f =1;%sf;
% Constrains 
cns.min_dis = 50;       
cns.trk_t   = 10;   
cns.max_trk = 200;
% Input Parameter 
ip.dt       = 1;                                             
ip.ws_mag   = 1;
ip.ob_noise = 0.1; 
% Inicializing Parameters
trk = int_trk();                            % Inicializing Traker
Zf = GT{sf}';
[SS Sp Xf ] =  inc_kal(ip,Zf,cns.max_trk);  % Inicializing State Space and its Parameters
%
% f= f+1;
% % % Kalman Filter Tracking

 for f = sf:sf :size(vid,4)
Zf = GT{f}';  

tic % set new number of detections
[Xf Sp ] = predict_kal(Xf,SS,Sp); % Predict next state with state and predicted motion

asg = opt_assign(Xf,Zf,cns.min_dis);         % now we assign the detections to estimated track positions
[Xf Sp ] = update_kal(asg,Zf,Xf,Sp);         % updating the state by assign
[Xf trk ] = update_trk(asg,Xf,Zf,trk,f,sf) ; % adding new track,removing bad trafk,updating nF
temp = Xf(:,1:size(Zf,2));

toc
show_track(vid(:,:,:,f),trk,cns.trk_t);
pause(0.1);
% % % % % % % % % % % % % % % % % % % % % % % % % 
% m2p =112;
% v= zeros(length(Zf),2);
% 
for i = 1:length(Zf)
    if isnan(Xf(1,i))
        temp(:,i) = Xf(:,i);
%     v(i,1) = Xf(3,i);
%     v(i,2) = Xf(4,i);
    end
end



end
% trk_idx = find(isnan(Xf(1,:)==0);             % Index of current Trks
% no_trk =  lenght(find(isnan(Xf(1,:))==0));    % Total No.current tracks
% new_trk_idx = find(isnan(Xf(1,:)==1);         % Index of empty tracks

