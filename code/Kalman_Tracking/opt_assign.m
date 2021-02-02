function asgn = opt_assign(Xf,Zf,min_dis)
trk_idx = find(isnan(Xf(1,:))==0);
est_dist = pdist([Xf(1:2,trk_idx)'; Zf']);
est_dist = squareform(est_dist);                               % make square
est_dist = est_dist(1:length(trk_idx),length(trk_idx)+1:end) ; % limit to just the tracks to detection distances
[t_asgn, cost] = assignmentoptimal(est_dist);%assignmentoptimal  % do the assignment with hungarian algo
t_asgn = t_asgn';
% Reject if dis is more than min_dis

% if (~isempty(trk_idx))&&(~isempty(t_asgn))
if ~isempty(t_asgn)
    rej = [];
    for i = 1:length(trk_idx)
        if t_asgn(i) > 0
            rej(i) =  est_dist(i,t_asgn(i)) < min_dis ;
        else
            rej(i) = 0;
        end
        
    end
    t_asgn = t_asgn.*rej;
    asgn =  NaN(1,size(Xf,2)); % inicilaize trk which doesn't exist to NaN
    asgn(trk_idx) = t_asgn;    % asgn NaN and trk_idx NaN are synchornized
else
    asgn =[];
end
% else
%     asgn = NaN(1,size(Xf,2));
% end

% end
