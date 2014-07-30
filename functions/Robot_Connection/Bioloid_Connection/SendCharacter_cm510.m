global SerialObject

clc

commandwindow
pause(1)

fprintf(SerialObject,'T');
%pause(0.01)
%data = fscanf(SerialObject)
data=fread(SerialObject);
ValuesReceived=get(SerialObject,'ValuesReceived')

text=char(data);
disp(text.')

%line=fgetl(SerialObject)
%data = fscanf(SerialObject)