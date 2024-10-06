function [fVals, magnitude, phase] = transformada_fourier(signal, fs, MagnitudeAxes, PhaseAxes)
    N = length(signal);        % Número de puntos de la señal
    fftSignal = fft(signal);   % Calcular la FFT

    % Tomar sólo la primera mitad de la FFT (debido a la simetría)
    fftSignal = fftSignal(1:N/2+1);
    
    % Eje de frecuencias
    fVals = (0:N/2)*(fs/N);

    % Magnitud escalada
    magnitude = abs(fftSignal)/N;
    magnitude(2:end-1) = 2*magnitude(2:end-1); % Escalar las magnitudes (excepto DC)

    % Fase
    phase = angle(fftSignal);


    % Graficar la magnitud en el objeto Axes correspondiente
    plot(MagnitudeAxes, fVals, magnitude);
    title(MagnitudeAxes, 'Magnitud de la Transformada de Fourier');
    xlabel(MagnitudeAxes, 'Frecuencia (Hz)');
    ylabel(MagnitudeAxes, 'Magnitud');

    % Graficar la fase en el objeto Axes correspondiente
    plot(PhaseAxes, fVals, phase);
    title(PhaseAxes, 'Fase de la Transformada de Fourier');
    xlabel(PhaseAxes, 'Frecuencia (Hz)');
    ylabel(PhaseAxes, 'Fase (radianes)');
end
