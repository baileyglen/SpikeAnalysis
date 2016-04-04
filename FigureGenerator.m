function [ ] = FigureGenerator( data )
%FIGUREGENERATOR Summary of this function goes here
%   Detailed explanation goes here
%% Setup Variables
ds = data.output.dataSet; %copy dataset for ease of use
VarList={'LL','RL'};
temp=[ 0    0.4470    0.7410;...
    0.8500    0.3250    0.0980;...
    0.9290    0.6940    0.1250;...
    0.4940    0.1840    0.5560];
newcmap = [temp(1,:);temp(3,:);temp(4,:);temp(2,:)];
if ~isempty(strfind(data.DataSet,'ISO')) ||...
        ~isempty(strfind(data.DataSet,'RfDel'))
    xAxisMinMax = [-2.8 2.8];
elseif  ~isempty(strfind(data.DataSet,'RfCon'))
    xAxisMinMax = [-2.8 13];
end
fontSize = 14;
renderer = '-painters';
%% overal means zscored - plotted as 1 plot

%VarList={'LL04','RL04','LL10','RL10'};
%PC = 4;
y=[];
tempy=[];
for varIDX=1:2
    tempy = ds.zScoreOverall(ds.Schedule==(VarList{varIDX}),:);
    y(:,varIDX)=nanmean(tempy);
    yStdErr(:,1,varIDX)=nanstd(tempy)./sqrt(size(tempy,1));
end
%%

fighandle=figure;
set(fighandle, 'Position', [100, 100, 400, 200]);
%newStdErr=permute(yStdErr,[1,2,3]);
[hl, hp]=boundedline(data.xA, y, yStdErr ,'cmap',newcmap);
%title(['Overall zscore']);

%legend (VarList{:});
set(hl,'linewidth',2.5);

axis([xAxisMinMax -.75 .95]);
set(gca,'YTick', [-.4 0 .4 .8]);
set(gca,'XTick', [-2 0 2 4 6 8 10 12]);

set(gca,'FontName','Calibri')
set(gca,'Linewidth',1);
set(gca,'FontSize',fontSize)

%     set(hl,'linewidth',2.2);
%     plot([-3 13],[0 0],'linestyle','-','color',[.5 .5 .5],'linewidth',.9);
%     
%     axis([xAxisMinMax -1.5 2.5]);
%     set(gca,'YTick', [-1 0 1 2]);
%     set(gca,'XTick', [-2 0 2 4 6 8 10 12 ]);
%     set(gca,'FontSize',fontSize)
%     set(gca,'FontName','Calibri')
%     set(gca,'Linewidth',.75);

axis on;
box on;


%     %subplot(2,1,condIDX);
%     plot(data.xA,y,'linewidth',2.5);
%     hold on
%     %plot(downsample(data.xA,1),downsample(y-yStdErr,1),'marker','.','markersize',3,'linestyle','none');
%     plot(downsample(data.xA,1),downsample(y-yStdErr,1),'marker','none','markersize',3,'linestyle',':','LineWidth',.5);
%     plot(downsample(data.xA,1),downsample(y+yStdErr,1),'marker','none','markersize',3,'linestyle',':','LineWidth',.5);
%     %plot(data.xA,y+yStdErr,'linestyle',':');
%     title(['Overall zscore']);
%     axis([-3 3 -1 1]);
%     legend (VarList{:});
export_fig (fighandle,[data.DataSet '_Overall.png'], renderer);

%% Inc and Dec
% Current Working!!!!

