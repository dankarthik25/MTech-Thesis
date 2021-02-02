function [Xf  trk ] = update_trk(asg,Xf,Zf,trk,trk_t,f,s_f)
if (~isempty(trk))&&(~isempty(asg))
    for i = 1: size(trk,2)
        pre_asg = trk(i).asg;
        next_asg = asg(i);
        if(~isnan(next_asg))
            trk(i).age = trk(i).age + 1;
            %         trk_rec = trk(i).asg{1};
            %         pre_asg = trk_rec(end);
            if (~isnan(pre_asg))&&(next_asg ~= 0)       % tracks in previous & current frame
                trk(i).asg              = next_asg;
                trk(i).Tot_Vis_Count    = trk(i).Tot_Vis_Count + 1;
                trk(i).Con_Invis_Count  = 0;
                trk(i).x{1}             = [trk(i).x{1}; Zf(1,next_asg)];
                trk(i).y{1}             = [trk(i).y{1}; Zf(2,next_asg)];
            elseif (isnan(pre_asg))&&(next_asg ~=0)     % Lost Track in previous frame but detected in current frame
                trk(i).asg              = next_asg;
                trk(i).Tot_Vis_Count    = trk(i).Tot_Vis_Count + 1;
                trk(i).Con_Invis_Count  = 0;
                trk(i).x{1}             = [trk(i).x{1}; Zf(1,next_asg)];
                trk(i).y{1}             = [trk(i).y{1}; Zf(2,next_asg)];
            elseif (~isnan(pre_asg))&&(next_asg == 0)   % traked in previous but Lost Track in current frame
                trk(i).asg              = NaN;
                trk(i).Con_Invis_Count  = 1;
                trk(i).x{1}             = [trk(i).x{1}; Xf(1,i)];
                trk(i).y{1}             = [trk(i).y{1}; Xf(2,i)];
            elseif (isnan(pre_asg))&&(next_asg ==0)     % Lost trak in previous frame and current frame
                trk(i).asg              = NaN;
                trk(i).Con_Invis_Count  = trk(i).Con_Invis_Count +1 ; % How many consiqutive frame are having Nan
                trk(i).x{1}             = [trk(i).x{1}; Xf(1,i)];
                trk(i).y{1}             = [trk(i).y{1}; Xf(2,i)];
                if(trk(i).Con_Invis_Count> trk_t)
                    Xf(:,i) = NaN;
                end
            end
        end
    end
else
    for i = 1: size(asg,2)
        if(~isnan(asg(i)))
            trk(i).id = i;
            trk(i).age = 1;
            trk(i).Tot_Vis_Count = 1;
            trk(i).Con_Invis_Count = 0;
            trk(i).asg = asg(i);
            trk(i).x{1}  = [ Zf(1,asg(i))];
            trk(i).y{1}  = [ Zf(2,asg(i))];
        end
    end
end
% Adding new track to the tracks
new = [];
new  = find(~ismember(1:size(Zf,2),asg)==1);
if ~isempty(new)
    new_trk_idx = find(isnan(Xf(1,:))==1);
    i =1;
    if length(new_trk_idx)
        for j = 1: size(new,2)
            idx = new_trk_idx(i);
            trk(idx).id     = idx;
            trk(idx).asg    = new(j);
            trk(idx).x{1}   = Zf(1,new(j));
            trk(idx).y{1}   = Zf(2,new(j));
            Xf(:,idx)       = [Zf(1,new(j)) Zf(2,new(j)) 0 0];
            i = i+1;
        end
    end
 
end
% nt = size(trk,2);

% end