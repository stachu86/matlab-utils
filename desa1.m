function [ ins_f ] = desa1( x, fs )
%DESA1 Discrete Energy Separation Algorithm
%
%   Input:
%       x - real valued signal vector
%       fs - sampling frequency in Hz
%   Output:
%       ins_f - instantaneous frequency (in Hz)

% Based on:
% Maragos, Petros, James F. Kaiser, and Thomas F. Quatieri.
% "Energy separation in signal modulations with application to speech analysis."
% IEEE transactions on signal processing 41.10 (1993): 3024-3051.

assert(length(x) >= 3,'Signal is too short!');

y = [0 diff(x)]; % extrapolate first sample of diff
t_x = teo(x); %teager from VOICEBOX
t_y = teo(y);% extrapolate first tko sample

% ins_f = 2*asin(sqrt((t_y(2:end)+t_y(1:end-1))./(8*t_x(1:end-1))));
ins_f = acos(1 - ((t_y(2:end)+t_y(1:end-1))./(4*t_x(1:end-1))));
ins_f = (ins_f*fs)./(2*pi); %scale to Hz
end

% Teager Energy Operator
function [energy] = teo(x)
energy = x(2:end-1).^2  - x(3:end).*x(1:end-2);
energy = [energy(1) energy energy(end)]; % extrapolate samples
end