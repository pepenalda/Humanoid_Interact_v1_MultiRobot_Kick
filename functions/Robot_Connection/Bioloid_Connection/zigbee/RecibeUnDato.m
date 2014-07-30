function [s,Dato]=RecibeUnDato

result=0;
Index_Zigbee=0;
while Index_Zigbee < 10
    result=calllib('zigbee','zgb_rx_check');
    if(result)
        s=1;
        Dato=calllib('zigbee','zgb_rx_data');
        break;
    else
        s=0;
        Dato='';
        Index_Zigbee=Index_Zigbee+1;
    end
end

% MaxIndex=50;
% RcvdData=0;
% Index=0;
% while(not(RcvdData))
%     if(calllib('zigbee','zgb_rx_check'))
%         RcvdData=1;
%         Dato=calllib('zigbee','zgb_rx_data');
%         break
%     end 
%     Index=Index+1;
%     if Index > MaxIndex
%         disp('OverTime ZigBee 01');
%         Dato=-1;
%         return
%     end
% end
% 
