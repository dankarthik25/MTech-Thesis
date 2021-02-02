% compile;
% load('../Dataset/mat/ped_flow.mat', 'vid','GT');
% vid = gray;clear gray;

% function[trk ] =  kft(GT,vid)
clear trk;clc;close all;

sf = 1;f =sf;
% Constrains
cns.min_dis = 50; % min distance of obj to accept as tracker 
cns.trk_t   = 10;
cns.max_trk = 500;
% Input Parameter
ip.dt       = 1;
ip.ws_mag   = 1;
ip.ob_noise = 0.1;
% Counting Line Parameters
cunt.enable = true;
if cunt.enable
    Count_People.in = 0;
    Count_People.out = 0;
    cunt.plot = true;
    cunt.show = true;
    cunt.w_x = 3;  % =========<w_x
    cunt.w_y = 40; % |w_y|
    
else
    cunt.plot = true;
    cunt.show = true;%false;
end
if(cunt.plot ==1)
    Count_People.in = 0;
    Count_People.out = 0;
    Count_People.Enter = []; % For storing the No of People in Vs frame
    Count_People.Exit = [];
    if 0
        Count_People.Entergt = [];Count_People.Exitgt = [];
    end
end
% % % % %
traker.enable = true;
if traker.enable
    traker.show = true;%false;
else
    traker.show = true;
end

% Inicializing Parameters
trk = int_trk();                            % Inicializing Traker
if size(GT{sf},1)>=1
    Zf = GT{sf}';
else
    Zf = [];
end
[SS Sp Xf ] =  inc_kal(ip,Zf,cns.max_trk);  % Inicializing Xf ,SS=>{A,B,U,Ex},Sp=>{H,P,Ez} ;
% % % Kalman Filter Tracking

for f = sf:1937%1000% sf +200
%     f
    if traker.enable
        Zf = double(GT{f}');
        tic % set new number of detections
        [Xf Sp ] = predict_kal(Xf,SS,Sp); % Xf = A.Xf + B.U =>P =A*P*A'+ Ex;=>K = P*H'*inv(H*P*H' +Ez);
        asg = opt_assign(Xf,Zf,cns.min_dis);         % now we assign the detections to estimated track positions
        [Xf Sp ] = update_kal(asg,Zf,Xf,Sp);         % updating the state by assign
        [Xf trk ] = update_trk(asg,Xf,Zf,trk,f,sf) ; % adding new track,removing bad trafk,updating nF
        Vf{f} = vel_trks(trk,asg,cns.min_dis);
        if cunt.enable
            Count_People  = upd_box_cunt(trk,asg,Count_People,cunt,size(vid,1),size(vid,2)); % update count
            if cunt.show
                RGB = show_count(vid(:,:,:,f),cunt,Count_People);
                if  ~traker.show 
                    imshow(RGB);
                end
            end
            if(cunt.plot)
                 Count_People.Enter = [Count_People.Enter; Count_People.in];
                 Count_People.Exit  = [Count_People.Exit;  Count_People.out];
%                 Count_People.Entergt = [Count_People.Entergt ];Count_People.Exitgt = [Count_People.Exitgt];
            end
        end
        toc
        if traker.show
            if (rem(f,4)==0)
%             RGB = vid(:,:,:,f);
            show_track(RGB,trk,cns.trk_t);
            pause(0.1);
            end
        end
    end
end
if(cunt.plot)
    x = [1:size(Count_People.Enter,1)];
    figure(10)
    plot( x,Count_People.Enter,x,Count_People.Exit);
    title('Entered and Exist Vs frame');
    ylabel('Count(people)');
    xlabel('frame(f)');
    legend(' Inside Box ','Outside Box','Net','Detection');
end
% trk_idx = find(isnan(Xf(1,:)==0);             % Index of current Trks
% no_trk =  lenght(find(isnan(Xf(1,:))==0));    % Total No.current tracks
% new_trk_idx = find(isnan(Xf(1,:)==1);         % Index of empty tracks

