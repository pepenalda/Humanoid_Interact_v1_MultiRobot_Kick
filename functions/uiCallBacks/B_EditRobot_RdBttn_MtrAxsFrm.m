function B_EditRobot_RdBttn_MtrAxsFrm(Button)

global VRMLTab
global Robot

selected=get(Button,'String');
slectedNum=str2double(selected);
for i=1:18
    if ne(i,slectedNum)
        set(VRMLTab.RdBtn_MtrFrm{i},'Value',0);
    end
end
selectedAxsFrm=get(VRMLTab.BttnGrp_AxsFrm,'SelectedObject');
SlctdStrngAxsFrm=get(selectedAxsFrm,'String');
if strcmp(SlctdStrngAxsFrm,'Frame')
    Value=getfield(Robot.vrRobot,['transparency_Frame' num2str(slectedNum)]);
elseif strcmp(SlctdStrngAxsFrm,'Axis')
    Value=getfield(Robot.vrRobot,['transparency_Axis' num2str(slectedNum)]);
else
    Value=getfield(Robot.vrRobot,['transparency_CoM' num2str(slectedNum)]);
end
set(VRMLTab.Slder_TrsprncyValue,'Value',Value);
set(VRMLTab.Edt_TrsprncyValue,'String',num2str(Value,'%1.3f'));

% 
% SlctdStrng=get(selected,'String');
% 
% switch SlctdStrng
%     case 'One'
%         for i=1:18
%             set(EditRobotTab.RdBtn_MtrFrm{i},'Enable','on');
%             if ne(i,1)
%                 set(EditRobotTab.RdBtn_MtrFrm{i},'Value',0);
%             end
%         end
%     case 'All'
%         for i=1:18
%             set(EditRobotTab.RdBtn_MtrFrm{i},'Enable','off');
%             set(EditRobotTab.RdBtn_MtrFrm{i},'Value',1);
%         end        
% end