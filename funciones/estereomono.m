function [prosig, prosigFs] = estereomono(signal1, Fs1, signal2, Fs2)
    % Esta función combina dos señales (posiblemente de diferentes longitudes) en una señal mono.
    % Si las frecuencias de muestreo son diferentes, una de las señales es
    % interpolada para que ambas tengan la misma frecuencia de muestreo.
    
    % Inicializar las señales interpoladas
    newSignal1 = signal1;
    newSignal2 = signal2;
    
    % Verificar si las frecuencias de muestreo son diferentes
    if Fs1 ~= Fs2
        % Si la frecuencia de muestreo de signal1 es menor, interpola signal1
        if Fs1 < Fs2
            % Interpolar signal1 a la frecuencia de muestreo de signal2
            newSignal1 = resample(signal1, Fs2, Fs1);
            prosigFs = Fs2;
        else
            % Interpolar signal2 a la frecuencia de muestreo de signal1
            newSignal2 = resample(signal2, Fs1, Fs2);
            prosigFs = Fs1;
        end
    else
        prosigFs = Fs1;  % Si las frecuencias de muestreo son iguales, usa una de ellas
    end

    % Ajustar longitudes de las señales
    l1 = length(newSignal1);
    l2 = length(newSignal2);

    % Rellenar con ceros si las longitudes no coinciden
    if l1 > l2
        newSignal2 = [newSignal2; zeros(l1 - l2, 1)];  % Rellenar signal2
    elseif l2 > l1
        newSignal1 = [newSignal1; zeros(l2 - l1, 1)];  % Rellenar signal1
    end

    % Convertir las señales a mono (promediar los canales)
    if size(newSignal1, 2) > 1
        newSignal1 = mean(newSignal1, 2);  % Convertir a mono promediando los canales
    end

    if size(newSignal2, 2) > 1
        newSignal2 = mean(newSignal2, 2);  % Convertir a mono promediando los canales
    end

    % Combinar las dos señales en una única señal mono
    prosig = (newSignal1 + newSignal2) / 2;  % Promediar las señales para obtener la señal mono
    
    % Reproducir el sonido resultante
    sound(prosig, prosigFs);
end