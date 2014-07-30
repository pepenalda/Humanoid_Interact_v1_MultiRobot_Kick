function F_PltTryTab_PshBttn_PlotTry

global PltTryTab
global WlkTab
global Walking
global TrayWalk
global RR_Walking
global RR_TrayWalk


selected=get(PltTryTab.BttnGrp_PC_Robot,'SelectedObject');
SlctdStrng=get(selected,'String');

Value0=get(PltTryTab.PpUp_TipoPaso,'Value');
i=get(PltTryTab.PpUp_Paso,'Value');
Value2=get(PltTryTab.PpUp_Elemento,'Value');
Line='-k';
axes(PltTryTab.axis);

if get(PltTryTab.RdBttn_Add,'Value')
    hold on
    if not(isempty(get(PltTryTab.axis,'Children')))
        Lines=length(get(PltTryTab.axis,'Children'));
        switch Lines
            case 1
                Line='-b';
            case 2
                Line='-r';
            case 3
                Line='-g';
            otherwise
                Line='-k';
        end
    end
else
    hold off
end

if strcmp(SlctdStrng,'PC')
    Value=get(PltTryTab.PpUp_Grupo,'Value');
    switch Value
        case 1
            if Value0==2
                plot(PltTryTab.axis,Walking.t,Line);
            elseif Value0==1
                plot(PltTryTab.axis,TrayWalk.t{i},Line);
            end
        case 2
            if Value0==2
                plot(PltTryTab.axis,Walking.t,rad2deg(Walking.th(Value2,:)),Line);
            elseif Value0==1
                plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.th{i}(Value2,:),Line);
            end
        case 3
            if Value0==2
                switch Value2
                    case 1
                        plot(PltTryTab.axis,Walking.t,Walking.P_x(:),Line);
                    case 2
                        plot(PltTryTab.axis,Walking.t,Walking.P_y(:),Line);
                    case 3
                        plot(PltTryTab.axis,Walking.t,Walking.P_z(:),Line);
                    case 4
                        plot(PltTryTab.axis,Walking.t,Walking.P_phi(:),Line);
                    case 5
                        plot(PltTryTab.axis,Walking.t,Walking.P_th(:),Line);
                    case 6
                        plot(PltTryTab.axis,Walking.t,Walking.P_psi(:),Line);
                end
            elseif Value0==1
                switch Value2
                    case 1
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.P_x{i},Line);
                    case 2
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.P_y{i},Line);
                    case 3
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.P_z{i},Line);
                    case 4
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.P_phi{i},Line);
                    case 5
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.P_th{i},Line);
                    case 6
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.P_psi{i},Line);
                end
            end
        case 4
            if Value0==2
                switch Value2
                    case 1
                        plot(PltTryTab.axis,Walking.t,Walking.Rf_x(:),Line);
                    case 2
                        plot(PltTryTab.axis,Walking.t,Walking.Rf_y(:),Line);
                    case 3
                        plot(PltTryTab.axis,Walking.t,Walking.Rf_z(:),Line);
                    case 4
                        plot(PltTryTab.axis,Walking.t,Walking.Rf_phi(:),Line);
                    case 5
                        plot(PltTryTab.axis,Walking.t,Walking.Rf_th(:),Line);
                    case 6
                        plot(PltTryTab.axis,Walking.t,Walking.Rf_psi(:),Line);
                end
            elseif Value0==1
                switch Value2
                    case 1
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.Rf_x{i},Line);
                    case 2
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.Rf_y{i},Line);
                    case 3
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.Rf_z{i},Line);
                    case 4
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.Rf_phi{i},Line);
                    case 5
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.Rf_th{i},Line);
                    case 6
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.Rf_psi{i},Line);
                end
            end
        case 5
            if Value0==2
                switch Value2
                    case 1
                        plot(PltTryTab.axis,Walking.t,Walking.Lf_x(:),Line);
                    case 2
                        plot(PltTryTab.axis,Walking.t,Walking.Lf_y(:),Line);
                    case 3
                        plot(PltTryTab.axis,Walking.t,Walking.Lf_z(:),Line);
                    case 4
                        plot(PltTryTab.axis,Walking.t,Walking.Lf_phi(:),Line);
                    case 5
                        plot(PltTryTab.axis,Walking.t,Walking.Lf_th(:),Line);
                    case 6
                        plot(PltTryTab.axis,Walking.t,Walking.Lf_psi(:),Line);
                end
            elseif Value0==1
                switch Value2
                    case 1
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.Lf_x{i},Line);
                    case 2
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.Lf_y{i},Line);
                    case 3
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.Lf_z{i},Line);
                    case 4
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.Lf_phi{i},Line);
                    case 5
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.Lf_th{i},Line);
                    case 6
                        plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.Lf_psi{i},Line);
                end
            end
    end
