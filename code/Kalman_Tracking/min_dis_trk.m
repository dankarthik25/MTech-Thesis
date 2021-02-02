% min_dis_trk

clear track;clear trackX;clear trackY;
% load('E:\Thesis\Dataset\mat\ped_flow.mat', 'vid', 'GT');
Ms = [3 5]; %marker sizes
c_list = ['r' 'b' 'g' 'c' 'm' 'y']

f =100;loc = GT{f};
for i = 1: size(GT{f},1)
    trk_id{i} = i;
    trkX{i} = loc(i,1);
    trkY{i} = loc(i,2);
end
b =0;
for f =100:300
est_dist = pdist([GT{f}; GT{f+1}]);
est_dist = squareform(est_dist); %make square
dist = est_dist(1:size(GT{f},1),size(GT{f},1)+1:end) ; %limit to just the tracks to detection distances
[asgn, cost] = assignmentoptimal(dist);%assignmentoptimal %do the assignment with hungarian algo
asgn = asgn'; % if asgn = 0; no assignment is done  (people in f > people in f+1)
% assigning the track which has min distance
loc = GT{f+1};
asgn_tk = [];
for i = 1: size(trk_id,2)
    trk_rec = trk_id{i};
    pre_asg = trk_rec(end);
    if ~isnan(pre_asg)
        asgn_tk = [asgn_tk;pre_asg];
        next_asg = asgn(pre_asg);
        if(next_asg~=0)  % if there exist asgn in current frame =>asgn(f)
            trk_id{i} =[trk_id{i};next_asg];
            trkX{i} =[trkX{i}; loc(next_asg,1)];
            trkY{i} =[trkY{i}; loc(next_asg,2)];
        else
            trk_id{i} = [trk_id{i};NaN];
        end
    end
end
% Adding new track to the tracks
new = [];
new  = find(~ismember(1:size(loc,1),asgn)==1);
if ~isempty(new)
    for j = 1: size(new,2)
        trk_id{i+1} = new(j);
        trkX{i+1} = loc(new(j),1);
        trkY{i+1} = loc(new(j),2);
        i = i+1;
    end
end
% function show_track(img,Q_loc,Q_estX,Q_estY,t,s_f,nF)
imshow(vid(:,:,:,f));hold on;
loc =GT{f};plot(loc(:,2),loc(:,1),'r*');
for Dc = 1:size(trk_id,2) % nF
    Sz = mod(Dc,2)+1; %pick marker size
    Cz = mod(Dc,6)+1; %pick color
    tmx = double(trkX{Dc});
    if (size(tmx,1)>15)
    tmx = tmx(end-15:end);
    end
    tmy = double(trkY{Dc});
    if(size(tmy,1)>15)
    tmy = tmy(end-15:end);
    end
    plot(tmy,tmx,'.-','markersize',Ms(Sz),'color',c_list(Cz),'linewidth',3);
    axis off;
end
pause(0.2);
end
% end