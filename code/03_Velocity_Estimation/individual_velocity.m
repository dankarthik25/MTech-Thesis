%  Finding Velocity of Individual by Tracking (min-distance)
% hz = 30;
% f =1;fd =1;
% c1 = find_center(vid_original(:,:,1,f),hz,0);
% c2 = find_center(vid_original(:,:,1,f+fd),hz,0);

% % %%
% v = zeros(size(c1));
% c1_map = 1:size(c1,1);          % Mapping Function      
% c2_map = 1:size(c2,1);
%
maped_c2 = []; maped_c1 = [];   % Index in Mapping Function which are to be mapped
for idx1 = 1:size(c1_map,2)
    temp1 = c1(c1_map(idx1),:);
    temp_idx2 = [];
    d_idx =[];
    for idx2 = 1:size(c2_map,2)
        temp2 = c2(c2_map(idx2),:);
        d = hypot(temp1(1)-temp2(1),temp1(2)-temp2(2));
        if(d==0)
            break;
        end

        if(d<=10)
            d_idx = [d_idx;d];
            temp_idx2 = [temp_idx2 ; idx2];
        end
    end
    if(d==0)
        maped_c2 = [maped_c2 ; idx2];
        maped_c1 = [maped_c1; idx1];
    end
    if(size(d_idx)>0)
        [dmin dmin_idx ] = sort( d_idx );
        maped_c2 = [maped_c2;temp_idx2(dmin_idx(1))];
        maped_c1 = [maped_c1;idx1]; 
        
    end

end

v(c1_map(maped_c1),:) = c1(c1_map(maped_c1),:) - c2(c2_map(maped_c2),:); % Finding the Optical Flow btw mapped points
c1_map(maped_c2) = [];
c2_map(maped_c2) = [];

