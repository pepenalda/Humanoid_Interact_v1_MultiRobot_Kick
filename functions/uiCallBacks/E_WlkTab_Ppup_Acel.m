function E_WlkTab_Ppup_Acel

global Walking
global WlkTab
global PltTryTab
global Paused Play
global Strct_MainFigure

if isfield(Strct_MainFigure,'Panel_WalkTab')
    Slider_Time=WlkTab.Slider_TimePlayAnimation;
    TggleBttn=WlkTab.TggleBttn_PlayAnimation;
    PopupMenu=WlkTab.PpupMenu_Acelerar;
else
    Slider_Time=PltTryTab.Slider_TimePlayAnimation;
    TggleBttn=PltTryTab.TggleBttn_PlayAnimation;
    PopupMenu=PltTryTab.PpupMenu_Acelerar;  
end

Paused=1;
Play=0;
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
UltimoIndice=length(Walking.t);
T_Final=Walking.t(length(Walking.t));
step=T_Final/(length(Walking.t)/Paso);
SldrStp=(step/T_Final);
set(Slider_Time,'sliderstep',[SldrStp 3*SldrStp]); 