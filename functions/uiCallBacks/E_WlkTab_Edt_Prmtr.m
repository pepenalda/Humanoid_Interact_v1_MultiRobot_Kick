function E_WlkTab_Edt_Prmtr(Edit)

global WlkTab
global Walk
global Robot

Prnt=get(Edit,'Parent');
i_Edt=str2double(get(Edit,'tag'));

ActualValueEdit=str2num(get(Edit,'String'));

if Prnt==WlkTab.PNL_Values1
    Min=get(WlkTab.Slider_PRM_1{i_Edt},'Min');
    Max=get(WlkTab.Slider_PRM_1{i_Edt},'Max');
    SliderStep=get(WlkTab.Slider_PRM_1{i_Edt},'SliderStep')*(Max-Min);
    Value=round(ActualValueEdit/SliderStep(1))*SliderStep(1);

    set(WlkTab.Slider_PRM_1{i_Edt},'value',Value);
    Walk.Values_1(i_Edt)=Value;
    Walk.Values_4(i_Edt)=Value;
    %PlotBLD_Wlk(WlkTab.Axes);
elseif Prnt==WlkTab.PNL_Values4
    Min=get(WlkTab.Slider_PRM_4{i_Edt},'Min');
    Max=get(WlkTab.Slider_PRM_4{i_Edt},'Max');
    SliderStep=get(WlkTab.Slider_PRM_4{i_Edt},'SliderStep')*(Max-Min);
    Value=round(ActualValueEdit/SliderStep(1))*SliderStep(1);

    set(WlkTab.Slider_PRM_4{i_Edt},'value',Value);
    Walk.Values_4(i_Edt)=Value;
    %PlotBLD_Wlk(WlkTab.Axes);
    
elseif Prnt==WlkTab.PNL_Values2
    Min=get(WlkTab.Slider_PRM_2{i_Edt},'Min');
    Max=get(WlkTab.Slider_PRM_2{i_Edt},'Max');
    SliderStep=get(WlkTab.Slider_PRM_2{i_Edt},'SliderStep')*(Max-Min);
    Value=round(ActualValueEdit/SliderStep(1))*SliderStep(1);
    
    set(WlkTab.Slider_PRM_2{i_Edt},'value',Value);
    Walk.Values_2(i_Edt)=Value;
else
    Min=get(WlkTab.Slider_PRM_3{i_Edt},'Min');
    Max=get(WlkTab.Slider_PRM_3{i_Edt},'Max');
    SliderStep=get(WlkTab.Slider_PRM_3{i_Edt},'SliderStep')*(Max-Min);
    Value=round(ActualValueEdit/SliderStep(1))*SliderStep(1);
    
    set(WlkTab.Slider_PRM_3{i_Edt},'value',Value);
    Walk.Values_3(i_Edt)=Value;    
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