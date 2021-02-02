% para.W = 1;
% para.DW_size = [20 20];
% para.SF  = 0.125;
% para.ImgType = '*.jpg';
% para.ImgType  ='*.png';
%'*.bmp';
% TrainingSet_Path =  'E:\Project\Hog\27Mar15\Annotated_Img\adsfa';
function [trainingImages,trainingLabel]=ext_Trainingset(path,para)
Folder_list =  dir([path]);
NumFolder = size(Folder_list,1)-2;
trainingImages = [];                          % Inicallizing Collection of Images
NumImg = zeros(2,1);  % Inicalizing " no of image =0 "
% tic
for folder_idx = 1:NumFolder
        if(para.W==1)
            Img_list = dir([path '\' Folder_list(folder_idx+2).name '\' para.ImgType ]) ;
             if(size(Img_list,1)==0)
                Img_list = dir([path '\' Folder_list(folder_idx+2).name '\*.BMP' ]);
            end
        else
            Img_list = dir([path '/' Folder_list(folder_idx+2).name '/*.bmp']) ; %  para.ImgType 
            if(size(Img_list,1)==0)
                Img_list = dir([path '/' Folder_list(folder_idx+2).name '/*.BMP' ]);
            end
        end
        NumImg(folder_idx) = size(Img_list,1) ;      

    for idx = 1:NumImg(folder_idx) 
        %--------------------------------
        if(para.W==1)
            img = imread([path '\' Folder_list(folder_idx+2).name '\' Img_list(idx).name  ]);   
        else
            img = imread([path '/' Folder_list(folder_idx+2).name '/' Img_list(idx).name  ]);
        end
        if (folder_idx==1)
            img = imresize(img,para.DW_size);
            img = uint8(img);
            if(folder_idx ==1)&&(idx==1)
                trainingImages(:,:,:,1) =uint8( img(:,:,:));
            else
                trainingImages(:,:,:,end+1) = uint8(img(:,:,:));
            end
        else 
            simg = img;
            if(size(img,1)>100)||(size(img,2)>100)
            simg = imresize(img, [100 NaN]);
            end
            dx = para.DW_size(1); dy=para.DW_size(2); scale =1;idx = 1;    % Image Index
            while ( size(simg,1) >= dx)&&(size(simg,2) >= dy)
%                tic; 
%                 if (size(simg,1)<100)||( size(simg,2) < 100 )
                  for i = 1:dx:size(simg,1)
                    for j = 1:dx: size(simg,2)
                        x_lim = i +dx -1;y_lim = j + dy - 1;
                            if (  x_lim <= size(simg,1)  )&&(  y_lim <= size(simg,2) )
                                temp(1:dx,1:dx,:) = simg(i :x_lim,j:y_lim,:);
                                trainingImages(:,:,:,end +1) = uint8(temp(:,:,:) );
                                idx = idx +1;
                            end
                    end
                  end
%                 end
                scale = scale * para.SF ;
                simg =  imresize(simg,scale);  
%                 toc
            end 
        end
       
    end
%     toc;
end
trainingImages = uint8(trainingImages);
no_total = size(trainingImages,4);
no_negative = no_total - NumImg(1) ;
trainingLabel = zeros(no_total,1); 
trainingLabel(1:NumImg(1)  )   = +1;                                         % +1 = Head
trainingLabel(NumImg(1)+1:no_total )  = -1;                             % -1 = NonHead
Y = uint8(Y);
%-------------------------------------------------------------------------------------
  end
