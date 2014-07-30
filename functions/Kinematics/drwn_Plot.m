function nao_Plot(Eje)

global Robot

% if get(IKTab.RdBttn_DSup,'Value') == 1
%     set_hip_RightSupport;
% elseif get(IKTab.RdBttn_SupRight,'Value') == 1
%     set_hip_RightSupport
% elseif get(IKTab.RdBttn_SupLeft,'Value') == 1
%     set_hip_LeftSupport
% end
row4=[0 0 0 1];
w_T_o=[Robot.w_R_o Robot.w_p_o; row4];
mlab_2_vrml=[0 0 1 0;
             1 0 0 0;
             0 1 0 0;
             0 0 0 1];
         
mlab_T_o=mlab_2_vrml*w_T_o;

x_o=mlab_T_o(1,4);
y_o=mlab_T_o(2,4);
z_o=mlab_T_o(3,4);

DRWN=drwn_DK;
 
MrkrSz=2;
cla(Eje)
%%Tronco
plot3(Eje,[x_o DRWN.Thd_o_00(1,4) DRWN.Thd_o_01(1,4) DRWN.Thd_o_02(1,4)]/10,...
      [y_o DRWN.Thd_o_00(2,4) DRWN.Thd_o_01(2,4) DRWN.Thd_o_02(2,4)]/10,...
      [z_o DRWN.Thd_o_00(3,4) DRWN.Thd_o_01(3,4) DRWN.Thd_o_02(3,4)]/10,'-ko','MarkerSize',MrkrSz);

%%Brazo Derecho
plot3(Eje,  [x_o DRWN.Tbd_o_00(1,4) DRWN.Tbd_o_01(1,4) DRWN.Tbd_o_02(1,4) DRWN.Tbd_o_03(1,4) DRWN.Tbd_o_04(1,4) DRWN.Tbd_o_05(1,4)]/10,...
            [y_o DRWN.Tbd_o_00(2,4) DRWN.Tbd_o_01(2,4) DRWN.Tbd_o_02(2,4) DRWN.Tbd_o_03(2,4) DRWN.Tbd_o_04(2,4) DRWN.Tbd_o_05(2,4)]/10,...
            [z_o DRWN.Tbd_o_00(3,4) DRWN.Tbd_o_01(3,4) DRWN.Tbd_o_02(3,4) DRWN.Tbd_o_03(3,4) DRWN.Tbd_o_04(3,4) DRWN.Tbd_o_05(3,4)]/10,'-go','MarkerSize',MrkrSz);% hold on

%%Brazo Izquierdo
plot3(Eje,  [x_o DRWN.Tbi_o_00(1,4) DRWN.Tbi_o_01(1,4) DRWN.Tbi_o_02(1,4) DRWN.Tbi_o_03(1,4) DRWN.Tbi_o_04(1,4) DRWN.Tbi_o_05(1,4)]/10,...
            [y_o DRWN.Tbi_o_00(2,4) DRWN.Tbi_o_01(2,4) DRWN.Tbi_o_02(2,4) DRWN.Tbi_o_03(2,4) DRWN.Tbi_o_04(2,4) DRWN.Tbi_o_05(2,4)]/10,...
            [z_o DRWN.Tbi_o_00(3,4) DRWN.Tbi_o_01(3,4) DRWN.Tbi_o_02(3,4) DRWN.Tbi_o_03(3,4) DRWN.Tbi_o_04(3,4) DRWN.Tbi_o_05(3,4)]/10,'-ro','MarkerSize',MrkrSz);% hold on

%%Pierna Derecha
plot3(Eje,  [x_o DRWN.Tpd_o_00(1,4) DRWN.Tpd_o_01(1,4) DRWN.Tpd_o_02(1,4) DRWN.Tpd_o_03(1,4) DRWN.Tpd_o_04(1,4) DRWN.Tpd_o_05(1,4), DRWN.Tpd_o_06(1,4) DRWN.Tpd_o_07(1,4)]/10,...
            [y_o DRWN.Tpd_o_00(2,4) DRWN.Tpd_o_01(2,4) DRWN.Tpd_o_02(2,4) DRWN.Tpd_o_03(2,4) DRWN.Tpd_o_04(2,4) DRWN.Tpd_o_05(2,4), DRWN.Tpd_o_06(2,4) DRWN.Tpd_o_07(2,4)]/10,...
            [z_o DRWN.Tpd_o_00(3,4) DRWN.Tpd_o_01(3,4) DRWN.Tpd_o_02(3,4) DRWN.Tpd_o_03(3,4) DRWN.Tpd_o_04(3,4) DRWN.Tpd_o_05(3,4), DRWN.Tpd_o_06(3,4) DRWN.Tpd_o_07(3,4)]/10, '-go','MarkerSize',MrkrSz);% hold on

