function F_PltTryTab_RdBttn_Time

global TrayStride
global Walk
global Walking
global PltTryTab
global PlotT_Time

Value=get(PltTryTab.RdBttn_Time,'Value');

Indice=0;
hold on
yLim=get(PltTryTab.axis,'YLim');
if Value
    for i=1:Walk.Values_1(1)
        Indice=Indice+length(TrayStride.t);
        PlotT_Time{i}=plot(PltTryTab.axis,[Walking.t(Indice), Walking.t(Indice)],[yLim(1), yLim(2)],'--m');
    end
else
    for i=1:length(PlotT_Time)
        if exist('PlotT_Time','var')
            delete(PlotT_Time{i});
        end
    end
end
hold off