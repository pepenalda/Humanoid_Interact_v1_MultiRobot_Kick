function Rotaciones_Sucesivas

syms phi th psi1


R1=Rot_Y(phi);
R2=Rot_X(th);
R3=Rot_Z(psi1);

R=R1*R2*R3

function R=Rot_X(ang)
s_a=sin(ang);
c_a=cos(ang);

R=[ 1   0    0;
    0 c_a -s_a;
    0 s_a  c_a];

function R=Rot_Y(ang)
s_a=sin(ang);
c_a=cos(ang);

R=[  c_a  0  s_a;
       0  1    0;
    -s_a  0  c_a];

function R=Rot_Z(ang)
s_a=sin(ang);
c_a=cos(ang);

R=[  c_a -s_a  0;
     s_a  c_a  0;
       0    0  1];