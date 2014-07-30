function close_serial_port
global SerialObject

fclose(Cnnct.SerialObject);
delete(Cnnct.SerialObject);
