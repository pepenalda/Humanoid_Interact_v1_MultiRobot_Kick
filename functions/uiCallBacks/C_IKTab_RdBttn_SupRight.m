function C_IKTab_RdBttn_SupRight

global Robot
global IKTab

ID_Motors_RightLeg=[7 9 11 13 15 17];
ID_Motors_LeftLeg=[8 10 12 14 16 18];

hObject=IKTab.RdBttn_SupRight;
button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    set(IKTab.RdBttn_DSup,'Value',get(IKTab.RdBttn_DSup,'Min')); 
    set(IKTab.RdBttn_SupLeft,'Value',get(IKTab.RdBttn_SupLeft,'Min'));
    if Robot.IK_Key==5 | Robot.IK_Key==4
        activateIK
    else if Robot.IK_Key==3
            UnactivateIK
        end
    end    
    set_hip_RightSupport;
else
    if Robot.IK_Key==5 | Robot.IK_Key==4 | Robot.IK_Key==3
        UnactivateIK
    end    
    Robot.w_R_o=[1 0 0; 0 1 0; 0 0 1]; Robot.w_p_o=[0 310 0].';
    vrot=vrrotmat2vec(Robot.w_R_o);
    setfield(Robot.vrRobot,'translationHips',Robot.w_p_o.');
    setfield(Robot.vrRobot,'rotationHips',vrot);        
end
PlotRBT(IKTab.Axes)

function activateIK
global IKTab
for j=1:3
    set(IKTab.Slider_Pos{j},'Enable','on');
    set(IKTab.Edit_Pos{j},'Enable','on');
    set(IKTab.Slider_Ori{j},'Enable','on');
    set(IKTab.Edit_Ori{j},'Enable','on');    
end

function UnactivateIK
global IKTab
for j=1:3
    set(IKTab.Slider_Pos{j},'Enable','off');
    set(IKTab.Edit_Pos{j},'Enable','off');
    set(IKTab.Slider_Ori{j},'Enable','off');
    set(IKTab.Edit_Ori{j},'Enable','off');    
end
