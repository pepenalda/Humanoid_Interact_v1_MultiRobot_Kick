function B_EditRobot_BttnGrp_TrnsprncyElmntSlct

global VRMLTab
global Robot

selected=get(VRMLTab.BttnGrp_TransparencyElementSelect,'SelectedObject');
SlctdStrng=get(selected,'String');

switch SlctdStrng
    case 'Robot'
        Value=getfield(Robot.vrRobot,'transparency');
        setOrgnFrmsEnOff;
        setExtmyEnOff;
        setAxsFrmEnOff;
    case 'Head Chest'
        setOrgnFrmsEnOff;
        setExtmyEnOff; 
        setAxsFrmEnOff;
         Value=getfield(Robot.vrRobot,'head_transparency');
    case 'Kinematic Chain'
        setOrgnFrmsEnOff;
        setExtmyEnOff; 
        setAxsFrmEnOff;
        Value=getfield(Robot.vrRobot,'structure_transparency');
    case 'Motors Axis'
        setOrgnFrmsEnOff;
        setExtmyEnOff;                
        setAxsFrmEnOn;
        Value=getfield(Robot.vrRobot,'axis_transparency');
        set(VRMLTab.BttnGrp_AxsFrm,'selectedobject',VRMLTab.Bttn_Axs);
    case 'Motors Frames'
        Value=getfield(Robot.vrRobot,'Frames_transparency');
        setOrgnFrmsEnOff;
        setOrgnFrmsEnOff;
        setAxsFrmEnOn;
        set(VRMLTab.BttnGrp_AxsFrm,'selectedobject',VRMLTab.Bttn_Frms);
    case 'Reference Frames'
        setOrgnFrmsEnOn;
        setExtmyEnOff;
        setAxsFrmEnOff;
        Value=getfield(Robot.vrRobot,'Torso_transparency');
    case 'Extremities Frames'
        setOrgnFrmsEnOff;
        setExtmyEnOn;
        setAxsFrmEnOff;
        Value=getfield(Robot.vrRobot,'LH_transparency');
    case 'CoMs'
        setOrgnFrmsEnOff;
        setOrgnFrmsEnOff;
        setAxsFrmEnOn;
        Value=getfield(Robot.vrRobot,'transparency_CoM0');      
        set(VRMLTab.BttnGrp_AxsFrm,'selectedobject',VRMLTab.Bttn_CoMs);
    case 'CoM'
        setOrgnFrmsEnOff;
        setExtmyEnOff; 
        setAxsFrmEnOff;
        Value=getfield(Robot.vrRobot,'transparency_CoM');                
    case 'Carpet'
        setOrgnFrmsEnOff;
        setExtmyEnOff; 
        setAxsFrmEnOff;
        Value=getfield(Robot.vrFloor,'transparencyCarpet');        
    case 'Floor'
        setOrgnFrmsEnOff;
        setExtmyEnOff; 
        setAxsFrmEnOff;
        Value=getfield(Robot.vrFloor,'transparencyFloor');                
end
set(VRMLTab.Slder_TrsprncyValue,'Value',Value);
set(VRMLTab.Edt_TrsprncyValue,'String',num2str(Value,'%1.3f'));

function setAxsFrmEnOff
global VRMLTab
set(VRMLTab.Bttn_Axs,'Enable','off');
set(VRMLTab.Bttn_Frms,'Enable','off');
set(VRMLTab.Bttn_CoMs,'Enable','off');
set(VRMLTab.Bttn_One,'Enable','off');
set(VRMLTab.Bttn_All,'Enable','off');

function setAxsFrmEnOn
global VRMLTab
set(VRMLTab.Bttn_Axs,'Enable','on');
set(VRMLTab.Bttn_Frms,'Enable','on');
set(VRMLTab.Bttn_CoMs,'Enable','on');
set(VRMLTab.Bttn_One,'Enable','on');
set(VRMLTab.Bttn_All,'Enable','on');

function setOrgnFrmsEnOff
global VRMLTab
        set(VRMLTab.OrgnFrmBttn01,'Enable','off');
        set(VRMLTab.OrgnFrmBttn02,'Enable','off');
        set(VRMLTab.OrgnFrmBttn03,'Enable','off');
        set(VRMLTab.OrgnFrmBttn04,'Enable','off');
        set(VRMLTab.OrgnFrmBttn05,'Enable','off');
        set(VRMLTab.OrgnFrmBttn06,'Enable','off');

function setExtmyEnOff   
global VRMLTab
        set(VRMLTab.ExtmyFrmBttn01,'Enable','off');
        set(VRMLTab.ExtmyFrmBttn02,'Enable','off');
        set(VRMLTab.ExtmyFrmBttn03,'Enable','off');
        set(VRMLTab.ExtmyFrmBttn04,'Enable','off');
        set(VRMLTab.ExtmyFrmBttn05,'Enable','off');
        set(VRMLTab.ExtmyFrmBttn06,'Enable','off');

function setOrgnFrmsEnOn
global VRMLTab
        set(VRMLTab.OrgnFrmBttn01,'Enable','on');
        set(VRMLTab.OrgnFrmBttn02,'Enable','on');
        set(VRMLTab.OrgnFrmBttn03,'Enable','on');
        set(VRMLTab.OrgnFrmBttn04,'Enable','on');
        set(VRMLTab.OrgnFrmBttn05,'Enable','on');
        set(VRMLTab.OrgnFrmBttn06,'Enable','on');

function setExtmyEnOn 
global VRMLTab
        set(VRMLTab.ExtmyFrmBttn01,'Enable','on');
        set(VRMLTab.ExtmyFrmBttn02,'Enable','on');
        set(VRMLTab.ExtmyFrmBttn03,'Enable','on');
        set(VRMLTab.ExtmyFrmBttn04,'Enable','on');
        set(VRMLTab.ExtmyFrmBttn05,'Enable','on');
        set(VRMLTab.ExtmyFrmBttn06,'Enable','on');
