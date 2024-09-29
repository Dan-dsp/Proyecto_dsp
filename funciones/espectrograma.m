function espectrograma(signal, fs)
    % PLOTSIGNALSPECTOGRAM Plots the spectrogram and the FFT (frequency, magnitude, phase) of a signal.
    % signal: La señal de entrada (vector)
    % fs: Frecuencia de muestreo

    % Parámetros para el espectrograma
    window = 256;            % Tamaño de la ventana
    overlap = window / 2;     % Superposición entre ventanas
    nfft = 512;               % Número de puntos para la FFT

    % ---- 1. Espectrograma ----
    [S,F,T,P] = spectrogram(signal, window, overlap, nfft, fs);
    PdB = 10*log10(P);  % Potencia en decibelios

    % ---- 2. FFT de la señal completa ----
    % Duplicar la frecuencia de muestreo para el cálculo de la FFT como mencionaste
    [fVals, magnitude, phase] = calculateFFT(signal, 2*fs);

    % ---- Graficar ----
    figure;

    % Subgráfico 1: Espectrograma
    subplot(3,1,1);
    surf(T,F,PdB,'EdgeColor','none');
    axis tight;
    view(0,90);
    xlabel('Tiempo (s)');
    ylabel('Frecuencia (Hz)');
    title('Espectrograma de la Señal');
    colorbar;
    ylabel(colorbar, 'Potencia/Frecuencia (dB/Hz)');

    % Subgráfico 2: Magnitud en el dominio de la frecuencia (FFT)
    subplot(3,1,2);
    plot(fVals(1:length(fVals)/2), magnitude(1:length(magnitude)/2)); % Solo la mitad positiva
    xlabel('Frecuencia (Hz)');
    ylabel('Magnitud');
    title('Espectro de Magnitud');

    % Subgráfico 3: Fase en el dominio de la frecuencia (FFT)
    subplot(3,1,3);
    plot(fVals(1:length(fVals)/2), phase(1:length(phase)/2)); % Solo la mitad positiva
    xlabel('Frecuencia (Hz)');
    ylabel('Fase (radianes)');
    title('Espectro de Fase');

end
