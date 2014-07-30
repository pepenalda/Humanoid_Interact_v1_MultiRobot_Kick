function A000_Main
warning('off','MATLAB:atan2:complexArgument');
%warning('off','MATLAB:hg:uicontrol:ParameterValuesMustBeValid');
warning('off','instrument:fscanf:unsuccessfulRead');
p=genpath('functions');
addpath(p);
Initialize;
Create_Wlkm_Wndw;

function Initialize
clc
clear all
    close all force
    vrclose all
    vrclear('-force')

    global Robot

    %Default Robot 
    Robot.Name='Bioloid';
Robot.Connectable=1;

function Create_Wlkm_Wndw
global WlkmFgr_BttnGrp
WelcomeFigure = dialog(  'Units','Normalized','Position',[0.25 0.4 0.5 0.4],'Name', 'Humanoid Interact (Welcome!!!)','WindowStyle', 'normal',...
                 'CloseRequestFcn', 'closereq; A01_Load_Virtual_World;','Resize','on','WindowStyle', 'modal');
WlkmFgr_BttnGrp=uibuttongroup('Parent',WelcomeFigure ,'units','normalized','Title','Select a Robot:',...
    'position',[0.2 0.1 0.6 0.8],'SelectionChangeFcn','A00_Wlkm_BttnGrp_RbtSlct;','BorderType','none','FontSize',14);
%
Labels={'Bioloid (Real and Virtual)','Nao (Real and Virtual)','Darwin (Virtual)','KHR-3HV (Virtual)'};
for i=1:4
    WlkmFig_RbtRadioBttn{i} = uicontrol('Parent',WlkmFgr_BttnGrp,'Style','Radio','String',Labels{i},... 
        'units','normalized','Position',[0.3 0.8-(i-1)*.2 0.7 0.14],'FontSize',14,'Tag',num2str(i));
end
uicontrol('Parent',WelcomeFigure, 'Style','pushbutton','units','normalized', 'Position',[0.4 0.1 0.2 0.1],...
    'Callback', 'closereq; A01_Create_Robot;','String','OK','HorizontalAlignment','center','Fontsize',14);
