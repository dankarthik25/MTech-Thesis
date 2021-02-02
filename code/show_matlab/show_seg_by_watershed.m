function show_seg_by_watershed(L,img)
idx = find(L==0);
% % % for colour view of the segmentataion 
% result = img;
% result(idx) = 255;
% result(:,:,2)=img;result(:,:,3) = img;
% imshow(result);

result = img;result(idx) = 255;
imagesc(result);