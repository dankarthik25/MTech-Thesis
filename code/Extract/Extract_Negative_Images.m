% para.W = 1;
% para.DW_size = [20 20];% para.SF  = 0.125;
% para.ImgType = '*.jpg';% para.ImgType  ='*.png';% para.ImgType = '*.bmp';% para.ImgType = '*.BMP';
% Images_Path =  'E:\DataSet\NLPR_HSDataset\train\02_NEG';% para.overlap = 0.5
function Neg_Images =Extract_Negative_Images(Images_Path,para)
Img_list =  dir([Images_Path '\' para.ImgType ]);
Neg_Images = [];
for Img_idx = 1: size(Img_list,1)
    img = imread([Images_Path '\' Img_list(Img_idx).name  ]);
    img = uint8(img);
    simg = img;
    dx = para.DW_size(1); dy=para.DW_size(2); scale =1;
%     Img_idx = 1;    % Image Index
     while ( size(simg,1) >= dx)&&(size(simg,2) >= dy)
         for i = 1:floor(dx*(1-para.overlap)):size(simg,1)
             for j = 1:floor(dy*(1-para.overlap)): size(simg,2)
                 x_lim = i +dx -1;y_lim = j + dy - 1;
                 if (  x_lim <= size(simg,1)  )&&(  y_lim <= size(simg,2) )
                    temp(1:dx,1:dy,:) = simg(i :x_lim,j:y_lim,:);
                    if(Img_idx==1)&&(i ==1)&&(j ==1)
                        Neg_Images(:,:,:,1) =uint8( temp(:,:,:));
                    else
                        Neg_Images(:,:,:,end +1) = uint8(temp(:,:,:) );
                    end
                 end
             end
         end
         scale = scale * para.SF ;
         simg =  imresize(simg,scale);  
     end
end
Neg_Images = uint8(Neg_Images);
end
