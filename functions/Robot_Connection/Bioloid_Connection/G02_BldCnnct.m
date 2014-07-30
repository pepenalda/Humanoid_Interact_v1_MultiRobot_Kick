function G02_BldCnnct

global Cnnct
global PPup_Port PPup_Baudrate Ports StringBaudRate

Index=1;
try
    devs= winqueryreg('name', 'HKEY_LOCAL_MACHINE', 'HARDWARE\DEVICEMAP\SERIALCOMM');
    size(devs);
    for i=1:length(devs)
        dev=devs{i};
        Port=winqueryreg('HKEY_LOCAL_MACHINE', 'HARDWARE\DEVICEMAP\SERIALCOMM',dev);
        %if not(strcmp(Port,'COM7')) && not(strcmp(Port,'COM8'))
            Ports{Index}=Port;
            Index=Index+1;
        %end
    end    
catch
end

Connect=1;
if isempty(Ports)
    Figure=dialog('Name','Serial Port Connect','MenuBar','none','Toolbar','none','units','normalized',...
        'OuterPosition',[0.4 , 0.4, 0.2, 0.2]);    
    uibutton(  'Parent',Figure,'Style','text','units','normalized','Position',[0.1 0.7 0.25 0.15],'HorizontalAlignment','left', ...
        'String',{'There is no port to connect to robot, make','sure USB2Dynamixel is connected to PC',...
        'and try again (Connect Robot)'},'Backgroundcolor',get(Figure,'color'));  
    PshBttn_SrlPrt_Cncl = uicontrol('Parent',Figure, 'Style','pushbutton','units','normalized', 'Position',[0.4 0.15 0.2 0.2],...
        'Callback', 'closereq;','String','OK');    
    Connect=0;
end
StringBaudRate={'57600','115200','250000','2000000'};
if Connect
    %Create Figure and connect to serial port
    Cnnct.Figure_Cnnct=dialog('Name','Serial Port Connect','MenuBar','none','Toolbar','none','units','normalized',...
        'OuterPosition',[0.4 , 0.4, 0.2, 0.2]);
    uicontrol(  'Parent',Cnnct.Figure_Cnnct,'Style','text','units','normalized','Position',[0.1 0.7 0.25 0.15],'HorizontalAlignment','left', ...
        'String','Serial Ports:','Backgroundcolor',get(Cnnct.Figure_Cnnct,'color'));
    PPup_Port=uicontrol('style','popupmenu','Parent',Cnnct.Figure_Cnnct,'units','normalized','Position',[0.4 0.7 0.3 0.2],'String',Ports);
    switch Cnnct.CnnctnType
        case {1,2}
            uicontrol(  'Parent',Cnnct.Figure_Cnnct,'Style','text','units','normalized','Position',[0.1 0.5 0.25 0.15],'HorizontalAlignment','left', ...
                'String','BaudRate:','Backgroundcolor',get(Cnnct.Figure_Cnnct,'color'));
            PPup_Baudrate=uicontrol('style','popupmenu','Parent',Cnnct.Figure_Cnnct,'units','normalized',...
                'Position',[0.4 0.5 0.3 0.2],'String',StringBaudRate);
            uicontrol(  'Parent',Cnnct.Figure_Cnnct,'Style','text','units','normalized','Position',[0.75 0.5 0.25 0.15],'HorizontalAlignment','left', ...
                'String','bps','Backgroundcolor',get(Cnnct.Figure_Cnnct,'color'));  
            uicontrol(  'Parent',Cnnct.Figure_Cnnct,'Style','text','units','normalized','Position',[0.75 0.5 0.25 0.15],'HorizontalAlignment','left', ...
                'String','bps','Backgroundcolor',get(Cnnct.Figure_Cnnct,'color'));
            uicontrol('Parent',Cnnct.Figure_Cnnct, 'Style','pushbutton','units','normalized', 'Position',[0.1 0.15 0.35 0.2],...
                'Callback','G03_Serial_ZBee_Cnnct','String','Connect');
        case 3
            uicontrol('Parent',Cnnct.Figure_Cnnct, 'Style','pushbutton','units','normalized', 'Position',[0.1 0.15 0.35 0.2],...
                'Callback','G03_Serial_ZBee_Cnnct','String','Connect');            
    end
    uicontrol('Parent',Cnnct.Figure_Cnnct, 'Style','pushbutton','units','normalized', 'Position',[0.55 0.15 0.35 0.2],...
        'Callback', 'closereq;','String','Cancel');
end


