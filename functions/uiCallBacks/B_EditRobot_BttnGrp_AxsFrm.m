function B_EditRobot_BttnGrp_AxsFrm

global EditRobotTab

selected=get(EditRobotTab.BttnGrp_AxsFrm,'SelectedObject');
SlctdStrng=get(selected,'String');

switch SlctdStrng
    case 'Axis'
        set(EditRobotTab.BttnGrp_TransparencyElementSelect,'SelectedObject',EditRobotTab.RdBttn_AxsTr);
    case 'Frame'
        set(EditRobotTab.BttnGrp_TransparencyElementSelect,'SelectedObject',EditRobotTab.RdBttn_FrmsTr);
    case 'CoMs'
        set(EditRobotTab.BttnGrp_TransparencyElementSelect,'SelectedObject',EditRobotTab.RdBttn_CoMsTr);
end