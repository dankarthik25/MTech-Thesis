% trk,asg
function vf = vel_trks(trk,asg,min_dis)
v_rate = 5;% m2p =112; frame_rate = 25;
vf = [];xf =[];

if ~isempty(asg)
    for i = 1:length(asg)
        if(~isnan(asg(i))&& (asg(i)~=0))
            if length(trk(i).x{1})>v_rate
            vx = (trk(i).x{1}(end) -trk(i).x{1}(end -v_rate))/v_rate;
            else
                  vx = (trk(i).x{1}(end) -trk(i).x{1}(1))/length(trk(i).x{1});
            end
            if abs(vx) < min_dis
                vf(asg(i),1) = vx;
            end
            if length(trk(i).y{1})>v_rate
            vy =  (trk(i).y{1}(end) -trk(i).y{1}(end -v_rate))/v_rate;
            else 
                vy =  (trk(i).y{1}(end) -trk(i).y{1}(1))/length(trk(i).y{1});
            end
            if abs(vy) < min_dis
                vf(asg(i),2) = vy;
            end
        end
    end
end



% [x,y] = meshgrid(1:1:size(vid,2),1:1:size(vid,1));
% f= 100;
% 
% u = zeros(size(vid,1),size(vid,2));
% v = zeros(size(vid,1),size(vid,2));
% 
% % u = cos(x).*y;v = sin(x).*y;
% loc = GT{f};vf = Vf{f};img = vid(:,:,:,f);


% % % % % % % % % % % % % % % % 
% %% Show the velocity compoent
% % % % % % % % % % % % % % % % % % % % 

% for i = 1:min(size(loc,1),size(vf,1))
%     if (loc(i,1)>0)&& (loc(i,1)<=size(vid,1))&&(loc(i,2)>0)&&(loc(i,2)<= size(vid,2))
%         x_i = loc(i,1);y_i = loc(i,2);
%         u(x_i,y_i) = vf(i,2);
%         v(x_i,y_i) = vf(i,1);
%     end
% end
% show_center(loc,img);
% imshow(img);
% hold on;
% quiver(x,y,u,v);
% hold off;
 