% load('../Dataset/mat/ped_flow.mat', 'gray');
% path = '../08_08_result/';
% compile;
% vid = gray;clear gray;
sigma = 7;
gauss_filt = fspecial('gaussian', ceil(6*sigma+1), ceil(sigma));
%%
% for f = 1: size(vid,4)
img = vid(:,:,:,f);

fd =30;winN = [];winSig =1;sigma_op = 1;thr = 2e-6;show = 2;
f = 100;
% % for f =1:size(vid,4)-1
for fd = 1:40
    tic
    ref_img = vid(:,:,:,f+fd); 
    figure(01); imshow(ref_img);
    tar_img = vid(:,:,:,f);
    [vx vy flowlk ] = optFlowLk(ref_img ,tar_img, winN, winSig, sigma_op,thr,show ); % toolbox_opFlow\
%     [flow(:,:,1) flow(:,:,2) flowlk ] = optFlowLk(vid(:,:,1,f) ,vid(:,:,1,f+fd), winN, winSig, sigma_op,thr,show ); % toolbox_opFlow\
%     imwrite(flowToColor(flow),strcat(path,'fd_',num2str(fd),'.png'));
vx  = imfilter(double(vx),gauss_filt,'replicate');
vy =  imfilter(double(vy),gauss_filt,'replicate');
flow(:,:,1) = vx;
flow(:,:,2) = vy;
mag = hypot(vx,vy);
fd
figure(02);imagesc(mag);
figure(03); imshow(flowToColor(flow));
keyInput = waitforbuttonpress;
    toc
end
