function [signal, sample_rate] = procesamiento_en_el_tiempo(tipo_de_procesamiento)
    [signal, sample_rate] = import_signal();
    switch tipo_de_procesamiento
        case 'cambiar frecuencia de muestreo'
            sample_rate = change_sample_rate();
        case 'desplazar'
            signal = desplazar(signal, sample_rate);
        case 'sumar'
            a
        case 'multiplicar'
            a
        case 'inversa'
            a
        case 'estereo a mono'
            a
        case 'mono a estereo'
            a
        case 'estereo con dos monos'
            a
        case 'volumen del audio'
            a
    end

    function [signal, sample_rate] = import_signal()
        % Busca el archivo que se quiere importar
        [filename, path] = uigetfile({'*.mp3;*.wav'}); 
        % figure(app.UIFigure);
        fullFileName = fullfile(path, filename);  % Construye la ruta completa del archivo
        
        % Recuperar los datos importados
        [signal, sample_rate] = audioread(fullFileName);
    end
    
    function new_sample_rate = change_sample_rate()
    
    end
    
    function shifted_signal = desplazar(signal, sample_rate)
        % shiftSignalForLoops: Shifts a signal by a specified number of samples or seconds using for loops
        % signal: The original signal to be shifted
        % shiftValue: The number of samples to shift or time in seconds to shift.
        % Fs: The sampling frequency in Hz.
        % isTimeShift: A boolean indicating if 'shiftValue' is in seconds (true) or samples (false).
    
        dlgtitle = 'Desplazar señal';
        prompt = {'Valor del desplazamiento', '0 para desplazamiento a la izquierda o 1 para desplazamiento a la derecha', '0 para desplazamiento por muestra o 1 para desplazamiento en segundos'};
        dims = [1 35];
        defect_input = {'1','0','1'};
        answer = inputdlg(prompt,dlgtitle,dims,defect_input);
        
        
        shift_value = str2num(answer{1});    % Valor del desplazamiento
        left_right_shifting = str2num(answer{2});    % Sentido del desplazamiento
        sample_second_shifting = str2num(answer{3});    % Referencia del desplazamiento: si en muestras o en segundos
    
        
        % Convert shift value from time (seconds) to samples if necessary
        if sample_second_shifting
            % Convert seconds to number of samples
            shift_value = round(shift_value * sample_rate);
        else
            % Use the given number of samples directly
        end
        
        % Get the length of the original signal
        signalLength = length(signal);
        
        % Adjust length for the shifted signal depending on the direction of the shift
        
        if left_right_shifting == 0
            % Advance: Add additional space to the left (beginning)
            shiftedSignalLength = signalLength + shift_value;
            shifted_signal = zeros(1, shiftedSignalLength);
            
            % Fill the shifted signal using the for loop
            for i = 1:signalLength
                shifted_signal(i) = signal(i);
            end
        
        elseif left_right_shifting == 1
            % Delay: Add additional space to the right (end)
            shiftedSignalLength = signalLength + shift_value;
            shifted_signal = zeros(1, shiftedSignalLength);
            
            % Fill the shifted signal using the for loop
            for i = 1:signalLength
                shifted_signal(i + shift_value) = signal(i);
                signal = shifted_signal;
            end
        
        else
            % No shift: Simply copy the original signal
            shifted_signal = signal;
        end
    end
end

