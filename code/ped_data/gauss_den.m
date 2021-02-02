% m2p =112; sigma = 1/2;%1/4% 1/6
function gauss_density = gauss_den(loc,img_sz,m2p,sdt)
 for i = 1: size(loc,1)
            if (ceil(loc(i,1))>1)&&(ceil(loc(i,1))<img_sz(1))
                x =ceil(loc(i,1)) ;
            elseif ceil(loc(i,1))<=1
                x =2;
            else
                x = img_sz(1)-1;
            end
            if (ceil(loc(i,2))>1)&&(ceil(loc(i,2))<img_sz(2))
                y = ceil(loc(i,2));
            elseif ceil(loc(i,2))<=1
                y =2;
            else
                y = img_sz(2)-1;
            end
            loc(i,1) =x;loc(i,2) = y;
            
        end
radius = ceil(sdt*m2p);
gauss_density = false(img_sz(1),img_sz(2));
for i = 1: size(loc,1)
    gauss_density(loc(i,1),loc(i,2)) = true;
end
% %%      Gaussian Density
    gauss_filt = fspecial('gaussian', ceil(6*radius+1), ceil(radius)); %  fspecial('gaussian',HSIZE,SIGMA)
    gauss_filt = gauss_filt/max(max(gauss_filt));         % figure(01);imagesc(gauss_filt);
    gauss_filt = (m2p)^2/sum(sum(gauss_filt))*gauss_filt; % figure(02);imagesc(gauss_filt);
    gauss_density  = imfilter(double(gauss_density),gauss_filt,'replicate');
end