%%Pie derecho
line(   [DRWN.Tpd_o_P1(1) DRWN.Tpd_o_P2(1)]/10, ...
        [DRWN.Tpd_o_P1(2) DRWN.Tpd_o_P2(2)]/10,...
        [DRWN.Tpd_o_P1(3) DRWN.Tpd_o_P2(3)]/10,'Color','g','Marker','o','MarkerSize',MrkrSz);

line(   [DRWN.Tpd_o_P3(1) DRWN.Tpd_o_P4(1)]/10, ...
        [DRWN.Tpd_o_P3(2) DRWN.Tpd_o_P4(2)]/10,...
        [DRWN.Tpd_o_P3(3) DRWN.Tpd_o_P4(3)]/10,'Color','g','Marker','o','MarkerSize',MrkrSz);

line(   [DRWN.Tpd_o_P5(1) DRWN.Tpd_o_P6(1)]/10, ...
        [DRWN.Tpd_o_P5(2) DRWN.Tpd_o_P6(2)]/10,...
        [DRWN.Tpd_o_P5(3) DRWN.Tpd_o_P6(3)]/10,'Color','g','Marker','o','MarkerSize',MrkrSz);
    
%%Pierna Izquierda
plot3(Eje,  [x_o DRWN.Tpi_o_00(1,4) DRWN.Tpi_o_01(1,4) DRWN.Tpi_o_02(1,4) DRWN.Tpi_o_03(1,4) DRWN.Tpi_o_04(1,4) DRWN.Tpi_o_05(1,4), DRWN.Tpi_o_06(1,4) DRWN.Tpi_o_07(1,4)]/10,...
            [y_o DRWN.Tpi_o_00(2,4) DRWN.Tpi_o_01(2,4) DRWN.Tpi_o_02(2,4) DRWN.Tpi_o_03(2,4) DRWN.Tpi_o_04(2,4) DRWN.Tpi_o_05(2,4), DRWN.Tpi_o_06(2,4) DRWN.Tpi_o_07(2,4)]/10,...
            [z_o DRWN.Tpi_o_00(3,4) DRWN.Tpi_o_01(3,4) DRWN.Tpi_o_02(3,4) DRWN.Tpi_o_03(3,4) DRWN.Tpi_o_04(3,4) DRWN.Tpi_o_05(3,4), DRWN.Tpi_o_06(3,4) DRWN.Tpi_o_07(3,4)]/10, '-ro','MarkerSize',MrkrSz);% hold on
     
%%Pie izquierdo
line(   [DRWN.Tpi_o_P1(1) DRWN.Tpi_o_P2(1)]/10, ...
        [DRWN.Tpi_o_P1(2) DRWN.Tpi_o_P2(2)]/10,...
        [DRWN.Tpi_o_P1(3) DRWN.Tpi_o_P2(3)]/10,'Color','r','Marker','o','MarkerSize',MrkrSz);

line(   [DRWN.Tpi_o_P3(1) DRWN.Tpi_o_P4(1)]/10, ...
        [DRWN.Tpi_o_P3(2) DRWN.Tpi_o_P4(2)]/10,...
        [DRWN.Tpi_o_P3(3) DRWN.Tpi_o_P4(3)]/10,'Color','r','Marker','o','MarkerSize',MrkrSz);

