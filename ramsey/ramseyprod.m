% MATLAB function to calculate output for ramsey.m
% (also tested in GNU Octave 3.4.0)
% Andrew Gimber, European University Institute
% 2012-01-29

function y=ramseyprod(k)

alpha=0.3;  % exponent on capital
y=k.^alpha; % Cobb-Douglas production function, fixed labour supply