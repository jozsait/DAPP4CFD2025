clear all;
close all;
clc;

%% changing text interpreter
% Set all interpreters to LaTeX
set(groot, 'defaultTextInterpreter', 'latex');
set(groot, 'defaultLegendInterpreter', 'latex');
set(groot, 'defaultAxesTickLabelInterpreter', 'latex');
set(groot, 'defaultColorbarTickLabelInterpreter', 'latex');

%% loading data
load HotWireData_Baseline.mat
Vel = flip(Vel,2);

y_adj = y + yOffset;

%% computing statistics
Vel_tave = mean(Vel,1).';
Vel_tstd = std(Vel,1).';
Vel_tskew = skewness(Vel,1).';
Vel_tkurt = kurtosis(Vel,1).';

%% correlation analysis

% example of statistically significantly correlated signals
% s1 = linspace(-1,1,1001);
% s2 = s1 + normrnd(0,0.5,[1,1001]);
% corrcoef(s1,s2)

s1 = Vel(:,59);
s1 = s1-mean(s1);
s2 = Vel(:,58);
s2 = s2-mean(s2);
corrcoef(s1,s2)

%% visualisation of spatiotemporal distribution

symbol = {'r--','b:','g-.','m-'};
subplot(2,2,1)
hold on
cter = 1;
for i = 1:2000:7000
    plot(Vel(i,:),y_adj,symbol{cter})
    cter = cter+1;
end
plot(Vel_tave,y_adj,'-k',LineWidth=2)
xlabel('U [m/s]')
ylabel('y [mm]')
legend(['t=',num2str(t(1)),' [s]'],...
    ['t=',num2str(t(2001)),' [s]'],...
    ['t=',num2str(t(4001)),' [s]'],...
    ['t=',num2str(t(6001)),' [s]'],...
    'time-averaged', ...
    Location='northwest')
ylim([0,80])
text(0.2, 0.1, '(a)', 'Units', 'normalized', 'FontSize', 10);

subplot(2,2,2)
plot(Vel_tstd,y_adj,'-k',LineWidth=2)
xlabel(' $\sqrt{ \frac{1}{N} \sum_{i=1}^N (U- \langle U \rangle)^2 }$ [m/s]')
ylabel('y [mm]')
ylim([0,80])
text(0.2, 0.1, '(b)', 'Units', 'normalized', 'FontSize', 10);

subplot(2,2,3)
plot(Vel_tskew,y_adj,'-k',LineWidth=2)
xlabel('skewness of U')
ylabel('y [mm]')
ylim([0,80])
text(0.2, 0.1, '(c)', 'Units', 'normalized', 'FontSize', 10);

subplot(2,2,4)
plot(Vel_tkurt,y_adj,'-k',LineWidth=2)
xlabel('kurtosis of U')
ylabel('y [mm]')
ylim([0,80])
text(0.2, 0.1, '(d)', 'Units', 'normalized', 'FontSize', 10);

set(findall(gcf,'-property','FontSize'),'FontSize',10);

f = gcf;      % current figure
exportgraphics(f, 'myfigure.png', 'Resolution', 300);

%% visualisation of a temporal signal
tsignal = Vel(:,59);
mean_tsignal = mean(tsignal);
std_tsignal = std(tsignal);

my_random_signal = normrnd(mean_tsignal,std_tsignal,[1,length(tsignal)]);

figure
plot(t,tsignal-mean_tsignal,'-k')
hold on
plot(t,my_random_signal-mean_tsignal,'--r')

figure
h1 = histogram(tsignal-mean_tsignal, 'FaceColor', 'r', 'FaceAlpha', 0.4, ...
               'EdgeColor', 'none');
hold on;

% Second histogram (blue, transparent)
h2 = histogram(my_random_signal-mean_tsignal, 'FaceColor', 'b', 'FaceAlpha', 0.4, ...
               'EdgeColor', 'none');