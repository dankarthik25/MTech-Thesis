
function annPoints = show_estimate(c,img)
imgObj = img;
figure;
imageHandle = imshow(imgObj);
dx = 0.1;dy =0.1;
for i = 1:size(c,1)
    txt = cellstr(num2str(i));
    text(x+dx,y+dy,txt);
    plot(c(i,1), c(i,2), 'r.', 'MarkerSize', 5);    
end
% end
