function den_c =  den2cden(den)
mark_point = 0.6;
hue = den;

hue = hue - min(min(hue));
% hue = hue/255;
% hue = hue / max(max(hue)) ;
hue = hue/10;
strip = [size(den,1):-1:1]';
strip = strip/size(den,1);
strip = [strip strip strip strip strip strip strip strip strip strip];
hue = [strip hue ];

idx = find(hue > 1);hue(idx) = 1;
hue = mark_point * hue;
hue = mark_point - hue;
sat = ones(size(hue,1),size(hue,2));
val = ones(size(hue,1),size(hue,2));

hsv_img(:,:,1) = hue;
hsv_img(:,:,2) = sat;
hsv_img(:,:,3) = val;

den_c = hsv2rgb(hsv_img);
den_c = uint8(255*den_c); 
