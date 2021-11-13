function [filter_nT] = Plot(alpha, N, wc1, wc2, ws, T)
%MAKE WINDOW FUNCTION
n = -(N-1)/2:1:(N-1)/2;
bita=alpha*sqrt(1-(2*n/(N-1)).^2);
kw=Bessl_function(bita)./Bessl_function(alpha);
figure,
stem(n,kw);
title('Window function');
ylabel('Amplitude');
xlabel('n');
grid on; 
%Bandpass filte without window 
left = -(N-1)/2:-1;
h_left = 1./(left*pi).*(sin(wc2*left*T)-sin(wc1*left*T));
nght = 1:(N-1)/2;
h_right = 1./(nght*pi).*(sin(wc2*nght*T)-sin(wc1*nght*T));
h_0 = 2/ws*(wc2-wc1);
h_nT = [h_left,h_0,h_right];
filter_nT = kw.*h_nT;%Bandpass filte multiple by window function 
%Ploat graph
n_shifted = [0:1:N-1];
figure,
stem(n_shifted, h_nT );
title('Filter Response - Rectangular window - Time Domain');
ylabel('Amplitude');
xlabel('n');
grid on;
n_shifted = [0:1:N-1];
figure,
stem(n_shifted, filter_nT);
title('Filter Response - Kaiser Window - Time Domain');
ylabel('Amplitude');
xlabel('n');
grid on;
[h,w] = freqz(filter_nT);
figure,
plot(w/T,20*log10(abs(h)))
ax = gca;
ax.YLim = [-100 20];
ax.XLim = [0,ws/2];
title('Magnitude Response in the range (0,w_s/2)');
xlabel('Normalized Frequency (rad/sample)')
ylabel('Magnitude (dB)')
grid on; 
figure,
plot(w/T,20*log10(abs(h)))
ax = gca;
ax.YLim = [-0.04, 0.04];
ax.XLim = [wc1,wc2];
title('Amplitude Response of the Passband');
xlabel('Normalized Frequency (rad/sample)')
ylabel('Magnitude (dB)')
grid on;
end
 


