clc
clear 
close all

senal_fila = load('PWM_MOD_MOD_3_1MHz.txt');
senal = transpose(senal_fila);

N  = 333333;
dt = 0.000001;
t  = 0:dt:(N-1)*dt;

subplot(221)
plot(t,senal)
xlabel('Tiempo (Seg)')

title('Señal Original')
xlim([0 0.001])

senal_tf = fft(senal);
fm = 1/dt;
f  = fm*(0:N-1)/N;
subplot(222)
plot(f,abs(senal_tf)/max(abs(senal_tf)));
xlim([0 100000])
xlabel('frecuencia (Hz)')
title('Espectro de Señal Original')

fc = 75;
wc = 2*pi*fc;
w  = 2*pi*f;

H  = 1./(1+1i*w/wc);
H(N/2+1:end) = conj(fliplr(H(2:N/2+1)));

senal_tf_filtrada = senal_tf.*H;
subplot(224)
plot(f,abs(senal_tf_filtrada)/max(abs(senal_tf)),'r')
xlim([0 (1e3)])
xlabel('frecuencia (Hz)')
title('Espectro de Señal Filtrada')

senal_filtrada = ifft(senal_tf_filtrada);
subplot(223)
plot(t,real(senal_filtrada),'r')
xlim([0 (0.1)])
xlabel('Tiempo (Seg)')
title('Señal Filtrada')
