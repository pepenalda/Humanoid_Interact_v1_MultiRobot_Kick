function set_all_limits(Min_Angles, Max_Angles)

N=18;   %Number of Dynamixels
L=4;    %Lenght of data to each dynamixel;
bParameterLength=(L+1)*N + 4;
gbpTxbuffer(1)=hex2dec('ff');   %header 01
gbpTxbuffer(2)=hex2dec('ff');   %header 01
gbpTxbuffer(3)=hex2dec('fe');   %Dynamixel ID: broadcast (0xfe)
gbpTxbuffer(4)=bParameterLength;
gbpTxbuffer(5)=hex2dec('83');   %Instruction : SYNC_WRITE
gbpTxbuffer(6)=6;               %Starting adress in table (6: CW Angle Limit (L) )
gbpTxbuffer(7)=L;               %Length of Data to be written (4)

Count_Min=Angle2Count(Min_Angles);
Count_Min16=uint16(Count_Min);
Count_Min8=typecast(Count_Min16,'uint8');

Count_Max=Angle2Count(Max_Angles);
Count_Max16=uint16(Count_Max);
Count_Max8=typecast(Count_Max16,'uint8');

index=0;
for i =1:N
    gbpTxbuffer(8+(5*index))=i;
    gbpTxbuffer(9+(5*index))=Count_Min8(1+(2*index));   %Min Angle Limit(L)
    gbpTxbuffer(10+(5*index))=Count_Min8(2+(2*index));  %Min Angle Limit(H)
    gbpTxbuffer(11+(5*index))=Count_Max8(1+(2*index));  %Max Angle Limit(L)
    gbpTxbuffer(12+(5*index))=Count_Max8(2+(2*index));  %Max Angle Limit(H)
    index=index+1;
end
TxBuffer(gbpTxbuffer);