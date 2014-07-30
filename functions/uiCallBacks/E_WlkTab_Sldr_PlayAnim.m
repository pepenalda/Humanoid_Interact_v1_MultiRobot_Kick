function E_WlkTab_Sldr_PlayAnim(Slider)

global Strct_MainFigure
global PltTryTab
global WlkTab
global Walking
global Paused Play
global PlayPoint

Paused=0;
Play=1;

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

set(TggleBttn,'String','Play');
set(TggleBttn,'Value',0);

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

Value=get(Slider,'Value');
Indices=find(Walking.t>Value);
if isempty(Indices)
    return
else
    j=Indices(1);
end
set(Slider_Time,'Value',Walking.t(j));
set(Edit_Time,'String',num2str(Walking.t(j)));
set_Virtual_Robot_Angles_Pelvis(Walking.th(:,j),j);
ActualizaPlot;
PlayPoint=j;