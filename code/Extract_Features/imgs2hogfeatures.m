% images to hog feats
% Images = t_images;
function Features = imgs2hogfeatures(Images,para)
Features = [];
for i = 1:size(Images,4)
    img =   Images(:,:,:,i);
    img = imresize(img,para.DW_size);
    [crop_feature vis ] = extractHOGFeatures(img,'Cellsize',[para.n,para.n]);
    Features = [Features;crop_feature ];
end
end
