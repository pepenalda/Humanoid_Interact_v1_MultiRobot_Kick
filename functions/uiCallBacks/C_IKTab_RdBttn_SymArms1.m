function C_IKTab_RdBttn_SymArms

global IKTab

hObject=IKTab.RdBttn_SymArms1;
button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    set(IKTab.RdBttn_SymArms2,'Value',get(IKTab.RdBttn_SymArms2,'Min')); 
    set(IKTab.RdBttn_SymArms3,'Value',get(IKTab.RdBttn_SymArms3,'Min'));
end

C_IKTab_Slider_Pos('1',get(IKTab.Slider_Pos{1},'Value'));