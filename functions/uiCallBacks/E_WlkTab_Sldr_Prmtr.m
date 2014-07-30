function E_WlkTab_Sldr_Prmtr(Slider)

global WlkTab
global Walk

Prnt=get(Slider,'Parent');
i_Sldr=str2double(get(Slider,'tag'));

ActualValueSlider=get(Slider,'Value');
Min=get(Slider,'Min');
Max=get(Slider,'Max');
SliderStep=get(Slider,'SliderStep')*(Max-Min);
Value=round(ActualValueSlider/SliderStep(1))*SliderStep(1);

if Prnt==WlkTab.PNL_Values1
    set(WlkTab.Edit_PRM_1{i_Sldr},'string',num2str(Value));
    Walk.Values_1(i_Sldr)=Value;
    Walk.Values_4(i_Sldr)=Value;
    Index=find(Walk.Frst_Indx{1}==i_Sldr);
    Walk.Values_3(Index)=Value;
    %PlotBLD_Wlk(WlkTab.Axes);
elseif Prnt==WlkTab.PNL_Values4
    set(WlkTab.Edit_PRM_4{i_Sldr},'string',num2str(Value));
    Walk.Values_4(i_Sldr)=Value;
    %PlotBLD_Wlk(WlkTab.Axes);    
elseif Prnt==WlkTab.PNL_Values2
    set(WlkTab.Edit_PRM_2{i_Sldr},'string',num2str(Value));
    Walk.Values_2(i_Sldr)=Value;
    Index=find(Walk.Frst_Indx{2}==i_Sldr)+9;
    Walk.Values_3(Index)=Value;
else
    set(WlkTab.Edit_PRM_3{i_Sldr},'string',num2str(Value));
    Walk.Values_3(i_Sldr)=Value;    
end

if Walk.Values_1(8) < 0 || Walk.Values_1(10) < 0
    set(WlkTab.uiPnl_RdBttnIzquierda,'Value',0);
    set(WlkTab.uiPnl_RdBttnDerecha,'Value',1);
    Robot.Drcha=1;
elseif Walk.Values_1(8) > 0 || Walk.Values_1(10) > 0
    set(WlkTab.uiPnl_RdBttnIzquierda,'Value',1);
    set(WlkTab.uiPnl_RdBttnDerecha,'Value',0);    
    Robot.Drcha=0;
end

PlotBLD_Wlk(WlkTab.Axes)