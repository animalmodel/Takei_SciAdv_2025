% Script for Figure 3
% Created on Nov 17 2025 
% @author:Tomohiko Takei

clear all
close all
addpath('Violinplot')

%% Data loading
filePath = 'data/';
load([filePath,'data_Fig3.mat']);

% color setting
co1 = [ 0           0.45        0.74;
        0.85        0.33        0.1;
        0.94        0.45        0.66   
        ];

figure;
%% Fig.3D 
% violin plot for %contribution (neuron-muscle pairs)
hAx = subplot(1,2,1); 
data_sp = pcont_muscle_sp;
data_cx = pcont_muscle_cx;
[ttesst_h_muscle,ttest_p_muscle,ttest_cl_muscle,ttest_stats_muscle]=ttest2(data_sp,data_cx,0.05,'both','unequal');
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
xlim(hAx,[0.6 2.4]),ylim(hAx,[-1.0,4.0])
set(gca,'TickDir','out','Box','off','XTick',1:2,'XTickLabel',{'PreM-IN','CM cell'})
axis(hAx,'square')
title({'%Contribution(muscles)',['t(',num2str(ttest_stats_muscle.df,'%.2f'),')=',num2str(ttest_stats_muscle.tstat,'%.2f'),', p=',num2str(ttest_p_muscle)]})

%% %contribution individual cells
hAx = subplot(1,2,2);
data_sp = pcont_cell_sp;
data_cx = pcont_cell_cx;
[ttesst_h_cell,ttest_p_cell,ttest_cl_cell,ttest_stats_cell]=ttest2(data_sp,data_cx,0.05,'both','unequal');
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
xlim(hAx,[0.6 2.4]),ylim(hAx,[-0.2,0.8])
set(gca,'TickDir','out','Box','off','XTick',1:2,'XTickLabel',{'PreM-IN','CM cell'})
title({'%Contribution(cells)',['t(',num2str(ttest_stats_cell.df,'%.2f'),')=',num2str(ttest_stats_cell.tstat,'%.2f'),', p=',num2str(ttest_p_cell)]})
axis(hAx,'square')


