function set_all_positions_time(Positions, Time)

disp('set all positions time')
N=18;   %Number of Dynamixels
L=4;    %Lenght of data to each dynamixel;
bParameterLength=(L+1)*N + 4;
gbpTxbuffer(1)=hex2dec('ff');   %header 01
gbpTxbuffer(2)=hex2dec('ff');   %header 01
gbpTxbuffer(3)=hex2dec('fe');   %Dynamixel ID: broadcast (0xfe)
gbpTxbuffer(4)=bParameterLength;
gbpTxbuffer(5)=hex2dec('83');   %Instruction : SYNC_WRITE
gbpTxbuffer(6)=30;              %Starting adress in table (30: Goal Position (L) )
gbpTxbuffer(7)=L;               %Length of Data to be written (4)

Positions

Count=Angle2Count(Positions);
Count=uint16(Count);
Count=typecast(Count,'uint8');

Current_Positions=get_all_positions;
Speeds=get_speeds(Current_Positions, Positions, Time);

CountSpeeds=Speed2Count(Speeds);
CountSpeeds16=uint16(CountSpeeds);
CountSpeeds8=typecast(CountSpeeds16,'uint8');

index=0;
for i =1:N
    gbpTxbuffer(8+(5*index))=i;
    gbpTxbuffer(9+(5*index))=Count(1+(2*index));            %Goal Position (L)
    gbpTxbuffer(10+(5*index))=Count(2+(2*index));           %Goal Position (H)
    gbpTxbuffer(11+(5*index))=CountSpeeds8(1+(2*index));    %Moving Speed (L)
    gbpTxbuffer(12+(5*index))=CountSpeeds8(2+(2*index));    %Moving Speed (H)
    index=index+1;
end
TxBuffer(gbpTxbuffer);