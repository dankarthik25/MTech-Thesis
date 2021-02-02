% % square density
% s_h = 20;      % size(head)
% head_cm =18;   % Empirical Value  
% m2p =ceil(100* size_head/head_cm); % Finding Scale to real co-ordinates

% f =1000; loc = filtered_GT{f};
function gaus_den = density(loc,img,radius,m2p)
loc_img = false(size(img,1),size(img,2));
for i = 1: size(loc,1)
    if (ceil(loc(i,1))>=1)&&(ceil(loc(i,1))<=size(img,1))
        x =ceil(loc(i,1)) ;
    elseif ceil(loc(i,1))<1
        x =1;
    else
        x = size(img,1);
    end
     if (ceil(loc(i,2))>=1)&&(ceil(loc(i,2))<=size(img,2))
        y = ceil(loc(i,2));
    elseif ceil(loc(i,2))<1
        y =1;
    else
        y = size(img,2);
    end
    loc_img(x,y) = true;
end
% figure(01);imshow(loc_img);
% %%      Gaussian Density
gauss_filt = fspecial('gaussian', ceil(6*radius+1), ceil(radius)); %  fspecial('gaussian',HSIZE,SIGMA)
gauss_filt = gauss_filt/max(max(gauss_filt));%figure(01);imagesc(gauss_filt);
gauss_filt = (m2p)^2/sum(sum(gauss_filt))*gauss_filt; % figure(02);imagesc(gauss_filt);
% gauss_filt = (size(gauss_filt,1)*size(gauss_filt,2))/(m2p)^2*gauss_filt;
% figure(02);imagesc(gauss_filt);

gaus_den  = imfilter(double(loc_img),gauss_filt,'replicate');
% figure(03); imagesc(gaus_den); % hold on;

% % dx = 0.1;dy = 0.1;n_p = 1;
% for i = 1:size(loc,1)
%     plot(loc(i,2),loc(i,1),'r.','MarkerSize',30);
% %     txt = cellstr(num2str(n_p));
% %     text(loc(i,2)+dy,loc(i,1)+dx,txt);
% %     n_p = n_p +1;
% end
% hold off;

% %%    Square Density
% radius = ceil(3*s_h/2);
% sq_filt = ones(2*radius,2*radius)*(m2p/(2*radius))^2;
% sq_den  = imfilter(double(loc_img),sq_filt,'replicate');
% figure(02);imagesc(sq_den);hold on;
% % dx = 0.1;dy = 0.1;n_p = 1;
% for i = 1:size(loc,1)
%     plot(loc(i,2),loc(i,1),'r.','MarkerSize',30);
% %     txt = cellstr(num2str(n_p));
% %     text(loc(i,2)+dy,loc(i,1)+dx,txt);
% %     n_p = n_p +1;
% end
% hold off;
