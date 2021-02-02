% % % %  * * * Merging Video * * * % % %
%     left_img = tub(:,:,:,f);left_img(323:360,:,:) = [];
%     right_img = sup;
%     add_img = left_img;
%     [sx1 sy1 c] = size(left_img);
%     [sx2 sy2 c] = size(right_img);
%     for x = 1:sx1
%         for y =1:sy1
%             add_img(x,sy1+y,:) = right_img(x,y,:);      
%         end
%     end
%     imwrite(add_img,strcat('../compare_result_',num2str(f),'.png'));
%     clear add_img;



% % % * * * Create video with two windows
% % * * Write Video
%
% writerObj = VideoWriter(strcat('vid_loc_','.avi'));
% open(writerObj);
% writeVideo(writerObj,vid_original);
% close(writerObj)

% Check the density and velocity components respectively
% Create pressure plot