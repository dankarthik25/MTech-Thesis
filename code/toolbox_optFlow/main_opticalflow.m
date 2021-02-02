% load video
% video
tic
% ===== Hermes Video ======
% winSig =1;
% winN = 1;sigma_op = 1;thr = 2e-6;show = 2;
%  I1, I2  - input images to calculate flow between
%  winN    - window radius for hard window (=[] if winSig provided)
%  winSig  - [] sigma for soft 'gauss' window (=[] if winN provided)
%  sigma   - [1] amount to smooth by (may be 0)
%  thr     - [3e-6] ABSOLUTE reliability threshold (min eigenvalue)
%  show    - [0] figure to use for display (no display if == 0)
% f =100;fd = 15;sigma =5;

vid = vid_original;
f =1; fd =1; sigma =1;
winN = [];winSig =1;sigma_op = 1;thr = 2e-6;show = 2;
for f =1:size(vid_original,4)-1
    %--Compute Optical flow-----
    %
    % f = f +1;
    % Gref =  rgb2gray(vid(:,:,:,f));Iref = vid(:,:,:,f);
    % Gtar = rgb2gray(vid(:,:,:,f+fd));
    % for f = 1: size(vid_original,4)
    Gref = vid(:,:,1,f);
    Gtar = vid(:,:,1,f+fd);
    
    
    tic
    [vx vy flow ] = optFlowLk(Gtar,Gref , [], winSig, sigma_op,thr,show );
    % [flow(:,:,1),flow(:,:,2)] = optFlowHorn( Gref, Gtar, 2, 0 );
  ux{f} = vx;
  uy{f} = vy;
  flowlk{f} = flow;
  toc
end
toc


% imshow(vid(:,:,:,f));
% hold on; [x,y]=meshgrid(1:1:size(vid,2),1:1:size(vid,1));
% quiver(x,y, vx ,vy,'r' );
% imwrite(Gref,strcat('img__',num2str(f),'.png'));
% imshow(flowToColor(flow));
% end
% est_loc = Estimate_loc(sigma,vx,vy);

% % show  or save the est_loc
% imagesc(histeq(est_loc));saveplot(strcat('location_est_',num2str( f-100 )),'png');

% est_local velocity of blobs
% => est_center of blobs && est_velocity of blobs
% % next frame estimate
% f = f+fd;
% Gref =  rgb2gray(vid(:,:,:,f));Iref = vid(:,:,:,f);
% Gtar = rgb2gray(vid(:,:,:,f+fd));
% tic
% [vx vy flow ] = optFlowLk(Gtar,Gref , [], winSig, sigma_op,thr,show );
% toc
% est_bw = Estimate_loc(sigma,vx,vy);
% %  To SHOW RESULTS
% result_img = Iref;
% result_img(:,:,3) = uint8(double(255*est_bw) +double( Iref(:,:,3)));
% imshow(result_img);

% ======= Estimated Velocity Gradient =============
%
toc

%============== Ground Truth  =======
% [centers Gt_loc ] = GroundTruth_loc(vid(:,:,:,f),sigma);

