function C_IKTab_RdBttn_SymLegs1

global IKTab

hObject=IKTab.RdBttn_SymLegs1;
button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    set(IKTab.RdBttn_SymLegs2,'Value',get(IKTab.RdBttn_SymLegs2,'Min')); 
    set(IKTab.RdBttn_SymLegs3,'Value',get(IKTab.RdBttn_SymLegs3,'Min'));
end

C_IKTab_Slider_Pos('1',get(IKTab.Slider_Pos{1},'Value'));