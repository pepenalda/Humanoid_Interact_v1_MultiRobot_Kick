function C_IKTab_PshBttn_AllTorquesOn

global IKTab

for i=1:18
    set(IKTab.RdBttn_Art{i},'Value',1);
end
all_torques_on;