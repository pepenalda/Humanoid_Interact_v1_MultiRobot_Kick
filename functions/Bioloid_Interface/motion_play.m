function motion_play(Time,Motion)
global Serialo

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


T1=tic;
t=cputime;
for i=1:length(Time)
    Count=Motion(2*(i-1)+1,:);
    CountSpeed=Motion(2*(i-1)+2,:);
    index=0;
    for j =1:N
        gbpTxbuffer(8+(5*index))=j;
        gbpTxbuffer(9+(5*index))=Count(1+(2*index));            %Goal Position (L)
        gbpTxbuffer(10+(5*index))=Count(2+(2*index));           %Goal Position (H)
        gbpTxbuffer(11+(5*index))=CountSpeed(1+(2*index));    %Moving Speed (L)
        gbpTxbuffer(12+(5*index))=CountSpeed(2+(2*index));    %Moving Speed (H)
        index=index+1;
    end
    %TxBuffer(gbpTxbuffer);
    len=97;
    CheckSum=sum(gbpTxbuffer(3:len));
    if CheckSum<=255
        CheckSum=uint8(CheckSum);
        gbpTxbuffer(len+1)=bitcmp(CheckSum);
    else
        CheckSum = uint16(CheckSum);
        CheckSum16 = typecast(CheckSum,'uint8');
        gbpTxbuffer(len+1)=bitcmp(CheckSum16(1));
    end
    %pause(0.05);
    while (cputime-t<=Time(i))
    end
    fwrite(Serialo,gbpTxbuffer);
end
toc(T1)