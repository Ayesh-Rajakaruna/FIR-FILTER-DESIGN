function [] = Signal(filter_nT, wa1, wa2, wp1, wp2, ws, T)
samples = 400;
len_fft = 1024;
w1 = wa1/2;
w2 = (wp1+wp2)/2;
w3 = (wa2+ws/2)/2;
nT = (0:T:samples*T);
%Input signal
xnT = sin(w1*nT)+sin(w2*nT)+sin(w3*nT);
Xw = fft(xnT, len_fft);
X1 = T*abs(Xw(1:len_fft/2+1));
%Output Signal using Disigned Filter
ynT = conv(xnT,filter_nT);
Yw = fft(ynT, len_fft);
Y = T*abs(Yw(1:len_fft/2+1));
%Expected Output Signal
ideal_ynT = sin(w2*nT);
ideal_Yjw = fft(ideal_ynT, len_fft);
Ye = T*abs(ideal_Yjw(1:len_fft/2+1));
fprintf('\n')
disp(['Middle frequency of the lower stopband  = ',num2str(w1)])
disp(['Middle frequency of the passband  = ',num2str(w2)])
disp(['Middle frequency of the upper stopband  = ',num2str(w3)])
%Ploat result
w = ws*(0:1/len_fft:1/2);
figure, subplot(3, 1, 1) ;
plot(w,X1);
grid on;
title('Frequency Spectrum Of Input Signal');
xlabel('w (rad/s)'); ylabel('X(w)');
axis([0, 1500, 0, 0.5]);
subplot(3, 1, 2);
plot(w, abs(Y'));
title('Frequency Spectrum Of Output Signal using Disigned Filter');
xlabel('w (rad/s)'); ylabel('Y(w)');
axis([0, 1500, 0, 0.5]);
grid on;
subplot(3, 1, 3);
plot(w, abs(Ye'));
title('Frequency Spectrum Of Expected Output Signal');
xlabel('w (rad/s)'); ylabel('Y_e(w)');
axis([0, 1500, 0, 0.5]);
grid on;


