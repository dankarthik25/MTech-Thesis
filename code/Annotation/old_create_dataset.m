%----------------------
sf = 0.8;para.n =2;para.DW_size =[15 15];step  = 1;interval = 3;SVMStruct = SVMStruct_15_2;
%----------------------
str_type = '.png';      % str_file = 'NLPR_pos';
%----------------------
non_detected = [];
for num = 2848: size(pos,4) % 4
    img = imresize(pos(:,:,:,num),1.25);
    [top bbox DetScore ] = Hog_MultiScale_Detection(img,SVMStruct,para,step,sf,interval);
    if( isempty(top) == 1)
        non_detected = [non_detected;num]; 
    else
%       create_dataset_cut_detection(top,,str_type,img,num,step,sd)
        create_dataset_cut_detection(top,str_type,img,num,  2 ,0.1);
              fprintf('Current img is: %d \n',round(num));
    end
end