function [Xf Sp ] = update_kal(asgn,Zf,Xf,Sp)
%apply the assingment to the update
% asgn NaN and trk_idx NaN are synchornized
trk_idx = find(isnan(Xf(1,:))==0);k = 1;
if ~isempty(asgn)
    for i = 1:length(trk_idx)
        if asgn(i)>0
            Xf(:,trk_idx(i)) =  Xf(:,trk_idx(i)) + Sp.K * (Zf(:,asgn(i)) - Sp.H * Xf(:,trk_idx(i)));
        end
        k = k + 1;
        
    end
end
Sp.P =  (eye(4)-Sp.K*Sp.H)*Sp.P;
end

% k = 1;
% for F = 1:length(asgn)
%     if asgn(F) > 0
%         Xf(:,k) = Xf(:,k) + K * (Zf(:,asgn(F)) - H * Xf(:,k));
%     end
%     k = k + 1;
% end
% update covariance estimation.