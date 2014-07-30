function B_EditRobot_BttnGrp_OneAll

global VRMLTab

selected=get(VRMLTab.BttnGrp_OneAll,'SelectedObject');
SlctdStrng=get(selected,'String');

switch SlctdStrng
    case 'One'
        for i=1:18
            set(VRMLTab.RdBtn_MtrFrm{i},'Enable','on');
            if ne(i,1)
                set(VRMLTab.RdBtn_MtrFrm{i},'Value',0);
            end
        end
    case 'All'
        for i=1:18
            set(VRMLTab.RdBtn_MtrFrm{i},'Enable','off');
            set(VRMLTab.RdBtn_MtrFrm{i},'Value',1);
        end        
end