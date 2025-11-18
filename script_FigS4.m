% Script for Figure S4
% Created on Nov 17 2025 
% @author:Tomohiko Takei

clear all
close all
addpath('Violinplot')

%% Data loading
filePath = 'data/';
load([filePath,'data_FigS4.mat']);

% color setting
co1 = [ 0           0.45        0.74;
        0.85        0.33        0.1;
        0.94        0.45        0.66   
        ];

figure;
%% Fig. S4A
nhistPSF_sp_e    = hist(nPSF_sp_e,1:8);
nhistPSF_sp_e(5) = sum(nhistPSF_sp_e(5:8));nhistPSF_sp_e(6:8)=[];
nhistPSF_cx_e    = hist(nPSF_cx_e,1:8);
nhistPSF_cx_e(5) = sum(nhistPSF_cx_e(5:8));nhistPSF_cx_e(6:8)=[];
nhistPSF_cx_s    = hist(nPSF_cx_s,1:8);
nhistPSF_cx_s(5) = sum(nhistPSF_cx_s(5:8));nhistPSF_cx_s(6:8)=[];

% ttest
[ttesstPSF_h_e,ttestPSF_p_e,ttestPSF_cl_e,ttestPSF_stats_e]=ttest2(nPSF_sp_e,nPSF_cx_e,0.05,'both','equal');
[ttesstPSF_h_s,ttestPSF_p_s,ttestPSF_cl_s,ttestPSF_stats_s]=ttest2(nPSF_sp_e,nPSF_cx_s,0.05,'both','equal');

phistPSF_sp_e = nhistPSF_sp_e/(sum(nhistPSF_sp_e))*100;
phistPSF_cx_e = nhistPSF_cx_e/(sum(nhistPSF_cx_e))*100;
phistPSF_cx_s = nhistPSF_cx_s/(sum(nhistPSF_cx_s))*100;

