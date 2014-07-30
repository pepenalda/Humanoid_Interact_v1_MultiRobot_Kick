function C_IKTab_Ppup_IKExtrmty
global Robot
global IKTab


Robot.IK_Key=get(IKTab.Ppup_IKExtremity,'Value');
if strcmp(Robot.Name,'Bioloid')
    ID_Motors_RightArm=[1 3 5];
    ID_Motors_LeftArm=[2 4 6];
    ID_Motors_RightLeg=[7 9 11 13 15 17];
    ID_Motors_LeftLeg=[8 10 12 14 16 18];
    ID_Motors_BothLegs=[7 8 9 10 11 12 13 14 15 16 17 18];
elseif strcmp(Robot.Name,'Nao')
    ID_Motors_RightArm=[9 10 11 12 13 14];
    ID_Motors_LeftArm=[3 4 5 6 7 8];
    ID_Motors_RightLeg=[21 22 23 24 25 26];
    ID_Motors_LeftLeg=[15 16 17 18 19 20];
    ID_Motors_BothLegs=[15 16 17 18 19 20 21 22 23 24 25 26];
end
for i=1:Robot.N;
    set(IKTab.TxtMtrNmbr{i},'FontWeight','normal');
end

switch Robot.IK_Key
    case 1
        ID_Motors=ID_Motors_RightArm;
        for i=1:3
            set(IKTab.Txt_Ori1{i},'Visible','off');
            set(IKTab.Slider_Ori{i},'Visible','off');
        end
        activateIKHands
    case 2
        ID_Motors=ID_Motors_LeftArm;
        for i=1:3
            set(IKTab.Txt_Ori1{i},'Visible','off');
            set(IKTab.Slider_Ori{i},'Visible','off');
        end     
        activateIKHands
    case 3
        ID_Motors=ID_Motors_RightLeg;
        if get(IKTab.RdBttn_SupLeft,'Value')==get(IKTab.RdBttn_SupLeft,'Max')
            %activateIK_SupRight;
            activateIK;
        elseif get(IKTab.RdBttn_SupRight,'Value')==get(IKTab.RdBttn_SupRight,'Max')
            UnactivateIK;
        elseif get(IKTab.RdBttn_DSup,'Value')==get(IKTab.RdBttn_DSup,'Max')
            %activateIK_SupLeft;
            UnactivateIK;
        else
            activateIK;
        end          
        for i=1:3
            set(IKTab.Txt_Ori1{i},'Visible','on');
            set(IKTab.Slider_Ori{i},'Visible','on');
        end        
    case 4
        ID_Motors=ID_Motors_LeftLeg;
        if get(IKTab.RdBttn_SupLeft,'Value')==get(IKTab.RdBttn_SupLeft,'Max')
            %activateIK_SupLeft;
            UnactivateIK;
        elseif get(IKTab.RdBttn_SupRight,'Value')==get(IKTab.RdBttn_SupRight,'Max')
            activateIK;
        elseif get(IKTab.RdBttn_DSup,'Value')==get(IKTab.RdBttn_DSup,'Max')
            %activateIK_SupLeft;
            UnactivateIK;
        else
            activateIK;
        end        
        for i=1:3
            set(IKTab.Txt_Ori1{i},'Visible','on');
            set(IKTab.Slider_Ori{i},'Visible','on');
        end        
    case 5
        if get(IKTab.RdBttn_SupLeft,'Value')==get(IKTab.RdBttn_SupLeft,'Max')
            ID_Motors=ID_Motors_LeftLeg;
            activateIK;
        elseif get(IKTab.RdBttn_SupRight,'Value')==get(IKTab.RdBttn_SupRight,'Max')
            ID_Motors=ID_Motors_RightLeg;
            activateIK;
        elseif get(IKTab.RdBttn_DSup,'Value')==get(IKTab.RdBttn_DSup,'Max')
            ID_Motors=ID_Motors_LeftLeg;
            activateIK;
        else
            ID_Motors=ID_Motors_BothLegs;
            UnactivateIK;
        end
        for i=1:3
            set(IKTab.Txt_Ori1{i},'Visible','on');
            set(IKTab.Slider_Ori{i},'Visible','on');
        end                
end

for i=1:length(ID_Motors);
    set(IKTab.TxtMtrNmbr{ID_Motors(i)},'FontWeight','bold');
end
PlotRBT(IKTab.Axes)

function activateIKHands
global IKTab
for j=1:3
    set(IKTab.Slider_Pos{j},'Enable','on');
    set(IKTab.Edit_Pos{j},'Enable','on');
    set(IKTab.Edit_Ori{j},'Enable','off'); 
end

function activateIK
global IKTab
for j=1:3
    set(IKTab.Slider_Pos{j},'Enable','on');
    set(IKTab.Edit_Pos{j},'Enable','on');
    set(IKTab.Slider_Ori{j},'Enable','on');
    set(IKTab.Edit_Ori{j},'Enable','on');    
end

function UnactivateIK
global IKTab
for j=1:3
    set(IKTab.Slider_Pos{j},'Enable','off');
    set(IKTab.Edit_Pos{j},'Enable','off');
    set(IKTab.Slider_Ori{j},'Enable','off');
end

function activateIK_SupLeft
global IKTab
for j=1:2
    set(IKTab.Slider_Pos{j},'Enable','on');
    set(IKTab.Edit_Pos{j},'Enable','on');
end

function activateIK_SupRight
global IKTab
for j=1:2
    set(IKTab.Slider_Pos{j},'Enable','on');
    set(IKTab.Edit_Pos{j},'Enable','on');
end
