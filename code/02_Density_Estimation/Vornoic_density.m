%  Finding Vornoic_Density 
% Input: 
%         loc => [n_p 2]
%         img => [m n 3]
%         m2p => 1m repesent how many pixels
% Output:
%         den     [m n]  : Vornoic Density Plot
%         den_c [m n 3]  : Color Plot of Density Plot
%         sup   [m n 3]  : Density superimposed with img

% size_head = 20; head_cm =18;   % Empirical Value
% m2p =ceil(100* size_head/head_cm); % Finding Scale to real co-ordinates

% f =1000; 
% loc = filtered_GT{f};img = vid(:,:,:,f);m2p =ceil(100* size_head/head_cm);

function den  =    Vornoic_density(loc,s_img,m2p)
% m2p =1;
%  s_img = [size(img,1) size(img,2)];
%  for i = 1: size(loc,1)
%     if (ceil(loc(i,1))>=1)&&(ceil(loc(i,1))<=size(img,1))
%         loc(i,1) =ceil(loc(i,1)) ;
%     elseif ceil(loc(i,1))<1
%         loc(i,1) =1;
%     else
%         loc(i,1)= size(img,1);
%     end
%      if (ceil(loc(i,2))>=1)&&(ceil(loc(i,2))<=size(img,2))
%         y = ceil(loc(i,2));
%     elseif ceil(loc(i,2))<1
%         y =1;
%     else
%         y = size(img,2);
%     end
% %     loc_img(x,y) = true;
% end
if size(loc,1)>1
    Points = find_Points(loc,s_img);           %
    n_p = size(loc,1);
    den = find_den(Points,m2p,s_img,n_p);
else
    den = zeros(s_img);
end
% den_c =  den2cden(den)   % den_c = image_den(den);
% sup = supimgs(den_c,img) % sup = img_sup(den_c,img);

function Points = find_Points(loc,s_img)

%                  |                  |                      |
%     -x,-y        |         -x,y     |       -x,2*Sy-y      |
%----------------------------------------->Y
%       x,-y       |           x,y     |       x,2*Sy-y      |
%----------------------------------------->Y
%  2*Sx-x,-y       |       2*Sx-x,y    |  2*Sx-x,2*Sy-y      |
%                      |                     |                               |
%                      X


x = loc(:,1)';
neg_x = -x+2;                    % inverse of x
mi_x = 2*s_img(1) - x+1;        % mirror inverse of x
y = loc(:,2)';
neg_y = -y+2;                    % inverse of x
mi_y = 2*s_img(2) - y+1;        % mirror inverse of x
t_x = [neg_x neg_x   neg_x    x       x      x     mi_x   mi_x    mi_x];
t_y = [neg_y   y      mi_y  neg_y     y    mi_y    neg_y    y     mi_y];
Points=[t_y;t_x]';
function den = find_den(Points,m2p,s_img,n_p)
[Vertices,Region]=voronoin(Points);  %  Vornoic Cell Division
den = double(zeros(s_img(1),s_img(2)));
for p = 4*n_p+1:5*n_p
    v_idx = Region{p};
    x = ceil(Vertices(v_idx,1));
    y = ceil(Vertices(v_idx,2));
    BW = poly2mask(x, y, s_img(1),s_img(2));%imshow(BW); % some error in it need to be corrected
    d = 1/ sum(sum(BW));
    den = den + d* double(BW);
end
den = den*m2p^2;
% figure(01);imshow(den_c);
% figure(02);imshow(sup);

%  %% To show the density in color with Edeges(sqr), region (.)
% for p=4*size(loc,1)+1:5*size(loc,1)%size(Points,1)
%     r=rand()/2+0.5;    % color: random light grey
%     g=rand()/2+0.5;    % color: random light grey
%     b=rand()/2+0.5;    % color: random light grey
%     col=[r g b];
%     patch(Vertices(Region{p},1),Vertices(Region{p},2),col);  % color
%     hold on;
%     plot(Vertices(Region{p},1),Vertices(Region{p},2),'bs');
%     plot(Points(p,1),Points(p,2),'r.') ;       % dot at "center"
% end