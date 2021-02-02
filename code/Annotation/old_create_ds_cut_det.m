% creat_ds_cut_det: Creating Dataset by croping Detection
% Dsize = [25 25];
% str_file = 'NLPR_pos';
% str_type = '.png';
% path = 'E:\DataSet\DataSet_Head';
function create_dataset_cut_detection(top,str_type,img,num,step,sd)
i_path = 'E:\DataSet\DataSet_Head\';
idx = 1;sc = 1;
% create the dataset buy detection
for i =  1: size(top,1)
 y = top(i,1);
 x = top(i,2);
 Dy = top(i,3);
 Dx = top(i,4);
 for interval = 1:4
  img = imresize(img,sc);
  x1 = round(x*sc - Dx*(1-sc)/2 );
  y1 = round(y*sc - Dy*(1-sc)/2 );
  if x1>0 && y1>0
  for ix = x1-step:1:x1+step
   for iy = y1-step:1:y1+step
       
    if(ix>0)&&(iy>0)&&(ix + Dx-1)<size(img,1)&&(iy + Dy -1)< size(img,2)
     crop(:,:,:) = uint8(img(ix:ix+ Dx -1,iy:iy+Dy-1,:));
     str_img = num2str(num,'%05d');
     str_crop_no = num2str(i,'%02d');
     str_shift_no = num2str(idx ,'%03d');
     img_name = strcat(i_path,str_img,'_','c',str_crop_no,'_','s',str_shift_no,str_type);
     crop = imresize(crop,2);
     imwrite (crop,img_name);
     clear crop;
     idx = idx +1;
    end
   end
  end
  end
 sc = sc -sd;
end
end