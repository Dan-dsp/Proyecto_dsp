function [prosig, prosigFs] = monoestereo(datain1, frecuenciademuestreoin1, datain2, frecuenciademuestreoin2)
    % Verificar que las se�ales sean vectores columna
    datain1 = datain1(:);
    datain2 = datain2(:);

    
    % Si las frecuencias de muestreo son diferentes, ajustar la se�al m�s corta
    if frecuenciademuestreoin1 ~= frecuenciademuestreoin2
        % Calcular la nueva longitud basada en la frecuencia de muestreo m�s alta
        if frecuenciademuestreoin1 > frecuenciademuestreoin2
            % Interpolar la se�al 2
            datain2 = resample(datain2, frecuenciademuestreoin1, frecuenciademuestreoin2);
            frecuenciademuestreoin2 = frecuenciademuestreoin1; % Ajustar la frecuencia de muestreo de la se�al 2
        else
            % Interpolar la se�al 1
            datain1 = resample(datain1, frecuenciademuestreoin2, frecuenciademuestreoin1);
            frecuenciademuestreoin1 = frecuenciademuestreoin2; % Ajustar la frecuencia de muestreo de la se�al 1
        end
    end

    % Obtener la longitud de las se�ales
    len1 = length(datain1);
    len2 = length(datain2);

    % Ajustar la longitud de las se�ales a la m�s larga
    maxLength = max(len1, len2);
    datain1(maxLength) = 0;  % Rellenar con ceros
    datain2(maxLength) = 0;  % Rellenar con ceros

    % Combinar las se�ales en una matriz de dos columnas
    prosig = [datain1(1:maxLength), datain2(1:maxLength)]; % Crear matriz (n�mero de muestras x 2)

    % Establecer la frecuencia de muestreo de la se�al est�reo
    prosigFs = frecuenciademuestreoin1;  % Usar la frecuencia de muestreo de la se�al 1

    % Reproducir la se�al est�reo resultante
    sound(prosig, prosigFs);
    disp(['Size of the signal ', num2str(size(prosig))]);

end
