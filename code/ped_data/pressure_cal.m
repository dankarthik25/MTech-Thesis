% load('../Dataset/mat/ped_flow.mat', 'GT','Vf');
img_sz = [360 640];sdt = 0.4;m2p = 112;

sigma = sdt*m2p;

for f = 1: min(size(GT,2),size(Vf,2))
 fprintf('f: %d \n',f);
loc = GT{f};vf = double(Vf{f});
den = gauss_den(loc,img_sz,m2p,sdt);
var_vel = avg_velocity(loc,vf,img_sz,sigma);
press = den.*var_vel;

plot_var(f) = sum(sum(var_vel))/(img_sz(1)*img_sz(2));
plot_press(f) = sum(sum(press))/(img_sz(1)*img_sz(2));
end
plot(1:1937,plot_var)
figure(02);
plot(1:1937,plot_press)
save('test.mat','plot_var','plot_press');