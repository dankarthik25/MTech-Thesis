% % % % %       CALCULATING GROUND TRUTH from Estimate location 
% load('08_08_gt_valuse.mat');
% load('../Dataset/mat/ped_flow.mat','vid');
% f = 1820;
% for f = 1:40
    img = imresize(read(vidObj,25*f),0.5);
    loc = cent{25*f};
     show_center(loc,img);
     idx=input('idx = ');
     idx = sort(idx,'descend');
     gt{f} = loc(idx,:);
% end
% while(f<size(vid,4))
%     % EDIT THE PROGRAM FOR ADDING THE FALSE NEGATIVE POINTS
% %     loc = Gt1{f};
%      loc = mark_head(vid(:,:,:,f),Gt1{f});
% 
%     show_center(loc,vid(:,:,:,f));
% % % % % % % % % Removing the FALSE POSTIVE % % % % % % % 
%     idx=input('idx = ');
%     idx = sort(idx,'descend'); 
%     for i = 1:size(idx,2)
%         loc(idx(i),:)=[];
%     end
%     Gt1{f} = loc;
%     f = f+1;
%    
%     
% end
%%
% % % % % % Pedstrian Dataset Ground Truth Calculation
% %
% %
% % load('../Dataset/mat/ped_flow.mat', 'gray');
% % load('../Dataset/mat/ped_flow.mat', 'vid');
% for f = f:size(vid,4)
%     tic
%     img = vid(:,:,:,f);
%     img(1:30,:,:)=0;img(330:360,:,:) = 0;img(1:54,490:640,:)=0;imshow(img);
%     bin = logical(zeros(size(img,1),size(img,2)));
%     for ix = 1:size(img,1)
%         for iy = 1: size(img,2)
%             if(img(ix,iy,1)>200)&&(img(ix,iy,2)>200)&&(img(ix,iy,3)>200)
%                 bin(ix,iy) = true;
%             end
%         end
%     end
%     % imshow(bin);
%     
%     L = bwlabel(bin);L_back = L;
%     loc = [];
%     imshow(img);hold on;
%     for seg = 1:max(max(L))
%         [row col] = find(L==seg);
%         idx = find(L==seg);
%         wid = max(row) - min(row) ;
%         len = max(col) - min(col);
%         if(size(row,1)>80)&&(size(row,1)<350)&&(wid<25)&&(len < 25)
%             x_cent = sum(row)/size(row,1);
%             y_cent = sum(col)/size(col,1);
%             p = [x_cent y_cent];
%             loc = [loc;p];
%             plot(y_cent,x_cent,'r*');
%         else
%             L(idx) = 0;
%         end
%     end
%     hold off;
%     
%     Gt{f} = loc;
% toc
% end
% % imagesc(L);
% 
% % se = strel('disk',10);iopen = imopen(255-forg,se);imshow(255-iopen);