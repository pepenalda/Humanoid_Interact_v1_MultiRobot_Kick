function E_WlkTab_BttnGrp_PazoIzqDer

global WlkTab 
global Walk 
global Robot

% PlotBLD_Wlk(WlkTab.Panel_PLotIK)
Izq=get(WlkTab.uiPnl_RdBttnIzquierda,'Value');
if Izq==1
    Robot.Drcha=0;
else
    Robot.Drcha=1;
end

if (Izq == 1 && (ne(Walk.Values_1(8),0)))
    Walk.Values_1(8)=sign(Walk.Values_1(8))*Walk.Values_1(8);
else
    Walk.Values_1(8)=-1*Walk.Values_1(8);
end

if (Izq == 1 && (ne(Walk.Values_1(10),0)))
    Walk.Values_1(10)=sign(Walk.Values_1(10))*Walk.Values_1(10);
else
    Walk.Values_1(10)=-1*Walk.Values_1(10);
end

PlotBLD_Wlk(WlkTab.Axes);
set(WlkTab.Slider_PRM_1{8},'Value',Walk.Values_1(8));
set(WlkTab.Edit_PRM_1{8},'String',num2str(Walk.Values_1(8)))

set(WlkTab.Slider_PRM_1{10},'Value',Walk.Values_1(10));
set(WlkTab.Edit_PRM_1{10},'String',num2str(Walk.Values_1(10)))