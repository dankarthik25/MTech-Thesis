% Range of theta is -90 to 90
function Theta = gradinet_signed_theat(ux,uy)
% magGrad = hypot(ux,uy);
Theta = zeros(size(ux));
for  ix = 1: size(ux,1)
    for iy = 1:size(uy,2)
        if (ux(ix,iy) == 0)&&(uy(ix,iy) == 0 )
            Theta(ix,iy) =0;
        end
        theta = atand(uy(ix,iy)/ux(ix,iy));
        if (ux(ix,iy)>0)&&(uy(ix,iy)>0)                % (+,+)
            Theta(ix,iy) = theta; % I quadrant
        elseif(ux(ix,iy)<0)&&(uy(ix,iy)>0)              % (-,+)
            Theta(ix,iy) = 180+ theta; % If theta is in II quadrant (-,+)
        elseif(ux(ix,iy)<0)&&(uy(ix,iy)<0)
            Theta(ix,iy)=  180 + theta; % If theta is in III quadrant (-,-)
        elseif(ux(ix,iy)>0)&&(uy(ix,iy)<0)             % (+,-)
            Theta(ix,iy) = 360- theta; % IV quadrant(+,+)or(+,-)
        end
    end
end
end