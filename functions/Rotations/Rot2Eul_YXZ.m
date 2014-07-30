function Eul=Rot2Eul_YXZ(Rot)
%
%Considering:
%Rot=Ry,phi*Rx,th*Rz,psi

if 1-abs(Rot(2,3)) < 0.0001
    if Rot(2,3)>0
        th=-pi/2;
    else
        th=0;
    end
    phi=atan2(-Rot(1,2),Rot(1,1));
    psi=0;    
else
    s_th=Rot(2,3);
    c_th=sqrt(1-s_th^2);
    th=atan2(-s_th,c_th);
    phi=atan2(Rot(1,3),Rot(3,3));
    psi=atan2(Rot(2,1),Rot(2,2));
end

Eul=[phi th psi];