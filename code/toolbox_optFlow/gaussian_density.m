
function density = gaussian_density(img,sigma)

gaussian = fspecial('gaussian', ceil(6*sigma+1), ceil(sigma));
density  = imfilter(double(img),gaussian,'replicate');
imagesc(gaussian)
end