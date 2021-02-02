
function show_center(loc,img)
n_p =1;
dx = 0.1;dy = 0.1;
% figure(02);
%     imagesc(img);
%     imagesc(img);
imshow(uint8(img));
hold on;
if not(isempty(loc))
    for i = 1:size(loc,1)

       % plot(loc(i,2),loc(i,1),'g*');
        plot(loc(i,2),loc(i,1),'r.','MarkerSize',10);
%         txt = cellstr(num2str(n_p));
%         text(loc(i,2)+dy,loc(i,1)+dx,txt);
        n_p = n_p +1;
    end
end
hold off;
end