line(   [DRWN.Tpi_o_P5(1) DRWN.Tpi_o_P6(1)]/10, ...
        [DRWN.Tpi_o_P5(2) DRWN.Tpi_o_P6(2)]/10,...
        [DRWN.Tpi_o_P5(3) DRWN.Tpi_o_P6(3)]/10,'Color','r','Marker','o','MarkerSize',MrkrSz);

    
    % lnft_1=line( [DRWN.T_opdb(1,4) DRWN.T_opdf(1,4)]/10,...
%       [DRWN.T_opdb(2,4) DRWN.T_opdf(2,4)]/10,...
%       [DRWN.T_opdb(3,4) DRWN.T_opdf(3,4)]/10,'Color','g','MarkerSize',MrkrSz);
% 
% lnft_2=line( [DRWN.T_opdP1(1,4) DRWN.T_opdP2(1,4)]/10,...
%       [DRWN.T_opdP1(2,4) DRWN.T_opdP2(2,4)]/10,...
%       [DRWN.T_opdP1(3,4) DRWN.T_opdP2(3,4)]/10,'Color','g','Marker','o','MarkerSize',MrkrSz);
% 
% lnft_3=line( [DRWN.T_opdP3(1,4) DRWN.T_opdP4(1,4)]/10,...
%       [DRWN.T_opdP3(2,4) DRWN.T_opdP4(2,4)]/10,...
%       [DRWN.T_opdP3(3,4) DRWN.T_opdP4(3,4)]/10,'Color','g','Marker','o','MarkerSize',MrkrSz);
%   
% hold on
% %%Left foot
% lnft_1=line( [DRWN.T_opib(1,4) DRWN.T_opif(1,4)]/10,...
%       [DRWN.T_opib(2,4) DRWN.T_opif(2,4)]/10,...
%       [DRWN.T_opib(3,4) DRWN.T_opif(3,4)]/10,'Color','r','MarkerSize',MrkrSz);
% 
% lnft_2=line( [DRWN.T_opiP1(1,4) DRWN.T_opiP2(1,4)]/10,...
%       [DRWN.T_opiP1(2,4) DRWN.T_opiP2(2,4)]/10,...
%       [DRWN.T_opiP1(3,4) DRWN.T_opiP2(3,4)]/10,'Color','r','Marker','o','MarkerSize',MrkrSz);
% 
% lnft_3=line( [DRWN.T_opiP3(1,4) DRWN.T_opiP4(1,4)]/10,...
%       [DRWN.T_opiP3(2,4) DRWN.T_opiP4(2,4)]/10,...
%       [DRWN.T_opiP3(3,4) DRWN.T_opiP4(3,4)]/10,'Color','r','Marker','o','MarkerSize',MrkrSz);
% grid on
% axis equal
% 
% axis([-250 250 -250 250 0 350]/10);
% 
% if Robot.FstPlt==1;
%     view(59,27);
%     Robot.FstPlt=0;
%     Robot.plotRbt=gca;
%     set(Robot.plotRbt,'CameraViewAngle',5);
%     set(Robot.plotRbt,'Parent',KinPanel);
% end
% 
% xlabel('x');
% ylabel('y');
% zlabel('z');
% 
% th=Get_Ths_vrHumanoid;
% switch Robot.IK_Key
%     case 1
%         %Obtener la posicion y orientacion de la mano derecha
%         T_bd=mlab_T_vrml*(mlab_T_o\DRWN.T_obd06);
%         xyz_bd=T_bd(1:3,4);
%         xyz_bd=xyz_bd.'/10;
%         x=xyz_bd(1);
%         y=xyz_bd(2);
%         z=xyz_bd(3);
%         T_bd=mlab_T_o\DRWN.T_obd06;
%         R_bd=T_bd(1:3,1:3);
%         rpy_bd=Rot2rpy_XZYCadN(R_bd)*180/pi;
%         r=rpy_bd(1);
%         p=rpy_bd(2);
%         ya=rpy_bd(3);
%     case 2
%         T_bi=mlab_T_vrml*(mlab_T_o\DRWN.T_obi06);
%         xyz_bi=T_bi(1:3,4);
%         xyz_bi=xyz_bi.'/10;
%         x=xyz_bi(1);
%         y=xyz_bi(2);
%         z=xyz_bi(3);
%         T_bi=mlab_T_o\DRWN.T_obi06;
%         R_bi=T_bi(1:3,1:3);
%         rpy_bi=Rot2rpy_XZYCadN(R_bi)*180/pi;
%         r=rpy_bi(3);
%         p=rpy_bi(1);
%         ya=rpy_bi(2);        
%     case 3
%         %Obtener la posicion y orientacion del pie derecho
%         T_pd=mlab_T_vrml*(DRWN.T_opd00a\DRWN.T_opd11);
%         xyz_pd=T_pd(1:3,4);
%         xyz_pd=xyz_pd.'/10;
%         x=xyz_pd(1);
%         y=xyz_pd(2);
%         z=xyz_pd(3);
%         T_pd=mlab_T_o\DRWN.T_opd12;
%         R_pd=T_pd(1:3,1:3);
%         rpyL_pd=[th(9)-th(17) th(11)-th(13)-th(15) -(th(7)+pi/4)]*180/pi;
%         rpy_pd=Rot2rpyYXZFootN((mlab_T_o\DRWN.T_opd12)).'*180/pi;
%         r=rpy_pd(1);
%         p=rpy_pd(2);
%         ya=rpy_pd(3);        
%         if get(IKTab.RdBttn_SupLeft,'Value')==get(IKTab.RdBttn_SupLeft,'Max') | get(IKTab.RdBttn_DSup,'Value')==get(IKTab.RdBttn_DSup,'Max')
%             T_RA=DRWN.T_opd11;
%             r_RA=T_RA(1:3,4)/10;
%             T_RF=DRWN.T_opd12;
%             W_R_RF=T_RF(1:3,1:3);
%             x=r_RA(1);
%             y=r_RA(2);
%             z=r_RA(3)-29.5/10;
%             rpy_pd=Rot2rpy_XZYCadN((mlab_T_vrml\DRWN.T_opd12)).'*180/pi;
%             r=rpy_pd(1);
%             p=rpy_pd(2);
%             ya=rpy_pd(3);         
%             rpyL_pd=rpy_pd;
%         end
%         set(IKTab.Slider_Ori{1},'Value',rpyL_pd(1));
%         set(IKTab.Slider_Ori{2},'Value',rpyL_pd(2));
%         set(IKTab.Slider_Ori{3},'Value',rpyL_pd(3));
%     case 4
%         T_pi=mlab_T_vrml*(DRWN.T_opi00a\DRWN.T_opi11);
%         xyz_pi=T_pi(1:3,4);
%         xyz_pi=xyz_pi.'/10;
%         x=xyz_pi(1);
%         y=xyz_pi(2);
%         z=xyz_pi(3);
%         T_pi=mlab_T_o\DRWN.T_opi12;
%         R_pi=T_pi(1:3,1:3);
% 
%         rpyL_pi=[th(10)-th(18) -th(12)+th(14)+th(16) -(th(8)-pi/4)]*180/pi;
%         rpy_pi=Rot2rpyYXZFootN((mlab_T_o\DRWN.T_opi12)).'*180/pi;
%         r=rpy_pi(1);
%         p=rpy_pi(2);
%         ya=rpy_pi(3);                
% 
%         if get(IKTab.RdBttn_SupRight,'Value')==get(IKTab.RdBttn_SupRight,'Max') | get(IKTab.RdBttn_DSup,'Value')==get(IKTab.RdBttn_DSup,'Max')
%             T_LA=DRWN.T_opi11;
%             r_LA=T_LA(1:3,4)/10;
%             T_LF=DRWN.T_opi12;
%             W_R_LF=T_LF(1:3,1:3);
%             x=r_LA(1);
%             y=r_LA(2);
%             z=r_LA(3)-29.5/10;
%             rpy_pi=Rot2rpy_XZYCadN((mlab_T_vrml\DRWN.T_opi12)).'*180/pi;
%             r=rpy_pi(1);
%             p=rpy_pi(2);
%             ya=rpy_pi(3);                   
%             rpyL_pi=rpy_pi;
%         end
%         set(IKTab.Slider_Ori{1},'Value',rpyL_pi(1));
%         set(IKTab.Slider_Ori{2},'Value',rpyL_pi(2));
%         set(IKTab.Slider_Ori{3},'Value',rpyL_pi(3));
%     case 5
%         T_pel=DRWN.T_opi00a;
%         xyz_pel=T_pel(1:3,4);
%         xyz_pel=xyz_pel.'/10;
%         x=xyz_pel(1);
%         y=xyz_pel(2);
%         z=xyz_pel(3)-29.5/10;
%         R_pel=Robot.w_R_o;
%         rpy_pel=Rot2rpy_XZYCadN(R_pel);
%         rpy_pel=rpy_pel*180/pi;
%         r=rpy_pel(1);
%         p=rpy_pel(2);
%         ya=rpy_pel(3);        
%         set(IKTab.Slider_Ori{1},'Value',rpy_pel(1));
%         set(IKTab.Slider_Ori{2},'Value',rpy_pel(2));
%         set(IKTab.Slider_Ori{3},'Value',rpy_pel(3));
% end
% 
% %set sliders and edits
% set(IKTab.Slider_Pos{1},'Value',x);
% set(IKTab.Slider_Pos{2},'Value',y);
% set(IKTab.Slider_Pos{3},'Value',z);
% set(IKTab.Edit_Pos{1},'String',num2str(x,'%2.2f'));
% set(IKTab.Edit_Pos{2},'String',num2str(y,'%2.2f'));
% set(IKTab.Edit_Pos{3},'String',num2str(z,'%2.2f'));
% 
% set(IKTab.Edit_Ori{1},'String',num2str(r,'%3.1f'));
% set(IKTab.Edit_Ori{2},'String',num2str(p,'%3.1f'));
% set(IKTab.Edit_Ori{3},'String',num2str(ya,'%3.1f'));
% 
% %set_CoM;