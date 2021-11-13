clc;
close all;
% Get index number
prompt = 'What is your index number? ';
indexNo = input(prompt,'s');
a = indexNo(4);
b = indexNo(5);
c = indexNo(6);
A = str2double(a);
B = str2double(b);
C = str2double(c);
fprintf('\n')
% Find spesification of my filter
[alpha, N, wa1, wa2, wp1, wp2, wc1, wc2, ws, T] = Kiser(A,B,C);
filter_nT = Plot(alpha, N, wc1, wc2, ws, T);
Signal(filter_nT, wa1, wa2, wp1, wp2, ws, T);