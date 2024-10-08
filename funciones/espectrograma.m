function espectrograma(signal, fs, SpectrogramAxes, title_1)
    % ESPECTROGRAMA Plots the spectrogram of a signal on a specified Axes.
    % signal: La señal de entrada (vector)
    % fs: Frecuencia de muestreo
    % SpectrogramAxes: Objeto Axes donde se graficará el espectrograma

    % Parámetros para el espectrograma
    window = 256;            % Tamaño de la ventana
    overlap = window / 2;     % Superposición entre ventanas
    nfft = 512;               % Número de puntos para la FFT

    % ---- 1. Espectrograma ----
    [S,F,T,P] = spectrogram(signal, window, overlap, nfft, fs);
    PdB = 10*log10(P);  % Potencia en decibelios

    % ---- Graficar en el objeto Axes ----
    surf(SpectrogramAxes, T, F, PdB, 'EdgeColor', 'none');
    axis(SpectrogramAxes, 'tight');
    view(SpectrogramAxes, 0, 90);
    xlabel(SpectrogramAxes, 'Tiempo (s)');
    ylabel(SpectrogramAxes, 'Frecuencia (Hz)');
    title(SpectrogramAxes, title_1);
    colorbar(SpectrogramAxes);
    ylabel(SpectrogramAxes.Colorbar, 'Potencia/Frecuencia (dB/Hz)');
end


    % % Subgráfico 2: Magnitud en el dominio de la frecuencia (FFT)
    % subplot(3,1,2);
    % plot(fVals(1:length(fVals)/2), magnitude(1:length(magnitude)/2)); % Solo la mitad positiva
    % xlabel('Frecuencia (Hz)');
    % ylabel('Magnitud');
    % title('Espectro de Magnitud');
    % 
    % % Subgráfico 3: Fase en el dominio de la frecuencia (FFT)
    % subplot(3,1,3);
    % plot(fVals(1:length(fVals)/2), phase(1:length(phase)/2)); % Solo la mitad positiva
    % xlabel('Frecuencia (Hz)');
    % ylabel('Fase (radianes)');
    % title('Espectro de Fase');

