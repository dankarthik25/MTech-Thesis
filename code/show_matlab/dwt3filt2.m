function dwt = dwt3filt2(img,str,sz1,sz2)
if(str =='g')
big  = sz2;
small = sz1;
h1 = fspecial('gaussian',2*big+1,big)-fspecial('gaussian',2*big+1,small);
dwt =  imfilter(img,h1,'replicate');
% dwt = double(zeros(size(img,1),size(img,2)));
else 

if (size(img,3)==1)
    dwt = medfilt2(img,[sz1,sz1])-medfilt2(img,[sz2,sz2]);;
elseif(size(img,3)==3)
    for i =1:3
        temp(:,:,i) = double( medfilt2(img(:,:,i),[sz1 sz1]))- double( medfilt2(img(:,:,i),[sz2,sz2]));
    end
    
    for ix = 1:size(img,1)
        for iy = 1:size(img,2)
            %             max_seg(ix,iy) = max(uint8(temp(ix,iy,:)));
            if(temp(ix,iy,1)>= temp(ix,iy,2))
                if(temp(ix,iy,1) >= temp(ix,iy,3))
                    dwt(ix,iy) = temp(ix,iy,1);
                else
                    dwt(ix,iy) = temp(ix,iy,3);
                end
            else
                dwt(ix,iy) = temp(ix,iy,2);
            end
        end
    end
end
end

   %     for i =1:3
%         small_img = medfilt2(img(:,:,i),[small small]);
%         big_img = medfilt2(img(:,:,i),[big,big]);
%         b_mod = double(small_img) - double(big_img);
%         idx = find(b_mod <0);b_mod(idx) = - 1*b_mod(idx);
%         b_cmod(:,:,i) = b_mod;
%     end
%     max_seg = double(zeros(size(img,1),size(img,2)));
%         for ix = 1:size(b_cmod,1)
%         for iy = 1:size(b_cmod,2)
%             %             max_seg(ix,iy) = max(uint8(b_cmod(ix,iy,:)));
%             if(b_cmod(ix,iy,1)>= b_cmod(ix,iy,2))
%                 if(b_cmod(ix,iy,1)>= b_cmod(ix,iy,3))
%                     max_seg(ix,iy) = b_cmod(ix,iy,1);
%                 else
%                     max_seg(ix,iy) = b_cmod(ix,iy,3);
%                 end
%             else
%                 max_seg(ix,iy) = b_cmod(ix,iy,2);
%             end
%         end
%     end
    

% n=1;figure(n);imagesc(medfilt2(