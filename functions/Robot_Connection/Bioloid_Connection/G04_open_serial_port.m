function G04_open_serial_port(Port,Baudrate)
global Cnnct

SerialObjectTest=instrfind;
if isempty(SerialObjectTest)
    Cnnct.SerialObject=serial(Port{1});
    Cnnct.SerialObject.Baudrate = str2num(Baudrate);  % Set the baud rate at 57600
    set(Cnnct.SerialObject, 'Parity', 'none') ;    % Set parity as none
    set(Cnnct.SerialObject, 'Databits', 8);        % set the number of data bits
    set(Cnnct.SerialObject, 'StopBits', 1);        % set number of stop bits as 1
    set(Cnnct.SerialObject, 'Timeout', 3);     % set timeout
    set(Cnnct.SerialObject, 'InputBufferSize', 10000);     % set terminator
    fopen(Cnnct.SerialObject);
else
    Cnnct.SerialObject=instrfind;
    Status=Cnnct.SerialObject.Status;
    if strcmp(Status,'open')
    else
        fopen(Cnnct.SerialObject);
    end
end
G06_Test_Connection;