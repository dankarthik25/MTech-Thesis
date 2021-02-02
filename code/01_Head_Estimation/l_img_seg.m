function[b_mag L] = l_img_seg(img,small,big,show,k)
k =2;
gaussian = fspecial('gaussian', ceil(6*k+1), k);
img = imfilter(img,gaussian,'replicate');
small_img = imfilter(medfilt2(img,[small small]),gaussian,'replicate');
small_img = medfilt2(img,[small small]);
b_mod = double(small_img) - double(medfilt2(img,[big big]));
idx = find(b_mod <0);b_pos(idx) = 0;b_mod(idx) = - 1*b_mod(idx);

if(show<=1)
    figure(01);imagesc(b_mod);
end
% % % Original Method
b_mag = b_mod;
% % % FILTERING THE MAX/MIN or Removing the Noise Local_Max 
% Method - I
% %---------------------------------------------
se = strel('disk',5);
b_mag = imopen(b_mod,se);
idx = find(b_mag<64);
b_mag(idx) = 0;
imagesc(b_mag);
% b_mag = imerode(b_mod,se);

% k =1;
% gaussian = fspecial('gaussian', ceil(6*k+1), k);
% b_mag = imfilter(b_mag,gaussian,'replicate');

% b_mag = imopen(b_mod,se);% b_mag = medfilt2(b_mod,[s_o s_o]);
if(show <=2)figure(02);imagesc(b_mag);end
% %------------------------------------------------
% Method - II compressing the image
%---------------------------------------------------
% k =0.45;
% temp = imresize(b_mod,k);
% b_mag= imresize(temp,1/k,'nearest');
% figure(02);imagesc(b_mag);
% %--------------------------------------------------
% Method - III make heirarical image opening and find the center with size more accuracy in center 
% %--------------------------------------------------

%------------------------------------------------
L = watershed(-b_mag);
% % TO SHOW THE SEGMENTED IMAGE
idx = find(L==0);
    result = b_mag; %    result = b_mag;
    result(idx) = -255;
if(show <=3)
    figure(03);
    imagesc(result); % result
end
end
