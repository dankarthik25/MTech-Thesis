% delete repeted img
w=15;
p.DW_size = [w w];
p.ImgType = '*.png';

path = 'E:\Thesis\code\ph_3\n';
Img_list =  dir([path '\' p.ImgType]);
lng = size(Img_list,1);idx =1;

while idx < lng
    idx
    img = imread([path '\' Img_list(idx).name  ]);
    s_idx = idx+1;
    while s_idx <= lng
        temp  = imread([path '\' Img_list(s_idx).name  ]);
        res = double(img)-double(temp);
        v = sum(sum(sum(abs(res))));
        if v==0
            delete(strcat(path,'/',Img_list(s_idx).name ));
            Img_list =  dir([path '\' p.ImgType]);
            lng = size(Img_list,1);
        end
        s_idx = s_idx+1;
    end
    idx = idx+1;
end

% path = 'E:\Thesis\code\ph_3\p'; 38,992
img_type = '.png';
str = 'n_';
numbering_Dataset(path,img_type,str)