hAx = subplot(4,4,[1,2]);
h=bar(1:5,[phistPSF_sp_e;phistPSF_cx_e;phistPSF_cx_s]',1);
YLims       = [0,90];
PlotHight   = [70,90,80];
set(hAx,'YLim',YLims,'TickDir','out','Box','off','XTick',1:5,'XTickLabel',{'1','2','3','4','≥5'})
set(h(1),'FaceColor',co1(1,:))
set(h(2),'FaceColor',co1(2,:))
set(h(3),'FaceColor',co1(3,:))
hold on
plot(hAx,[-sem(nPSF_sp_e),0,sem(nPSF_sp_e)]+mean(nPSF_sp_e),ones(1,3)*PlotHight(1),'k-')
plot(hAx,[-sem(nPSF_cx_e),0,sem(nPSF_cx_e)]+mean(nPSF_cx_e),ones(1,3)*PlotHight(2),'k-')
plot(hAx,[-sem(nPSF_cx_s),0,sem(nPSF_cx_s)]+mean(nPSF_cx_s),ones(1,3)*PlotHight(3),'k-')
plot(hAx,mean(nPSF_sp_e),PlotHight(1),'ko','MarkerFaceColor',co1(1,:),'MarkerSize',15)
plot(hAx,mean(nPSF_cx_e),PlotHight(2),'ko','MarkerFaceColor',co1(2,:),'MarkerSize',15)
plot(hAx,mean(nPSF_cx_s),PlotHight(3),'ko','MarkerFaceColor',co1(3,:),'MarkerSize',15)
xlabel(hAx,'Muscle field size'),ylabel(hAx,'Number of cells (%)')
title({'Muscle field size',...
    ['t(',num2str(ttestPSF_stats_e.df,'%.2f'),')=',num2str(ttestPSF_stats_e.tstat,'%.2f'),', p=',num2str(ttestPSF_p_e)],...
    ['t(',num2str(ttestPSF_stats_s.df,'%.2f'),')=',num2str(ttestPSF_stats_s.tstat,'%.2f'),', p=',num2str(ttestPSF_p_s)]})
disp([num2str(mean(nPSF_sp_e)),' + ',num2str(std(nPSF_sp_e)),' vs ',num2str(mean(nPSF_cx_e)),' + ',num2str(std(nPSF_cx_e))])
disp([num2str(mean(nPSF_sp_e)),' + ',num2str(std(nPSF_sp_e)),' vs ',num2str(mean(nPSF_cx_s)),' + ',num2str(std(nPSF_cx_s))])

%% Fig. S4B
% violin plot for onset latency
hAx = subplot(4,4,3);
data_sp_e     = latency_sp_e;
data_cx_e     = latency_cx_e;
data_cx_s     = latency_cx_s;
[ttesst_h_e,ttest_p_e,ttest_cl_e,ttest_stats_e]=ttest2(data_sp_e,data_cx_e,0.05,'both','unequal');
[ttesst_h_s,ttest_p_s,ttest_cl_s,ttest_stats_s]=ttest2(data_sp_e,data_cx_s,0.05,'both','unequal');
data.grp1 = data_sp_e; data.grp2 = data_cx_e; data.grp3 = data_cx_s;
hV1=violinplot(data);
for ihV=1:length(hV1)
    hV1(ihV).ViolinColor    = {co1(ihV,:)};
    hV1(ihV).BoxColor       = co1(ihV,:);
    hV1(ihV).ShowMean       = true;
    hV1(ihV).ShowMedian     = false;
    hV1(ihV).ShowWhiskers   = false;
    hV1(ihV).ScatterPlot(1).MarkerFaceAlpha = 0.3;
end
set(hAx,'TickDir','out','Box','off','XTick',1:3,'XTickLabel',{'PreM(MoE)','CM(MoE)','CM(MoS)'})
% axis(hAx,'square')
title({'Onset latency (ms)',...
    ['t(',num2str(ttest_stats_e.df,'%.2f'),')=',num2str(ttest_stats_e.tstat,'%.2f'),', p=',num2str(ttest_p_e)],...
    ['t(',num2str(ttest_stats_s.df,'%.2f'),')=',num2str(ttest_stats_s.tstat,'%.2f'),', p=',num2str(ttest_p_s)]})

%% Fig. S4C
% violin plot for MPI
hAx = subplot(4,4,4);
data_sp_e     = mpi_sp_e;
data_cx_e     = mpi_cx_e;
data_cx_s     = mpi_cx_s;
[ttesst_h_e,ttest_p_e,ttest_cl_e,ttest_stats_e]=ttest2(data_sp_e,data_cx_e,0.05,'both','unequal');
[ttesst_h_s,ttest_p_s,ttest_cl_s,ttest_stats_s]=ttest2(data_sp_e,data_cx_s,0.05,'both','unequal');
data.grp1 = data_sp_e; data.grp2 = data_cx_e; data.grp3 = data_cx_s;
hV1=violinplot(data);
for ihV=1:length(hV1)
    hV1(ihV).ViolinColor    = {co1(ihV,:)};
    hV1(ihV).BoxColor       = co1(ihV,:);
    hV1(ihV).ShowMean       = true;
    hV1(ihV).ShowMedian     = false;
    hV1(ihV).ShowWhiskers   = false;
    hV1(ihV).ScatterPlot(1).MarkerFaceAlpha = 0.3;
end
set(hAx,'TickDir','out','Box','off','XTick',1:3,'XTickLabel',{'PreM(MoE)','CM(MoE)','CM(MoS)'})
% axis(hAx,'square')
title({'MPI (%)',...
    ['t(',num2str(ttest_stats_e.df,'%.2f'),')=',num2str(ttest_stats_e.tstat,'%.2f'),', p=',num2str(ttest_p_e)],...
    ['t(',num2str(ttest_stats_s.df,'%.2f'),')=',num2str(ttest_stats_s.tstat,'%.2f'),', p=',num2str(ttest_p_s)]})


%% Fig. S4D
% violin plot for Rmax
hAx = subplot(4,4,5);
data_sp_e = rmax_sp_e;
data_cx_e = rmax_cx_e;
data_cx_s = rmax_cx_s;
[ttesst_h_e,ttest_p_e,ttest_cl_e,ttest_stats_e] = ttest2(r2z(data_sp_e),r2z(data_cx_e),0.05,'both','unequal');
[ttesst_h_s,ttest_p_s,ttest_cl_s,ttest_stats_s]   = ttest2(r2z(data_sp_e),r2z(data_cx_s),0.05,'both','unequal');
data.grp1 = data_sp_e; data.grp2 = data_cx_e; data.grp3 = data_cx_s;
hV1=violinplot(data);
for ihV=1:length(hV1)
    hV1(ihV).ViolinColor    = {co1(ihV,:)};
    hV1(ihV).BoxColor       = co1(ihV,:);
    hV1(ihV).ShowMean       = true;
    hV1(ihV).ShowMedian     = false;
    hV1(ihV).ShowWhiskers   = false;
    hV1(ihV).ScatterPlot(1).MarkerFaceAlpha = 0.3;
end
hold(hAx,'on')
plot(hAx,[0 4],[0 0],'k:');
xlim(hAx,[0.6 3.4]),ylim(hAx,[-0.4,1.0])
set(hAx,'TickDir','out','Box','off','XTick',1:3,'XTickLabel',{'PreM(MonE)','CM(MonE)','CM(MonS)'})
% axis(hAx,'square')
title({'Rmax',...
    [' t(',num2str(ttest_stats_e.df,'%.2f'),')=',num2str(ttest_stats_e.tstat,'%.2f'),', p=',num2str(ttest_p_e)],...
    [' t(',num2str(ttest_stats_s.df,'%.2f'),')=',num2str(ttest_stats_s.tstat,'%.2f'),', p=',num2str(ttest_p_s)]})

%% Fig. S4E
% violin plot for lag
hAx = subplot(4,4,6);
data_sp_e = lag_sp_e;
data_cx_e = lag_cx_e;
data_cx_s = lag_cx_s;
[ttesst_h_e,ttest_p_e,ttest_cl_e,ttest_stats_e] = ttest2(data_sp_e,data_cx_e,0.05,'both','unequal');
[ttesst_h_s,ttest_p_s,ttest_cl_s,ttest_stats_s] = ttest2(data_sp_e,data_cx_s,0.05,'both','unequal');
data.grp1 = data_sp_e; data.grp2 = data_cx_e; data.grp3 = data_cx_s;
hV1=violinplot(data);
for ihV=1:length(hV1)
    hV1(ihV).ViolinColor    = {co1(ihV,:)};
    hV1(ihV).BoxColor       = co1(ihV,:);
    hV1(ihV).ShowMean       = true;
    hV1(ihV).ShowMedian     = false;
    hV1(ihV).ShowWhiskers   = false;
    hV1(ihV).ScatterPlot(1).MarkerFaceAlpha = 0.3;
end
hold(hAx,'on')
plot(hAx,[0 4],[0 0],'k:');
xlim(hAx,[0.6 3.4]),ylim(hAx,[-1.0,1.0])
set(hAx,'TickDir','out','Box','off','XTick',1:3,'XTickLabel',{'PreM(MonE)','CM(MonE)','CM(MonS)'})
% axis(hAx,'square')
title({'Lag (s)',...
    [' t(',num2str(ttest_stats_e.df,'%.2f'),')=',num2str(ttest_stats_e.tstat,'%.2f'),', p=',num2str(ttest_p_e)],...
    [' t(',num2str(ttest_stats_s.df,'%.2f'),')=',num2str(ttest_stats_s.tstat,'%.2f'),', p=',num2str(ttest_p_s)]})

%% Fig.S4F
% violin plot for %contribution (neuron-muscle pairs)
hAx = subplot(4,4,7); 
data_sp_e = pcont_muscle_sp_e;
data_cx_e = pcont_muscle_cx_e;
data_cx_s = pcont_muscle_cx_s;

[ttesst_h_muscle_e,ttest_p_muscle_e,ttest_cl_muscle_e,ttest_stats_muscle_e]=ttest2(data_sp_e,data_cx_e,0.05,'both','unequal');
[ttesst_h_muscle_s,ttest_p_muscle_s,ttest_cl_muscle_s,ttest_stats_muscle_s]=ttest2(data_sp_e,data_cx_s,0.05,'both','unequal');

data.grp1 = data_sp_e; data.grp2 = data_cx_e; data.grp3 = data_cx_s;
hV1=violinplot(data);
for ihV=1:length(hV1)
    hV1(ihV).ViolinColor    = {co1(ihV,:)};
    hV1(ihV).BoxColor       = co1(ihV,:);
    hV1(ihV).ShowMean       = true;
    hV1(ihV).ShowMedian     = false;
    hV1(ihV).ShowWhiskers   = false;
    hV1(ihV).ScatterPlot(1).MarkerFaceAlpha = 0.3;
end
hold(hAx,'on')
plot(hAx,[0 4],[0 0],'k:');
xlim(hAx,[0.6 3.4]),ylim(hAx,[-1.0,4.0])
set(hAx,'TickDir','out','Box','off','XTick',1:3,'XTickLabel',{'PreM(MonE)','CM(MonE)','CM(MonS)'})
% axis(hAx,'square')
title({'%Contribution(muscles)',...
    ['t(',num2str(ttest_stats_muscle_e.df,'%.2f'),')=',num2str(ttest_stats_muscle_e.tstat,'%.2f'),', p=',num2str(ttest_p_muscle_e)],...
    ['t(',num2str(ttest_stats_muscle_s.df,'%.2f'),')=',num2str(ttest_stats_muscle_s.tstat,'%.2f'),', p=',num2str(ttest_p_muscle_s)]})

%% Fig.S4G 
% violin plot for %contribution individual cells
hAx = subplot(4,4,8); 
data_sp_e = pcont_cell_sp_e;
data_cx_e = pcont_cell_cx_e;
data_cx_s = pcont_cell_cx_s;

[ttesst_h_cell_e,ttest_p_cell_e,ttest_cl_cell_e,ttest_stats_cell_e]=ttest2(data_sp_e,data_cx_e,0.05,'both','unequal');
[ttesst_h_cell_s,ttest_p_cell_s,ttest_cl_cell_s,ttest_stats_cell_s]=ttest2(data_sp_e,data_cx_s,0.05,'both','unequal');

data.grp1 = data_sp_e; data.grp2 = data_cx_e; data.grp3 = data_cx_s;
hV1=violinplot(data);
for ihV=1:length(hV1)
    hV1(ihV).ViolinColor    = {co1(ihV,:)};
    hV1(ihV).BoxColor       = co1(ihV,:);
    hV1(ihV).ShowMean       = true;
    hV1(ihV).ShowMedian     = false;
    hV1(ihV).ShowWhiskers   = false;
    hV1(ihV).ScatterPlot(1).MarkerFaceAlpha = 0.3;
end
hold(hAx,'on')
plot(hAx,[0 4],[0 0],'k:');
xlim(hAx,[0.6 3.4]),ylim(hAx,[-0.2,0.8])
set(hAx,'TickDir','out','Box','off','XTick',1:3,'XTickLabel',{'PreM(MonE)','CM(MonE)','CM(MonS)'})
% axis(hAx,'square')
title({'%Contribution(cells)',...
    ['t(',num2str(ttest_stats_cell_e.df,'%.2f'),')=',num2str(ttest_stats_cell_e.tstat,'%.2f'),', p=',num2str(ttest_p_cell_e)],...
    ['t(',num2str(ttest_stats_cell_s.df,'%.2f'),')=',num2str(ttest_stats_cell_s.tstat,'%.2f'),', p=',num2str(ttest_p_cell_s)]})

%% Fig.S4H
% scatterplot of correlation with residual vs synergy for PreM-INs 
hAx = subplot(4,4,9); 
data_sp_e = [corr_residual_sp_e,corr_synergy_sp_e];
plot(hAx,data_sp_e(:,1),data_sp_e(:,2),'o','LineStyle','none','MarkerEdgeColor','none','MarkerFaceColor',co1(1,:))
hold on
plot(hAx,[-1,1],[-1,1],'k:')
xlim(hAx,[-1.0 1.0]),ylim(hAx,[-1.0,1.0])
set(hAx,'TickDir','out','Box','on')
axis(hAx,'square')
ylabel(hAx,'Corr with synergy'),xlabel(hAx,'Corr with residual')
[ttesst_h_sp_e,ttest_p_sp_e,ttest_cl_sp_e,ttest_stats_sp_e]=ttest(r2z(data_sp_e(:,1)),r2z(data_sp_e(:,2)),0.05,'both');
title({'PreM-IN (MonE)',['t(',num2str(ttest_stats_sp_e.df,'%.2f'),')=',num2str(ttest_stats_sp_e.tstat,'%.2f'),', sp_p=',num2str(ttest_p_sp_e)]})

%% Fig.S4I
% scatterplot of correlation with residual vs synergy for CM cells 
hAx = subplot(4,4,10); 
data_cx_e = [corr_residual_cx_e,corr_synergy_cx_e];
plot(hAx,data_cx_e(:,1),data_cx_e(:,2),'o','LineStyle','none','MarkerEdgeColor','none','MarkerFaceColor',co1(2,:))
hold on
plot(hAx,[-1,1],[-1,1],'k:')
xlim(hAx,[-1.0 1.0]),ylim(hAx,[-1.0,1.0])
set(hAx,'TickDir','out','Box','on')
axis(hAx,'square')
ylabel(hAx,'Corr with synergy'),xlabel(hAx,'Corr with residual')
[ttesst_h_cx_e,ttestx_p_cx_e,ttest_cl_cx_e,ttest_stats_cx_e]=ttest(r2z(data_cx_e(:,1)),r2z(data_cx_e(:,2)),0.05,'both');
title({'CM cell (MonE)',['t(',num2str(ttest_stats_cx_e.df,'%.2f'),')=',num2str(ttest_stats_cx_e.tstat,'%.2f'),', cx_p=',num2str(ttestx_p_cx_e)]})

%% Fig.S4J
% scatterplot of correlation with residual vs synergy for CM cells 
hAx = subplot(4,4,11); 
data_cx_s = [corr_residual_cx_s,corr_synergy_cx_s];
plot(hAx,data_cx_s(:,1),data_cx_s(:,2),'o','LineStyle','none','MarkerEdgeColor','none','MarkerFaceColor',co1(2,:))
hold on
plot(hAx,[-1,1],[-1,1],'k:')
xlim(hAx,[-1.0 1.0]),ylim(hAx,[-1.0,1.0])
set(hAx,'TickDir','out','Box','on')
axis(hAx,'square')
ylabel(hAx,'Corr with synergy'),xlabel(hAx,'Corr with residual')
[ttesst_h_cx_s,ttestx_p_cx_s,ttest_cl_cx_s,ttest_stats_cx_s]=ttest(r2z(data_cx_s(:,1)),r2z(data_cx_s(:,2)),0.05,'both');
title({'CM cell (MonS)',['t(',num2str(ttest_stats_cx_s.df,'%.2f'),')=',num2str(ttest_stats_cx_s.tstat,'%.2f'),', cx_p=',num2str(ttestx_p_cx_s)]})

%% Fig.S4K
% Preferred Index
data_sp_e  = r2z(corr_residual_sp_e)-r2z(corr_synergy_sp_e);
data_cx_e  = r2z(corr_residual_cx_e)-r2z(corr_synergy_cx_e);
data_cx_s  = r2z(corr_residual_cx_s)-r2z(corr_synergy_cx_s);

[ttesst_h_e,ttest_p_e,ttest_cl_e,ttest_stats_e]=ttest2(data_sp_e,data_cx_e,0.05,'both','unequal');
[ttesst_h_s,ttest_p_s,ttest_cl_s,ttest_stats_s]=ttest2(data_sp_e,data_cx_s,0.05,'both','unequal');

hist_x      = -4.0:0.4:4.0;
hist_sp_e   = hist(data_sp_e,hist_x);
hist_cx_e   = hist(data_cx_e,hist_x);
hist_cx_s   = hist(data_cx_s,hist_x);
binwidth    = hist_x(2)-hist_x(1);

hAx = subplot(4,4,13);
bar(hAx,hist_x+binwidth/2,hist_sp_e,1,'FaceColor',co1(1,:),'EdgeColor','none');
hold(hAx,'on')
stairs(hAx,hist_x,hist_sp_e,'Color','k');
plot(hAx,[0,0],[0,10],'k:')
xlim(hAx,[-5 5]),ylim(hAx,[0,10])
set(hAx,'TickDir','out','Box','off')
axis(hAx,'square')
xlabel(hAx,'Preference index'),ylabel(hAx,'Counts')
title({'PreM-IN (MonE)'})

%% Fig.S4L
hAx = subplot(4,4,14);
bar(hAx,hist_x+binwidth/2,hist_cx_e,1,'FaceColor',co1(2,:),'EdgeColor','none');
hold(hAx,'on')
stairs(hAx,hist_x,hist_cx_e,'Color','k');
plot(hAx,[0,0],[0,10],'k:')
xlim(hAx,[-5 5]),ylim(hAx,[0,10])
set(hAx,'TickDir','out','Box','off')
axis(hAx,'square')
xlabel(hAx,'Preference index'),ylabel(hAx,'Counts')
title({'CM cell(MonE)',['t(',num2str(ttest_stats_e.df,'%.2f'),')=',num2str(ttest_stats_e.tstat,'%.2f'),', p=',num2str(ttest_p_e)]})

%% Fig.S4M
hAx = subplot(4,4,15);
bar(hAx,hist_x+binwidth/2,hist_cx_s,1,'FaceColor',co1(2,:),'EdgeColor','none');
hold(hAx,'on')
stairs(hAx,hist_x,hist_cx_s,'Color','k');
plot(hAx,[0,0],[0,10],'k:')
xlim(hAx,[-5 5]),ylim(hAx,[0,10])
set(hAx,'TickDir','out','Box','off')
axis(hAx,'square')
xlabel(hAx,'Preference index'),ylabel(hAx,'Counts')
title({'CM cell (MonE)',['t(',num2str(ttest_stats_s.df,'%.2f'),')=',num2str(ttest_stats_s.tstat,'%.2f'),', p=',num2str(ttest_p_s)]})
