%   Creating the Denisty plot  with knowledge of Geometric
%   Pixel Area = [1X1] pixel represent  1/25 m^2 
function density = Gauss_Density(center,f,size_img,m2p)
% f =1; % frame no
% sigma =5
% pixel_area = 1/25;

% c = center{f};
idx = find(center(:,1)==0);center(idx,:) = [];
idx = find(center(:,2)==0);center(idx,:) = [];

density = double(zeros(size_img));
for i = 1:size(center,1)
    density(center(i,2),center(i,1)) = 1; % Location of person is estimated
end
% figure(02); imagesc(density);
geometric_area = size_img(1)*size_img(2) / m2p^2; % A_R area of region

global_density = size(center,1)/geometric_area;        % rhow = global density
sigma = sqrt(5/global_density);% sigma = 1;            % sigma =~ 4-5 empirical
gaussian = fspecial('gaussian', ceil(6*sigma+1), ceil(sigma));
density  = imfilter(double(density),gaussian,'replicate');
% for ix = 1:size(density,1)
%     for iy = 1:size(density,2)
%         if(density(ix,iy)<1)
%             density(ix,iy) =1;
%         end
%     end
% end

% figure(06);
% imagesc(density);

% p = [xbar ybar];
% ybar = rem(idx(max_idx(1)),size(b,1));
% xbar = floor(idx(max_idx(1))/size(b,1)) +1 ;