% Script for Figure 1
% Created on Nov 17 2025 
% @author:Tomohiko Takei

clear all
close all
addpath('Violinplot')

%% Data loading
filePath = 'data/';
load([filePath,'data_Fig1.mat']);

% color setting
co1 = [ 0           0.45        0.74;
        0.85        0.33        0.1;
        0.94        0.45        0.66   
        ];
    
figure;
%% Fig. 1B
nhistPSF_sp    = hist(nPSF_sp,1:8);
nhistPSF_sp(5) = sum(nhistPSF_sp(5:8));nhistPSF_sp(6:8)=[];
nhistPSF_cx    = hist(nPSF_cx,1:8);
nhistPSF_cx(5) = sum(nhistPSF_cx(5:8));nhistPSF_cx(6:8)=[];

% ttest
[ttesstPSF_h,ttestPSF_p,ttestPSF_cl,ttestPSF_stats]=ttest2(nPSF_sp,nPSF_cx,0.05,'both','equal');
phistPSF_sp = nhistPSF_sp/(sum(nhistPSF_sp))*100;
phistPSF_cx = nhistPSF_cx/(sum(nhistPSF_cx))*100;

hAx = subplot(2,2,[1,2]);
h=bar(1:5,[phistPSF_sp;phistPSF_cx]',1);
YLims       = [0,60];
PlotHight   = 58;
set(hAx,'YLim',YLims,'TickDir','out','Box','off','XTick',[1:5],'XTickLabel',{'1','2','3','4','≥5'})
set(h(1),'FaceColor',co1(1,:))
set(h(2),'FaceColor',co1(2,:))
hold on
plot(hAx,[-sem(nPSF_sp),0,sem(nPSF_sp)]+mean(nPSF_sp),ones(1,3)*PlotHight,'k-')
plot(hAx,[-sem(nPSF_cx),0,sem(nPSF_cx)]+mean(nPSF_cx),ones(1,3)*PlotHight,'k-')
plot(hAx,mean(nPSF_sp),PlotHight,'ko','MarkerFaceColor',co1(1,:),'MarkerSize',15)
plot(hAx,mean(nPSF_cx),PlotHight,'ko','MarkerFaceColor',co1(2,:),'MarkerSize',15)
xlabel(hAx,'Muscle field size'),ylabel(hAx,'Number of cells (%)')
title({'Muscle field size',['t(',num2str(ttestPSF_stats.df,'%.2f'),')=',num2str(ttestPSF_stats.tstat,'%.2f'),', p=',num2str(ttestPSF_p)]})
disp([num2str(mean(nPSF_sp)),' + ',num2str(std(nPSF_sp)),' vs ',num2str(mean(nPSF_cx)),' + ',num2str(std(nPSF_cx))])

%% Fig. 1C
% violin plot for onset latency
hAx = subplot(2,2,3);
data_sp     = latency_sp;
data_cx     = latency_cx;
[ttesst_h,ttest_p,ttest_cl,ttest_stats]=ttest2(data_sp,data_cx,0.05,'both','unequal');
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
set(hAx,'TickDir','out','Box','off','XTick',1:2,'XTickLabel',{'PreM-IN','CM cell'})
axis(hAx,'square')
title({'Onset latency (ms)',['t(',num2str(ttest_stats.df,'%.2f'),')=',num2str(ttest_stats.tstat,'%.2f'),', p=',num2str(ttest_p)]})


%% Fig. 1D
% violin plot for MPI
hAx =subplot(2,2,4);
data_sp = mpi_sp;
data_cx = mpi_cx;
[ttesst_h,ttest_p,ttest_cl,ttest_stats]=ttest2(data_sp,data_cx,0.05,'both','unequal');
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
set(hAx,'TickDir','out','Box','off','XTick',1:2,'XTickLabel',{'PreM-IN','CM cell'})
axis(hAx,'square')
title({'MPI (%)',['t(',num2str(ttest_stats.df,'%.2f'),')=',num2str(ttest_stats.tstat,'%.2f'),', p=',num2str(ttest_p)]})