% To Mark the Location in image
% loc = ann_loc(str,img)
%       Input:
%               img: gray or color image
%               saveas:str file of save file 
%               eg: str = 'delete102';
%       Output:
%               loc = [x y ]; % location in image is img(x,y) or img(loc(1,1),loc(1,2));

function loc = ann_loc(loc,img)
%----------------------------------------------%
% Mark the objects location and save the coordinates.
%----------------------------------------------%
imgObj = img; 
figure(01);
imageHandle = imshow(imgObj);
keyInput = 0;
% i = 1;
% loc = [];
show_center(loc,img);
while (keyInput ~= 1)
    temp = ginput(1);
    if(isempty(temp))
        break;
    end
    
    if (~isempty(loc))
    loc(end+1,:) = [temp(1,2) temp(1,1)];
%     loc(end+1,2) = temp(1,1);
    else
        loc(1,1) = temp(1,2);
        loc(1,2) = temp(1,1);
    end
    show_center(loc,img); 
    % hold on, plot(temp(1), temp(2), 'r.', 'MarkerSize', 5);% i = i + 1;
    keyInput = waitforbuttonpress;
end
if (~isempty(loc))
    idx = find(loc(:,1)<=0 );
    loc(idx,:) = [];
    idx = find(loc(:,1)>=size(img,1));
    loc(idx,:) = [];
    
    idx = find(loc(:,2)<=0 );
    loc(idx,:) = [];
    idx = find(loc(:,2)>=size(img,2));
    loc(idx,:) = [];
end
% save(str,'loc');  % Output file name
end
