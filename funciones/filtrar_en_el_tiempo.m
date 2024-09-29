%funcion para crear filtro con el tiempo usando padding, 
% el padding se agrega adelante y atras de la funcion 
% siendo el mismo tamaño de la funcion 

function [magnitud, tiempo] = filtrar_en_el_tiempo(signal, fs, filter_type, frecuencia_corte)
    % Filtra una señal en el dominio del tiempo aplicando padding (relleno de ceros).
    % signal: Señal de entrada (vector).
    % fs: Frecuencia de muestreo.
    % filter_type: Tipo de filtro ('low', 'high', 'bandpass', 'bandstop').
    % frecuencia_corte: Frecuencia o frecuencias de corte para el filtro.

    % Valores predeterminados
    if nargin < 3
        filter_type = 'low'; % Tipo de filtro predeterminado es paso bajo
    end
    if nargin < 4
        frecuencia_corte = 0.1; % Frecuencia de corte predeterminada
    end

    % ---- Paso 1: Padding (relleno de ceros) ----
    padding = zeros(1, length(signal));  % Crear relleno de ceros
    signal_padded = [padding, signal, padding];  % Añadir relleno a la señal

    % ---- Paso 2: Crear filtro ----
    % Creamos el filtro de acuerdo al tipo y la frecuencia de corte
    [b_filter, a_filter] = butter(6, frecuencia_corte, filter_type);

    % ---- Paso 3: Aplicar el filtro ----
    filtered_signal = filter(b_filter, a_filter, signal_padded);  % Aplicar el filtro

    % ---- Paso 4: Devolver el tiempo y la magnitud filtrada ----
    tiempo = (0:length(signal_padded)-1)/fs;  % Tiempo ajustado al padding
    magnitud = filtered_signal;  % Señal filtrada
end