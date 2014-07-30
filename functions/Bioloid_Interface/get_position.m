function Position=get_position(ID)

gbpTxbuffer(1)=hex2dec('ff');   %header 01
gbpTxbuffer(2)=hex2dec('ff');   %header 01
gbpTxbuffer(3)=ID;              %Dynamixel ID
gbpTxbuffer(4)=04;              %Length (4)
gbpTxbuffer(5)=02;              %Instruction : READ_DATA
gbpTxbuffer(6)=36;              %Starting adress in table (30: Goal Position (L) )
gbpTxbuffer(7)=2;               %read 2 bytes

[Error,Reply]=TxBufferR(gbpTxbuffer,2);
Count=Reply(1)+256*Reply(2);
Position=Count2Angle(Count);