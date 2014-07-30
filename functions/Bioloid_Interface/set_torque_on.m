function set_torque_on(ID)

global Cnnct
bParameterLength=2;
gbpTxbuffer(1)=hex2dec('ff');   %header 01
gbpTxbuffer(2)=hex2dec('ff');   %header 01
gbpTxbuffer(3)=ID;              %Dynamixel ID: broadcast (0xfe)
gbpTxbuffer(4)=bParameterLength+2; 
gbpTxbuffer(5)=03;              %Instruction : WRITE_DATA
gbpTxbuffer(6)=24;              %Starting adress in table (30: Goal Position (L) )
gbpTxbuffer(7)=hex2dec('1');    %Torque on

TxBuffer(gbpTxbuffer);
Status=fread(Cnnct.SerialObject,6,'uchar');