% Range of theta is -90 to 90
function Theta = gradinet_unsigned_theat(img,sigma)
[ux,uy] = gradient_find(img,sigma);
magGrad = hypot(ux,uy);
Theta = zeros(size(ux));
% idx = find(magGrad(ix,iy)<5);
% if length(idx) <0
%     Theta(idx) = 0;
%     %             Theta(ix,iy) = 720;
% end
for  ix = 1: size(ux,1)
    for iy = 1:size(uy,2)
        if (magGrad(ix,iy)<5)
%             Theta(idx) = 0;
            Theta(ix,iy) = 720;
        end
        theta = atand(uy(ix,iy)/ux(ix,iy));
%         Theta(ix,iy) = theta;
%         Theta(ix,iy) = abs( theta) ;
        
        if (ux(ix,iy)>0)&&(uy(ix,iy)>0)                % (+,+)
%             Theta is positive
            Theta(ix,iy) = theta; % I quadrant
        elseif(ux(ix,iy)<0)&&(uy(ix,iy)>0)              % (-,+)
%             Theat is negative
            Theta(ix,iy) = 180+ theta; % If theta is in II quadrant (-,+)
        elseif(ux(ix,iy)<0)&&(uy(ix,iy)<0)
%             Theta is positive
            Theta(ix,iy) = -180 + theta;
%             Theta(ix,iy)=  180+ theta; % If theta is in III quadrant (-,-)
        elseif(ux(ix,iy)>0)&&(uy(ix,iy)<0)             % (+,-)
%             Theta is negative
                Theta(ix,iy) =  theta; % for continous theta we use +values for theta
%             Theta(ix,iy) = 360 + theta; % IV quadrant(+,+)or(+,-)
        end
    end
end
% [x,y]=meshgrid(1:1:size(Theta,2),1:1:size(Theta,1));
% figure(01);
% imshow(uint8(magGrad));hold on;quiver(x,y,cosd(Theta),sind(Theta));
end