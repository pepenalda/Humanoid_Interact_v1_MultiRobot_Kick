clear all
close all
clc

A=1;
B=1;
T=1;
Pausa=0.2;
%t_vec=0:0.01:T;
t=0:0.01:T;

Cicloidal_1=A*(t/T-(1/(2*pi))*sin(2*pi*t/T));
Cicloidal_1=A-Cicloidal_1;
%Cicloidal_2=A*sin(pi*t/T-(1/2)*sin(2*pi*t/T));
%Cicloidal_3=A*(t/T-(1/(pi))*sin(pi*t/T));

% Cicloidal_4=A*(t/T+(1/(pi))*sin(pi*t/T));
% 
% Cicloidal_5=A-A*(t/T-(1/(pi))*sin(pi*t/T));


% T1=(T-Pausa)/2;
% t_vec=0:0.01:T;
% 
% for i=1:length(t_vec)
%     t=t_vec(i);
%     if (t < T1)
%         y_Pelvis(i)=-Epsilon*A*(t/T1-1/(2*pi)*sin(2*pi*t/T1));
%         %Alabeo_Tronco=Epsilon*  Global_Int_IncAlabeoTronco/2*(t/T_local-(1/pi)*sin(pi*t/T_local));
%     else
%         if (t < T1+Pausa)
%             y_Pelvis(i)=-Epsilon*A;
%             %Alabeo_Tronco=Epsilon* Global_Int_IncAlabeoTronco;
%         else
%             if (t <= T)
%                 T_local=T1;
%                 t_local=t-(T1+Pausa);
%                 y_Pelvis(i)=-Epsilon*A+Epsilon*(A-Epsilon*B/2)*(t_local/T_local-(1/pi)*sin(pi*t_local/T_local));
%                 %Alabeo_Tronco=Epsilon* Global_Int_IncAlabeoTronco-Epsilon*( Global_Int_IncAlabeoTronco)*(t_local/T_local-(1/pi)*sin(pi*t_local/T_local));
%             end
%         end
%     end
% end

hold on
plot(t,Cicloidal_1,'-k','LineWidth',2)
%grid on
xlabel('t')
ylabel('f(t)')
axis equal
set(gcf,'Color','w')