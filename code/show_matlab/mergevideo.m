% merge video
for f = 1: size(tub,4)
    left_img = zeros(size(tub,1),size(tub,2));
    left_img(1:322,:,1) = vid_original(:,:,1,f);
    [sx1 sy1] = size(left_img);
    left_img(:,:,2) = left_img(:,:,1);left_img(:,:,3) = left_img(:,:,1);
    left_img = uint8(left_img);
    
    right_img = tub(:,:,:,f);
    add_img = left_img;
    [sx2 sy2 c] = size(right_img);
    for x = 1:size(tub,1)
        for y =1:size(tub,2)
            add_img(x,sy1+y,:) = right_img(x,y,:);      
        end
    end
  
    imwrite(add_img,strcat('merge_result_',num2str(f),'.png'));
      clear add_img;
end