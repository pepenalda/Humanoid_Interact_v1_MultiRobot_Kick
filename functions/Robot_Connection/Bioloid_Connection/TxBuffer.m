function TxBuffer(buffer)
global Cnnct

len=length(buffer);
CheckSum=sum(buffer(3:len));

if CheckSum<=255
    CheckSum=uint8(CheckSum);
    buffer(len+1)=bitcmp(CheckSum);
else
    CheckSum = uint16(CheckSum);
    CheckSum16 = typecast(CheckSum,'uint8');
    buffer(len+1)=bitcmp(CheckSum16(1));
end
fwrite(Cnnct.SerialObject,buffer);