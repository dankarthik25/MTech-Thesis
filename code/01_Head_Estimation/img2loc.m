% s_o = 18;small  = ceil(18/4);big = ceil(sqrt(2*s_o^2));
function [loc b_mag b_mod ] = img2loc(img,small,big,show) % used in ped dataset
loc =[]; % location the head { loc = [ x_loc, y_loc ] }
small_img = medfilt2(img,[small small]);
b_mod = double(small_img) - double(medfilt2(img,[big big]));
idx = find(b_mod <0);b_pos(idx) = 0;b_mod(idx) = - 1*b_mod(idx);

if(show<=1)
    figure(01);imagesc(b_mod);
end

se = strel('disk',small);
b_mag = imerode(b_mod,se);
idx = find(b_mag<=32);
b_mag(idx) = 0;

bw = true(size(b_mag));
bw(idx) = false;
if(show<=2)
%     figure(02);imagesc(b_mag);
figure(02);imshow(bw);
end
L = bwlabel(bw);
for l = 1:max(max(L))
   idx = find(L==l);
   sum_seg = sum(b_mag(idx));
   [x_idx,y_idx] = ind2sub(size(L),idx);
   if ((max(x_idx)- min(x_idx))> 0)||((max(y_idx)-min(x_idx))> 0)
   y_cent = round(sum(y_idx .* double(b_mag(idx)) ) / sum_seg);
   x_cent = round(sum(x_idx .* double(b_mag(idx)) ) / sum_seg);
    pt = [x_cent y_cent];
   loc = [loc;pt];
   end
end
% To show the result
if show <= 3 figure(03);imshow(show_loc2bbox(loc,img,2*small+5));end 
% width = 1;
% d_size = [2*small+5 2*small+5];
% num_idx = 1;
% img_type = '.png';
% path = 'E:\Thesis\code';
% for  i =  1: size(loc,1)
%     x = ceil((loc(i,1) - d_size(1)/2));
%     y = ceil((loc(i,2) - d_size(2)/2));
%     if y<1
%         y = 1;
%     end
%     if x<1
%         x = 1;
%     end
%     if(x + d_size(1)-1)<size(img,1)&&(y + d_size(2)-1)< size(img,2)
% % % % % % % % % % % % % % % % % 
%         if x > width %()
%             x_min = x - width ;
%         else 
%             x_min = 1; 
%         end
%         if x < size(img,1)-width
%             x_max = x + width ;
%         else
%             x_max = size(img,1);
%         end
% % % % % % % % %
%         if y > width %()
%             y_min = y - width;
%         else 
%             y_min = 1;
%         end
%         if y<size(img,2)- width
%             y_max = y + width;
%         else
%             y_max = size(img,2);
%         end
%         temp_x = x_min:x_max;
%         temp_y = y_min:y_max;
%         count = 1;
%         for tx = 1:size(temp_x,2)
%             x = temp_x(tx);
%             for ty = 1 :size(temp_y,2)
%                 y = temp_y(ty);
%                 crop(:,:,:) = img(x:x+ d_size(1)-1,y:y+d_size(2)-1,:);
%                 dataset(:,:,:,i) = crop(:,:,:);
% %                 i = i +1;
%                 str_img = strcat('p',num2str(num_idx,'%05d'));
%                 img_name = strcat(str_img,img_type);
%                 imwrite (crop,strcat(path,'/',img_name));
%                 count = count+1;
%             end
%         end
%         temp_x = [];temp_y = [];
%         num_idx = num_idx + 1;
%     end
% end

% result =   show_loc2bbox(loc,img,big);
