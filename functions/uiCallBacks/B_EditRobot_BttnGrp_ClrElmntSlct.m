function B_EditRobot_BttnGrp_ClrElmntSlct
global VRMLTab

color=B_EditRobot_Fnc_GetPartColor(VRMLTab.BttnGrp_ClrsElmentSlct);
set(VRMLTab.uiPnl_ClrSmpl,'BackgroundColor',color);

