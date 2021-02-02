% % % % %  Processor in Kalman Filter % % % % % % % % % 

% INPUT : w_s = StateSpace_Noise;
%         w_o = Observation_Noise;
%         X_fi
%%   Inicialization of Kalman Filter

% % % %             X_fi = A. X_f-1 + B.U_f + w_s 

%           |                      |                    |
% X = [ x   |    A = [ 1 0 dt 0    |    B = [ dt^2/2    |     U_f = 0; 
%       y   |          0 1 0 dt    |          dt^2/2    |        
%      dx   |          0 0 1 0     |           dt       |     
%      dy]  |          0 0 0 1 ];  |           dt     ];|          
%           |                      |                    |

% Ex = [dt^4/4   0    dt^3/2  0                     P = Ex;
%       0      dt^4/4   0   dt^3/2
%       dt^3/2   0    dt^2    0      *|w_s|^2; 
%       0      dt^3/2   0    dt^2 ]

% % % %         Zf = H.X_f1 + w_o    % % % % 

% H = [1 0 0 0          Ez = [w_o  0 
%      0 1 0 0 ];              0  w_o ];
%% Inicailize Traker :
% trk.id        :  Id no of the traker                              size(trk,2)
% trk.age       :  Total time the obj present 
% trk.in_trk    :  Total time obj was trked
% trk.lost_trk  :  Time in consiqutive obj was lost
% trk.asg       :  assignment of trk to assg in the past frames
% trk.x         :  track of obj in X axis
% trk.y         :  track of obj in Y axis

%% Kalman Filter Prediction and Update
% INPUT :X_f-1

% For every f :Loop
% % 
% % predict state    [X_f P K ] = predict_kal(nt,A,B,u,X_f,H,P,Ex,Ez) %%%%%remove nt,make A,B,U,Ex,Ez =>str SS,P,H,K=>str Sp
% %					 X_fi = A. X_f-1 + B.U_f ;
% %                  P = A.P.A' + Ex ;       K = P.H'. 1/[HPH'+ EZ]   ;
 
% % ASSINGNMENT      asg = opt_assign(X_fi,Zf);   % hungarrian algorithum asgn = opt_assign(nt,Xf,Zf,min_dis)
 
% % update state     [Xf P ] = update_kal(asgn,Zf,Xf,H,K,P)
% % 			     X_f = X_fi + K .[Zf(asg) - H.X_fi ];
% %                  P = (I-K.H).P

% % update track     trk

% % show track