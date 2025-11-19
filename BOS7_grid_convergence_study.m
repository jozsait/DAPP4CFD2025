clear all;
close all;
clc;

%%

% area
area = 76;

% cell count
cell_count = [inf 18000 8000 4500];

% quantity of interest
quant_of_interest = [NaN 6.063 5.972 5.863];

% convergence order
p = 1.53;

% grid spacing
h = sqrt(area./cell_count);

% normalised grid spacing
NGS = h/h(2);

% refinement ratios
r32 = h(4)/h(3);
r21 = h(3)/h(2);

% Richardson extrapolated value
quant_of_interest(1) = (r21^p*quant_of_interest(2) - quant_of_interest(3))...
    /(r21^p-1);

% errors
eps21 = abs( ( quant_of_interest(3)-quant_of_interest(2) )...
    / quant_of_interest(2) );
eps32 = abs( ( quant_of_interest(4)-quant_of_interest(3) )...
    / quant_of_interest(3) );

% grid convergence indices
GCI21 = 1.25*eps21/(r21^p-1);
GCI32 = 1.25*eps32/(r32^p-1);

% asymptotic range
AR = r21^p * GCI21/GCI32;
disp({'the asymptotic range is ', AR})

%% plotting results
plot(NGS(2:4),quant_of_interest(2:4),'-ko',LineWidth=2)
hold on
plot(NGS(1),quant_of_interest(1),'rd',MarkerFaceColor='r')
xlabel('normalised grid spacing')
ylabel('reattachment length')