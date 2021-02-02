function mask_img = mask_circle(r)
% r = 30;
mask_img = false(2*r-1,2*r-1);
cx = r;
cy = r;
for ix = 1:size(mask_img,1)
    for iy =1:size(mask_img,2)
        if((ix-cx)^2+(iy-cy)^2 <=r^2)
            mask_img(ix,iy) = true;
        end
    end
end
% imshow(mask_img);

        