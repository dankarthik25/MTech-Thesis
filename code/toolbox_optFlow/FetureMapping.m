f = 100;fd = 10;
% % ====== Reading a Image ============ 
ref_img = vid(:,:,:,f);
target_img = vid(:,:,:,f+fd);
% %  Step 2: Detect Feature Points ======
%                 SURF features
ref_pts = detectSURFFeatures(rgb2gray(ref_img));
targ_pts = detectSURFFeatures(rgb2gray(target_img));
% filtering by r_min and r_max 
% plot( ref_pts.Location(1:100,1),ref_pts.Location(1:100,2),'r.','MarkerSize',5);
% %                  Shi Thomas features
% ref_pts =  (rgb2gray(ref_img));
% targ_pts = (rgb2gray(target_img));
% %                  Harris features
% ref_pts = detectHarrisFeatures(I1);
% targ_pts = detectHarrisFeatures(I2);
%%
% % ========= Step 3: Extract Feature Descriptors
[boxFeatures, ref_pts] = extractFeatures(rgb2gray(ref_img), ref_pts);
[sceneFeatures, targ_pts] = extractFeatures(rgb2gray(target_img), targ_pts);
% % ==========Step 4: Feature Matching or KLT-Feature tracker
boxPairs = matchFeatures(boxFeatures, sceneFeatures);
pts1 = ref_pts(boxPairs(:, 1), :);
pts2 = targ_pts(boxPairs(:, 2), :);
% Step : Visuallizing matching point 
figure;
showMatchedFeatures(ref_img, target_img, pts1,pts2, 'montage');
title('Putatively Matched Points (Including Outliers)');
% Step 5: Locate the Object in the Scene Using Putative Matches
[tform, inlierBoxPoints, inlierScenePoints] = estimateGeometricTransform(pts1, pts2, 'affine');
% Display the matching point pairs with the outliers removed
figure;
showMatchedFeatures(ref_img, target_img, inlierBoxPoints,inlierScenePoints, 'montage');
%  Method 2
%%
match_pts1 = ref_pts(boxPairs(:, 1));
match_pts2 = targ_pts(boxPairs(:, 2));
figure; ax = axes;
showMatchedFeatures(ref_img,target_img,match_pts1,match_pts2,'Parent',ax);
% title(ax, 'Putative point matches');
legend(ax,'Matched points 1','Matched points 2');
% title('Matched Points (Inliers Only)');
