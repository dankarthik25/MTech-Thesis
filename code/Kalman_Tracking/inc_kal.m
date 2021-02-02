function [SS Sp Xf ] =  inc_kal(ip,Zf,max_trk)
dt       = ip.dt;
st_noise = ip.ws_mag;
ob_noise = ip.ob_noise;
% estimate of initial location estimation 
Xf = nan(4,max_trk);
if ~isempty(Zf)
    Xf(:,1:size(Zf,2)) = [Zf(1,:) ;Zf(2,:) ;zeros(1,size(Zf,2)); zeros(1,size(Zf,2))];    
end
% % % % % % % % % % % % % % % % % % % % 
% % % % State Equation 
% % estX_k = A . estX_k-1 + B u_k-1 + ws 
% 
% dt = 1;  %our sampling rate
SS.A = [1 0 dt 0;...
        0 1 0 dt;...
        0 0 1 0 ;...
        0 0 0 1]; 
%  
SS.B = [(dt^2/2);...
       (dt^2/2);...
          dt   ;... 
          dt];
SS.U = 0; % define acceleration magnitude to start
%    

% st_noise = 1; % state space noise: the variability how fast the obj moving (stdv of acceleration: meters/sec^2)
 
SS.Ex = [dt^4/4   0    dt^3/2  0   ; ...
          0      dt^4/4   0   dt^3/2; ...
         dt^3/2   0      dt^2    0   ; ...
         0      dt^3/2   0    dt^2].*st_noise^2; % Ex convert the state space noise (stdv) into covariance matrix

  % estimate of initial obj position variance (covariance matrix)
% %% Observation Equation measurement 
Sp.H = [1 0 0 0;...
        0 1 0 0]; 
Sp.P = SS.Ex;
% z_k = H estX_k + wo
wo_x = ob_noise;  %measurement noise in the horizontal direction (x axis).
wo_y = ob_noise;  %measurement noise in the horizontal direction (y axis).
SS.Ez = [wo_x 0; 0 wo_y];


          

% end
