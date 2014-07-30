function C_IKTab_PshBttn_GoZs

global Robot
global IKTab

vals=Robot.Ths_Zs;
Set_Ths_vrHumanoid(vals);

PlotRBT(IKTab.Axes)
