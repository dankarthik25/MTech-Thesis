 function org_img = superimpose_img(org_img,den) 
%  den = 255-den;
 if (size(org_img,3)==1)
     org_img(:,:,2) = org_img(:,:,1);
     org_img(:,:,3) = org_img(:,:,1);
 end
for x =  1: size(den,1)
    for y = 1:size(den,2)
        if(den(x,y) >= 1)
            org_img(x,y,2)= den(x,y); %255;
%             org_img(x,y,1) =0;
%             org_img(x,y,1)=255;
% % method for showing Binary image Location
%             org_img(x,y,2)=0; % den(x,y);
%             org_img(x,y,1) = 255;
%             org_img(x,y,3) =0;

        end
% % SuperImposing the Images ;
%             org_img(:,:,1) = 0.8 * double(org_img(:,:,1)) + 0.2 * double(den(:,:,1));        
%     end
end
% figure(02)
imshow(org_img);
 end
% 
% figure(03)
% imagesc(den);
% s = strcat('op_',int2str(fd),'.png');
% imwrite(flowToColor(flow),s);
% imwrite(simg,s);
