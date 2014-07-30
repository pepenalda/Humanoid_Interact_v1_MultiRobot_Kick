function all_torques_on()
global Cnnct

if Cnnct.CnnctnType==1
    N=18;   %Number of Dynamixels
    L=1;    %Lenght of data to each dynamixel;
    bParameterLength=(L+1)*N + 4;
    gbpTxbuffer(1)=hex2dec('ff');   %header 01
    gbpTxbuffer(2)=hex2dec('ff');   %header 01
    gbpTxbuffer(3)=hex2dec('fe');   %Dynamixel ID: broadcast (0xfe)
    gbpTxbuffer(4)=bParameterLength;
    gbpTxbuffer(5)=hex2dec('83');   %Instruction : SYNC_WRITE
    gbpTxbuffer(6)=24;              %Starting adress in table (24: Torque Enable)
    gbpTxbuffer(7)=1;               %Length of Data to be written (1)

    index=0;
    for i =1:N
        gbpTxbuffer(8+(2*index))=i;
        gbpTxbuffer(9+(2*index))=uint8(1);
        index=index+1;
    end
    TxBuffer(gbpTxbuffer);
else
    TxString('all_torques_on');
end
