% % % Annotation Help
%------------------------------------------------------------
% ann_loc               MARK the LOCATION in image      loc = ann_loc(str,img)
% ann_bbox              MARK the BOUNDING BOX of single img
% show_bbox             SHOW BBOX show_bbox(img,bbox);
% ann_mulit_img_bbox    MARK BBOX in Multi Images 
% loc2bbox              Convet loc to bbox of size Dsize
% crop_loc              Crop the obj[D_size D_size] loc from given image to folder:'path' and type :'img_type'
%-------------------------------------------------------------
%------------------------------------------------------------
% ann_loc       MARK the LOCATION in image      loc = ann_loc(str,img)
%------------------------------------------------------------
% 
% loc = ann_loc(str,img)
% Input:
%       img: gray or color image
%       str: file name to be saved
% Output:
%         loc = [x y]; % location in image is img(x,y) or img(loc(1,1),loc(1,2));
%--------------------------------------------------------------
% ann_bbox      MARK the BOUNDING BOX
%-------------------------------------------------------------
% [bbox index ] = ann_bbox(str,img)
% Input:
%           img: gray or color img
%           str: file name to be saved
% Output:
%           bbox:[x_min y_min x_w y_w];
%           index: index of bbox
%---------------------------------------
% show_bbox     SHOW BBOX           show_bbox(img,bbox);
%------------------------------------------
% Input:
%         img: gray or color img
%         bbox: [x_min y_min x_w y_w];% i=1;imshow(bbox(i,1):bbox(i,1)+bbox(i,3),bbox(i,2):bbox(i,2)+bbox(i,4));
% Output
%       To show the detection
%
%-----------------------------------------------
%  MARK BBOX in Multi Images
%-----------------------------------------------
% [bbox index ] = ann_mulit_img_bbox(str,Images)
%----------------------------------------------------
% Convet loc to bbox = loc2bbox(Dsize,img,loc)
%---------------------------------------------------
% Crop the obj[D_size D_size] loc from given image to folder:'path' and type :'img_type'
%  crop_loc(Dsize,str_file,str_type,img)
% -----------------------------------------------------