% sigma = 7; % gives person location information
% sigma = 10; % 5-10% overlapping
% sigma = 15; % 50 % overlapping
% sigma = 20; %  mediam isolated iland  with neighboor iland
% sigma = 25; % mediam size smooth isolated ilands
% sigma = 30; % conneted mediam size ilands with sharpe out boarder
% simga = 35; % conneted median size iland with smooth boarder
% sigma = 50 % countor plots
        % ======= Ground Truth  =======
function [centers Gt_density ] = GroundTruth_loc(img1,sigma)
Gt_loc = zeros(size(img1,1),size(img1,2));
for x = 1: size(img1,1)
    for y =1 :size(img1,2)
        if (( img1(x,y,1) >=210)&&( img1(x,y,2) >=210)&&( img1(x,y,3) >=210))
            Gt_loc(x,y) = 255;
        end
        Gt_loc = uint8(Gt_loc);
    end
end
% ====== Removing the white background
Gt_loc(1:17,   1:640) = 0;Gt_loc(17:44,496:564) = 0;
Gt_loc(320:360,1:640) = 0;Gt_loc(17:34,559:640) = 0;
% =======
Gt_loc = gaussian_density(Gt_loc,7); 
% making a smooth 2d distribution so that the local max give the location of person
% ==== *** The size of head is appox 10 pix radius *** === 

% % ----- For finding the Ground Truth Head ------
% % Finding Circles or Local Maxima
[centers, radii] = imfindcircles(Gt_loc,[5 20]);
clc;
% figure(03)
% imagesc(Gt_density);% h = viscircles(centers,radii);
% ==== GROUND TRUTH DENSITY ==== 
Gt_loc = zeros(size(img1,1),size(img1,2));
idx =  ( ceil(centers(:,1))-1)*size(img1,1)  + ceil(centers(:,2));
Gt_loc(idx) = 255;
%  ======= Analysis of different sigma values ======
% sigma = 7; % gives person location information
% sigma = 10; % 5-10% overlapping
% sigma = 15; % 50 % overlapping
% sigma = 20; %  mediam isolated iland  with neighboor iland
% sigma = 25; % mediam size smooth isolated ilands
% sigma = 30; % conneted mediam size ilands with sharpe out boarder
% sigma = 35; % conneted median size iland with smooth boarder
% sigma = 50 % countor plots
Gt_density = gaussian_density(Gt_loc,sigma);
end
