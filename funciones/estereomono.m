function [prosig, prosigFs] = estereomono(signal1, Fs1, signal2, Fs2)
    % Esta función combina dos señales estéreo en una señal mono.
    % Si las frecuencias de muestreo son diferentes, una de las señales es
    % interpolada internamente para que ambas tengan la misma frecuencia de muestreo.
    
    % Verificar si las frecuencias de muestreo son diferentes
    if Fs2 < Fs1
        % Interpolar la señal1 a la frecuencia de muestreo de la señal2
        oldfreq = 0:(1/Fs1):(length(signal1) - 1) / Fs1;
        newfreq = 0:(1/Fs2):(length(signal1) - 1) / Fs1;
        newSignal1 = interp1(oldfreq, signal1, newfreq);  % Interpolación directa
        newSignal1 = transpose(newSignal1);  % Transponer para mantener consistencia
        lnf = length(newSignal1);
        lns2 = length(signal2);
        prosigFs = Fs2;  % Nueva frecuencia de muestreo será la más baja
        
        % Ajustar longitudes de las señales si es necesario
        if lnf > lns2
            signal2 = [signal2, zeros(1, lnf - lns2)];
        else
            newSignal1 = [newSignal1, zeros(1, lns2 - lnf)];
        end
        
        % Combinar las dos señales en una señal mono
        prosig = (signal2 * 0.5) + (newSignal1 * 0.5);
    else
        % Interpolar la señal2 a la frecuencia de muestreo de la señal1
        oldfreq = 0:(1/Fs2):(length(signal2) - 1) / Fs2;
        newfreq = 0:(1/Fs1):(length(signal2) - 1) / Fs2;
        newSignal2 = interp1(oldfreq, signal2, newfreq);  % Interpolación directa
        newSignal2 = transpose(newSignal2);  % Transponer para mantener consistencia
        lnf = length(newSignal2);
        lns1 = length(signal1);
        prosigFs = Fs1;  % Nueva frecuencia de muestreo será la más baja
        
        % Ajustar longitudes de las señales si es necesario
        if lnf > lns1
            signal1 = [signal1, zeros(1, lnf - lns1)];
        else
            newSignal2 = [newSignal2, zeros(1, lns1 - lnf)];
        end
        
        % Combinar las dos señales en una señal mono
        prosig = (signal1 * 0.5) + (newSignal2 * 0.5);
    end
    sound(prosig, prosigFs);

end
