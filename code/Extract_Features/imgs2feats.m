% % % % Convet training Images to training Features
% % para.n =>bin size
% %      DW=> Detection Window size = [dx dy]
% % 
% 
% para.n = 2;para.DW_size = [15 15];

function t_features = imgs2feats(t_features,t_images,para)
% t_features = [];          % Inicallizing Total Collection of Features
img = t_images(:,:,:,1);
img = imresize(img,para.DW_size);
hog_nxn = extractHOGFeatures(img,'Cellsize',[para.n,para.n]);
% t_features  = zeros(size(t_images,4) ,  size(hog_nxn,2), 'single'); % inicallise the features
% t_features = [];
inicial = size(t_features,1)+1+94999;
for idx = inicial :size(t_images,4)
    if(mod(idx,1000) == 0)
        idx
        save('Neg_50x50_50overlap_01.mat','t_features');
    end
    img = t_images(:,:,:,idx);
    img = imresize(img,para.DW_size);
    features= extractHOGFeatures(img, 'CellSize', [para.n para.n]);
    t_features = [t_features; features];
end
end
