% Script for Figure 2
% Created on Nov 17 2025 
% @author:Tomohiko Takei

clear all
close all
addpath('Violinplot')

%% Data loading
filePath = 'data/';
load([filePath,'data_Fig2.mat']);

% color setting
co1 = [ 0           0.45        0.74;
        0.85        0.33        0.1;
        0.94        0.45        0.66   
        ];

figure;
%% Fig. 2E
% scatter plot for PreM-INs
hAx = subplot(2,2,1);
data_sp = [lag_sp,rmax_sp];
plot(hAx,data_sp(:,1),data_sp(:,2),'o','MarkerEdgeColor',co1(1,:),'MarkerFaceColor',co1(1,:),'MarkerSize',5)
hold(hAx,'on')
plot(hAx,[-1.0 1.0],[0 0],'k:',[0 0],[-1.0 1.0],'k:');
xlim(hAx,[-1.0 1.0]),ylim(hAx,[-0.4,1.0])
set(gca,'TickDir','out','Box','on','XTick',-1:0.5:1,'YTick',-0.4:0.2:1.0)
axis(hAx,'square')
title('PreM-IN')

%% Fig. 2F
% scatter plot for CM cells
hAx = subplot(2,2,2);
data_cx = [lag_cx,rmax_cx];
plot(hAx,data_cx(:,1),data_cx(:,2),'o','MarkerEdgeColor',co1(2,:),'MarkerFaceColor',co1(2,:),'MarkerSize',5)
hold(hAx,'on')
plot(hAx,[-1.0 1.0],[0 0],'k:',[0 0],[-1.0 1.0],'k:');
xlim(hAx,[-1.0 1.0]),ylim(hAx,[-0.4,1.0])
set(gca,'TickDir','out','Box','on','XTick',-1:0.5:1,'YTick',-0.4:0.2:1.0)
axis(hAx,'square')
title('CM cell')

%% Fig. 2G
% violin plot for Rmax
hAx = subplot(2,2,3);
data_sp = rmax_sp;
data_cx = rmax_cx;
[ttesst_h,ttest_p,ttest_cl,ttest_stats]=ttest2(r2z(data_sp),r2z(data_cx),0.05,'both','unequal');
data.grp1 = data_sp; data.grp2 = data_cx;
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
plot(hAx,[0 3],[0 0],'k:');
xlim(hAx,[0.6 2.4]),ylim(hAx,[-0.4,1.0])
set(gca,'TickDir','out','Box','off','XTick',1:2,'XTickLabel',{'PreM-IN','CM cell'})
axis(hAx,'square')
ylabel(hAx,'Rmax'),xlabel(hAx,'Lag (s)')
title({'Rmax',['t(',num2str(ttest_stats.df,'%.2f'),')=',num2str(ttest_stats.tstat,'%.2f'),', p=',num2str(ttest_p)]})

%% Fig. 2H
% violin plot for lag
hAx = subplot(2,2,4);
data_sp = lag_sp;
data_cx = lag_cx;
[ttesst_h,ttest_p,ttest_cl,ttest_stats]=ttest2(data_sp,data_cx,0.05,'both','unequal');
data.grp1 = data_sp;data.grp2 = data_cx;
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
plot(hAx,[0 3],[0 0],'k:');
xlim(hAx,[0.6 2.4]),ylim(hAx,[-1.0,1.0])
set(gca,'TickDir','out','Box','off','XTick',1:2,'XTickLabel',{'PreM-IN','CM cell'})
axis(hAx,'square')
title({'Lag (s)',['t(',num2str(ttest_stats.df,'%.2f'),')=',num2str(ttest_stats.tstat,'%.2f'),', p=',num2str(ttest_p)]})
[vartest_h,vartest_p,vartest_ci,vartest_stats] = vartest2(data_sp,data_cx)