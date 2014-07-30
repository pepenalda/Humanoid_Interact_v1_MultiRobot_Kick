function C_IKTab_Slider_Vel(Value)

global IKTab
global Robot

if strcmp(Robot.Name,'Bioloid')
    set(IKTab.Edit_Vel,'String',num2str(Value,'%2.0f'));
elseif strcmp(Robot.Name,'Nao')
    set(IKTab.Edit_Vel,'String',num2str(Value,'%1.2f'));
end