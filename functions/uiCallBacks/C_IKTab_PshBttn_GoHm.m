function C_IKTab_PshBttn_GoHm

global Robot
global IKTab

vals=Robot.Ths_Hm;
Set_Ths_vrHumanoid(vals);

PlotRBT(IKTab.Axes)
