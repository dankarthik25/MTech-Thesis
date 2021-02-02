%    saving the detection images of Hog detection
% INPUT
% img,bbox = [y_min x_min w_y w_x] for Hog detection[x_min y_min x_width y_width]
function result_img = showdetection(img,bbox)
w  =1;
result_img = img;
if(size(result_img,3)==1)
    result_img(:,:,2) = result_img(:,:,1);
    result_img(:,:,3)  = result_img(:,:,1);
end
for i = 1: size(bbox,1);
    x_min = floor(bbox(i,2));y_min = floor(bbox(i,1));
    w_y = ceil(bbox(i,3)); w_x = ceil(bbox(i,4));
% For Drawing Vertical Lines 
    result_img(x_min:x_min+w_x,y_min:y_min+w,1) = 255;
    result_img(x_min:x_min+w_x,y_min:y_min+w,2) = 0;
    result_img(x_min:x_min+w_x,y_min:y_min+w,3) = 0;
    result_img(x_min:x_min+w_x,y_min+w_y:y_min+w_y+w,1) = 255;
    result_img(x_min:x_min+w_x,y_min+w_y:y_min+w_y+w,2) = 0;
    result_img(x_min:x_min+w_x,y_min+w_y:y_min+w_y+w,3) = 0;
% For Drawing Horizontal Line    
    result_img(x_min:x_min+w,y_min:y_min+w_y,1) = 255;
    result_img(x_min:x_min+w,y_min:y_min+w_y,2) = 0;
    result_img(x_min:x_min+w,y_min:y_min+w_y,3) = 0;
    result_img(x_min+w_x:x_min+w_x+w,y_min:y_min+w_y,1) = 255;
    result_img(x_min+w_x:x_min+w_x+w,y_min:y_min+w_y,2) = 0;
    result_img(x_min+w_x:x_min+w_x+w,y_min:y_min+w_y,3) = 0;
end
% imshow(result_img);
% saveas(figure1,'Detection.jpg')
end
%% Other mtehod using rectangle fuction
% function showdetection(bbox,img)
% bbox = [ xo yo wo ho ] formate
% hold on;
% imshow(img);
% for i =1:size(bbox,1)
%     rectangle('position',bbox(i,:),'edgecolor','r');
% end
% hold off;
% end