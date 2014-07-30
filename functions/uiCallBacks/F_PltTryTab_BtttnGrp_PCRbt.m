function F_PltTryTab_BtttnGrp_PCRbt

global PltTryTab WlkTab
global RR_TrayWalk
global RR_Walking

selected=get(PltTryTab.BttnGrp_PC_Robot,'SelectedObject');
SlctdStrng=get(selected,'String');
Value=1;
Value1=1;
String_Group=get(PltTryTab.PpUp_Grupo,'String');
Indice=get(PltTryTab.PpUp_Grupo,'Value');
String_GroupSelected=String_Group{Indice};
switch SlctdStrng
    case 'PC'
        if strcmp(String_GroupSelected,'Angulos Deseados') || strcmp(String_GroupSelected,'Angulos Deseados Motor') ...
                || strcmp(String_GroupSelected,'Angulos Reales') || strcmp(String_GroupSelected,'Cargas Reales')
            Value=2;    
        elseif strcmp(String_GroupSelected,'Pelvis Coord.')
            Value=3;
        elseif strcmp(String_GroupSelected,'Right Foot Coord.')
            Value=4;
        elseif strcmp(String_GroupSelected,'Left Foot Coord.')
            Value=5;            
        end
        set(PltTryTab.PpUp_Grupo,'String',{'Time','Angles','Pelvis Coord. ','Right Foot Coord.','Left Foot Coord.'});
        set(PltTryTab.PpUp_Grupo,'Value',Value);
        if Value==2
            for i=1:18
                ElemntStr{i}=['Th' num2str(i)];
            end
            set(PltTryTab.PpUp_Elemento,'String',ElemntStr);            
        else
            StringE={'x','y','z','Alabeo','Cabeceo','Guiñada'};
            set(PltTryTab.PpUp_Elemento,'String',StringE);
        end
        set(PltTryTab.PpUp_Elemento,'Value',get(PltTryTab.PpUp_Elemento,'Value')-1);
    case 'Robot'
        String=[];
        i=1;
        if isfield(RR_TrayWalk,'thsDes')
            String{i}='Des. Angles';
            i=i+1;
        end        
        if isfield(RR_TrayWalk,'thsDesMot')
            String{i}='Des. Angles Motor';
            i=i+1;
        end
        if isfield(RR_TrayWalk,'thsReal')
            String{i}='Real Angles';
            i=i+1;
        end        
        if isfield(RR_TrayWalk,'Load')
            String{i}='Motor Load';
            i=i+1;
        end                
        if isfield(RR_TrayWalk,'P_x')
            String{i}='Pelvis Coord.';
            i_CoordPelvis=i;
            i=i+1;
            
        end
        if isfield(RR_TrayWalk,'Rf_x')
            String{i}='Right Foot Coord.';
            i_CoordPieDer=i;
            i=i+1;
        end
        if isfield(RR_TrayWalk,'Lf_x')
            String{i}='Left Foot Coord.';
            i_CoordPieIzq=i;
            i=i+1;
        end 
        if isempty(String)
            set(PltTryTab.RdBttn_PC,'Value',1);
            set(PltTryTab.RdBttn_Rbt,'Value',0);
            StringError={'\bf{No robot data:}','\rm Execute WLK with sensing option.'};
            Figure1=dialog('Name','No robot data','WindowStyle', 'modal','MenuBar','none','Toolbar','none','units','normalized',...
                'OuterPosition',[0.4 , 0.4, 0.3, 0.25]);
            uibutton('Parent',Figure1, 'Style','text','units','normalized', 'Position',[0.2 0.35 0.6 0.6],...
                'String',StringError,'HorizontalAlignment','center');
            uicontrol('Parent',Figure1, 'Style','pushbutton','units','normalized', 'Position',[0.4 0.08 0.2 0.15],...
                'Callback', 'closereq; ','String','ok','HorizontalAlignment','center','Fontsize',10);            
        else
            String_Group=get(PltTryTab.PpUp_Grupo,'String');
            Indice=get(PltTryTab.PpUp_Grupo,'Value');
            String_GroupSelected=String_Group{Indice};
            if strcmp(String_GroupSelected,'Pelvis Coord. ') && isfield(RR_TrayWalk,'P_x')
                set(PltTryTab.PpUp_Grupo,'Value',i_CoordPelvis);
            elseif strcmp(String_GroupSelected,'Right Foot Coord.') && isfield(RR_TrayWalk,'Rf_x')
                set(PltTryTab.PpUp_Grupo,'Value',i_CoordPieDer);
            elseif strcmp(String_GroupSelected,'Left Foot Coord.') && isfield(RR_TrayWalk,'Lf_x')
                set(PltTryTab.PpUp_Grupo,'Value',i_CoordPieIzq);
            else
                set(PltTryTab.PpUp_Grupo,'Value',1);
            end
            set(PltTryTab.PpUp_Grupo,'String',String);
            StringTest=String{get(PltTryTab.PpUp_Grupo,'Value')};
            if strcmp(StringTest,'Angulos Deseados') || strcmp(StringTest,'Angulos Deseados Motor') || strcmp(StringTest,'Angulos Reales')
                StringE{1}='Time';
                for i=1:18
                    StringE{i+1}=['Th' num2str(i)];
                end
                set(PltTryTab.PpUp_Elemento,'String',StringE);
                set(PltTryTab.PpUp_Elemento,'Value',get(PltTryTab.PpUp_Elemento,'Value')+1);
            elseif strcmp(StringTest,'Motor Load')
                StringE{1}='Time';
                for i=1:18
                    StringE{i+1}=['Motor' num2str(i)];
                end
                set(PltTryTab.PpUp_Elemento,'String',StringE);
            else
                StringE={'Time','x','y','z','phi','th','psi'};
                set(PltTryTab.PpUp_Elemento,'String',StringE);
                set(PltTryTab.PpUp_Elemento,'Value',get(PltTryTab.PpUp_Elemento,'Value')+1);                
            end
        end
        end

                
                    
            