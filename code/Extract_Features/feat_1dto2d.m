%% 
% This method is not working

%%
% % % img =
% features  = extractHOGFeatures(img,'Cellsize',[para.c_bin,para.c_bin]);
% sf(1) = floor(size(img,1)/para.c_bin - 1);
% sf(2) =  floor(size(img,2)/para.c_bin - 1);
% reshape_features_1 = reshape(features,9,2*sf(1),2*sf(2));
% reshape_features_2 = reshape(features,2*sf(1),9,2*sf(2));
% reshape_features_3 = reshape(features,2*sf(1),2*sf(2),9);    clear sf;
% ---Verifing if the reshape is working correctly or not-------
%  back_feature = reshape(reshape_features,1,[]);
% [label,Score] = predict(SVMStruct_15_2, back_feature);
%        Shifting the feature
% scale = zeros(24,24,9);
% x =11;y =13;
% scale(x:x+12-1,y:y+12-1,1:9) = reshape_features(:,:,:);
% ---Verifing
% temp = scale(x:x+12-1,y:y+12-1,1:9);
% back_feature1 = reshape(temp,1,[]);
% [label1,Score1] = predict(SVMStruct_15_2,back_feature);

step = 1; sc =1; 
bbox  = [];
features  = extractHOGFeatures(scale,'Cellsize',[para.c_bin,para.c_bin]);
sf(1) = floor(size(scale,1)/para.c_bin - 1);
sf(2) =  floor(size(scale,2)/para.c_bin - 1);
% scale_feat = reshape(features,2*sf(1),2*sf(2),9); 
scale_feat_1 = reshape(features,9,2*sf(1),2*sf(2));
% scale_feat_2 = reshape(features,2*sf(1),9,2*sf(2));
% scale_feat_3 = reshape(features,2*sf(1),2*sf(2),9);    clear sf;
for x =1:step:size(scale_feat_1,2)-12 +1
   for y = 1:step:size(scale_feat_1,3) -12 +1
%         crop_img = uint8(s_img(x:x+para.DW_size(1)-1,y:y+para.DW_size(2)-1,1:3));
%         crop_feature = extractHOGFeatures(crop_img,'Cellsize',[para.n,para.n]);
        crop_feature = scale_feat_1(1:9,x:x+12-1,y:y+12-1);
%         crop_feature = scale_feat_2(x:x+12-1,1:9,y:y+12-1);
%         crop_feature = scale_feat_3(x:x+12-1,y:y+12-1,1:9);
        crop_feature = reshape(crop_feature,1,[]);
        [label,Score] = predict(SVMStruct_15_2, crop_feature);
        if(Score(2) >= 0)
            DetScore = [DetScore;Score(2)];
            new_row = [y/sc,x/sc,para.DW_size(2)/sc,para.DW_size(1)/sc];
%             para.c_bin*ceil(y/(2*sc+1)
            bbox = [bbox;new_row];
        end
    end
end