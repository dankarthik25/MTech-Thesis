%  Count_People  = upd_cunt(trk,asg,Count_People,cunt,size(vid,1),size(vid,2)); % update count
%ix = size(vid,1);
% iy = size(vid,2); %  function [c_in c_out ] = upd_cunt(trk,asg,c_in,c_out,cunt,ix,iy)
function Count_People = upd_line_cunt(trk,asg,Count_People,cunt,ix,iy)

c_in  = Count_People.in;
c_out = Count_People.out;

if (~isempty(trk))&&(~isempty(asg))
    for i = 1: size(trk,2)
        pre_asg = trk(i).asg;
        next_asg = asg(i);
        if(~isnan(next_asg))               % it is actually a tracker
            trk(i).age = trk(i).age + 1;
%             if(size(trk(i).x{1},1)==2)&&(size(trk(i).y{1},1)==2)
                x_rec = trk(i).x{1}(end-1:end);
                y_rec = trk(i).y{1}(end-1:end);
%                 % Inside line/Outside line = [1/0];
                  pre_p = x_rec(1)<= ix/2;
                  nxt_p = x_rec(2)> ix/2;
%                 pre_p = x_rec(1)<cunt.w_x | x_rec(1)> ix -cunt.w_x| y_rec(1)<cunt.w_y| y_rec(1)> iy - cunt.w_y;
%                 nxt_p = x_rec(2)<cunt.w_x | x_rec(2)> ix -cunt.w_x| y_rec(2)<cunt.w_y| y_rec(2)> iy - cunt.w_y;
                if xor(pre_p,nxt_p)
                    if(pre_p)
                        c_in = c_in+1;
                    else
                        c_out = c_out+1;
                    end
                end
        end
    end
end
Count_People.in  = c_in;
Count_People.out = c_out;