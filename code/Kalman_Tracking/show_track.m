
function show_track(img,trk,trk_t)
Ms = [3 5]; %marker sizes
c_list = ['r' 'b' 'g' 'c' 'm' 'y'];
imshow(img);
hold on;
show_length = 10;
for i = 1:size(trk,2) % nF
    Sz = mod(i,2)+1; %pick marker size
    Cz = mod(i,6)+1; %pick color
    if(trk(i).Con_Invis_Count< trk_t)        
        tmX = trk(i).x{1};
        tmY = trk(i).y{1};
        if length(tmX)> show_length
            tmY = tmY(end-show_length:end);
            tmX = tmX(end-show_length:end);
        end
        plot(tmY,tmX,'.-','markersize',Ms(Sz),'color',c_list(Cz),'linewidth',3);
        axis off;
    end
end
end

