function loc = mark_head(img,loc)
% %%
imageHandle =   imshow(img);
keyInput = 0;
p = [];
n_p =1; dx = 0.1;dy = 0.1;
figure(01);
hold on;
if not(isempty(loc))
    for i = 1:size(loc,1)
%     pt = [xbar ybar];
        plot(loc(i,2),loc(i,1),'cs','MarkerSize',30);
        txt = cellstr(num2str(n_p));
        text(loc(i,2)+dy,loc(i,1)+dx,txt);
        n_p = n_p +1;
    end
end
while (keyInput ~= 1)
    
    [p(1) p(2)] = ginput(1);
    hold on, plot(p(1), p(2), 'cs', 'MarkerSize', 30);
    if(p(2)<=size(img,1))&&(p(1)<=size(img,2))
        loc = [loc;[p(2) p(1) ]];
    end
    keyInput = waitforbuttonpress;
end

end
