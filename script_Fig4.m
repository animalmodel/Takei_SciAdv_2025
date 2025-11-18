% Script for Figure 4
% Created on Nov 17 2025 
% @author:Tomohiko Takei

clear all
close all
addpath('Violinplot')

%% Data loading
filePath = 'data/';
load([filePath,'data_Fig4.mat']);

% color setting
co1 = [ 0           0.45        0.74;
        0.85        0.33        0.1;
        0.94        0.45        0.66   
        ];

figure;
%% Fig.4D
% scatterplot of correlation with residual vs synergy for PreM-INs 
hAx = subplot(2,2,1); 
data_sp = [corr_residual_sp,corr_synergy_sp];
plot(hAx,data_sp(:,1),data_sp(:,2),'o','LineStyle','none','MarkerEdgeColor','none','MarkerFaceColor',co1(1,:))
hold on
plot(hAx,[-1,1],[-1,1],'k:')
xlim(hAx,[-1.0 1.0]),ylim(hAx,[-1.0,1.0])
set(hAx,'TickDir','out','Box','on')
axis(hAx,'square')
ylabel(hAx,'Corr with synergy'),xlabel(hAx,'Corr with residual')
[ttesst_sp_h,ttest_sp_p,ttest_sp_cl,ttest_sp_stats]=ttest(r2z(data_sp(:,1)),r2z(data_sp(:,2)),0.05,'both');
title({'PreM-IN',['t(',num2str(ttest_sp_stats.df,'%.2f'),')=',num2str(ttest_sp_stats.tstat,'%.2f'),', sp_p=',num2str(ttest_sp_p)]})

%% Fig.4D
% scatterplot of correlation with residual vs synergy for CM cells 
hAx = subplot(2,2,2); 
data_cx = [corr_residual_cx,corr_synergy_cx];
plot(hAx,data_cx(:,1),data_cx(:,2),'o','LineStyle','none','MarkerEdgeColor','none','MarkerFaceColor',co1(2,:))
hold on
plot(hAx,[-1,1],[-1,1],'k:')
xlim(hAx,[-1.0 1.0]),ylim(hAx,[-1.0,1.0])
set(hAx,'TickDir','out','Box','on')
axis(hAx,'square')
ylabel(hAx,'Corr with synergy'),xlabel(hAx,'Corr with residual')
[ttesst_cx_h,ttest_cx_p,ttest_cx_cl,ttest_cx_stats]=ttest(r2z(data_cx(:,1)),r2z(data_cx(:,2)),0.05,'both');
title({'CM cell',['t(',num2str(ttest_cx_stats.df,'%.2f'),')=',num2str(ttest_cx_stats.tstat,'%.2f'),', cx_p=',num2str(ttest_cx_p)]})

%% Fig.4E
% Preferred Index
data_sp  = r2z(corr_residual_sp)-r2z(corr_synergy_sp);
data_cx  = r2z(corr_residual_cx)-r2z(corr_synergy_cx);

% normality test added by TT for SciAdvRevision 20251007 
[kstest_h_sp,kstest_p_sp,kstest_ksstat_sp,kstest_cv_sp] = kstest((data_sp-mean(data_sp))/std(data_sp));
[kstest_h_cx,kstest_p_cx,kstest_ksstat_cx,kstest_cv_cx] = kstest((data_cx-mean(data_cx))/std(data_cx));

% F test for equal variances added by TT for SciAdvRevision 20251007
[vartest_h,vartest_p, vartest_ci, vartest_stats]   = vartest2(data_sp,data_cx);

[ttesst2_h,ttest_p,ttest_cl,ttest_stats]=ttest2(data_sp,data_cx,0.05,'both','unequal');
[rstest_p,rstest_h,rstest_stats]=ranksum(data_sp,data_cx,0.05);

hist_x      = -4.0:0.4:4.0;
hist_sp     = hist(data_sp,hist_x);
hist_cx     = hist(data_cx,hist_x);
binwidth    = hist_x(2)-hist_x(1);

hAx = subplot(2,2,3);
bar(hAx,hist_x+binwidth/2,hist_sp,1,'FaceColor',co1(1,:),'EdgeColor','none');
hold(hAx,'on')
stairs(hAx,hist_x,hist_sp,'Color','k');
plot(hAx,[0,0],[0,10],'k:')
xlim(hAx,[-5 5]),ylim(hAx,[0,10])
set(hAx,'TickDir','out','Box','off')
axis(hAx,'square')
xlabel(hAx,'Preference index'),ylabel(hAx,'Counts')
title({'PreM-IN'})


hAx = subplot(2,2,4);
bar(hAx,hist_x+binwidth/2,hist_cx,1,'FaceColor',co1(2,:),'EdgeColor','none');
hold(hAx,'on')
stairs(hAx,hist_x,hist_cx,'Color','k');
plot(hAx,[0,0],[0,10],'k:')
xlim(hAx,[-5 5]),ylim(hAx,[0,10])
set(hAx,'TickDir','out','Box','off')
axis(hAx,'square')
xlabel(hAx,'Preference index'),ylabel(hAx,'Counts')
title({'CM cell',['t(',num2str(ttest_stats.df,'%.2f'),')=',num2str(ttest_stats.tstat,'%.2f'),', p=',num2str(ttest_p)]})


