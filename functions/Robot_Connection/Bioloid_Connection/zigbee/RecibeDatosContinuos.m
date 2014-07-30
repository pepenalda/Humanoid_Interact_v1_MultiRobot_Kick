function Datos_Out=RecibeDatosContinuos(N)

disp('Recibiendo datos, espere...');
Receive=1;
Errors=0;
i=1;
while Errors < 100
    [s,Dato]=RecibeUnDato;
    if s
        Datos(i)=Dato;
        Errors=0;
        i=i+1;
        %s=sprintf('No. Datos received: %i received \r',i);
        %disp(s);
    else
        Errors=Errors+1;
    end
end
if exist('Datos','var')
    L=length(Datos);
    s=sprintf('%i datos recibidos \nProcesando datos... \n',L);
    disp(s);
    Indices=find(Datos==hex2dec('ffff'));
    Indice_Datos_R=1;
    Datos_R=[];
    for i=1:length(Indices)-15
        Dato_R=Datos(Indices(i):(Indices(i)+N+3));
        if (Indices(i+1)==Indices(i)+1)
        else
            Datos_R(Indice_Datos_R,:)=Datos(Indices(i+1):Indices(i+1)+N+3);
            Indice_Datos_R=Indice_Datos_R+1;
        end
    end
    [R C]=size(Datos_R);
    Indice_Datos_OK=1;
    for i=1:R
        if (Datos_R(i,1) == 65535) && (Datos_R(i,2) == 65535) && (Datos_R(i,3) == 65535)
            Datos_R_OK(Indice_Datos_OK,:)=Datos_R(i,4:3+N);
            Indice_Datos_OK=Indice_Datos_OK+1;
        end
    end
    Datos_Out=Datos_R_OK;    
else
    Datos_Out=0;
end