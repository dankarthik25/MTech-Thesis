function img = show_loc2bbox(loc,img,d)
w =1;
if(size(img,3) ==1)
    img(:,:,2) = img(:,:,1);
    img(:,:,3) = img(:,:,1);
end
% d = 15;width =2;
for i = 1:size(loc,1)
    
    x = ceil(loc(i,1));y = ceil(loc(i,2));
    
    x_min = x - d;
    if(x_min <=0) 
        x_min = 1;
    end
    x_max = x +d;
    
    if(x_max >size(img,1)) 
        x_max = size(img,1);
    end
    y_min = y - d;
    if(y_min <=0) 
        y_min = 1;
    end
    y_max = y+d;
    if(y_max >size(img,2)) 
        y_max = size(img,2);
    end
    r = 255;
    g = 0;
    b = 0;
    
    img(x_min:x_max,y_min:y_min+w,1) = r;
    img(x_min:x_max,y_min:y_min+w,2) = g;
    img(x_min:x_max,y_min:y_min+w,3) = b;
    
    img(x_min:x_max,y_max-w:y_max,1) = r;
    img(x_min:x_max,y_max-w:y_max,2) = g;
    img(x_min:x_max,y_max-w:y_max,3) = b ;
    
    img(x_min:x_min+w,y_min:y_max,1) = r;
    img(x_min:x_min+w,y_min:y_max,2) = g;
    img(x_min:x_min+w,y_min:y_max,3) = b;
    
    img(x_max-w:x_max,y_min:y_max,1) = r;
    img(x_max-w:x_max,y_min:y_max,2) = g;
    img(x_max-w:x_max,y_min:y_max,3) = b;
end
% imshow(img);
% end