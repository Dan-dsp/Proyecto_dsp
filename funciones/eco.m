function [prosig, prosigFs] = eco(datain, freqin)

    % Parámetros de los retardos y amplitudes
    A1 = 0.5;  % Amplitud del primer eco
    A2 = 0.3;  % Amplitud del segundo eco
    A3 = 0.2;  % Amplitud del tercer eco

    % Retardos (en muestras)
    k1 = 1 * freqin;  % 1 segundo de retardo
    k2 = 2 * freqin;  % 2 segundos de retardo
    k3 = 3 * freqin;  % 3 segundos de retardo

    % Asegurarse de que datain sea un vector columna
    x = datain(:);
    
    length_x = length(x);
    disp(class(length_x));
    disp(class(freqin));
    % Generar la señal con eco
    y = zeros(length_x + k3, 1);  % Inicializar la señal de salida con ceros para incluir el retardo máximo
    y(1:length(x)) = x;  % Copiar la señal original

    % Añadir los ecos de manera segura
    if length(x) + k1 <= length(y)
        y(k1 + 1:k1 + length(x)) = y(k1 + 1:k1 + length(x)) + A1 * x;
    end

    if length(x) + k2 <= length(y)
        y(k2 + 1:k2 + length(x)) = y(k2 + 1:k2 + length(x)) + A2 * x;
    end

    if length(x) + k3 <= length(y)
        y(k3 + 1:k3 + length(x)) = y(k3 + 1:k3 + length(x)) + A3 * x;
    end

    % Variable de salida
    prosig = y;        % Señal procesada con eco
    prosigFs = freqin; % Frecuencia de muestreo

    % Reproducir la señal con eco
    sound(prosig, prosigFs);
end
