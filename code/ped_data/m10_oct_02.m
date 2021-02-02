% % Intergrating the local max with hog 
% % input : loc:location by local max
% %       : image
%         : small
%         : loc
% %       : SVM struct 
%         : method.hog_bin = 1;
% %       : size of the objects
% % %% PROCESS : Create a window around the loc for searching the object and returen the  best matched
% % output: loc_filtered 

% method.type = 'hog';method.hog_bin = 1;
for f = 1:size(gray,4)
    tic
    img = gray(:,:,:,f);   
    loc = img2loc(img,small,big,4);
    loc_f =  loc_filt(small,img,loc,SVMStruct,method,[25 25]);
    toc
    imshow(show_loc2bbox(loc_f,img,2*small+5));
end
