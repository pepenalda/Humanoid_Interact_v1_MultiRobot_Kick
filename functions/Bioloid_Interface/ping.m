function reply=ping(ID)
global Cnnct

%Prepare the buffer for read instruction
gbpTxbuffer(1)=hex2dec('ff');   %header 01
gbpTxbuffer(2)=hex2dec('ff');   %header 01
gbpTxbuffer(3)=ID;               %Dynamixel ID: broadcast (0xfe)
gbpTxbuffer(4)=2;               %Length (4)
gbpTxbuffer(5)=1;       %Instruction : READ_DATA

len=length(gbpTxbuffer);
CheckSum=sum(gbpTxbuffer(3:len));
CheckSum=uint8(CheckSum);
gbpTxbuffer(len+1)=bitcmp(CheckSum);
fwrite(Cnnct.SerialObject,gbpTxbuffer);
try
    Var=fread(Cnnct.SerialObject,6,'uchar');
    if Var(3)==ID
        reply=1;
    else
        reply=0;
    end
catch
    %sprintf('problem reading serial');
    reply=0;
end

