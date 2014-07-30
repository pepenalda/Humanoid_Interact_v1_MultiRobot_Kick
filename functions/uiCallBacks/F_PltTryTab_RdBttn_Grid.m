function F_PltTryTab_RdBttn_Grid
global PltTryTab
Value=get(PltTryTab.RdBttn_Grid,'Value');

if Value
    grid(PltTryTab.axis,'on');
else
    grid(PltTryTab.axis,'off');
end
