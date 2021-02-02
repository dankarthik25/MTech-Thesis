% % Intergrating the local max with hog 
% % input : loc:location by local max
% %       : image
%         : small
%         : loc
% %       : SVM struct 
%         : method.hog_bin = 1;
% %       : size of the objects
% % %% PROCESS : Create a window around the loc for searching the object and returen the  best matched
% % output: loc_filtered 

% Dsize = [25 25];
% width = 0;
function loc_feat =  loc_filt(img,loc,SVMStruct,method,Dsize)
width = 0;
loc_feat= [];
feat = [];
for i = 1:size(loc,1)
   x = ceil((loc(i,1) - Dsize(1)/2));
    y = ceil((loc(i,2) - Dsize(2)/2));
% % % % % % % % % % % % % % % % % % %     
    if x  <1 x = 1;end
    if y  <1 y = 1;end
    if x  > size(img,1)- Dsize(1)+1
        x = size(img,1)-Dsize(1)+1;end
    if y  > size(img,2)- Dsize(2)+1
        y = size(img,2)-Dsize(2)+1;end
    
 crop_img = img(x:x+Dsize(1)-1,y:y+Dsize(2)-1 );
 crop_feat = extractHOGFeatures(crop_img,'Cellsize',[method.hog_bin method.hog_bin]);
 feat = [feat ;crop_feat];
end
[label,Score] = predict(SVMStruct, feat); % for verification only
idx = find(label==1);
if(~isempty(idx))
    loc_feat = loc(idx,:);
end
end
% %% Consiering a winow for the obj
% for i = 1:size(loc,1)
%     x = ceil((loc(i,1) - Dsize(1)/2));
%     y = ceil((loc(i,2) - Dsize(2)/2));
% % % % % % % % % % % % % % % % % % % %     
%     if x - width <1
%         x_min = 1;
%     else 
%         x_min = x - width;
%     end
% % % % % % % % % % % % % % % % % % % % % %     
%     if (x + width>=1) && (x + width <= size(img,1)- Dsize(1)+1)
%          x_max = x + width ; 
%     elseif (x + width > size(img,1)- Dsize(1)+1)
%        x_max = size(img,1)-Dsize(1)+1;
%     else
%         x_max =1;
%     end
% % % % % % % % % % % % % % % % % % % %   
%     if y - width<1
%         y_min = 1;
%     elseif(y-width>1)&&(y-width<size(img,2)-Dsize(2)+1)
%         y_min = y - width;
%     elseif(y-width>1)&&(y-width>size(img,2)-Dsize(2)+1)
%         y_min = size(img,2) - Dsize(2);
%         
%     end
% % % % % % % % % % % % % % % % % % % % % %    
%     if (y + width >=1)&&(y + width <= size(img,2) - Dsize(2)+1)
%         y_max = y + width ;
%     elseif y + width > size(img,2) - Dsize(2)
%         y_max = size(img,2)- Dsize(2);
%     else
%         y_max =1;
%     end
%     feat = [];
%     if(x_min>0)&&(x_max>0)&&(y_min>0)&&(y_max>0)
%        for ix  = x_min :x_max
%            for iy = y_min:y_max
%               crop_img = img(ix:ix+Dsize(1)-1,iy:iy+Dsize(2)-1 );
%               crop_feat = extractHOGFeatures(crop_img,'Cellsize',[method.hog_bin method.hog_bin]);
%               feat = [feat ;crop_feat]; 
%            end
%        end
%        [label,Score] = predict(SVMStruct, feat); % for verification only
%        if ~isempty(find(Score(:,2)>=0))
%            loc_f = [loc_f;loc(i,:)];
%        end
%     end
% end




