clear all;
close all;
clc;

T0 = 10;
f0 = 1/T0;
omega0 = 2*pi*f0;

Nt = 101;
t = linspace(0,T0,10001);
x = 1-rectangularPulse(0,T0/2,t);

Nmodes = 1000;

a0 = mean(x);
x_recon = a0;
for n=1:1:Nmodes
    an = 2/T0 * trapz(t, x .* cos(n*omega0*t) );
    bn = 2/T0 * trapz(t, x .* sin(n*omega0*t) );
    x_recon = x_recon + an*cos(n*omega0*t) + bn*sin(n*omega0*t);
end

plot(t,x,'xk')
hold on
plot(t,x_recon,'-r',LineWidth=2)