function C_IKTab_RdBttn_IKMvRbt(IKTab,Tag)

Panel=str2num(Tag);
hObject=IKTab.RdBttn_IKMvRbt{Panel};
button_state = get(hObject,'Value');

IDs{1}=[1 3 5];
IDs{2}=[2 4 6];
IDs{3}=[7 9 11 13 15 17];
IDs{4}=[8 10 12 14 16 18];

if button_state == get(hObject,'Max');
    for i=1:length(IDs{Panel})
        set(IKTab.RdBttn_Art{IDs{Panel}(i)},'Value',get(IKTab.RdBttn_Art{IDs{Panel}(i)},'Max'));
        set_torque_on(IDs{Panel}(i));
    end
    if get(IKTab.RdBttn_SymArms1,'Value')==get(IKTab.RdBttn_SymArms1,'Max') || get(IKTab.RdBttn_SymArms2,'Value')==get(IKTab.RdBttn_SymArms2,'Max') || get(IKTab.RdBttn_SymArms3,'Value')==get(IKTab.RdBttn_SymArms3,'Max')
        if Panel==1
            set(IKTab.RdBttn_IKMvRbt{2},'Value',get(IKTab.RdBttn_IKMvRbt{2},'Max'));
            for i=1:length(IDs{2})
                set(IKTab.RdBttn_Art{IDs{2}(i)},'Value',get(IKTab.RdBttn_Art{IDs{2}(i)},'Max'));
                set_torque_on(IDs{2}(i));
            end            
        elseif Panel ==2
            set(IKTab.RdBttn_IKMvRbt{1},'Value',get(IKTab.RdBttn_IKMvRbt{1},'Max'));
            for i=1:length(IDs{1})
                set(IKTab.RdBttn_Art{IDs{1}(i)},'Value',get(IKTab.RdBttn_Art{IDs{1}(i)},'Max'));
                set_torque_on(IDs{1}(i));
            end                        
        end
    end
    if get(IKTab.RdBttn_SymLegs1,'Value')==get(IKTab.RdBttn_SymLegs1,'Max') || get(IKTab.RdBttn_SymLegs2,'Value')==get(IKTab.RdBttn_SymLegs2,'Max') || get(IKTab.RdBttn_SymLegs3,'Value')==get(IKTab.RdBttn_SymLegs3,'Max')
        if Panel==3
            set(IKTab.RdBttn_IKMvRbt{4},'Value',get(IKTab.RdBttn_IKMvRbt{4},'Max'));
            for i=1:length(IDs{4})
                set(IKTab.RdBttn_Art{IDs{4}(i)},'Value',get(IKTab.RdBttn_Art{IDs{4}(i)},'Max'));
                set_torque_on(IDs{4}(i));
            end                                    
        elseif Panel ==4
            set(IKTab.RdBttn_IKMvRbt{3},'Value',get(IKTab.RdBttn_IKMvRbt{3},'Max'));
            for i=1:length(IDs{3})
                set(IKTab.RdBttn_Art{IDs{3}(i)},'Value',get(IKTab.RdBttn_Art{IDs{3}(i)},'Max'));
                set_torque_on(IDs{3}(i));
            end                                                
        end
    end    
elseif button_state == get(hObject,'Min')
    for i=1:length(IDs{Panel})
        set(IKTab.RdBttn_Art{IDs{Panel}(i)},'Value',get(IKTab.RdBttn_Art{IDs{Panel}(i)},'Min'));
        set_torque_off(IDs{Panel}(i));
    end    
    if get(IKTab.RdBttn_SymArms1,'Value')==get(IKTab.RdBttn_SymArms1,'Max') || get(IKTab.RdBttn_SymArms2,'Value')==get(IKTab.RdBttn_SymArms2,'Max') || get(IKTab.RdBttn_SymArms3,'Value')==get(IKTab.RdBttn_SymArms3,'Max')
        if Panel==1
            set(IKTab.RdBttn_IKMvRbt{2},'Value',get(IKTab.RdBttn_IKMvRbt{2},'Min'));
            for i=1:length(IDs{2})
                set(IKTab.RdBttn_Art{IDs{2}(i)},'Value',get(IKTab.RdBttn_Art{IDs{2}(i)},'Min'));
                set_torque_off(IDs{2}(i));
            end                
        elseif Panel ==2
            set(IKTab.RdBttn_IKMvRbt{1},'Value',get(IKTab.RdBttn_IKMvRbt{1},'Min'));
            for i=1:length(IDs{1})
                set(IKTab.RdBttn_Art{IDs{1}(i)},'Value',get(IKTab.RdBttn_Art{IDs{1}(i)},'Min'));
                set_torque_off(IDs{1}(i));
            end                            
        end        
    end
    if get(IKTab.RdBttn_SymLegs1,'Value')==get(IKTab.RdBttn_SymLegs1,'Max') || get(IKTab.RdBttn_SymLegs2,'Value')==get(IKTab.RdBttn_SymLegs2,'Max') || get(IKTab.RdBttn_SymLegs3,'Value')==get(IKTab.RdBttn_SymLegs3,'Max')
        if Panel==3
            set(IKTab.RdBttn_IKMvRbt{4},'Value',get(IKTab.RdBttn_IKMvRbt{4},'Min'));
            for i=1:length(IDs{4})
                set(IKTab.RdBttn_Art{IDs{4}(i)},'Value',get(IKTab.RdBttn_Art{IDs{4}(i)},'Min'));
                set_torque_off(IDs{4}(i));
            end                                        
        elseif Panel ==4
            set(IKTab.RdBttn_IKMvRbt{3},'Value',get(IKTab.RdBttn_IKMvRbt{3},'Min'));
            for i=1:length(IDs{3})
                set(IKTab.RdBttn_Art{IDs{3}(i)},'Value',get(IKTab.RdBttn_Art{IDs{3}(i)},'Min'));
                set_torque_off(IDs{3}(i));
            end                                                    
        end        
    end    
end