function D_MainFig_PshBttn_RstPrts
global Strct_MainFigure
global Cnnct

obj=instrfind;

if not(isempty(obj))
    fclose(obj);
    delete(obj);
end
set(Strct_MainFigure.PshBttn_CnnctRbt,'enable','on');
set(Strct_MainFigure.PshBttn_DisCnnctRbt,'enable','off');
set(Strct_MainFigure.RdBttn_CnnctRbt,'String','Cnnctn Type');

if libisloaded('zigbee')
    PortChain=Cnnct.V1{1};
    val=str2num(PortChain(4));
    result=calllib('zigbee', 'zgb_initialize', val);
    calllib('zigbee', 'zgb_terminate');
    %result=calllib('zigbee', 'zgb_initialize', 5);
    pause(0.5);
    result=calllib('zigbee', 'zgb_initialize', 5)
end