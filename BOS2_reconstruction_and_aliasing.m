clear all;
close all;
clc;

%% discrete signal definition
nt = 41;
td = linspace(0,2*pi,nt);
fd = sin(td);

%% reconstructed signal definition (polynomial)

% find coefficients
p = polyfit(td,fd,5);
% Evaluate the fitted polynomial
t_recon = linspace(min(td),max(td)*1.7,1001);
f_recon = polyval(p,t_recon);

%% visualisation
figure(1)
plot(td,fd,'or',LineWidth=2)
hold on
plot(t_recon,f_recon,'-k',LineWidth=2)