% path = 'E:\Thesis\code\ph_3\p';
% img_type = '.png';
% str = 'p_';
function numbering_Dataset(path,img_type,str)
% % % % % % % % % % % % % % % % % % %
Img_list =  dir([path '\' '*' img_type]);
for idx = 1: size(Img_list,1)
    img = imread([path '\' Img_list(idx).name  ]);
    img_name = strcat(num2str(idx,'%05d'),img_type);
    if exist(strcat(path,'/',img_name),'file')==2
        imwrite (img,strcat(path,'/',str,img_name));
    else
        imwrite (img,strcat(path,'/',str,img_name));
        delete(strcat(path ,'/',Img_list(idx).name)); % delete(img_name);delete(strcat(path ,'\',img_name))
    end
end
