function getDynamics

global Walking
%clc
%Walking
[R C]=size(Walking.th);
% 
% th=Walking.th;
% t=Walking.t/1000;
% for i=1:C
%         if i==1
%             d_th=zeros(R,1);
%             dd_th=zeros(R,1);
%         else
%             d_th(:,i)=(th(:,i)-th(:,i-1))/(t(i)-t(i-1));
%             if i==2
%                 dd_th(:,i)=zeros(R,1);
%             else
%                 dd_th(:,i)=(d_th(:,i)-d_th(:,i-1))/(t(i)-t(i-1));
%             end
%         end
% end
% 
% q_P=[Walking.P_x; Walking.P_y; Walking.P_z; Walking.P_phi; Walking.P_th; Walking.P_psi];
% [R,C]=size(q_P);
% for i=1:C
%         if i==1
%             dq_P=zeros(R,1);
%             ddq_P=zeros(R,1);
%         else
%             dq_P(:,i)=(q_P(:,i)-q_P(:,i-1))/(t(i)-t(i-1));
%             if i==2
%                 ddq_P(:,i)=zeros(R,1);
%             else
%                 ddq_P(:,i)=(dq_P(:,i)-dq_P(:,i-1))/(t(i)-t(i-1));
%             end
%         end
% end
% 
% 
% [R,C]=size(th);
% 
% %Walking
% Index=1;
% for i=1:C
%     th_actual=th(:,i);
%     dth_actual=d_th(:,i);
%     q_B_actual=q_P(:,i);
%     q_B_actual=[q_B_actual(1:3); q_B_actual(4:6)*pi/180];
%     dq_B_actual=dq_P(:,i);
%     if Index==40
%         tic
%         M_Lag=get_M_Lagrange(q_B_actual,dq_B_actual,th_actual,dth_actual);
%         toc
%         tic
%         M_NE=get_M_NE(q_B_actual,dq_B_actual,th_actual,dth_actual);
%         toc
% %         disp('-----------Brazo Derecho--------')
% %         disp('M_Lag')
% %         M_Lag(7:9,1:9)
% %         disp('M_NE')
% %         M_NE(7:9,1:9)
% %         disp('-----------Brazo Izquierdo--------')
% %         disp('M_Lag')
% %         M_Lag(10:12,1:12)
% %         disp('M_NE')
% %         M_NE(10:12,1:12)
% %         disp('-----------Pierna Derecha--------')
% %         disp('M_Lag')
% %         M_Lag(13:18,1:6)
% %         disp('M_NE')
% %         M_NE(13:18,1:6)
% %         disp('M_Lag')
% %         M_Lag(13:18,13:18)
% %         disp('M_NE')
% %         M_NE(13:18,13:18)
%         disp('-----------Pierna Izquierda--------')
%         disp('M_Lag')
%         M_Lag(19:24,1:6)
%         disp('M_NE')
%         M_NE(19:24,1:6)
%         disp('M_Lag')
%         M_Lag(19:24,19:24)
%         disp('M_NE')
%         M_NE(19:24,19:24)
%        
%     end
%     %M_BrDr_qB_NE=M(1:3,1:6)
%     %M_BrDr_BrDr_NE=M(1:3,7:9)
%     %M_PrDr_PrDr_NE=M(7:12,13:18)
%     Index=Index+1;
% end
% % 
% % figure
% % subplot(311)
% % plot(t,q_P(2,:))
% % subplot(312)
% % plot(t,dq_P(2,:))
% % subplot(313)
% % plot(t,ddq_P(2,:))
% 
