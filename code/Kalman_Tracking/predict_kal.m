function [Xf Sp ] = predict_kal(Xf,SS,Sp)
% % % % Updating the State Space 
trk_idx = find(isnan(Xf(1,:))==0);
for i = 1:length(trk_idx)
    Xf(:,trk_idx(i)) = SS.A * Xf(:,trk_idx(i)) + SS.B * SS.U;
end
% % % % Updating the State Parameters
%predict next covariance
Sp.P = SS.A * Sp.P* SS.A' + SS.Ex;              % P =A*P*A'+ Ex;
% Kalman Gain
Sp.K = Sp.P*Sp.H'*inv(Sp.H*Sp.P*Sp.H'+SS.Ez);   % K = P*H'*inv(H*P*H' +Ez)
end