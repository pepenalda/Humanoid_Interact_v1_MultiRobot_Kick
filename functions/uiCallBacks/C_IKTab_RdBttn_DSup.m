function C_IKTab_RdBttn_DSup

global Robot
global IKTab

hObject=IKTab.RdBttn_DSup;
button_state = get(hObject,'Value');

mlab_R_vrml=[0 0 1;
             1 0 0;
             0 1 0];
         
if button_state == 1
    set(IKTab.RdBttn_SupLeft,'Value',0); 
    set(IKTab.RdBttn_SupRight,'Value',0);
    if Robot.IK_Key==5
        activateIK
    else if Robot.IK_Key==3 | Robot.IK_Key==4
            UnactivateIK
        end
    end
else
    if Robot.IK_Key==5 | Robot.IK_Key==4 | Robot.IK_Key==3
        activateIK 
    end
    Robot.w_R_o=[1 0 0; 0 1 0; 0 0 1]; Robot.w_p_o=[0 0 31].';
    vrot=vrrotmat2vec(Robot.w_R_o);
    setfield(Robot.vrRobot,'translationHips',(mlab_R_vrml.'*Robot.w_p_o*10  ).');
    setfield(Robot.vrRobot,'rotationHips',vrot);    
    EqLegs=0;
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
