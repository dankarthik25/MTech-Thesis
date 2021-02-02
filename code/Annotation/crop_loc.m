%  loc = GT{f};
% Dsize = [25 25];
% % % % First Create the folder then only Dataset is created
% path = '../dataset_25';
% img = vi(:,:,:,f);

function [num_idx dataset] = crop_loc(loc,Dsize,path,img,num_idx)
% num_idx =1;
% count = 1;
dataset = [];
img_type = '.png';
width = Dsize(1)/2;
% Create the postive samples of image 


for  i =  1: size(loc,1)
    x = ceil((loc(i,1) - Dsize(1)/2));
    y = ceil((loc(i,2) - Dsize(2)/2));
    if y<1
        y = 1;
    end
    if x<1
        x = 1;
    end
    if(x + Dsize(1)-1)<size(img,1)&&(y + Dsize(2)-1)< size(img,2)
% % % % % % % % % % % % % % % % 
        if x > width %()
            x_min = x - width ;
        else 
            x_min = 1; 
        end
        if x < size(img,1)-width
            x_max = x + width ;
        else
            x_max = size(img,1);
        end
% % % % % % % %
        if y > width %()
            y_min = y - width;
        else 
            y_min = 1;
        end
        if y<size(img,2)- width
            y_max = y + width;
        else
            y_max = size(img,2);
        end
        temp_x = x_min:x_max;
        temp_y = y_min:y_max;
        count = 1;
        for tx = 1:size(temp_x,2)
            x = temp_x(tx);
            for ty = 1 :size(temp_y,2)
                y = temp_y(ty);
                crop(:,:,:) = img(x:x+ Dsize(1)-1,y:y+Dsize(2)-1,:);
                dataset(:,:,:,i) = crop(:,:,:);
%                 i = i +1;
                str_img = strcat('p',num2str(num_idx,'%05d'));
                img_name = strcat(str_img,img_type);
                imwrite (crop,strcat(path,'/',img_name));
                count = count+1;
            end
        end
        temp_x = [];temp_y = [];
        num_idx = num_idx + 1;
    end
end