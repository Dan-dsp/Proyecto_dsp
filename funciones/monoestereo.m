function [prosig, prosigFs] = monoestereo   (datain1, frecuenciademuestreoin1, datain2, frecuenciademuestreoin2)
    % Verificar que las señales sean vectores columna
    datain1 = datain1(:);
    datain2 = datain2(:);

    % Si las frecuencias de muestreo son diferentes, ajustar la señal más corta
    if frecuenciademuestreoin1 ~= frecuenciademuestreoin2
        % Calcular la nueva longitud basada en la frecuencia de muestreo más alta
        if frecuenciademuestreoin1 > frecuenciademuestreoin2
            % Interpolar la señal 2
            datain2 = resample(datain2, frecuenciademuestreoin1, frecuenciademuestreoin2);
            frecuenciademuestreoin2 = frecuenciademuestreoin1; % Ajustar la frecuencia de muestreo de la señal 2
        else
            % Interpolar la señal 1
            datain1 = resample(datain1, frecuenciademuestreoin2, frecuenciademuestreoin1);
            frecuenciademuestreoin1 = frecuenciademuestreoin2; % Ajustar la frecuencia de muestreo de la señal 1
        end
    end

    % Obtener la longitud de las señales
    len1 = length(datain1);
    len2 = length(datain2);

    % Ajustar la longitud de las señales a la más larga
    maxLength = max(len1, len2);
    datain1(maxLength) = 0;  % Rellenar con ceros
    datain2(maxLength) = 0;  % Rellenar con ceros

    % Combinar las señales en una matriz de dos columnas
    prosig = [datain1(1:maxLength), datain2(1:maxLength)]; % Crear matriz (número de muestras x 2)

    % Establecer la frecuencia de muestreo de la señal estéreo
    prosigFs = frecuenciademuestreoin1;  % Usar la frecuencia de muestreo de la señal 1

    % Reproducir la señal estéreo resultante
    sound(prosig, prosigFs);

end
