function [f, A] = singleSidedFFT(t, x)
% singleSidedFFT Compute single-sided amplitude spectrum using FFT
%   [f, A] = singleSidedFFT(t, x)
%   t : time vector (seconds)
%   x : signal vector
%
%   f : frequency vector (Hz)
%   A : single-sided amplitude spectrum

    % Ensure column vectors
    t = t(:);
    x = x(:);

    % Sampling parameters
    dt = t(2) - t(1);     % sampling interval
    Fs = 1/dt;            % sampling frequency
    N  = length(x);       % number of samples
    
    % FFT
    X = fft(x);

    % Two-sided spectrum amplitude
    P2 = abs(X/N);

    % Single-sided spectrum
    P1 = P2(1:floor(N/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);  % double non-DC and non-Nyquist terms

    % Frequency axis
    f = Fs*(0:floor(N/2))/N;

    % Output
    A = P1;
end
