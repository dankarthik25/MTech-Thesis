% Finding the Location of Head either by Ground Truth or Detection
% Croping the objects by Location with small shift and saving in path_dat
% Manually Filtering the objects in path_dat and moving to path_pos
% Updating the numbering index


% load('../Dataset/mat/ped_flow.mat', 'GT','gray');
D_size =[25 25] ;
% path_pos = 'E:\Thesis\code\dataset_25/pos';
path_dat = 'E:\Thesis\code\dataset_25';
imt_type = '.png';

num_idx = 1;
%%
for f =10:10:1000
    loc = img2loc(gray(:,:,:,f),small,big,8);
    num_idx  = crop_loc(loc,D_size,path_dat,gray(:,:,:,f),num_idx);

% [num_idx dataset ] = crop_loc(GT{f},D_size,path_dat,gray(:,:,:,f),num_idx);
% f = f+50;
end
%%


% numbering_Dataset(path_pos,img_type);










% Dsize = [25 25];

% str_type = '.png';
% path = 'E:\DataSet\DataSet_Head';
% function create_dataset_GT(Dw,imgs,loc,str_type,path)
% path = 'E:\DataSet\DataSet_Head\';
% for num = 1:size(imgs,4)
%     img = imgs(:,:,:,num);
%     loc = GT{f};
%     % create the dataset buy detection
%     for i =  1: size(loc,1)
%         x = top(i,1);
%         y = top(i,2);
%         if x <1
%             x =1;
%         elseif x>size(img,1)-Dw(1)
%             x = size(img,1)-Dw(1);
%         end
%         if y<1
%             y =1;
%         elseif y >size(img,2)-Dw(2)
%             y = size(img,2)-Dw(2);
%         end
%         crop = img(x:x+Dw(1),y:y+Dw(2));
%         
%         str_img = num2str(num,'%05d');
%         str_crop_no = num2str(i,'%02d');
%         img_name = strcat(path,str_img,'_',str_crop_no,'_','s',str_shift_no,str_type);
%         crop = imresize(crop,2);
%         imwrite (crop,img_name);
%         clear crop;
%     end
% end
