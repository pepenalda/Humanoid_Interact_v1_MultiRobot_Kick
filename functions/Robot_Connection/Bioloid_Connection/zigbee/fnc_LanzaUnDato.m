function Result=fnc_LanzaUnDato(Dato)

result=calllib('zigbee', 'zgb_tx_data', int32(Dato));
if result==0
    disp('Failed to transmit');
    Result=0;
else
    s=sprintf('Dato: %s transmitted',num2str(Dato));
    disp(s);
    Result=1;
end