% saveas = 'delete10';% img = gray;
function [bbox index ] = ann_bbox(saveas,img)
clc, close all, %clear;
%--------------------------------
% load(strcat(saveas,'.mat'));
% if(exist('bbox','var')==1)
% else
bbox = [];
index = [];i = size(index,1)+1;
% end
% for i = size(index,1)+1: size(Images,4)
imgObj = img;
figure;
imageHandle = imshow(imgObj);
keyInput = 0;

while (keyInput ~= 1)
    %     [bbox(i,1) bbox(i,2)] = ginput(1);
    p = ginput(2); % [y_min x_min ;y_max x_max];
    %     imshow(x_min:x_max,y_min:y_max);
    %     imshow(img(p(1,2):p(2,2),p(1,1):p(2,1)));
    %                   1     2      3     4
    sp(1) = min(  floor(p(1,2)) , floor(p(2,2))  ); % x_min
    sp(2) = min(  floor(p(1,1)) , floor(p(2,1)) );  % y_min
    sp(3) = max(  floor(p(1,2)) , floor(p(2,2)) ) - min( floor(p(1,2)),floor(p(2,2)) ); % w_x width in x
    sp(4) = max(  floor(p(1,1)) , floor(p(2,1)) ) - min( floor(p(1,1)),floor(p(2,1)) ); % w_y width in y
    % sp(5) = i; %         sp = [x_min y_min w_x w_y ] %
    % imshow(img(sp(1):sp(1)+sp(3),sp(2):sp(2)+sp(4)));
    index = [index;i];
    bbox = [bbox;sp];
    save(saveas,'bbox','index');
    hold on, imshow( show_bbox(img,bbox));
    keyInput = waitforbuttonpress;
end
% end
% hold on, scatter(bbox(:,1), bbox(:,2), 'r.');
save(saveas,'bbox','index');  % Output file name
% end