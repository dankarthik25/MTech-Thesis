% X =
% X_gt =
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%   Detection Rate  %%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ped_det_rate(X,X_gt)

y_people = zeros(1,size(X,2));
y_gt = zeros(1,size(X,2));
for f =  1: size(X,2)
    y_people(f) = size(X{f},1);
    y_gt(f) = size(X_gt{f},1);
end
x = 1:f;
figure(1)
plot( x,y_people,'r',x,y_gt,'b',x,y_gt-y_people,'g');
title('Pedestrians Detection Vs frame');% ,'FontSize',26);
ylabel('Detection(count)');% ,'FontSize',14);
xlabel('frame(f)');% ,'FontSize' ,14);
legend('Detection','Ground Truth','Error');%,'FontSize',20);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%  Gauss Density Vs Vornic Density  %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot_den   =  true ; %false;
if(plot_den ==1)
    d_g = [];d_g_gt=[];d_v = [];d_v_gt = [];
end
