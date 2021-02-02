function loc = l_seg2center(img,small,big,show)
x_min = 2;
x_max = 70;
y_min = x_min;
y_max = x_max;
area_min = 10;
area_max = 400;
% (x_w>x_min)&&(x_w>x_max)
[b_mag, L] = l_img_seg(img,small,big,show);
loc_reg = zeros(size(b_mag));
seg = regionprops(L, 'PixelIdxList', 'PixelList');
loc = [];n_p =1;
dx = 0.1;dy = 0.1;
if(show<=4)
    figure(04)
%     imagesc(b_mag);
    idx = find(L==0);
    result = b_mag; %    result = b_mag;
    result(idx) = -255;
    imagesc(result);
%     imshow(img);
    hold on;
end
for k = 1:numel(seg)
    idx = seg(k).PixelIdxList;
%     Local Region Filtering 
    loc_reg(idx) = b_mag(idx) /(max(b_mag(idx))+eps);
    sum_rg = sum(loc_reg(idx))+eps;
    f_idx = find(loc_reg(idx)>0.15);
    area_Lreg = length(f_idx);
    y = seg(k).PixelList(:, 1);
    x = seg(k).PixelList(:, 2);
% %     Limit of x,y width
    x_w = max(x(f_idx))-min(x(f_idx));
    y_w = max(y(f_idx))-min(y(f_idx));
    y_cent = round(sum(y .* double(loc_reg(idx)) ) / sum_rg);
    x_cent = round(sum(x .* double(loc_reg(idx)) ) / sum_rg);
% %     Limit of Center Location
    b_cent = logical((~isnan(y_cent))&&(~isnan(x_cent))&&(y_cent>0)&&(y_cent<size(img,2))&&(x_cent>0)&&(x_cent<size(img,1))&&((b_mag(x_cent,y_cent)>80)) );
% %     Limit on Width of Head
    b_w = logical((x_w>x_min)&&(x_w<x_max)&&(y_w >y_min)&&(y_w<y_max));
% %     Limt on Area of Head
    b_a = logical((area_Lreg>area_min)&&(area_Lreg<area_max));
    if b_cent&&b_a&&b_w  % much regional difference,(x_w y_w)[18-25],arear[400-900]
        pt = [x_cent y_cent];
        loc = [loc;pt];
        if(show <= 4)
            plot(y_cent,x_cent,'r*');
            txt = cellstr(num2str(n_p));
            text(y_cent+dy,x_cent+dx,txt);
        end
        n_p = n_p +1;
    end
end
if(show <=4)
    hold off;
end
end
