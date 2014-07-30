function C_IKTab_PshBttn_AllTorquesOff

global IKTab

for i=1:18
    set(IKTab.RdBttn_Art{i},'Value',0);  
end
set(IKTab.RdBttn_IKMvRbt,'Value',0);
all_torques_off