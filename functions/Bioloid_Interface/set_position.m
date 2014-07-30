function set_position(ID,Position)

global Cnnct

Count=Angle2Count(Position);
Count16=uint16(Count);
Count8=typecast(Count16,'uint8');

bParameterLength=5;
gbpTxbuffer(1)=hex2dec('ff');   %header 01
gbpTxbuffer(2)=hex2dec('ff');   %header 01
gbpTxbuffer(3)=ID;              %Dynamixel ID: broadcast (0xfe)
gbpTxbuffer(4)=bParameterLength+2; 
gbpTxbuffer(5)=03;              %Instruction : WRITE_DATA
gbpTxbuffer(6)=30;              %Starting adress in table (30: Goal Position (L) )
gbpTxbuffer(7)=Count8(1);       %Goal Position (L)
gbpTxbuffer(8)=Count8(2);       %Goal Position (H)
gbpTxbuffer(9)=50;              %Moving Speed (L)
gbpTxbuffer(10)=0;              %Moving Speed (H)

TxBuffer(gbpTxbuffer);
Status=fread(Cnnct.SerialObject,6,'uchar');