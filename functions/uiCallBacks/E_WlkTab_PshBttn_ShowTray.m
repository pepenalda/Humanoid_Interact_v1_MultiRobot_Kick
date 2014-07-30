function E_WlkTab_PshBttn_ShowTray(PshBttn)

State=get(PshBttn,'Value');
global PlotTrayPelvis PlotTrayPieIzq PlotTrayPieDer
if State==1
    Robot.Plt_Try=1;
    set(PlotTrayPelvis,'visible','on');
    set(PlotTrayPieIzq,'visible','on');
    set(PlotTrayPieDer,'visible','on');
else
    Robot.Plt_Try=0;
    set(PlotTrayPelvis,'visible','off');
    set(PlotTrayPieIzq,'visible','off');
    set(PlotTrayPieDer,'visible','off');
end