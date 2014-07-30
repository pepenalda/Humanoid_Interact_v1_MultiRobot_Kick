function D_MainFig_PshBttn_CnnctRbt
global Robot

if strcmp(Robot.Name,'Bioloid')
    String_1={'Toss Mode', '(Seral Cable or ZigBee)'};
    String_2={'Serial','\rm(Special Firmware)'};
    String_3={'Walk ZigBee','\rm(Special Firmware)'};

    Figure=dialog('Name','Connect to Bioloid','MenuBar','none','Toolbar','none','units','normalized',...
        'OuterPosition',[0.4 , 0.4, 0.4, 0.2]);
    uibutton('Parent',Figure, 'Style','pushbutton','units','normalized', 'Position',[0.08 0.4 0.25 0.3],...
        'Callback', 'closereq; G01_Message(1); ','String',String_1);

    uibutton('Parent',Figure, 'Style','pushbutton','units','normalized', 'Position',[0.4 0.4 0.20 0.3],...
        'Callback', 'closereq; G01_Message(2);','String',String_2,'enable','on');

    uibutton('Parent',Figure, 'Style','pushbutton','units','normalized', 'Position',[0.7 0.4 0.20 0.3],...
        'Callback', 'closereq; G01_Message(3);','String',String_3,'enable','on')
elseif strcmp(Robot.Name,'Nao')
    G01_Message_Nao;   
end
