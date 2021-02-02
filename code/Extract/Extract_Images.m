% p.ImgType  ='*.png'; 
% p.DW_size = [30 30];
% path ='E:\Thesis\code\ph_2\pos';
% path = 'E:\Thesis\code\ph_3\pos'
% % % % % % % % % % % % % % % % % % % % % % % % %
% p.ImgType  ='*.png'; 
% p.DW_size = [25 25];
% path = 'E:\Thesis\code\dataset_25\test_25';
% path ='E:\Thesis\code\dataset_25\pos_25';
% % % % % % % % % % % % % % % % % % % % % % % % % 
% p.ImgType  ='*.png'; 
% p.DW_size = [50 50];
% path = 'E:\Thesis\code\dataset_25\Dataset2';

% path = 'E:\Thesis\code\dataset_25\pos';
% % % % % % % % % % % % % % % % % % % % % % % %
% para.W = 1;

% para.SF  = 0.125;
% para.ImgType = '*.jpg';

% para.ImgType = '*.BMP';
% '*.bmp';
% Images_Path =  'E:\Project\Hog\27Mar15\Annotated_Img\83212324_20x20';
% Images_Path = 'E:\DataSet\DataSet_Head';
%  11-May-15
% path = 'E:\DataSet\NLPR_HSDataset\test\01_POS';
% para.DW_size = [32 32];
% para.ImgType = '*.BMP';
%----------------------------------------------
function images = Extract_Images(path,p)%,no_img)
if strcmp(p.os,'w')
    in_file = '\';
else
    in_file = '/';
end
Img_list =  dir([path in_file p.ImgType]);
img =  imread([path in_file Img_list(1).name  ]);
images = zeros(size(img,1),size(img,2),3,size(Img_list,1));
no_img =size(Img_list,1); % if no_img >= size(Img_list,1)
%     no_img = size(Img_list,1);
% end
for idx = 1: size(Img_list,1)
     img = imread([path in_file Img_list(idx).name  ]);
     img = uint8(img);
     img = imresize(img,p.DW_size);
     if size(img,3) ==1
         img(:,:,2) = img(:,:,1);
         img(:,:,3) = img(:,:,1);
     end
        images(:,:,:,idx) =uint8( img(:,:,:));
     
end
images = uint8(images);
end
% traing_imgs = pos;
% traing_imgs(:,:,:,end+1:end+size(neg,4)) = neg;
% yd = -1*ones(size(traing_imgs,4),1);
% yd(1:size(pos,4),1) = 1;