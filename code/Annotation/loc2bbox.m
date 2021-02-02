% Dsize = [20 20]; 

function bbox = loc2bbox(Dsize,loc,img)
sc=1;
bbox = [];
for i = 1: size(loc,1)
    x = ceil((loc(i,1) - Dsize(1)/2));
    y = ceil((loc(i,2)- Dsize(2)/2));
    new_row = [x/sc,y/sc,Dsize(1)/sc,Dsize(2)/sc];   
    bbox = [bbox;new_row];
end
% imshow(show_bbox(img,bbox));
end