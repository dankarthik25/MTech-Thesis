function I= Estimate_loc(sigma,vx,vy)
%
% sigma = 5;
% ======= Estimated Density =============
mag = hypot(vx, vy);
mag =uint8( 255* mag / max(max(mag)));
est_density = gaussian_density(mag,sigma);
est_density =uint8( 255* est_density / max(max(est_density)));
est_h = histeq(est_density);
% ====== ***** Removal of background and noise ***** =====
est_h1 = uint8(double(est_h) .* double(im2bw(est_h,0.75)));
se = strel('disk',2*sigma); I1 = imopen(est_h1,se); % imagesc(I1);
I2 = est_h1 -I1;idx = find(I2 <= 100 );I2(idx) = 0;
se = strel('disk',sigma); I3 = imopen(I2,se); % imagesc(I3);
se = strel('disk',1);I3 = imerode(I3,se);I1 = imerode(I1,se);
I = im2bw(I1+I3);
I =uint8(double(est_h1) .* double(I));
% label = bwlabel(im2bw(imdilate(Ierode,se)));

end

% 
% % est_h2 =est_h1;
% se = strel('disk', 12);
% I1 = imopen(est_h3, se);
% figure(02)
% imagesc(I1), title('Opening (I1)') ; % Seperating large regions
% 
% I2 = Io-I1 ;  % Septerationg small size regions
% idx = find(I2 <= 100 );I2(idx) = 0; % filtering the regions created by subration
% 
% se = strel('disk', 5);
% I3 = imopen(I2, se); % removing noise regions 
% se = strel('disk', 1);
% I3 = im
% figure(02)
% imagesc(I3), title('Opening (I1)') 
% 
% I = I1 + I3;
% imagesc(I);

