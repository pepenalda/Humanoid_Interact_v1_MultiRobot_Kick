function G01_Message(CnnctnType_IN)

global Cnnct
Cnnct.CnnctnType=CnnctnType_IN;

String{1}={'\bf{Toss Mode:}','\rm  Instal default firmware to cm-510 (RoboPlus Manager)',...
    'Connect via USB2Dynamixel (RS-232) and Serial Cable','','Put cm-510 in Toss Mode:',...
    'Send ''T'' with cm510 in MANAGE Menu (RoboPlus Terminal)','Disconnect from RoboPlus Terminal to realease port','','Is posiible to work in this mode using Zigbee!!!'};
String{2}={'Serial Port connection with CM-510 / CM-530 having','','special adapted \bf{Firmware}','', '\rm Install and execute the firmware'};
String{3}={'\bf{Walk Zig Bee:}','\rm  Install and execute','\bf{Walking firmware} \rm to cm-510 (RoboPlus Terminal)',...
    'Connect: USB2Dynamixel -> Zig 100 | Zig 100 -> cm-510 '};

Figure1=dialog('Name','Connect to Bioloid','MenuBar','none','Toolbar','none','units','normalized',...
    'OuterPosition',[0.4 , 0.4, 0.3, 0.25]);
uibutton('Parent',Figure1, 'Style','text','units','normalized', 'Position',[0.2 0.35 0.6 0.6],...
    'String',String{CnnctnType_IN},'HorizontalAlignment','center');
uicontrol('Parent',Figure1, 'Style','pushbutton','units','normalized', 'Position',[0.4 0.08 0.2 0.15],...
    'Callback', 'closereq; G02_BldCnnct;','String','OK','HorizontalAlignment','center','Fontsize',10);
