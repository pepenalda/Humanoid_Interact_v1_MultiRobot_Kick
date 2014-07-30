function E_WlkTab_TggleBttn_PlayAnim(PshBttn)

global Strct_MainFigure
global WlkTab
global PltTryTab
global Walking

global PlayPoint
global Play Paused

if isfield(Strct_MainFigure,'Panel_WalkTab')
    Slider_Time=WlkTab.Slider_TimePlayAnimation;
    TggleBttn=WlkTab.TggleBttn_PlayAnimation;
    PopupMenu=WlkTab.PpupMenu_Acelerar;
    Edit_Time=WlkTab.Edit_TimePlayAnimation;
    Eje=WlkTab.Axes;
else
    Slider_Time=PltTryTab.Slider_TimePlayAnimation;
    TggleBttn=PltTryTab.TggleBttn_PlayAnimation;
    PopupMenu=PltTryTab.PpupMenu_Acelerar;
    Edit_Time=PltTryTab.Edit_TimePlayAnimation;
    Eje=PltTryTab.Axes;
end

Acelerar=get(PopupMenu,'Value');
switch Acelerar
    case 1
        Paso=1;
    case 2
        Paso=2;
    case 3
        Paso=5;
    case 4
        Paso=10;
end

Play=1;
if get(PshBttn,'Value')==1
    Paused=0;
    set(PshBttn,'String','Pause');
    Puntos=length(Walking.t);
    if isempty(Paused)
        Inicio=1;
    else
        Inicio=PlayPoint;
    end
    %Inicio
    for j=Inicio:Paso:Puntos
        set(Slider_Time,'Value',Walking.t(j));
        set(Edit_Time,'String',num2str(Walking.t(j)));
        set_Virtual_Robot_Angles_Pelvis(Walking.th(:,j),j);
        %pause(0.005);
        ActualizaPlot;
        PlayPoint=j;
        if Play==0
            return;
        end
    end
else
    set(PshBttn,'String','Play');
    Paused=1;
    Play=0;
end
PlayPoint=1;
%Paused=[];
set(PshBttn,'String','Play');
set(PshBttn,'Value',0);
if ne(Paused,1)
    set(Slider_Time,'Value',0);
    set(Edit_Time,'String',num2str(0));
    PlotBLD_Wlk(Eje);
end

