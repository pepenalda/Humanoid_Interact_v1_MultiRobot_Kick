function TxString(String)
global Cnnct

len=length(String);
String=[String 13];
fwrite(Cnnct.SerialObject,String);