function Datos=RecibeDatos(N)
%N=18
for i=1:N
    [s,Dato]=RecibeUnDato;
    if s==0
        disp('fallo en la recepción');
        Datos=[];
        Datos=0;
        break;
    else
        Datos(i)=Dato;
    end
end
if Datos==0
else
    DatosStr='';
    for i=1:length(Datos)
        DatosStr=[DatosStr ' | ' num2str(Datos(i))];
    end
    DatosStr=[DatosStr ' | ' ];
    s=sprintf('Datos: %s received',DatosStr);
    disp(s);
end

Flag=0;
NDatosExtra=10;
for i=1:NDatosExtra
    [s,Dato]=RecibeUnDato;
    if s==0
        DatosExt=[];
        DatosExt=0;
        break;
    else
        disp('Datos Extra en el Buffer:');
        DatosExtra(i)=Dato;
        Flag=1
    end
end

DatosExtraStr=[];
if Flag==1
    for i=1:length(DatosExtra)
        DatosExtraStr=[DatosExtraStr ' | ' ];
    end
    s=sprintf('DatosExtra: %s received',DatosExtraStr);
    disp(s);
end