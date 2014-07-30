function set_positions_speed(Positions, Indices, Speed)

N=length(Positions);
%N=18;   %Number of Dynamixels
L=4;    %Lenght of data to each dynamixel;
bParameterLength=(L+1)*N + 4;
gbpTxbuffer(1)=hex2dec('ff');   %header 01
gbpTxbuffer(2)=hex2dec('ff');   %header 01
gbpTxbuffer(3)=hex2dec('fe');   %Dynamixel ID: broadcast (0xfe)
gbpTxbuffer(4)=bParameterLength;
gbpTxbuffer(5)=hex2dec('83');   %Instruction : SYNC_WRITE
gbpTxbuffer(6)=30;              %Starting adress in table (30: Goal Position (L) )
gbpTxbuffer(7)=L;               %Length of Data to be written (4)

Count=Angle2Count(Positions);
Count=uint16(Count);
Count=typecast(Count,'uint8');

CountSpeed=Speed2Count(Speed);
CountSpeed16=uint16(CountSpeed);
CountSpeed8=typecast(CountSpeed16,'uint8');

index=0;
for i =1:N
    gbpTxbuffer(8+(5*index))=Indices(i);
    gbpTxbuffer(9+(5*index))=Count(1+(2*index));    %Goal Position (L)
    gbpTxbuffer(10+(5*index))=Count(2+(2*index));  	%Goal Position (H)
    gbpTxbuffer(11+(5*index))=CountSpeed8(1);       %Moving Speed (L)
    gbpTxbuffer(12+(5*index))=CountSpeed8(2);       %Moving Speed (H)
    index=index+1;
end
TxBuffer(gbpTxbuffer);