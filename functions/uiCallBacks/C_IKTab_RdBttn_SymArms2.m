function C_IKTab_RdBttn_SymArms2

global IKTab

hObject=IKTab.RdBttn_SymArms2;
button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    set(IKTab.RdBttn_SymArms1,'Value',get(IKTab.RdBttn_SymArms1,'Min')); 
    set(IKTab.RdBttn_SymArms3,'Value',get(IKTab.RdBttn_SymArms3,'Min'));
end

C_IKTab_Slider_Pos('1',get(IKTab.Slider_Pos{1},'Value'));