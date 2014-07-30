function B_EditRobot_Slder_Trnsprncy(Value)

global VRMLTab
global Robot

selected=get(VRMLTab.BttnGrp_TransparencyElementSelect,'SelectedObject');
SlctdStrng=get(selected,'String');

HumanoidField=1;
switch SlctdStrng
    case 'Robot'
        FieldString='transparency';
    case 'Head Chest'
        FieldString='head_transparency';
    case 'Kinematic Chain'
        FieldString='structure_transparency';
    case 'Motors Axis'
        selectedOneAll=get(VRMLTab.BttnGrp_OneAll,'SelectedObject');
        SlctdStrngOneAll=get(selectedOneAll,'String');
        if strcmp(SlctdStrngOneAll,'One')
            for i=1:Robot.N
                if get(VRMLTab.RdBtn_MtrFrm{i},'Value')==1
                    FieldString=['transparency_Axis' num2str(i)];
                end
            end
        else
            FieldString='transparency_Axis1';
            for i=1:Robot.N
                String=['transparency_Axis' num2str(i)];
                setfield(Robot.vrRobot,String,Value);
            end
        end
    case 'Motors Frames'
        selectedOneAll=get(VRMLTab.BttnGrp_OneAll,'SelectedObject');
        SlctdStrngOneAll=get(selectedOneAll,'String');
        if strcmp(SlctdStrngOneAll,'One')
            for i=1:Robot.N
                if get(VRMLTab.RdBtn_MtrFrm{i},'Value')==1
                    FieldString=['transparency_Frame' num2str(i)];
                end
            end
        else
            FieldString='transparency_Frame1';
            for i=1:Robot.N
                String=['transparency_Frame' num2str(i)];
                setfield(Robot.vrRobot,String,Value);
            end
        end
    case 'Reference Frames'
        Slctd_RfrnceFrm=get(VRMLTab.BttnGrp_OrgnFrms,'selectedobject');
        switch Slctd_RfrnceFrm
            case VRMLTab.OrgnFrmBttn01
                FieldString='Torso_transparency';        
            case VRMLTab.OrgnFrmBttn02
                FieldString='Pelvis_transparency';        
            case VRMLTab.OrgnFrmBttn03
                FieldString='LS_transparency';        
            case VRMLTab.OrgnFrmBttn04
                FieldString='RS_transparency';        
            case VRMLTab.OrgnFrmBttn05
                FieldString='LHip_transparency';        
            case VRMLTab.OrgnFrmBttn06
                FieldString='RHip_transparency';                       
        end
    case 'Extremities Frames'
        Slctd_ExtmyFrm=get(VRMLTab.BttnGrp_ExtrmtyFrms,'selectedobject');
        switch Slctd_ExtmyFrm
            case VRMLTab.ExtmyFrmBttn01
                FieldString='LH_transparency';        
            case VRMLTab.ExtmyFrmBttn02
                FieldString='RH_transparency';        
            case VRMLTab.ExtmyFrmBttn03
                FieldString='LAnkle_transparency';        
            case VRMLTab.ExtmyFrmBttn04
                FieldString='LF_transparency';        
            case VRMLTab.ExtmyFrmBttn05
                FieldString='RAnkle_transparency';        
            case VRMLTab.ExtmyFrmBttn06
                FieldString='RF_transparency';                       
        end
    case 'CoMs'
        selectedOneAll=get(VRMLTab.BttnGrp_OneAll,'SelectedObject');
        SlctdStrngOneAll=get(selectedOneAll,'String');
        if strcmp(SlctdStrngOneAll,'One')
            for i=1:18
                if get(VRMLTab.RdBtn_MtrFrm{i},'Value')==1
                    FieldString=['transparency_CoM' num2str(i)];
                end
            end
        else
            FieldString='transparency_CoM0';
            for i=1:18
                String=['transparency_CoM' num2str(i)];
                setfield(Robot.vrRobot,String,Value);
            end
        end
    case 'CoM'
        HumanoidField=1;
        FieldString='transparency_CoM';        
    case 'Carpet'
        HumanoidField=0;
        FieldString='transparencyCarpet';
    case 'Floor'
        HumanoidField=0;
        FieldString='transparencyFloor';        
end
if HumanoidField
    setfield(Robot.vrRobot,FieldString,Value);
    set(VRMLTab.Edt_TrsprncyValue,'String',num2str(Value,'%1.2f'));
else
    setfield(vrFloor,FieldString,Value);
    set(VRMLTab.Edt_TrsprncyValue,'String',num2str(Value,'%1.2f'));    
end