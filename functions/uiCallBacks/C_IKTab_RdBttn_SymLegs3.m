function C_IKTab_RdBttn_SymLegs3

global IKTab

hObject=IKTab.RdBttn_SymLegs3;
button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    set(IKTab.RdBttn_SymLegs1,'Value',get(IKTab.RdBttn_SymLegs1,'Min')); 
    set(IKTab.RdBttn_SymLegs2,'Value',get(IKTab.RdBttn_SymLegs2,'Min'));
end

C_IKTab_Slider_Pos('1',get(IKTab.Slider_Pos{1},'Value'));