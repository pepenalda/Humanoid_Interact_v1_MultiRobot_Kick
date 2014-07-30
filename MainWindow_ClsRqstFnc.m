function InteractClsRqstFnc

warning('off','MATLAB:rmpath:DirNotFound');

D_MainFig_PshBttn_RstPrts;
obj=instrfind;
if not(isempty(obj))
    fclose(obj);
    delete(obj);
end
if libisloaded('zigbee')
    calllib('zigbee', 'zgb_terminate');
    unloadlibrary('zigbee');
end

try
    p=genpath('functions');
    rmpath(p);
    close(HumRob_vrmlWorld); 
    delete(HumRob_vrmlWorld);     
end

clear all;
vrclose all
vrclear('-force')
closereq;
