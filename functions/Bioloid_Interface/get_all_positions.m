function Positions=get_all_positions
global Cnnct
clc

N=18;   %Number of Dynamixels
gbpTxbuffer=0;
data={};
%Prepare the buffer for read instruction
gbpTxbuffer(1)=hex2dec('ff');   %header 01
gbpTxbuffer(2)=hex2dec('ff');   %header 01
gbpTxbuffer(3)=1;               %Dynamixel ID: broadcast (0xfe)
gbpTxbuffer(4)=4;               %Length (4)
gbpTxbuffer(5)=hex2dec('02');   %Instruction : READ_DATA
gbpTxbuffer(6)=36;              %Starting adress in table (36: Present Position (L) )
gbpTxbuffer(7)=2;               %Length of Data to be read (2)

len=length(gbpTxbuffer);

%tic
%Change the ID of dynamixel, calc the CheckSum and Send the Instruction
%Save the replys in data array
for i =1:N
    gbpTxbuffer(3)=i;
    CheckSum=sum(gbpTxbuffer(3:len));
    CheckSum=uint8(CheckSum);
    gbpTxbuffer(len+1)=bitcmp(CheckSum);
    fwrite(Cnnct.SerialObject,gbpTxbuffer);
    try
        Var=fread(Cnnct.SerialObject,8,'uchar');
        %instrfind;
        %Var(8)=fread(Cnnct.SerialObject,1,'uchar');
    catch
        sprintf(1,'problem reading serial');
    end
    Var;
    if ne(Var(2),255)
        Counts(i)=Var(5)+256*Var(6);
    else
        Counts(i)=Var(6)+256*Var(7);
    end
end
%toc
Positions=Count2Angle(Counts);