function E_WlkTab_PshBttn_Kick(PushButton)
global Robot
global WlkTab

State=get(PushButton,'value');

if State==0
    Robot.Kick=0;
else
    Robot.Kick=1;
end

PlotBLD_Wlk(WlkTab.Axes)