% imgs = zeros(32,32,size(top,1));
for i = 1: size(top,1)
    saveimg(:,:,:) = simg(top(i,2):top(i,2) +top(i,4)-1,top(i,1):top(i,1)+top(i,3)-1,:);
%     saveimg = imgs(:,:,:,i)
    str = strcat('detimg_',int2str(i),'.png');
    imwrite(saveimg,str);
end