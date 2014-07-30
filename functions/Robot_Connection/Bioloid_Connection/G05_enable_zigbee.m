function G05_enable_zigbee(Port)

if not (libisloaded('zigbee'))
     loadlibrary('zigbee', 'zigbee.h');
end

pause(0.5);
PortChain=Port{1};
val=str2num(PortChain(4));
result=calllib('zigbee', 'zgb_initialize', val);
G07_ActivateCnnct_Elements;

