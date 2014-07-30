function ths=Rot2ths_CadIzq(Rot)
%
if 1-abs(Rot(3,3)) < 0.0001
    if Rot(3,3)>0
        th10=-pi/2;
    else
        th10=pi/2;
    end
    th8p=atan2(Rot(2,1),-Rot(2,2));
    th12=0;    
else
    s_th=-Rot(3,3);
    c_th=sqrt(1-s_th^2);
    th10=atan2(s_th,c_th);
    th12=atan2(-Rot(2,3),Rot(1,3));
    th8p=atan2(-Rot(3,2),Rot(3,1));
end

ths(1)=th8p-pi/4;
ths(2)=th10;
ths(3)=th12;
    