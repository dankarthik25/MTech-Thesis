%  saveplot('head','png')
function saveplot(img_name,img_type)
set(gca,'XTick',[]) % Remove the ticks in the x axis!
set(gca,'YTick',[]) % Remove the ticks in the y axis
set(gca,'Position',[0 0 1 1]) % Make the axes occupy the hole figure
saveas(gcf,img_name,img_type);
end