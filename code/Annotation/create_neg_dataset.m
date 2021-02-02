% create_neg_dataset
% p.DW_size = [20 20];
% p.SF  = 0.125;
% p.overlap = 0.5;
% p.img_type = '.png';
% p.path = 'E:\Thesis\code\dataset_25';
% function cre
clc;
Dw_size = [20 20];
img_type = '.png';
path = 'E:\Thesis\code\dataset_25';
img = gray(:,:,:,1);


scale =1;
count = 1;
for ix = 1:1: 54
    for iy = 500:1: size(img,2)-Dw_size(2)
        crop = img(ix:ix+Dw_size(1),iy:iy+Dw_size(2),:);
        str_img = strcat('n_',num2str(count,'%04d'));
        img_name = strcat(str_img,img_type);
        imwrite (crop,strcat(path,'\',img_name));
        count =count +1;
    end
end
        % while ( size(img,1) >= dx)&&(size(img,2) >= dy)
        %     for i = 1:floor(dx*(1-p.overlap)):size(img,1)
        %         for j = 1:floor(dy*(1-p.overlap)): size(img,2)
        %             x_lim = i +dx -1;y_lim = j + dy - 1;
        %             if (  x_lim <= size(img,1)  )&&(  y_lim <= size(img,2) )
        %                 crop = img(i :x_lim,j:y_lim,:);
        %                 str_img = strcat('n_',num2str(count,'%07d'));
        %                 img_name = strcat(str_img,p.img_type);
        %                 imwrite (crop,strcat(p.path,'\',img_name));
        %                 count = count+1;
        %             end
        %         end
        %         scale = scale * p.SF ;
        %         img =  imresize(img,scale);
        %     end
        %
        % end
%     end