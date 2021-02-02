
% %  Matlab Code
% % hsv_img = rgb2hsv(rgb_img); hsv_image = rgb2hsv(rgb_image)

% HSV
% Hue : Color :chroma
% Saturation : Whiteness
% v : barkness will change
%
% cmap(:,:,1) % hue
% cmap(:,:,2) % saturation
% cmap(:,:,3) % value
%
% red    (255,  0,  0) 	=> (0     ,1,1)
% yellow (255,255,  0) 	=> (0.1667,1,1)
% green  (  0,255,  0) 	=> (0.3333,1,1)
% cyan   (255,255,  0)`	=> (   0.5,1,1)
% blue   (  0,  0,255)  => (0.6667,1,1)
%
% magentas(255,255,0)    =>(0.8333,1,1)
%


function[c_den sup] =  show_imagesc(den,img,th_max,th_min)
% img = vid_original(:,:,1,1);
% Given density image (double )
mark_point = 0.6;
hue = den;
hue = hue - min(min(hue));
hue = hue / max(max(hue));
% hue = hue / th_max;
idx = find(hue > 1);hue(idx) = 1;
hue = mark_point * hue;
hue = mark_point - hue;
sat = ones(size(hue,1),size(hue,2));
val = ones(size(hue,1),size(hue,2));

hsv_img(:,:,1) = hue;
hsv_img(:,:,2) = sat;
hsv_img(:,:,3) = val;

c_den = hsv2rgb(hsv_img);
c_den = uint8(255*c_den);

img(:,:,2) = img(:,:,1);
img(:,:,3) = img(:,:,1);
sup = zeros(size(img,3));
for ix = 1:size(c_den,1)
    for iy = 1: size(c_den,2)
        if(c_den(ix,iy) <th_min)
            sup(ix,iy,1) = img(ix,iy,1);
            sup(ix,iy,2) = img(ix,iy,2);
            sup(ix,iy,3) = img(ix,iy,3);
        else
            sup(ix,iy,1) = 0.75 * double(img(ix,iy,1)) + 0.25 * double(c_den(ix,iy,1));
            sup(ix,iy,2) = 0.75 * double(img(ix,iy,2)) + 0.25 * double(c_den(ix,iy,2)); 
            sup(ix,iy,3) = 0.75 * double(img(ix,iy,3)) + 0.25 * double(c_den(ix,iy,3)); 
        end
    end
end
sup = uint8(sup);

imshow(sup);
