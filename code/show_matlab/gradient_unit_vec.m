function [theta ,mag]= gradient_unit_vec(I,sigma,sz)
for i =1:3
    I(:,:,i) = medfilt2(I(:,:,i),[sz sz]);
end
figure(01);
imshow(uint8(I));
mag = zeros(size(I,1),size(I,3));
theta = mag;
if(size(I,3)==1)
    [Gx Gy] = gradient_find(I, sigma);
    G = Gx + Gy *1j;%     G_unit = G ./ abs(G);
    G_mag = abs(G);
 % % % % % % % % % % % % % % % 
 % % signed theta (-180 180] %
 % % % % % % % % % % % % % % %  
theta = radtodeg(angle(G));
    % % % % % % % % % % % % % % %
    % % signed theta [-90 90] % % 
    % % % % % % % % % % % % % % % 
% theta = atand(imag(G)/real(G) );



%     theta = atand(imag(G)/real(G) );

    % G_unit = cosd(theta) + sind(theta)*1j;
elseif(size(I,3)==3)
    G_mag = zeros(size(I));
    G_theta = G_mag;
    [Gx Gy] = gradient_find(I, sigma);
    G = Gx + Gy *1j;
    G_mag   = abs(G);
    G_theta = atand(imag(G./real(G) ));
    
    for ix = 1:size(I,1)
        for iy = 1:size(I,2)
           if(G_mag(ix,iy,1)>= G_mag(ix,iy,2))
                if(G_mag(ix,iy,1)>= G_mag(ix,iy,3))
                    theta(ix,iy) = G_theta(ix,iy,1);
                    mag(ix,iy) = G_mag(ix,iy,1);
                else
                    theta(ix,iy) = G_theta(ix,iy,3);
                    mag(ix,iy) = G_mag(ix,iy,3);
                end
            else
                theta(ix,iy) = G_theta(ix,iy,2);
                mag(ix,iy) = G_mag(ix,iy,2);
            end
        end
    end

figure(02);
imagesc(theta);
end