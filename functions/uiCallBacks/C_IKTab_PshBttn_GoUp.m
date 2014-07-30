function C_IKTab_PshBttn_GoUp

global Robot
global IKTab

vals=Robot.Ths_Up;
Set_Ths_vrHumanoid(vals);

PlotRBT(IKTab.Axes)