else
    Value=get(PltTryTab.PpUp_Grupo,'Value');
    StringArray=get(PltTryTab.PpUp_Grupo,'String');
    String=StringArray{Value};
    switch String
        case 'Des. Angles'
            if Value0==2
                if Value2==1
                    plot(PltTryTab.axis,WlkTab.Robot.ThsDes.t_Marcha,Line);
                else
                    plot(PltTryTab.axis,WlkTab.Robot.ThsDes.t_Marcha,WlkTab.Robot.ThsDes.Datos_Marcha(Value2-1,:),Line);
                end
            elseif Value0==1
                plot(PltTryTab.axis,TrayWalk.t{i},Line);
            end
        case 'Des. Angles Motor'
            if Value0==2
                if Value2==1
                    plot(PltTryTab.axis,WlkTab.Robot.ThsDesMotor.t_Marcha,Line);
                else
                    plot(PltTryTab.axis,WlkTab.Robot.ThsDesMotor.t_Marcha,WlkTab.Robot.ThsDesMotor.Datos_Marcha(Value2-1,:),Line);
                end
            elseif Value0==1
                plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.th{i}(Value2,:),Line);
            end
        case 'Real Angles'
            if Value0==2
                if Value2==1
                    plot(PltTryTab.axis,WlkTab.Robot.ThsReal.t_Marcha,Line);
                else
                    plot(PltTryTab.axis,WlkTab.Robot.ThsReal.t_Marcha,WlkTab.Robot.ThsReal.Datos_Marcha(Value2-1,:),Line);
                end
            elseif Value0==1
                plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.th{i}(Value2,:),Line);
            end
        case 'Motor Load'
            if Value0==2
                if Value2==1
                    plot(PltTryTab.axis,WlkTab.Robot.CargaReal.t_Marcha,Line);
                else
                    plot(PltTryTab.axis,WlkTab.Robot.CargaReal.t_Marcha,WlkTab.Robot.CargaReal.Datos_Marcha(Value2-1,:),Line);
                end
            elseif Value0==1
                plot(PltTryTab.axis,TrayWalk.t{i},TrayWalk.th{i}(Value2,:),Line);
            end
        case 'Pelvis Coord.'
            if Value0==2
                switch Value2
                    case 1
                        plot(PltTryTab.axis,RR_Walking.t,Line);
                    case 2
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.P_x(:),Line);
                    case 3
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.P_y(:),Line);
                    case 4
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.P_z(:),Line);
                    case 5
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.P_phi(:),Line);
                    case 6
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.P_th(:),Line);
                    case 7
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.P_psi(:),Line);
                end
            elseif Value0==1
                switch Value2
                    case 1
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},Line);
                    case 2
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.P_x{i},Line);
                    case 3
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.P_y{i},Line);
                    case 4
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.P_z{i},Line);
                    case 5
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.P_phi{i},Line);
                    case 6
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.P_th{i},Line);
                    case 7
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.P_psi{i},Line);
                end
            end
        case 'Right Foot Coord.'
            if Value0==2
                switch Value2
                    case 1
                        plot(PltTryTab.axis,RR_Walking.t,Line);
                    case 2
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.Rf_x(:),Line);
                    case 3
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.Rf_y(:),Line);
                    case 4
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.Rf_z(:),Line);
                    case 5
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.Rf_phi(:),Line);
                    case 6
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.Rf_th(:),Line);
                    case 7
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.Rf_psi(:),Line);
                end
            elseif Value0==1
                switch Value2
                    case 1
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},Line);
                    case 2
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.Rf_x{i},Line);
                    case 3
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.Rf_y{i},Line);
                    case 4
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.Rf_z{i},Line);
                    case 5
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.Rf_phi{i},Line);
                    case 6
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.Rf_th{i},Line);
                    case 7
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.Rf_psi{i},Line);
                end
            end
        case 'Left Foot Coord.'
            if Value0==2
                switch Value2
                    case 1
                        plot(PltTryTab.axis,RR_Walking.t,Line);
                    case 2
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.Lf_x(:),Line);
                    case 3
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.Lf_y(:),Line);
                    case 4
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.Lf_z(:),Line);
                    case 5
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.Lf_phi(:),Line);
                    case 6
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.Lf_th(:),Line);
                    case 7
                        plot(PltTryTab.axis,RR_Walking.t,RR_Walking.Lf_psi(:),Line);
                end
            elseif Value0==1
                switch Value2
                    case 1
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},Line);
                    case 2
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.Lf_x{i},Line);
                    case 3
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.Lf_y{i},Line);
                    case 4
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.Lf_z{i},Line);
                    case 5
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.Lf_phi{i},Line);
                    case 6
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.Lf_th{i},Line);
                    case 7
                        plot(PltTryTab.axis,RR_TrayWalk.t{i},RR_TrayWalk.Lf_psi{i},Line);
                end
            end
    end
end
axis tight
if get(PltTryTab.RdBttn_Grid,'Value')
    grid(PltTryTab.axis,'on');
else
    grid(PltTryTab.axis,'off');
end
if get(PltTryTab.RdBttn_Time,'Value') && not(get(PltTryTab.RdBttn_Add,'Value'))
    %F_PltTryTab_RdBttn_Time;
end

function DegreeAngles=Rad2Deg(RadiansAngles)
DegreeAngles=RadiansAngles*180/pi;
