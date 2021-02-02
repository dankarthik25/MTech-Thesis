%    saving the detection images of Hog detection
% INPUT
% img;
% bbox = [x_min y_min w_x w_y];

function result_img = show_bbox(img,bbox)
w  =1;
result_img = img;

if(size(result_img,3)==1)
    result_img(:,:,2) = result_img(:,:,1);
    result_img(:,:,3)  = result_img(:,:,1);
end
figure(01);
imshow(result_img);
for i = 1: size(bbox,1);
    x_min = floor(bbox(i,1));
    y_min = floor(bbox(i,2));
    x_max = floor(bbox(i,1)) + ceil(bbox(i,3));
    y_max = floor(bbox(i,2)) + ceil(bbox(i,4)); 
    if x_min<1
        x_min =1;
    end
    if x_max>size(img,1)
        x_max = size(img,1);
    end
    if y_min<1
        y_min =1;
    end
    if y_max>size(img,2)
        y_max = size(img,2);
    end
    r = 255;g=0;b =0;
% For Drawing Vertical Lines 
    result_img(x_min:x_max,y_min:y_min+w,1) = r;
    result_img(x_min:x_max,y_min:y_min+w,2) = g;
    result_img(x_min:x_max,y_min:y_min+w,3) = b;
    
    result_img(x_min:x_max,y_max:y_max+w,1) = r;
    result_img(x_min:x_max,y_max:y_max+w,2) = g;
    result_img(x_min:x_max,y_max:y_max+w,3) = b;
% For Drawing Horizontal Line    
    result_img(x_min:x_min+w,y_min:y_max,1) = r;
    result_img(x_min:x_min+w,y_min:y_max,2) = g;
    result_img(x_min:x_min+w,y_min:y_max,3) = b;
    
    result_img(x_max:x_max+w,y_min:y_max,1) = r;
    result_img(x_max:x_max+w,y_min:y_max,2) = g;
    result_img(x_max:x_max+w,y_min:y_max,3) = b;
end
figure(01);
imshow(result_img);
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