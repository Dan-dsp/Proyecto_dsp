function fourier_sistemas(filtro_tipo, fs, MagnitudeAxes, PhaseAxes)
    % FOURIER_SISTEMAS Lee coeficientes FIR/IIR de un archivo Excel y grafica
    % la Transformada de Fourier (respuesta en frecuencia).
    %
    % Inputs:
    %   filtro_tipo - Nombre del filtro ('FIR1', 'FIR2', ..., 'IIR1', 'IIR2', etc.).
    %   fs          - Frecuencia de muestreo en Hz.
    %   MagnitudeAxes - Ejes para graficar la magnitud.
    %   PhaseAxes   - Ejes para graficar la fase.
    %
    % Este código selecciona el filtro especificado por filtro_tipo, calcula
    % la Transformada de Fourier (para FIR) o usa freqz (para IIR) y grafica
    % los resultados.

    % Archivo Excel con los coeficientes
    excel_file = 'Filtros_Prueba_Proyecto1_Entregable.xlsx';
    
    % Inicializar variables
    h = []; % Coeficientes del filtro FIR o IIR (numerador)
    h_denominador = []; % Denominador para los filtros IIR (solo aplica a IIR)
    filter_type = '';  % 'FIR' o 'IIR'

    % Definir el filtro basado en el parámetro de entrada
    switch filtro_tipo
        % Casos FIR
        case {'FIR1', 'FIR2', 'FIR3', 'FIR4'}
            filter_type = 'FIR';
            % Definir el rango de lectura en función del filtro
            switch filtro_tipo
                case 'FIR1'
                    range = 'B6:B31';
                    hoja = 'Filtro FIR 1';
                case 'FIR2'
                    range = 'B6:B31';
                    hoja = 'Filtro FIR 2';
                case 'FIR3'
                    range = 'B6:B46';
                    hoja = 'Filtro FIR 3';
                case 'FIR4'
                    range = 'B6:B46';
                    hoja = 'Filtro FIR 4';
            end
            % Leer coeficientes FIR
            h = transpose(readmatrix(excel_file, 'Sheet', hoja, 'Range', range));
        
        % Casos IIR
        case {'IIR1', 'IIR2', 'IIR3', 'IIR4'}
            filter_type = 'IIR';
            % Leer coeficientes del numerador y denominador
            switch filtro_tipo
                case 'IIR1'
                    range_num = 'B6:B11';
                    range_den = 'B13:B18';
                    hoja = 'Filro IIR 1';
                case 'IIR2'
                    range_num = 'B6:B11';
                    range_den = 'B13:B18';
                    hoja = 'Filtro FIR 2';
                case 'IIR3'
                    range_num = 'B7:B13';
                    range_den = 'B15:B21';
                    hoja = 'Filtro FIR 3';
                case 'IIR4'
                    range_num = 'B6:B12';
                    range_den = 'B14:B20';
                    hoja = 'Filtro FIR 4';
            end
            % Leer coeficientes IIR
            h = transpose(readmatrix(excel_file, 'Sheet', hoja, 'Range', range_num));
            h_denominador = transpose(readmatrix(excel_file, 'Sheet', hoja, 'Range', range_den));
        
        otherwise
            error('Filtro no reconocido. Usa ''FIR1'', ''FIR2'', ''IIR1'', etc.');
    end

    % Procesar FIR o IIR según el tipo de filtro
    if strcmp(filter_type, 'FIR')
        % Llamar a la función transformada_fourier para graficar FIR
        transformada_fourier(h, fs, MagnitudeAxes, PhaseAxes);
    elseif strcmp(filter_type, 'IIR')
        % Graficar respuesta en frecuencia para IIR usando freqz
        [H_freq, fVals] = freqz(h, h_denominador, 1024, fs);
        % Calcular magnitud y fase
        magnitude = abs(H_freq);
        phase = angle(H_freq);
        % Llamada única para graficar magnitud y fase
        graficar_resultados(fVals, magnitude, phase, MagnitudeAxes, PhaseAxes, filtro_tipo);
    end
end

% Función local graficar_resultados
function graficar_resultados(fVals, magnitude, phase, MagnitudeAxes, PhaseAxes, filtro_tipo)
    % GRAFICAR_RESULTADOS Graficar la magnitud y fase de un filtro
    %
    % Inputs:
    %   fVals        - Valores de frecuencia.
    %   magnitude    - Magnitud de la respuesta en frecuencia.
    %   phase        - Fase de la respuesta en frecuencia.
    %   MagnitudeAxes - Ejes para graficar la magnitud.
    %   PhaseAxes    - Ejes para graficar la fase.
    %   filtro_tipo  - Nombre del filtro (para el título de las gráficas).

    % Graficar la magnitud
    plot(MagnitudeAxes, fVals, magnitude, 'LineWidth', 1.5);
    title(MagnitudeAxes, ['Magnitud de la Transformada de Fourier - ', filtro_tipo]);
    xlabel(MagnitudeAxes, 'Frecuencia (Hz)');
    ylabel(MagnitudeAxes, 'Magnitud');
    grid(MagnitudeAxes, 'on');

    % Graficar la fase
    plot(PhaseAxes, fVals, phase, 'LineWidth', 1.5);
    title(PhaseAxes, ['Fase de la Transformada de Fourier - ', filtro_tipo]);
    xlabel(PhaseAxes, 'Frecuencia (Hz)');
    ylabel(PhaseAxes, 'Fase (radianes)');
    grid(PhaseAxes, 'on');
end
