function PlotRBT(Eje)

global Robot

switch Robot.Name
    case 'Bioloid'
        bld_Plot(Eje);
    case 'Nao'
        nao_Plot(Eje);
    case 'Darwin'
        drwn_Plot(Eje);
    case 'KHR'
        khr_Plot(Eje);
end
