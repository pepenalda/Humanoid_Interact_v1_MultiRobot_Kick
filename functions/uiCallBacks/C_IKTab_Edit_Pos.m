function C_IKTab_Edit_Pos(Tag,String,PosOri)

global IKTab

xyzID=str2num(Tag);
Value=str2num(String);

%Actualizacion del slider correspondiente y el propio Edit
if PosOri ==1
    %Chequeo de los limites de x y z
    Min_xyz=get(IKTab.Slider_Pos{xyzID},'Min');
    Max_xyz=get(IKTab.Slider_Pos{xyzID},'Max');
    if Value < Min_xyz
        Value=Min_xyz;
    elseif Value > Max_xyz
        Value=Max_xyz;
    end
    num2str(Value,'%02.1f');
    set(IKTab.Slider_Pos{xyzID},'Value',Value);
    set(IKTab.Edit_Pos{xyzID},'String',num2str(Value,'%02.1f'));
else
    set(IKTab.Slider_Ori{xyzID},'Value',Value);
end
    
%Resuelve la cinematica inversa en Slider_Pos
C_IKTab_Slider_Pos(Tag,Value);