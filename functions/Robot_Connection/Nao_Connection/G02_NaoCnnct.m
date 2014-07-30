function G02_NaoCnnct
global Cnnct

RobotIP=Cnnct.NaoIP;
tts = ALTextToSpeechProxy(RobotIP,9559);
Success=1;
try
    tts.say('Conectado a');
    tts.setLanguage('English');
    tts.say('Humanoid   Interact');
    tts.setLanguage('Spanish');
catch
    Success=0;
end

Figure=dialog('Name','Nao Conection status','MenuBar','none','Toolbar','none','units','normalized',...
    'OuterPosition',[0.4 , 0.4, 0.2, 0.2]);
if Success
    uibutton(  'Parent',Figure,'Style','text','units','normalized','Position',[0.1 0.7 0.25 0.15],'HorizontalAlignment','left', ...
    'String',{'Succesfully connected to Nao with IP',RobotIP},'Backgroundcolor',get(Figure,'color'));
    Cnnct.CnnctnType=1;
    G07_ActivateCnnct_Elements
else
    uibutton(  'Parent',Figure,'Style','text','units','normalized','Position',[0.1 0.7 0.25 0.15],'HorizontalAlignment','left', ...
    'String',{'A problem accured while trying to connect to Nao','Make sure Nao is abalable at IP:',RobotIP},'Backgroundcolor',get(Figure,'color'));
    Cnnct.CnnctnType=0;
end
PshBttn_SrlPrt_Cncl = uicontrol('Parent',Figure, 'Style','pushbutton','units','normalized', 'Position',[0.4 0.15 0.2 0.2],...
    'Callback', 'closereq;','String','OK');
