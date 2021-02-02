% shows grad of Img given :MagG, Theta ,fi,unit_edges,weg_edges)
% where 
% fi         =figure.no
% unit_edges = true  (1);    % edges           unit vector  
% unit_edges = false (0);    % normal to edges unit vector 
% weg_edges  = true  (1);    % edges           weighted vector 
% weg_edges  = false (0);    % normal to edges weighted vector 


function gradient_show(MagG,Theta,fi,unit_edges,weg_edges)
% idx = find(Theta>0);
% Theta = Theta -90; % for changing Continous +-0 to Discontious at +-90 

% % CALCULATING ## MagG ##
% MagG = hypot(dx,dy); 
% mag = uint8(255 * magGrad /max(max(magGrad))); % imagesc(mag);
% idx = find(magGrad<1);
% dx(idx) =0;dy(idx) = 0; mag(idx) =1;

% figure no,                                    fi
% normal/tangent to edge,                       nt  0/1
% only angle or amplitude(r) and angle          ua 0/1
[x,y]=meshgrid(1:1:size(MagG,2),1:1:size(MagG,1));
    if((unit_edges==0)&&(weg_edges==0))        % normal and only angle
        figure(fi) 
%         imshow(uint8(MagG));
          imagesc(MagG);
        hold on; 
%         quiver(x,y,dx./mag, dy ./ mag  ); 
         quiver(x,y,cosd(Theta),sind(Theta),'g');
    elseif((unit_edges==0)&&(weg_edges ==1))
        figure(fi)
        imshow(uint8(MagG)); hold ton;   
%         quiver(x,y,dx,dy);
          quiver(x,y,MagG.*cosd(Theta),MagG.*sind(Theta));
    elseif((unit_edges==1)&&(weg_edges ==0))
        figure(fi)
        imagesc(MagG);
%         imshow(uint8(MagG)); 
        hold on;   
%         quiver(x,y,dy./mag, -dx ./ mag  );
        quiver(x,y,cosd(Theta-90),sind(Theta-90),'g');
    elseif((unit_edges ==1)&&(weg_edges==1))
        figure(fi)
        imagesc(MagG);
%         imshow(uint8(MagG)); hold on; % quiver(x,y,dy,-dx);
        quiver(x,y,MagG.*cosd(Theta-90),MagG.*sind(Theta-90));
        
        % dy,-dx=> Theta -90 we used this formula
        %-dy,dx => Theta+90

    else
    end
end
% % % % % % % % % % % % % % % % % % % % % 
% %      How to find Signed theta     % % 
% % % % % % % % % % % % % % % % % % % % % 
% for  ix = 1: size(ux,1)
%     for iy = 1:size(uy,2)
%         if (magGrad(ix,iy)<5)
% %             Theta(idx) = 0;
%             Theta(ix,iy) = 720;
%         end
%         theta = atand(uy(ix,iy)/ux(ix,iy));        
%         if (ux(ix,iy)>0)&&(uy(ix,iy)>0)                % (+,+)
% % Theta is positive
%             Theta(ix,iy) = theta; % I quadrant
%         elseif(ux(ix,iy)<0)&&(uy(ix,iy)>0)              % (-,+)
% % Theat is negative
%             Theta(ix,iy) = 180+ theta; % If theta is in II quadrant (-,+)
%         elseif(ux(ix,iy)<0)&&(uy(ix,iy)<0)
% % Theta is positive
%             Theta(ix,iy)=  180+ theta; % If theta is in III quadrant (-,-)
%         elseif(ux(ix,iy)>0)&&(uy(ix,iy)<0)             % (+,-)
% % Theta is negative
% % Theta(ix,iy) =  theta; for continous theta we use +values for theta
%             Theta(ix,iy) = 360 + theta; % IV quadrant(+,+)or(+,-)
%         end
%     end