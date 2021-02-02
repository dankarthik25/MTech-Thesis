                    % % % % % % % % % % % % % % % % 
                    % For crowd Turbulance video  %
                    % % % % % % % % % % % % % % % % 

% % % % % % % INPUT   % % % % % % 
% img : image to find the local region center
% hz : size of local region to be segmented
% if the size of object{s_o}the size of segment {hz = sqrt(2* area(object))}
% hz = ceil(sqrt(2* (s_o)^2));
% sh [1]to show the center
% % % % % % % OUTPUT % % % % % 
% c : local max/min region centers
% % % % % % % % % % % % % % % % 
% find the local max/min segmented region
% For every region(s) we are finding center [xbar ybar]


function c = crowd_turb_local_max(img,hz,sh)
[b L] = seg_img(img,hz,0); % Segment the image by given size of local max
% To show result
b = b; % the weighted image for calculating centriod
% I = reshape(b,[],1);
s = regionprops(L, 'PixelIdxList', 'PixelList');
c = [];
if(sh==1)
    figure(02)
%     imagesc(b);% 
    imshow(img);
    hold on;
end
for k = 1:numel(s)
    idx = s(k).PixelIdxList;
    [max max_idx ] = sort( b(idx),'descend' );
    if (max(1) >=0)
        ybar = rem(idx(max_idx(1)),size(b,1));
        xbar = floor(idx(max_idx(1))/size(b,1)) +1 ;
        p = [xbar ybar];
        c = [c;p];
        if(sh == 1)
            plot(xbar,ybar,'r*');
        end
        
    end
    % % %     Finding the weighted centriod of the segmented region
    %         sum_rg = sum( double(b(idx)) );
    %         if(sum_rg > 0)
    %             x = s(k).PixelList(:, 1);
    %             y = s(k).PixelList(:, 2);
    %             xbar = round(sum(x .* double(b(idx))) / sum_rg);
    %             ybar = round(sum(y .* double(b(idx))) / sum_rg);
    %             p = [xbar ybar];
    %             c = [c;p];
    %             if(sh == 1)
    %                 plot(xbar,ybar,'r*');
    %             end
    %         end
end
% c =c';
if(sh==1)
    
    hold off;
    
end


end

function[b L] = seg_img(img,hz,s)
% % INPUT PARAMETERS
% img : image
% hz  : size of local_min/max for segmentation 
% s   : [1] To show the segmeted regions

% % OUTPUT PARAMETERS
% b : local region white (255) and black(-255)
% L : segmented region Labeled image

% % % % % % % % % % % % % % % % % % % % % % % % % %
% % PROCESS
% 1> gaussian blur[3x3] the image
% finding median blured of sw_img{img},sb_img{255-img}
% finding the local max{bw}/min{bb} region and adding {b}
% finding local regions {|b|}
% Segmenting the local regions by watershed method to get the seg regions
% % % % % % % % % % % % % % % % % % % % % % % % % % % 


% % Inicial Values of Video
% % test = 255-img; i =20;
% % using medfilt2 of 1x1 is removing the head peak point which can be used
% % as center of head
% % i =8; Every person [4 4] is individula are isolated points
% % i =30; Every point and umberallas [15 15] is covered
% % Further increase in i just increased the boarder of image


% INPUT  img,hz
% hz =30;
% img = histeq(vid_original(:,:,1,f)); % give much better results
% s =1;
%%
% gaussian = fspecial('gaussian',3,1);
% img = uint8(imfilter(double(img),gaussian,'replicate'));

sw_img = medfilt2(img,[hz hz]);
b = double(img) - double(sw_img);
% figure(01);imagesc(b);
b_pos = zeros(size(img));b_neg = zeros(size(img));

b_pos = b;
idx = find(b <0);
b_pos(idx) = 0;
b_neg(idx) =- 1*b(idx);

b_mag = b_pos + b_neg;

% se = strel('disk',3);
% b_mag = imerode(b_mag,se);
% figure(04); imagesc(-b_mag);
%%

% Idx = ones(size(img));Idx(idx)= -1;
L = watershed(-b_mag); % segmenting the local max region

% % TO SHOW THE SEGMENTED IMAGE
% if(s==1)
%     idx = find(L==0);
%     result = b_mag; %    result = b_mag;
%     result(idx) = -255;
%     figure(01);
%     imagesc(result); % result
% end

end