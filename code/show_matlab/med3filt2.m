function img = med3filt2(img,sz)

for i = 1:size(img,3)
    img(:,:,i) = medfilt2(img(:,:,i),[sz sz]);
end
img = uint8(img);

% for i = 1:3
%     i_er(:,:,i) = imerode(img(:,:,i),strel('disk',4));
% end
% figure(01);
% imshow(uint8(i_er));