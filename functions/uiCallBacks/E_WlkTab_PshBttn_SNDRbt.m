function E_WlkTab_PshBttn_SNDRbt()
global WlkTab
global Walk

if strcmp(get(WlkTab.PNL_Values3,'visible'),'on')
    PrmsKey=3;
elseif strcmp(get(WlkTab.PNL_Values4,'visible'),'on')
    PrmsKey=4;
elseif strcmp(get(WlkTab.PNL_Values2,'visible'),'on')
    PrmsKey=2;
else
    PrmsKey=1;
end

fnc_LanzaUnDato('s');
switch PrmsKey
    case 1
        fnc_LanzaUnDato('a');
        Vector=Walk.Values_1;
        Types=Walk.Types_1;
        sendVector(Vector,Types);
    case 2
        fnc_LanzaUnDato('b');
        Vector=Walk.Values_2;
        Types=Walk.Types_2;
        sendVector(Vector,Types);
    case 3
        fnc_LanzaUnDato('c');
        Vector=Walk.Values_3;
        Types=Walk.Types_3;
        sendVector(Vector,Types);        
    case 4
        fnc_LanzaUnDato('d');
        Vector=Walk.Values_4;
        Types=Walk.Types_4;
        sendVector(Vector,Types);
end

function sendVector(Vector,Types)
for i=1:length(Vector)
    if strcmp(Types(i),'i')
        fnc_LanzaUnDato(Vector(i));
    else
        value=round(Vector(i)*10);
        fnc_LanzaUnDato(value);
    end
end