% La señal de entrada debe ser un vector, normalizado
% Esta funcion devuelve los valores de frecuencia su magnitud y fase
% correspondientes 
% debe escogerse una frecuencia de muestreo normalmente el doble de la
% frecuencia de de la señal 

function [fVals, magnitude, phase] = transformada_fourier(signal, fs)
    % signal: La señal de entrada (vector)
    % fs: Frecuencia de muestreo (escalares)

    N = length(signal);        % Número de puntos de la señal
    fftSignal = fft(signal);   % Calcular la FFT
    fVals = (0:N-1)*(fs/N);    % Eje de frecuencias

    % Magnitud y Fase
    magnitude = abs(fftSignal); % Magnitud de la FFT
    phase = angle(fftSignal);   % Fase de la FFT
end
