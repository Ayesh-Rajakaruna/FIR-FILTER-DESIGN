function [alpha, N, wa1, wa2, wp1, wp2, wc1, wc2, ws, T] = Kiser(A,B,C)
Ap = 0.03 + (0.01*A);    %Maximum passband ripple
Aa = 45 + B;             %Minimum stopband attenuation
wp1 = C*100 + 300;       %Lower passband edge
wp2 = C*100 + 700;       %Upper passband edge
wa1 = C*100 + 150;       %Lower stopband edge
wa2 = C*100 + 800;       %Upper stopband edge
ws = 2*(C*100 + 1200) ;  %Sampling frequency
tran1 = wp1-wa1;
tran2 = wa2-wp2;
Bt=min(tran1,tran2);
wc1 = wp1-Bt/2; % lower cutoff frequency
wc2 = wp2+Bt/2; % upper cutoff frequency
T = 2*pi/ws; % sampling period
disp(['Maximum passband ripple = ',num2str(Ap),'dB'])
disp(['Minimum stopband attenuation = ',num2str(Aa),'dB'])
disp(['Lower passband edge = ',num2str(wp1),'rad/s'])
disp(['Upper passband edge = ',num2str(wp2),'rad/s'])
disp(['Lower stopband edge = ',num2str(wa1),'rad/s'])
disp(['Upper stopband edge = ',num2str(wa2),'rad/s'])
disp(['Sampling frequency = ',num2str(ws),'rad/s'])
disp(['Sampling period = ',num2str(T),'s'])
disp(['lower cutoff frequency= ',num2str(wc1),'rad/s'])
disp(['upper cutoff frequency = ',num2str(wc2),'rad/s'])
%Choosing Delta
delta_p = (10^(0.05*Ap)-1)/(10^(0.05*Ap)+1);
delta_a = 10^(-0.05*Aa);
delta = min(delta_p,delta_a);
%Actual Stopband attenuation
actual_Aa = -20*log10(delta);
%Choosing Delta
if actual_Aa <= 21
    alpha = 0;
elseif (21 < actual_Aa) && (actual_Aa <= 50)
    alpha = 0.5842*(actual_Aa-21)^0.4 + 0.07886*(actual_Aa-21) ;
else
    alpha = 0.1102*(actual_Aa-8.7) ;
end
%Choosing D
if actual_Aa <= 21
D = 0.9222;
else
D = (actual_Aa - 7.95)/14.36;
end
%Choosing Order
if mod(ceil(ws*D/Bt + 1 ) , 2 ) == 1
N = ceil(ws*D/Bt + 1 ) ;
else
N = ceil(ws*D/Bt + 1 ) + 1;
end
fprintf('\n')
disp(['Delta of Kaiser Window  = ',num2str(delta)])
disp(['𝐴a of Kaiser Window  = ',num2str(actual_Aa)])
disp(['Alpha of Kaiser Window  = ',num2str(alpha)])
disp(['D of Kaiser Window  = ',num2str(D)])
disp(['Order of Kaiser Window  = ',num2str(N)])
end

