function G03_Serial_ZBee_Cnnct
global Cnnct
global PPup_Port PPup_Baudrate Ports StringBaudRate

V1=Ports(get(PPup_Port,'value'));
Cnnct.V1=V1;
G05_enable_zigbee(V1); 
Cnnct.Port=V1;
close(Cnnct.Figure_Cnnct);