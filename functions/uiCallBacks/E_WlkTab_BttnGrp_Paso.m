function E_WlkTab_BttnGrp_Paso
global WlkTab
for i=1:7
    if i<7
        if strcmp(get(WlkTab.PnlsPrmtrs{i},'visible'),'on')
            j=i;
            ClickedBttnCALIB=WlkTab.PshBttnCALIB{j};
            E_WlkTab_PshBttnCALIB(ClickedBttnCALIB,0);
        end
    else
        if strcmp(get(WlkTab.PnlsPrmtrs{8},'visible'),'on')
            j=7;
            ClickedBttnCALIB=WlkTab.PshBttnCALIB{j};
            E_WlkTab_PshBttnCALIB(ClickedBttnCALIB,0);
        end        
    end
end