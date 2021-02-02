
% supimgs.m


function sup = supimgs(den_c,img)
strip = den_c(:,1:10,:);
img(:,:,2) = img(:,:,1);img(:,:,3) = img(:,:,1);
img = [strip img];
sup = zeros(size(img,3));
for ix = 1:size(den_c,1)
    for iy = 1: size(den_c,2)
        sup(ix,iy,1) = 0.25 * double(img(ix,iy,1)) + 0.75 * double(den_c(ix,iy,1));
        sup(ix,iy,2) = 0.25 * double(img(ix,iy,2)) + 0.75 * double(den_c(ix,iy,2));
        sup(ix,iy,3) = 0.25 * double(img(ix,iy,3)) + 0.75 * double(den_c(ix,iy,3));
    end
end

sup = uint8(sup);
