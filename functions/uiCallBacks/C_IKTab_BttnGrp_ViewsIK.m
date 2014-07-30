function C_IKTab_BttnGrp_ViewsIK

global Robot
global vrFigure
global IKTab

selected=get(IKTab.uiBttnGrp_Views,'SelectedObject');
SlctdStrng=get(selected,'String');
axes(IKTab.Axes);
switch SlctdStrng
    case 'Lateral'
        view(0,0);
        set(vrFigure,'Viewpoint','VPLat') % change viewpoint
    case 'Perspectiva'
        view(59,27);
        set(vrFigure,'Viewpoint','VPPersp') % change viewpoint
    case 'Front'
        view(90,0);
        set(vrFigure,'Viewpoint','VPFront') % change viewpoint
    case 'Upper'
        view(0,90);
        set(vrFigure,'Viewpoint','VPSup') % change viewpoint
end