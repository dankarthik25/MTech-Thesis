% saveas = '103354110q_delete';
function [bbox index ] = ann_mulit_img_bbox(str,Images)
clc, close all, %clear;
bbox = [];index = [];
for i = size(index,1)+1: size(Images,4)
    img = Images(:,:,:,i);
    [bbox_temp index_temp ] = ann_bbox(str,img);
     bbox{i} = bbox_temp;
     index{i} = index_temp;
end
save(str,'bbox','index');  % Output file name
end