%  Pedistrian Detection Making Ground Truth
% % % For removing the False Postive Points in creating Ground Truth

% load('../Dataset/mat/ped_flow.mat','gray');
% vid = gray;
% path = '../08_08_result/';
% compile;
% f = 1;

% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% show = 6;s_o = 18;small  = ceil(18/4);big = ceil(sqrt(2*s_o^2));
% method.type = 'hog';method.hog_bin = 1;
% % %%Extracting the location and storing it as  val
% for f = 1:size(gray,4)
%     fprintf('f:%d \n',f);
%     img = gray(:,:,:,f);
%     loc_max = img2loc(img,small,big,show);
%     loc =  loc_filt(small,img,loc_max,SVMStruct,method,[25 25]);
%     Gt{f} = loc;
% end
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

% %% 1st annotate the missing objects

% for f = 1:size(Gt,2)
%     img = gray(:,:,:,f);
%     loc = Gt{f};
% %     fprintf('f:%d annotate the missing objects \n',f);
% %     loc = ann_loc(loc,img);
%     show_center(loc,img);
%         Gt{f} = loc;
% %     end
% end

%% 2nd remove the unwanted objects
for f = f:size(vid,4)   % size(Gt,2)

    img = vid(:,:,:,f);
% % % % % % % % % % % % % % %     
%  Add THE MISSING LOCATION
% % % % % % % % % % % % % % 
    loc = Gt{f};
    fprintf('f:%d annotate the missing objects \n',f);
    loc = ann_loc(loc,img);
    Gt{f} = loc;
% % % % % % % % % % % % % % % % % % % 
%  REMOVE THE UNWANTER LOCATION
% % % % % % % % % % % % % % % % % % 
    loc= Gt{f};
    show_center(loc,img);

    if~isempty(loc)
%         show_center(loc,img);
        show_center(loc,img);
        fprintf('f:%d remove the false objects \n',f);
        idx=input('idx = ');
        idx = sort(idx,'descend');
        for i = 1:size(idx,2)
            loc(idx(i),:)=[];
        end
    end
    Gt{f} = loc;
end


% %% 2nd remove the unwanted objects
% for f = 1:size(Gt,2)
%     img = gray(:,:,:,f);
%     loc = Gt{f};
%     if~isempty(loc)
%         show_center(loc,img);
%         fprintf('f:%d remove the false objects \n',f);
%         idx=input('idx = ');
%         idx = sort(idx,'descend');
%         for i = 1:size(idx,2)
%             loc(idx(i),:)=[];
%         end
%     end
% end

% while(f<=size(gray,4))
%     %     loc =  d08_08_15(gray,f);
%     img = gray(:,:,:,f);
%     loc_max = img2loc(img,small,big,show);
%     loc =  loc_filt(small,img,loc_max,SVMStruct,method,[25 25]);
%     if~isempty(loc)
%         x = loc(:,1);
%         y = loc(:,2);
%         %     idx = find((y>513)&(y<540)&(x>1)&(x<42));loc(idx,:) = []; % for removing the points at left and top strip
%         show_center(loc,img);
%         idx=input('idx = ');
%         idx = sort(idx,'descend');
%         for i = 1:size(idx,2)
%             loc(idx(i),:)=[];
%         end
%         show_center(loc,img);
%         %
%         Gt{f} = loc;
%         f = f+1;
%     end
% end