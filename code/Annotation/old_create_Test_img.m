% para.DW_size = [32 32];
% para.n = 3;
% step = 64;
function Testimg = create_Test_img(ix,iy,para,step,t_images)
% Testimg =zeros(ix,iy,3);
Testimg =255*ones(ix,iy,3);
% para.DW_size = [32 32];% step = 64;
i =1;
for idx = 20:step:size(Testimg,1)
    for jdx = 20:step:size(Testimg,2)
        if ((idx +para.DW_size(1)-1)<size(Testimg,1))&&((jdx+para.DW_size(2)-1)<size(Testimg,2))
            Testimg(idx:idx+para.DW_size(1)-1,jdx:jdx+para.DW_size(2)-1,:,1) = t_images(:,:,:,i);
            i= i+1;
        end
    end
end
Testimg = uint8(Testimg);
imshow(Testimg);
end