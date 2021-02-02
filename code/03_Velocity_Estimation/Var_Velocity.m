% Variace of Velocity
function den = Var_Velocity(ux,uy,s_i,sigma,f_idx,bin)
% Method - I  Var = U - smooth(U);

% buffer  = 20;
% sigma = 1;
a_ux = zeros(s_i); a_uy = a_ux;
for f = 1 :size(ux,2)
    if(isempty(ux{f}))
        ux{f} = zeros(s_i(1),s_i(2));
    end
    if(isempty(uy{f}))
        uy{f} = zeros(s_i(1),s_i(2));
    end
    a_ux =  a_ux + ux{f};a_uy = a_uy +uy{f};
end
a_ux = a_ux / size(ux,2);
a_uy = a_uy / size(uy,2);

% flow(:,:,1) = a_ux;flow(:,:,2) = a_uy;
% imwrite(flowToColor(flow),strcat('../optical_flow/optical_flow',num2str(f_idx),'.png'));

% % % * * * METHOD-I * * * % % % 
gaussian1 = fspecial('gaussian', ceil(6*sigma+1), ceil(sigma));
gaussian2 = fspecial('gaussian', ceil(6*2*sigma+1), ceil(2*sigma));

var_uxx = imfilter(double(a_ux),gaussian1,'replicate') -  imfilter(double(a_ux),gaussian2,'replicate');
var_uyy = imfilter(double(a_uy),gaussian1,'replicate') -  imfilter(double(a_uy),gaussian2,'replicate');
var_uyx = imfilter(double(a_uy),gaussian1,'replicate') -  imfilter(double(a_ux),gaussian2,'replicate');
var_uxy = imfilter(double(a_ux),gaussian1,'replicate') -  imfilter(double(a_uy),gaussian2,'replicate');


% var_ux = var_uxx;  + var_uxy;
% var_uy = var_uyy; + var_uyx;
% % flow(:,:,1) = var_ux;flow(:,:,2) = var_uy;
% % imwrite(flowToColor(flow),strcat('../var_vel_xx_yy/optical_flow',num2str(f_idx),'.png'));

% flow(:,:,1) = var_ux;flow(:,:,2) = var_uy;
% figure(01);imshow( flowToColor(flow) );
% figure(02);imagesc(hypot(flow(:,:,1),flow(:,:,2)));
den = sqrt(var_uxx.^2 + var_uyy.^2+  var_uxy.^2 + var_uyx.^2 );
% den = hypot(var_uyx,var_uxy);



% end
% % % * * * METHOD -II => by sub avg_velocity {a_u} by current velocity  u{bin} => result is nosiy point showing 

% var_uxx = a_ux - ux{bin};
% var_uyy = a_uy - uy{bin};
% den = hypot(var_uxx,var_uyy);
% imagesc(den);
% saveplot(strcat('den_vel_plot',num2str(f_idx)),'png');