function A00_Wlkm_BttnGrp_RbtSlct

global WlkmFgr_BttnGrp 
global Robot

selected=get(WlkmFgr_BttnGrp,'SelectedObject');
SlctdStrng=get(selected,'String');

switch SlctdStrng
    case 'Bioloid (Real and Virtual)'
        Robot.Name='Bioloid';
    case 'Nao (Real and Virtual)'
        Robot.Name='Nao';
    case 'Darwin (Virtual)'
        Robot.Name='Darwin';
    case 'KHR-3HV (Virtual)'
        Robot.Name='KHR';
end                                                                                                                                                                                                                                                                                                                                                                                                                                          