% http://www.shawnlankton.com/2007/06/matlab-figures-without-borders-and-toolbars/
function save_plot(img,bbox,str_name)
iptsetpref('ImshowBorder','tight');% image  fill the whole window![for ‘imshow’  not ‘imagesc’ ].
set(0,'DefaultFigureMenu','none'); %removes menu and toolbar from all new figures
format compact; %makes disp() calls show things without empty lines
set(0,'Default');

figure;
showdetection(bbox,uint8(img));
hgexport(gcf, str_name, hgexport('factorystyle'), 'Format', 'jpeg');
end
% - See more at: http://www.shawnlankton.com/2007/06/matlab-figures-without-borders-and-toolbars/#sthash.bXVBpWiS.dpuf