CondList={'increase','decrease'};
%TimeList={'Early','Extended'};
y=[];
yStdErr=[];
%newcmap = [temp(4,:);temp(2,:)];
newcmap = [temp(1,:);temp(3,:);temp(4,:);temp(2,:)];
for condIDX = 1:2
    
    
    %set(fighandle, 'Position', [100, 100, 202, 215]);
    
    for varIDX = 1:2
        tempy = ds.zScoreOverall( ...
            ds.Schedule       == (VarList{varIDX}) & ...
            ds.DPrimeCategory == (CondList{condIDX})    ,:);
        y(:,varIDX)=nanmean(tempy);
        yStdErr(:,1,varIDX)=nanstd(tempy)./sqrt(size(tempy,1));
        %         y(:,varIDX)=mean(data.(VarList{varIDX}).DPrime.First3.(CondList{condIDX}),1);
        %         yStdErr(:,1,varIDX)=std(data.(VarList{varIDX}).DPrime.First3.(CondList{condIDX}),1)/sqrt(size(data.(VarList{varIDX}).DPrime.First3.(CondList{condIDX}),1));
        %         %y(:,varIDX-2)=mean(data.(VarList{varIDX}).DPrime.First3.(CondList{condIDX}),1);
        %yStdErr(:,1,varIDX-2)=std(data.(VarList{varIDX}).DPrime.First3.(CondList{condIDX}),1)/sqrt(size(data.(VarList{varIDX}).DPrime.First3.(CondList{condIDX}),1));
    end
    
    fighandle=figure ('position',[100, 100, 400, 200]);%, 'outerposition',[90, 90, 250, 200]);
    %curAxes=axes('position', [0.1300    0.1100+(.5*x-1)    0.7750    0.3412]);
    %axisPos=get(gca, 'position');
    %set (gca,'position', [0.1300+(    0.1100    0.7750    0.3412]);
    %tempCmap=newcmap(timeIDX*2-1:timeIDX*2,:);
    %subplot('Position',[.2 .2 .63 .59]);
    
    [hl, hp]=boundedline(data.xA, y, yStdErr ,'cmap',newcmap);
    %set(gca,'position', [0.1300    0.1100+(.5*x-1)    0.7750    0.3412]);
    %axisPos=get(gca, 'position');
    %set(gca, 'position', [axisPos(1)-(~mod(condIDX,2)*.04) axisPos(2)+.07 axisPos(3) axisPos(4)]);
    
    %     if condIDX==1
    %         tmpStr='Increasing';
    %     else
    %         tmpStr='Decreasing';
    %     end
    %title(['Reinforcer Consumption Modulated Cells: ' tmpStr]);
    set(hl,'linewidth',2.2);
    plot([-3 13],[0 0],'linestyle','-','color',[.5 .5 .5],'linewidth',.9);
    
    axis([xAxisMinMax -1.5 2.5]);
    set(gca,'YTick', [-1 0 1 2]);
    set(gca,'XTick', [-2 0 2 4 6 8 10 12 ]);
    set(gca,'FontSize',fontSize)
    set(gca,'FontName','Calibri')
    set(gca,'Linewidth',.75);
    
    export_fig (fighandle, [data.DataSet '_' CondList{condIDX} '.png'], renderer);
    %h_legend=legend (VarList{:});
    %set(h_legend,'FontSize',8,'Orientation','horizontal','Location','best')
end




%% DPrimeSorting Heatmap
VarList={'LL','RL'};
%PC = 4;
fighandle=figure;
for varIDX=1:2
    set(gca,'DefaultTextFontSize',fontSize) % may not be working
    subplot(1,2,varIDX);
    
    tempds = ds(ds.Schedule==(VarList{varIDX}),:);
    tempds.diff = tempds.zScorePre-tempds.zScorePost;
    tempds = sortrows(tempds, 'diff','descend');
    y = tempds.zScoreOverall;
    
    %yStdErr(:,1,varIDX)=nanstd(tempy)./sqrt(size(tempy,1));

    
    
    
%     tempy= zscore(data.(VarList{varIDX}).MlMtx')';
    set(fighandle, 'Position', [100, 100, 400, 200]);
    %set(gca,'DefaultTextFontSize',18+varIDX*2)
    imagesc(data.xA,1:size(y,1),y,[-2 2]);
    %title(['DPrime sorted: ' VarList{varIDX}]);
    axis([xAxisMinMax .5 size(y,1)+.5]);
    axisPos=get(gca, 'position');
    set(gca, 'position', [axisPos(1)-(~mod(varIDX,2)*.02) axisPos(2)+((varIDX<=2)*.02) axisPos(3)/1.08 axisPos(4)]);
    set(gca,'YTick',[1 size(y,1)])
    set(gca,'FontSize',fontSize)
    set(gca,'FontName','Calibri')
end
axes('cLim',[-2 2],'Position', [.1 .1 .9 .9], 'Visible', 'off');
cb=colorbar('location', 'East','YAxisLocation','right');
%set(cbar_handle, 'YAxisLocation','right')
cbPos=get(cb, 'position');
set(cb, 'position', [cbPos(1)+.03 cbPos(2)-.025 cbPos(3)/5 cbPos(4)]);
set(cb,'FontSize',fontSize)
set(cb,'FontName','Calibri')
export_fig (2,fighandle, [data.DataSet '_Heatmap.png'], renderer);

end
