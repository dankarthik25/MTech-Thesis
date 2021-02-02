% input vx,vy;
%  Quantizing theta no completed
function [dux duy theta] = qunatize_theta(dx,dy)

[magGrad Theta] = cartesian2polar(ux,uy)
idx = find(magGrad < 1);dx(idx) =0;dy(idx) = 0;
mag = 255 * magGrad /max(max(magGrad)) ; % imagesc(mag);
mag(idx) =1;
ux = dx ./ mag;
uy = dy ./ mag;
theta = find_theta(ux,uy);
dux = zeros(size(dx));
duy = zeros(size(dx));
thr = 22.5;
for  ix = 1: size(dx,1)
    for iy = 1:size(dy,2)
        if (ux(ix,iy) == 0)&&(uy(ix,iy) == 0 )
            dux(ix,iy) =0;
            duy(ix,iy) =0;
        end
        if(theta(ix,iy) > -thr )&&(theta(ix,iy)<= thr )                     % 0d (-22.5 22.5]
            dux(ix,iy) = 1;
            duy(ix,iy) = 0;
        elseif(theta(ix,iy) > 45-thr )&&(theta(ix,iy) <= 45+ thr )          % 45d (22.5 77.5]
            dux(ix,iy) = 1;
            duy(ix,iy) = 1;
        elseif(theta(ix,iy) > 90 -thr )&&(theta(ix,iy)<= 90+thr )          % 90d (77.5 135.5]
            dux(ix,iy) = 0;
            duy(ix,iy) = 1;
        elseif(theta(ix,iy) > 135 -thr )&&(theta(ix,iy)<= 135+ thr )        %135d (77.5 112.5]
            dux(ix,iy) = -1;
            duy(ix,iy) =  1;
        elseif((theta(ix,iy) > 180 -thr )&&(theta(ix,iy)<= 180 ))|| ((theta(ix,iy) >= -180 )&&(theta(ix,iy)< -180 +thr ))
            dux(ix,iy) = -1;                                                %180d (112.5 180]U[-180 -112.5)
            duy(ix,iy) =  0;
        elseif(theta(ix,iy) >= -90 - thr )&&(theta(ix,iy)< -90 +thr )       %-90d [-135.5 -77.5 )
            dux(ix,iy) =  0;
            duy(ix,iy) = -1;
        elseif(theta(ix,iy) >= -135 - thr )&&(theta(ix,iy)< -135 +thr )       %-135d [-77.5 -22.5 )
            dux(ix,iy) = -1;
            duy(ix,iy) = -1;
        elseif(theta(ix,iy) >= -45 - thr )&&(theta(ix,iy)< -45 +thr )       %-45d [-77.5 -22.5 )
            dux(ix,iy) = 1;
            duy(ix,iy) = -1;
        end
    end
end
end
%         if(ux(ix,iy)>= 1/sqrt(2))
%             dux(ix,iy) = 1;
%             if(uy(ix,iy)>= 1/sqrt(2))
%                 duy(ix,iy) = 1;             % +Ve +Ve
%             elseif(uy(ix,iy) <= -1/sqrt(2))
%                 duy(ix,iy) = -1;            % +Ve -Ve
%             end
%         elseif(ux(ix,iy) <= -1/sqrt(2))
%             dux(ix,iy) = -1;
%             if(uy(ix,iy) >= 1/sqrt(2))
%                 duy(ix,iy) = 1;             % -Ve +Ve
%             elseif(uy(ix,iy) <= -1/sqrt(2))
%                 duy(ix,iy) = -1;            % -Ve -Ve
%             end
%         end
