
function RGB = show_count(img,cunt,Count_People)
c_in  = Count_People.in ;
c_out = Count_People.out;
ix = size(img,1);iy = size(img,2);
% Ms = [3 5]; %marker sizes
% c_list = ['r' 'b' 'g' 'c' 'm' 'y'];
if(size(img,3)==1)
    img(:,:,2) = img;
    img(:,:,3) = img(:,:,1);
% else 
end
% % %     Outer Box
img([1 2 ix-1 ix],:,1:2)   = 0;img([1 2 ix-1 ix],:,3)  =255;
img(:,[1 2 iy-1 iy],1:2)   = 0;img(:,[1 2 iy-1 iy],3)  =255;
% % %     Inner Box
img([2*cunt.w_x ix-2*cunt.w_x],[2*cunt.w_y:iy-2*cunt.w_y],1:2)= 0;img([2*cunt.w_x ix-2*cunt.w_x],[2*cunt.w_y:iy-2*cunt.w_y],3)  =255;
img([2*cunt.w_x:ix-2*cunt.w_x],[2*cunt.w_y iy-2*cunt.w_y],1:2)= 0;img([2*cunt.w_x:ix-2*cunt.w_x],[2*cunt.w_y   iy-2*cunt.w_y],3)=255;
% % %     Boundary Box
img([cunt.w_x ix-cunt.w_x],[cunt.w_y:iy-cunt.w_y],2:3)= 0;img([cunt.w_x ix-cunt.w_x],[cunt.w_y:iy-cunt.w_y],1)=255;
img([cunt.w_x:ix-cunt.w_x],[cunt.w_y iy-cunt.w_y],2:3)= 0;img([cunt.w_x:ix-cunt.w_x],[cunt.w_y iy-cunt.w_y],1)=255;
str{1} = ['Out:' num2str(c_out)];
str{2} = ['In :' num2str(c_in)];
RGB = insertText(img,[1 1;1 26],str,'FontSize',15,'BoxColor',{'blue','red'});
% imshow(RGB);
% hold on;
% for i = 1:size(trk,2) % nF
%     Sz = mod(i,2)+1; %pick marker size
%     Cz = mod(i,6)+1; %pick color
%     if(trk(i).Con_Invis_Count< trk_t)&&(~isnan(trk(i).asg))
%         tmX = trk(i).x{1};
%         tmY = trk(i).y{1};
%         if length(tmX)>20
%             tmY = tmY(end-20:end);
%             tmX = tmX(end-20:end);
%         end
%         plot(tmY,tmX,'.-','markersize',Ms(Sz),'color',c_list(Cz),'linewidth',3);
%         axis off;
%     end
% end
end

